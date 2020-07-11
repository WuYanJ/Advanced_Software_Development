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
    public boolean userExist(String username) throws ClassNotFoundException, SQLException, InstantiationException, IOException, IllegalAccessException {
        Connection conn = DataBaseUtils.getConn();
        String sql = "SELECT * FROM tb_user WHERE username = ?";
        try {
            PreparedStatement preparedStatement = conn.prepareStatement(sql);
            preparedStatement.setString(1, username);
            //执行查询，获取结果集
            ResultSet resultSet = preparedStatement.executeQuery();
            while (!resultSet.next()) {
                return true;
            }
            //释放资源
            resultSet.close();
            preparedStatement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DataBaseUtils.closeConn(conn);
        }
        return true;
    }

    //将用户存入数据库
    public void saveUser(User user) throws ClassNotFoundException, SQLException, InstantiationException, IOException, IllegalAccessException {
        Connection conn = DataBaseUtils.getConn();
        String sql = "INSERT INTO tb_user(username,password" +
                ",question,answer,email) values(?,?,?,?,?,?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getQuestion());
            ps.setString(4, user.getAnswer());
            ps.setString(5, user.getEmail());
            //执行更新操作
            ps.executeUpdate();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
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
