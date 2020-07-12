package com.wyj.Utils;



import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.Properties;

/*
* 操作jdbc的工具类，其中封装了一些工具方法
* */
public class DataBaseUtils {
    // 工具方法：获取connection
    // 通过读取配置文件，从数据库服务器获取一个连接
    public static Connection getConn() throws ClassNotFoundException, SQLException, IOException {
        String driverClass = null;
        String url = null;
        String user = null;
        String password = null;

        // 读取jdbc.properties文件
        InputStream in =
                DataBaseUtils.class.getClassLoader().getResourceAsStream("com/wyj/Utils/jdbc.properties");
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

    // 执行sql的方法
    // sql：insert, update, delete，而不包含select
    // 这个方法是有问题的。现在每次执行一个sql语句都要创建一个connection
    public static void update(String sql) throws SQLException {
        Connection connection = null;
        Statement statement = null;

        try {
            // 1.获取数据库连接
            connection = getConn();
            // 2. 调用connection对象的createStatement方法获取Statement对象
            statement = connection.createStatement();
            // 3. 准备sql语句

            // 4. 发送sql语句：调用Statement对象的executeUpdate(sql)方法
            statement.executeUpdate(sql);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 5. 关闭数据库资源：由里向外关（先获取的后关闭）
            releaseDB(null, statement, connection);
        }
    }

    public static void update(String sql, Object...args) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        try {
            // 1.获取数据库连接
            connection = getConn();
            // 2. 调用connection对象的prepareStatement方法用sql获取PreparedStatement对象
            preparedStatement = connection.prepareStatement(sql);
            for(int i = 0;i < args.length; i++){
                preparedStatement.setObject(i+1, args[i]);
            }
            // 4. 发送sql语句：调用executeUpdate()方法
            preparedStatement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 5. 关闭数据库资源：由里向外关（先获取的后关闭）
            releaseDB(null, preparedStatement, connection);
        }
    }
}
