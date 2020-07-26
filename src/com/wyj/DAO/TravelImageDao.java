package com.wyj.DAO;

import com.wyj.Model.TravelImage;
import com.wyj.Model.TravelImageNFavor;
import com.wyj.Model.TravelUser;
import com.wyj.Utils.DataBaseUtils;
import org.junit.Test;

import javax.xml.crypto.Data;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TravelImageDao extends DAO{
    // 已测试(map<path, favorAmount>)，从数据库获得favorAmount最高的几张图片的<url, favorAmount>对
    public Map<String, Integer> getHottestImage(int amount) throws SQLException, IOException, ClassNotFoundException {
        Connection connection = null;
        Statement statement = null;
        String path = null;
        ResultSet resultSet = null;
        Map<String, Integer> hottestImageFavorMap = new HashMap<>();
        String sql = "SELECT imageID, favorAmount FROM travels.travelimageFavorAmount order by favorAmount desc limit " + amount;
        List<TravelImageNFavor> travelImageNFavorList = getForList(TravelImageNFavor.class, sql);
        for(TravelImageNFavor travelImageNFavor: travelImageNFavorList) {
            sql = "SELECT path FROM travels.travelimage WHERE imageID=" + travelImageNFavor.getImageID();
            connection = DataBaseUtils.getConn();
            statement = connection.createStatement();
            resultSet = statement.executeQuery(sql);
            if(resultSet.next()) {
                path = resultSet.getString(1);
            }
            hottestImageFavorMap.put(path, travelImageNFavor.getFavorAmount());
        }
        DataBaseUtils.releaseDB(resultSet, statement, connection);
        return hottestImageFavorMap;
    }
    // 已测试
    public List<TravelImage> getLatestImage(int amount) throws SQLException {
        String sql = "SELECT imageID, title, description, latitude, longitude, cityCode, country_regionCodeISO country_regionCode, UID, path, content, topic  FROM travels.travelimage order by updatedDate desc limit " + amount;
        List<TravelImage> travelImage = getForList(TravelImage.class, sql);
        return travelImage;
    }

    // 已测试
    public TravelImage getImage(String path) throws SQLException {
        String sql = "SELECT ImageID imageID, Title title, Description description," +
                "Latitude latitude, Longitude longitude, CityCode cityCode, Country_RegionCodeISO country_regionCode," +
                "UID, PATH path, Content content FROM travels.travelimage WHERE path='" + path + "'";
        TravelImage image = get(TravelImage.class, sql);
        sql = "SELECT count(favorID) FROM travels.travelimagefavor WHERE imageID=?";
        long favorAmount = getForValue(sql, image.getImageID());
        sql = "SELECT username FROM travels.traveluser WHERE uid=?";
        String photographer = getForValue(sql, image.getUID());
        image.setFavorAmount(favorAmount);
        image.setPhotographer(photographer);
        return image;
    }

    public String imageID2path(int imageID) throws SQLException, IOException, ClassNotFoundException {
        Connection connection = null;
        Statement statement = null;
        String path = null;
        ResultSet resultSet = null;
        String sql = "SELECT PATH FROM travels.travelimage WHERE imageID=" + imageID;
        connection = DataBaseUtils.getConn();
        statement = connection.createStatement();
        resultSet = statement.executeQuery(sql);
        if(resultSet.next()) {
            path = resultSet.getString(1);
        }
        return path;
    }
    public int path2imageID(String path) throws SQLException, IOException, ClassNotFoundException {
        Connection connection = null;
        Statement statement = null;
        int imageID = 0;
        ResultSet resultSet = null;
        String sql = "SELECT imageID FROM travels.travelimage WHERE path='" + path + "'";
        connection = DataBaseUtils.getConn();
        statement = connection.createStatement();
        resultSet = statement.executeQuery(sql);
        if(resultSet.next()) {
            imageID = resultSet.getInt(1);
        }
        return imageID;
    }

    // 已测试
    public List<TravelImage> getMyImages(String username) throws SQLException {
        String sql = "SELECT UID, email, username, state FROM travels.traveluser WHERE username='" + username + "'";
        // 先在traveluser表中用username找到UID
        TravelUser myself = get(TravelUser.class, sql);
        // 再在travelimage表中用UID找到myImageList
        sql = "SELECT ImageID imageID, Title title, Description description," +
                "Latitude latitude, Longitude longitude, CityCode cityCode, Country_RegionCodeISO country_regionCode," +
                "UID, PATH path, Content content FROM travels.travelimage WHERE UID=" + myself.getUID();
        return getForList(TravelImage.class, sql);
    }

    public List<Integer> getMyBookmarkedImageIds(int uid) throws SQLException, IOException, ClassNotFoundException {
        List<Integer> myBookmarkedImageIds = new ArrayList<Integer>();
        String sql = "SELECT imageID FROM travels.travelimagefavor WHERE uid=" + uid;
        List<TravelImage> images = getForList(TravelImage.class, sql);
        for(int i = 0;i < images.size(); i++){
            myBookmarkedImageIds.add(images.get(i).getImageID());
        }
        return myBookmarkedImageIds;
    }

    public List<TravelImage> fuzzyGetImagesByTitle(String titleCrackle) throws SQLException {
        String sql = "SELECT ImageID imageID, Title title, Description description," +
                "Latitude latitude, Longitude longitude, CityCode cityCode, Country_RegionCodeISO country_regionCode," +
                "UID, PATH path, Content content FROM travels.travelimage WHERE title LIKE '%" + titleCrackle + "%'";
        return getForList(TravelImage.class, sql);
    }
}
