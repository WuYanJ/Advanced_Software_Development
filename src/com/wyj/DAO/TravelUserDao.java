package com.wyj.DAO;

import com.wyj.Model.TravelUser;
import com.wyj.Model.User;
import com.wyj.Utils.DataBaseUtils;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TravelUserDao extends DAO{
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

    public List<String> getMyBookmarkedImagePaths(int uid) throws SQLException, IOException, ClassNotFoundException {
        TravelImageDao travelImageDao = new TravelImageDao();
        List<Integer> myBookmarkedImageIds = travelImageDao.getMyBookmarkedImageIds(uid);

        List<String> bookmarkList = new ArrayList<String>();
        for (Integer myBookmarkedImageId : myBookmarkedImageIds) {
            try {
                bookmarkList.add(travelImageDao.imageID2path(myBookmarkedImageId));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return bookmarkList;
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

    public TravelUser get(int uid) {
        return null;
    }

    public TravelUser getUser(String username) throws SQLException {
        String sql = "SELECT uid, email, username, pass password, state, dateJoined, dateLastModified FROM travels.traveluser WHERE username='" + username + "'";
        return get(TravelUser.class, sql);
    }

    public List<TravelUser> fuzzyGetUsers(String usernameCrackle) throws SQLException {
        String sql = "SELECT uid, email, username, pass password, state, dateJoined, dateLastModified FROM travels.traveluser WHERE username LIKE '%" + usernameCrackle + "%'";
        return getForList(TravelUser.class, sql);
    }

    public List<TravelUser> getFriends(String username) throws SQLException {
        List<TravelUser> friends = new ArrayList<>();
        String sql = "SELECT fromUser FROM travels.invitation WHERE (toUser=? OR fromUser=?) AND status=2 ";
        List<String> friendNames = getForValueList(sql, username, username);
        sql = "SELECT uid, email, username, pass password, state, dateJoined, dateLastModified FROM travels.traveluser WHERE username=?";
        for (String name: friendNames){
            TravelUser user = get(TravelUser.class, sql, name);
            friends.add(user);
            if(user.getUsername().equals(username)){
                friends.remove(user);
            }
        }
        return friends;
    }
}
