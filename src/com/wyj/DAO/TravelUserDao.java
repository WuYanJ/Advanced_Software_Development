package com.wyj.DAO;

import com.wyj.Model.TravelUser;
import com.wyj.Model.User;
import com.wyj.Utils.DataBaseUtils;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class TravelUserDao {
//    查询数据库，判断用户名是否已经被注册
    public boolean travelUserExist(String username) throws ClassNotFoundException, SQLException, IOException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        String sql = "SELECT * FROM travels.traveluser WHERE username = ?";
        try {
            connection = DataBaseUtils.getConn();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, username);
            //执行查询，获取结果集
            resultSet = preparedStatement.executeQuery();
            if (!resultSet.next()) {
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DataBaseUtils.releaseDB(resultSet, preparedStatement, connection);
        }
        return true;
    }

    //将用户存入数据库
    public void saveTravelUser(TravelUser travelUser) throws ClassNotFoundException, SQLException, IOException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        String sql = "INSERT INTO travels.traveluser(email, username, pass" +
                ", dateJoined) values(?,?,?,?)";
        try {
            connection = DataBaseUtils.getConn();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setObject(1, travelUser.getEmail());
            preparedStatement.setObject(2, travelUser.getUsername());
            preparedStatement.setObject(3, travelUser.getPassword());
            preparedStatement.setObject(4, travelUser.getDateJoined());
            //执行更新操作
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DataBaseUtils.releaseDB(null, preparedStatement, connection);
        }
    }

    public TravelUser login(String username, String password) throws ClassNotFoundException, SQLException, InstantiationException, IOException, IllegalAccessException {
        //实例化一个用户对象
        TravelUser travelUser = null;
        Connection connection = DataBaseUtils.getConn();
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        String sql = "SELECT * FROM travels.traveluser WHERE username = ? and pass = ?";
        try {
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);
            //执行查询，获取结果集
            resultSet = preparedStatement.executeQuery();

            //判断结果是否有效，若有效则对travelUser进行赋值
            while (resultSet.next()) {
                travelUser = new TravelUser();
                travelUser.setUID(resultSet.getInt(1));
                travelUser.setEmail(resultSet.getString(2));
                travelUser.setUsername(resultSet.getString(3));
                travelUser.setPassword(resultSet.getString(4));
                travelUser.setState(resultSet.getInt(5));
                travelUser.setDateJoined(resultSet.getDate(6));
                travelUser.setDateJoined(resultSet.getDate(7));
            }
            resultSet.close();
            preparedStatement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DataBaseUtils.releaseDB(resultSet, preparedStatement, connection);
        }
        return travelUser;
    }
}
