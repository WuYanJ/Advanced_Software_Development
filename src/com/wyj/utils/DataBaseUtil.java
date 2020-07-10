package com.wyj.utils;



import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.Properties;

/*
* 操作jdbc的工具类，其中封装了一些工具方法
* */
public class DataBaseUtil {
    // 工具方法：获取connection
    // 通过读取配置文件，从数据库服务器获取一个连接
    public static Connection getConn() throws ClassNotFoundException, SQLException, IOException {
        String driverClass = null;
        String url = null;
        String user = null;
        String password = null;

        // 读取jdbc.properties文件
        InputStream in =
                DataBaseUtil.class.getClassLoader().getResourceAsStream("jdbc.properties");
        Properties properties = new Properties();
        properties.load(in);
        driverClass = properties.getProperty("driver");
        url = properties.getProperty("url");
        user = properties.getProperty("user");
        password = properties.getProperty("password");

        // 通过DriverManager的getConnection方法获取数据库连接
        Class.forName(driverClass);
        Connection conn = DriverManager.getConnection(url,
                user, password);
        return conn;
    }

    //关闭数据库连接
    public static void closeConn(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // 关闭数据库资源
    public static void releaseDB(ResultSet resultSet, Statement statement,
                                 Connection connection) throws SQLException {
        if(resultSet != null) {
            try {
                resultSet.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        if(statement != null) {
            try {
                statement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        if(connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
