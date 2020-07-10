package com.wyj.utils;



import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DataBaseUtil {

    public static Connection getConn() throws ClassNotFoundException, IllegalAccessException, InstantiationException, SQLException, IOException {
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

    //关闭数据库
    public static void closeConn(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
