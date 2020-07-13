package com.wyj.DAO;

import com.wyj.Model.TravelImage;
import com.wyj.Model.TravelImageNFavor;
import com.wyj.Model.TravelUser;
import com.wyj.Utils.DataBaseUtils;
import org.junit.Test;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class TravelImageDao extends DAO{
    // 已测试
    public List<String> getHottestImage(int amount) throws SQLException, IOException, ClassNotFoundException {
        Connection connection = null;
        Statement statement = null;
        String path = null;
        ResultSet resultSet = null;
        List<String> hottestURLs = new ArrayList<>();
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
            hottestURLs.add(path);
        }
        return hottestURLs;
    }

    public List<TravelImage> getLatestImage(int amount) {
        return null;
    }

    // 已测试
    private TravelImage getImage(String path) throws SQLException {
        String sql = "SELECT ImageID imageID, Title title, Description description," +
                "Latitude latitude, Longitude longitude, CityCode cityCode, Country_RegionCodeISO country_regionCode," +
                "UID, PATH path, Content content FROM travels.travelimage WHERE path=" + path;
        return get(TravelImage.class, sql);
    }

    // 已测试
    List<TravelImage> getMyImages(String username) throws SQLException {
        String sql = "SELECT UID, email, username, state FROM travels.traveluser WHERE username=" + username;
        // 先在traveluser表中用username找到UID
        TravelUser myself = get(TravelUser.class, sql);
        // 再在travelimage表中用UID找到myImageList
        sql = "SELECT ImageID imageID, Title title, Description description," +
                "Latitude latitude, Longitude longitude, CityCode cityCode, Country_RegionCodeISO country_regionCode," +
                "UID, PATH path, Content content FROM travels.travelimage WHERE UID=" + myself.getUID();
        System.out.println(getForList(TravelImage.class, sql).get(0));
        return getForList(TravelImage.class, sql);
    }
}