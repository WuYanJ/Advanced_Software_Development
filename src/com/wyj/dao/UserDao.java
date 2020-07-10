package com.wyj.dao;

import com.wyj.model.User;
import com.wyj.utils.DataBaseUtil;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDao {
//    查询数据库，判断用户名是否已经被注册
    public boolean userExist(String username) throws ClassNotFoundException, SQLException, InstantiationException, IOException, IllegalAccessException {
        Connection conn = DataBaseUtil.getConn();
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
            DataBaseUtil.closeConn(conn);
        }
        return true;
    }

    //将用户存入数据库
    public void saveUser(User user) throws ClassNotFoundException, SQLException, InstantiationException, IOException, IllegalAccessException {
        Connection conn = DataBaseUtil.getConn();
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

    public User login(String username, String password) throws ClassNotFoundException, SQLException, InstantiationException, IOException, IllegalAccessException {
        //实例化一个用户对象
        User user = null;
        Connection conn = DataBaseUtil.getConn();
        String sql = "SELECT * FROM tb_user WHERE username = ? and password = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            //执行查询，获取结果集
            ResultSet rs = ps.executeQuery();

            //判断结果是否有效，若有效则对currentUser进行赋值
            while (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setQuestion(rs.getString("question"));
                user.setAnswer(rs.getString("answer"));
                user.setEmail(rs.getString("email"));
            }

            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DataBaseUtil.closeConn(conn);
        }
        return user;
    }
}
