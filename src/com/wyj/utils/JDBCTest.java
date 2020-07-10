package com.wyj.utils;

import org.junit.Test;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.Properties;

public class JDBCTest {

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
        System.out.println(DataBaseUtil.getConn());
    }

    @Test
    public void testStatement() throws SQLException {
        Connection connection = null;
        Statement statement = null;

        try {
            // 1.获取数据库连接
            connection = DataBaseUtil.getConn();
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
            DataBaseUtil.releaseDB(null, statement, connection);
        }
    }

    @Test
    public void testInsertBlob() throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        try {
            connection = DataBaseUtil.getConn();
            String sql = "INSERT INTO pj_test.user(username, password, age, picture) VALUES (?, ?, ?, ?)";
            preparedStatement = connection.prepareStatement(sql);
            InputStream inputStream = new FileInputStream("/Users/wuyanjie/JavaEE sample projects/" +
                    "JavaWeb2020Summer/web/static/image/travel-images/small/222222.jpg");
            preparedStatement.setString(1, "wuyanjie");
            preparedStatement.setString(2, "20000813");
            preparedStatement.setInt(3, 19);
            preparedStatement.setBlob(4, inputStream);
            preparedStatement.executeUpdate();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            preparedStatement.close();
            DataBaseUtil.closeConn(connection);
        }
    }
    @Test
    public void testResultSet() throws SQLException {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;
        try {
            // 1. 获取数据库连接
            connection = DataBaseUtil.getConn();
            // 2. 调用connection对象的createStatement方法获取Statement对象
            statement = connection.createStatement();
            // 3. 准备sql语句
            String sql = "SELECT id, username, password, age FROM pj_test.users";
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
            DataBaseUtil.releaseDB(resultSet, statement, connection);
        }
    }
}
