package com.wyj.Test;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import com.wyj.Model.TravelImage;
import com.wyj.Model.User;
import com.wyj.Utils.DataBaseUtils;
import com.wyj.Utils.ReflectionUtils;
import org.apache.commons.dbcp2.BasicDataSource;
import org.apache.commons.dbcp2.BasicDataSourceFactory;
import org.junit.Test;

import javax.sql.DataSource;
import javax.xml.crypto.Data;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Scanner;

public class JDBCTest {


    @Test
    public void testDBUtils() throws SQLException, IOException, ClassNotFoundException {
        Connection connection = DataBaseUtils.getConn();
        System.out.println(connection);
    }
    @Test
    public void testC3P0WithConfigFile() throws SQLException {
        DataSource dataSource = new ComboPooledDataSource("helloc3p0");
        System.out.println(dataSource.getConnection());
        ComboPooledDataSource comboPooledDataSource =
                (ComboPooledDataSource)dataSource;
        System.out.println(comboPooledDataSource.getMaxStatements());
    }

    // 创建数据库连接池
    @Test
    public void testDBCP() throws SQLException {
        BasicDataSource dataSource = new BasicDataSource();
        // 创建DBCP数据源实例
        // 为数据源实例指定必须的属性
        dataSource.setUsername("root");
        dataSource.setPassword("wuyanjie!20000813");
        dataSource.setUrl("jdbc:mysql:///travels");
        dataSource.setDriverClassName("com.mysql.jdbc.Driver");
        // 指定数据源的可选属性
        // 指定初始化连接个数
        dataSource.setInitialSize(50);
        // 从数据源中获取数据库连接
        Connection connection = dataSource.getConnection();
        System.out.println(connection.getClass());
    }

    @Test
    public void testDBCPWithDataSourceFactory() throws Exception {
        Properties properties = new Properties();
        InputStream inputStream = JDBCTest.class.getClassLoader()
                .getResourceAsStream("dbcp.properties");
        properties.load(inputStream);
        DataSource dataSource =
                BasicDataSourceFactory.createDataSource(properties);
        System.out.println(dataSource.getConnection().getClass());
        BasicDataSource basicDataSource = (BasicDataSource)dataSource;
        System.out.println(basicDataSource.getMaxWaitMillis());
    }

    @Test
    public void testGetConnection() throws ClassNotFoundException, SQLException {
        String user = "root";
        String password = "wuyanjie!20000813";
        String url = "jdbc:mysql:///travels";//可以直接把localhost:3306省略
        String driverClass = "com.mysql.jdbc.Driver";

        Class.forName(driverClass);
        Connection connection = DriverManager.getConnection(url, user, password);
        System.out.println(connection);
    }
    @Test
    public void testDriver() throws SQLException {
        Driver driver = new com.mysql.jdbc.Driver();
        String url = "jdbc:mysql://localhost:3306/travels";
        Properties info = new Properties();
        info.put("user", "root");
        info.put("password", "wuyanjie!20000813");

        Connection connection = driver.connect(url, info);
        System.out.println(connection);
    }

    @Test
    public void testDBUtil() throws ClassNotFoundException, SQLException, InstantiationException, IOException, IllegalAccessException {
        System.out.println(DataBaseUtils.getConn());
    }

    @Test
    public void testStatement() throws SQLException {
        Connection connection = null;
        Statement statement = null;

        try {
            // 1.获取数据库连接
            connection = DataBaseUtils.getConn();
            // 2. 调用connection对象的createStatement方法获取Statement对象
            statement = connection.createStatement();
            // 3. 准备sql语句
            String sql = "INSERT INTO travels.geocities(GeoNameID)VALUES (164329)";
            // 4. 发送sql语句：调用Statement对象的executeUpdate(sql)方法
            statement.executeUpdate(sql);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 5. 关闭数据库资源：由里向外关（先获取的后关闭）
            DataBaseUtils.releaseDB(null, statement, connection);
        }
    }

    //testPreparedStatement
    @Test
    public void testInsertBlob() throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        try {
            connection = DataBaseUtils.getConn();
            String sql = "INSERT INTO pj_test.user(username, password, age, picture) VALUES (?, ?, ?, ?)";
            preparedStatement = connection.prepareStatement(sql);
            InputStream inputStream = new FileInputStream("/Users/wuyanjie/JavaEE sample projects/" +
                    "JavaWeb2020Summer/web/static/image/travel-images/small/222222.jpg");

            // 设置占位符
            preparedStatement.setString(1, "wuyanjie");
            preparedStatement.setString(2, "20000813");
            preparedStatement.setInt(3, 19);
            preparedStatement.setBlob(4, inputStream);
            preparedStatement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            preparedStatement.close();
            DataBaseUtils.closeConn(connection);
        }
    }
    @Test
    public void testResultSet() throws SQLException {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;
        try {
            // 1. 获取数据库连接
            connection = DataBaseUtils.getConn();
            // 2. 调用connection对象的createStatement方法获取Statement对象
            statement = connection.createStatement();
            // 3. 准备sql语句
            String sql = "SELECT id, username, password, age FROM pj_test.user";
            // 4. 发送sql语句：调用Statement对象的executeQuery(sql)方法得到结果集合对象ResultSet
            resultSet = statement.executeQuery(sql);
            // 5. 处理结果集合ResultSet
            //     (1. 调用ResultSet的next()方法，查看结果集合的下一条记录是否有效。若有效，则下移指针
            while (resultSet.next()) {
                //     (2. getXxx()方法获取具体的列的值
                int id = resultSet.getInt(1);
                String username = resultSet.getString(2);
                String password = resultSet.getString(3);
                int age = resultSet.getInt(4);
                System.out.println(id);
                System.out.println(username);
                System.out.println(password);
                System.out.println(age);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 5. 关闭数据库资源
            DataBaseUtils.releaseDB(resultSet, statement, connection);
        }
    }


    @Test
    public void testGetTravelImage() throws SQLException {
        //1 得到查询类型
        int searchType = getSearchTypeFromConsole();
        //2 根据类型，用sql查询TravelImage对象
        TravelImage travelImage = searchTravelImage(searchType);
        // 打印结果
        printImage(travelImage);
    }


    // 从控制台读入一个整数，确定要查询的类型.
    // 如果输入的是1，7以外的整数，提示重新输入
    private int getSearchTypeFromConsole(){
        //        System.out.print("请输入查询类型:");
//        Scanner scanner = new Scanner(System.in);
//        int type = scanner.nextInt();
        int type = 1;
        if(type != 1 && type != 7) {
            System.out.println("输入有误，请重新输入");
            throw new RuntimeException();// 使程序中断
        }

        return type;
    }

    //具体查询image信息，返回一个TravelImage对象。
    private TravelImage searchTravelImage(int searchType) throws SQLException {

        // 1. 根据输入的searchType提示用户输入信息
        String sql = "SELECT ImageID, title, description, latitude, longitude, cityCode," +
                " country_regionCodeISO, UID, path, Content" +
                " FROM travels.travelimage WHERE ";

        Scanner scanner = new Scanner(System.in);
        // 1.1 若searchType为1，提示输入imageID，若为7，输入UID
        if(searchType == 1){
//            System.out.print("输入imageID:");
//            int imageID = scanner.nextInt();
            int imageID = 34;
            sql = sql + "ImageID = " + imageID;
        } else {
//            System.out.print("输入UID:");
//            int UID = scanner.nextInt();
            int UID = 3;
            sql = sql + "UID = " + UID;
        }
        // 2. 根据searchType确定sql
        // 3. 执行查询
        // 4. 若存在查询结果，把查询结果封装为一个Student对象
        return getTravelImage(sql);
    }
// 根据传入的sql返回TravelImage对象
    private TravelImage getTravelImage(String sql) throws SQLException {
        TravelImage travelImage = null;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DataBaseUtils.getConn();
            statement = connection.createStatement();
            resultSet = statement.executeQuery(sql);

            if(resultSet.next()) {
                travelImage = new TravelImage(resultSet.getInt(1),resultSet.getString(2),
                        resultSet.getString(3), resultSet.getDouble(4), resultSet.getDouble(5),
                        resultSet.getString(6), resultSet.getString(7),
                        resultSet.getInt(8), resultSet.getString(9), resultSet.getString(10), null);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DataBaseUtils.releaseDB(resultSet, statement, connection);
        }
        return travelImage;
    }

    private void printImage(TravelImage travelImage){
        if(travelImage != null) {
            System.out.println(travelImage);
        } else {
            System.out.println("查无此人");
        }
    }

    public TravelImage getTravelImage(String sql, Object ... args) throws SQLException {
        TravelImage travelImage = null;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DataBaseUtils.getConn();
            preparedStatement = connection.prepareStatement(sql);
            for(int i = 0; i < args.length; i++) {
                preparedStatement.setObject(i+1, args[i]);
            }
            resultSet = preparedStatement.executeQuery(sql);

            if(resultSet.next()) {
                travelImage = new TravelImage();
                travelImage.setImageID(resultSet.getInt(1));
                travelImage.setTitle(resultSet.getString(2));
                travelImage.setDescription(resultSet.getString(3));
                travelImage.setLatitude(resultSet.getDouble(4));
                travelImage.setLongitude(resultSet.getDouble(5));
                travelImage.setCityCode(resultSet.getString(6));
                travelImage.setCountry_regionCode(resultSet.getString(7));
                travelImage.setUID(resultSet.getInt(8));
                travelImage.setPath(resultSet.getString(9));
                travelImage.setContent(resultSet.getString(10));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DataBaseUtils.releaseDB(resultSet, preparedStatement, connection);
        }
        return travelImage;
    }

    @Test
    public void testGet() throws SQLException {
        String sql = "SELECT username, password FROM pj_test.user WHERE id=?";
        // sql的列和类属性之间如何建立关系
        User user = get(User.class, sql, 1);
        System.out.println(user);
    }


    @Test
    public void testResultSetMetaData(){
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            String sql = "SELECT username usnm, password pswd FROM pj_test.user WHERE id= ?";
            connection = DataBaseUtils.getConn();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1,1);
            resultSet = preparedStatement.executeQuery();
            Map<String, Object> map = new HashMap<String, Object>();
            //1. 得到resultSetMetaData对象
            ResultSetMetaData rsmd = resultSet.getMetaData();

            // 用while遍历结果集合
            while(resultSet.next()){
                //2. 打印每一列的列名
                for(int i = 0;i < rsmd.getColumnCount();i++){
                    // 列的别名，从1开始
                    String columnLabel = rsmd.getColumnLabel(i+1);
                    Object columnValue = resultSet.getObject(columnLabel);
                    map.put(columnLabel, columnValue);
                }
            }
//            System.out.println(map);
            Class clazz = User.class;
            Object object = clazz.newInstance();
            // 为这个对象的属性一个个赋值.对象有哪些属性要看columnLabel(用map)
            // map用Entry遍历
            for(Map.Entry<String, Object> entry: map.entrySet()){
                String fieldName = entry.getKey();
                Object fieldValue = entry.getValue();
                System.out.println(fieldName + ": " + fieldValue);

                // 之后可以用ReflectionUtils中的反射方法为对象赋值
                // ReflectionUtils.setFieldValue(object, fieldName, fieldValue);
                // 于是object就被成功赋值
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 通用的从数据库得到对象的get方法（参数是对象类名，sql语句和查询参数）
    public <T> T get(Class<T> clazz, String sql, Object...args) throws SQLException {
        T entity = null;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            // 1 得到ResultSet对象
            connection = DataBaseUtils.getConn();
            preparedStatement = connection.prepareStatement(sql);
            for(int i = 0; i < args.length; i++) {
                preparedStatement.setObject(i+1, args[i]);
            }
            resultSet = preparedStatement.executeQuery(sql);
            // 2 得到ResultSetMetaData对象（用来得到列的别名）
            ResultSetMetaData rsmd = resultSet.getMetaData();

            //3 创建一个Map<String, Object>对象，键：sql查询的列别名
            Map<String, Object> map = new HashMap<>();
            //4 处理ResultSet，利用ResultSetMetaData填充map对象
            if(resultSet.next()){ //只得到一个对象，用if就行不需要用while
                for(int i = 0;i < rsmd.getColumnCount();i++){ // 处理多个列
                    String columnLabel = rsmd.getColumnLabel(i+1);
                    Object columnValue = resultSet.getObject(columnLabel);
//                    Object columnValue = resultSet.getObject(i+1);
                    map.put(columnLabel, columnValue);
                }
            }
            //5 若map不为空，利用反射创建clazz对应类的对象。
            if(map.size() > 0) {
                entity = clazz.newInstance();
                //6 遍历map，利用反射为class对象的对应属性赋值
                for(Map.Entry<String, Object> entry : map.entrySet()) {
                    String fieldName = entry.getKey();
                    Object fieldValue = entry.getValue();
                    ReflectionUtils.setFieldValue(entity, fieldName, fieldValue);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DataBaseUtils.releaseDB(resultSet, preparedStatement, connection);
        }
        return entity;
    }
}
