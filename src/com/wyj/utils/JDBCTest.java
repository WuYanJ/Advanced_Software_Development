package com.wyj.utils;

import org.junit.Test;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Driver;
import java.sql.SQLException;
import java.util.Properties;

public class JDBCTest {
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
}
