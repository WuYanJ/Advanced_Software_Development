package com.wyj.DAO;

import com.wyj.Model.TravelImage;
import com.wyj.Model.TravelUser;
import com.wyj.Model.User;
import org.junit.Test;

import java.sql.SQLException;
import java.util.List;

public class DAOTest {
    DAO dao = new DAO();
    TravelUserDao travelUserDao = new TravelUserDao();

    @Test
    public void testUpdate() throws SQLException {
        String sql = "INSERT INTO pj_test.user(username, password, age) VALUES(?, ?, ?)";
        dao.update(sql,"huangyixin", "20000105", 20);
    }

    @Test
    public void testGetForList() throws SQLException {
        String sql = "SELECT id, username, password FROM pj_test.user";
        List<User> users = dao.getForList(User.class, sql);
        System.out.println(users);
    }

    @Test
    public void testGetForValue() throws SQLException {
        String sql = "SELECT username FROM pj_test.user WHERE id=?";
        String username = dao.getForValue(sql,2);
        System.out.println(username);

        sql = "SELECT min(age) FROM pj_test.user";
        int age = dao.getForValue(sql);
        System.out.println(age);
    }

    @Test
    public void testGetMyBookmarkedImageIds() throws SQLException {
        String sql = "SELECT imageID FROM travels.travelimagefavor WHERE uid=12";
        List<TravelImage> images = dao.getForList(TravelImage.class, sql);
        System.out.println(images);
    }

    @Test
    public void testGetUser() throws SQLException {
        TravelUser user = travelUserDao.getUser("luisg");
        System.out.println(user.getEmail());
    }

    @Test
    public void testFuzzyGetUsers() throws SQLException {
        List<TravelUser> users = travelUserDao.fuzzyGetUsers("s");
        System.out.println(users.size());
    }
    @Test
    public void testGetForValueList() throws SQLException {
        String sql = "SELECT fromUser FROM travels.invitation WHERE toUser=?";
        List<String> list = dao.getForValueList(sql, "jacksmith");
        System.out.println(list.size());
    }
}
