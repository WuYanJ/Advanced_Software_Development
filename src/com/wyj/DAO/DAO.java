package com.wyj.DAO;

import com.wyj.Utils.DataBaseUtils;
import org.apache.commons.beanutils.BeanUtils;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DAO {
    // insert update delete都可以包含在其中
// sql和sql占位符的可变参数
    public void update(String sql, Object... args) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        try {
            // 1.获取数据库连接
            connection = DataBaseUtils.getConn();
            // 2. 调用connection对象的prepareStatement方法用sql获取PreparedStatement对象
            preparedStatement = connection.prepareStatement(sql);
            for (int i = 0; i < args.length; i++) {
                preparedStatement.setObject(i + 1, args[i]);
            }
            // 4. 发送sql语句：调用executeUpdate(sql)方法
            preparedStatement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 5. 关闭数据库资源：由里向外关（先获取的后关闭）
            DataBaseUtils.releaseDB(null, preparedStatement, connection);
        }
    }

    // select（可能查询一个对象，一组对象，某个对象的属性）
    // 查询一个对象
    public <T> T get(Class<T> clazz, String sql, Object... args) throws SQLException {
        T entity = null;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            // 1 得到ResultSet
            connection = DataBaseUtils.getConn();
            preparedStatement = connection.prepareStatement(sql);
            for (int i = 0; i < args.length; i++) {
                preparedStatement.setObject(i + 1, args[i]);
            }
            resultSet = preparedStatement.executeQuery();

            // 2 resultSet.getMetaData得到ResultSetMetaData对象（用来得到列的别名）（数据库类名和对象属性名的映射）
            ResultSetMetaData rsmd = resultSet.getMetaData();

            if (resultSet.next()) { //只得到一个对象，用if就行不需要用while
                // 3 若ResultSet中有记录构造Map<String, Object>(<别名, 值>)键：sql查询的列别名
                Map<String, Object> map = new HashMap<>();

                // 4 处理ResultSet，利用ResultSetMetaData填充map对象
                // 5 由ResultSetMetaData得到结果集合中有多少列
                // 6 由ResultSetMetaData得到每一列的别名，由ResultSet得到每一列的值
                for (int i = 0; i < rsmd.getColumnCount(); i++) { // 处理多个列
                    String columnLabel = rsmd.getColumnLabel(i + 1);
                    Object columnValue = resultSet.getObject(columnLabel);
//                    Object columnValue = resultSet.getObject(i+1);
                    // 填充map对象
                    map.put(columnLabel, columnValue);
                }
                // 7 若map不为空，用反射创建class对应的对象（无参的构造器：用反射创建对象）
                if (map.size() > 0) {
                    entity = clazz.newInstance();
                    // 9 遍历Map对象，利用反射为class对象的entity对应属性赋值
                    for (Map.Entry<String, Object> entry : map.entrySet()) {
                        String fieldName = entry.getKey();
                        Object fieldValue = entry.getValue();
//                    ReflectionUtils.setFieldValue(entity, fieldName, fieldValue);
                        BeanUtils.setProperty(entity, fieldName, fieldValue);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DataBaseUtils.releaseDB(resultSet, preparedStatement, connection);
        }
        return entity;
    }

    public <T> List<T> getForList(Class<T> clazz, String sql, Object... args) throws SQLException {
        List<T> objList = new ArrayList<>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            // 得到ResultSet
            connection = DataBaseUtils.getConn();
            preparedStatement = connection.prepareStatement(sql);
            for (int i = 0; i < args.length; i++) {
                preparedStatement.setObject(i + 1, args[i]);// 填充占位符
            }
            resultSet = preparedStatement.executeQuery();
            // two Extract Methods
            // 处理结果集，得到mapList。其中一个map对象就是一条记录
            List<Map<String, Object>> mapList = resultSet2MapList(resultSet);
            // mapList转成clazz对应类对象的List：objList
            // map的key是数据库列的别名，也是对象的propertyName
            objList = mapList2objList(clazz, mapList);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DataBaseUtils.releaseDB(resultSet, preparedStatement, connection);
        }
        return objList;
    }

    private <T> List<T> mapList2objList(Class<T> clazz, List<Map<String, Object>> mapList) throws InstantiationException, IllegalAccessException, InvocationTargetException {
        List<T> objList = new ArrayList<>();
        T bean = null;
        if (mapList.size() > 0) {
            // 对于每一个map
            for (Map<String, Object> m : mapList) {
                bean = clazz.newInstance();
                // 某个map的每一个entry
                for (Map.Entry<String, Object> entry : m.entrySet()) {
                    String propertyName = entry.getKey();
                    Object propertyValue = entry.getValue();
                    BeanUtils.setProperty(bean, propertyName, propertyValue);
                }
                objList.add(bean);
            }
        }
        return objList;
    }

    // 处理结果集合，得到map的list，其中一个map对象对应一条记录
    private List<Map<String, Object>> resultSet2MapList(ResultSet resultSet) throws SQLException {
        // 准备一个List<Map<String, Object>>，其中一个Map对象对应一条记录
        List<Map<String, Object>> mapList = new ArrayList<>();
        // 2 得到ResultSetMetaData对象（列的别名）
        List<String> columnLabels = getColumnLabels(resultSet);

        // while每次循环都要用一个map，因此可以声明在外面，创建在里面
        Map<String, Object> map = null;
        // 处理ResultSet的时候不用if语句，改用while循环
        while (resultSet.next()) { //只得到一个对象，用if就行不需要用while
            // 3 若ResultSet中有记录构造Map<String, Object>(<别名, 值>)键：sql查询的列别名
            map = new HashMap<>();

            // 4 处理ResultSet，利用ResultSetMetaData填充map对象
            // 5 由ResultSetMetaData得到结果集合中有多少列
            // 6 由ResultSetMetaData得到每一列的别名，由ResultSet得到每一列的值
            for (String columnLabel: columnLabels) { // 处理多个列
                Object columnValue = resultSet.getObject(columnLabel);
//                    Object columnValue = resultSet.getObject(i+1);
                // 填充map对象
                map.put(columnLabel, columnValue);
            }
            // 把填充好的Map对象放入mapList中
            mapList.add(map);
        }
        return mapList;
    }

    // 获取结果集合的ColumnLabels对应的集合
    private List<String> getColumnLabels(ResultSet resultSet) throws SQLException {
        List<String> labels = new ArrayList<>();
        ResultSetMetaData rsmd = resultSet.getMetaData();
        for(int i = 0; i < rsmd.getColumnCount(); i++){
            labels.add(rsmd.getColumnLabel(i+1));
        }
        return labels;
    }

    // 返回某条记录的某一个字段的值，或一个统计的值（一共有多少条记录等）
    public <E> E getForValue(String sql, Object... args) throws SQLException {
        // 1 得到结果集：应该只有一行一列
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DataBaseUtils.getConn();
            preparedStatement = connection.prepareStatement(sql);
            for (int i = 0; i < args.length; i++) {
                preparedStatement.setObject(i + 1, args[i]);
            }
            resultSet = preparedStatement.executeQuery();

            if(resultSet.next()) {
                return (E)resultSet.getObject(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DataBaseUtils.releaseDB(resultSet, preparedStatement, connection);
        }
        // 比如：
        // SELECT COUNT(id) FROM USERS
        // SELECT email FROM USERS WHERE id = 5;
        return null;
    }
}
