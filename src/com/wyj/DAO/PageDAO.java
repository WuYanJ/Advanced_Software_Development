package com.wyj.DAO;

import com.wyj.Model.TravelImage;
import com.wyj.Model.TravelUser;
import org.junit.Test;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PageDAO extends DAO {
    TravelUserDao travelUserDao = new TravelUserDao();
    // 已测试
    public long getMyBookmarksRecordCount(int uid) throws SQLException {
        // 求总记录数
        String sql = "SELECT count(*) FROM travels.travelimagefavor WHERE uid=?";
        return getForValue(sql, uid);
    }

    // 已测试
    public List<TravelImage> getMyBookmarksPageItems(int begin, int pageSize, int uid) throws SQLException, IOException, ClassNotFoundException {
        List<TravelImage> myBookmarksPageItems = new ArrayList<>();
        List<String> bookmarkList = travelUserDao.getMyBookmarkedImagePaths(uid);
        String sql = "SELECT ImageID imageID, Title title, Description description," +
                "     Latitude latitude, Longitude longitude, CityCode cityCode, Country_RegionCodeISO country_regionCode," +
                "     UID, PATH path, Content content FROM travels.travelimage WHERE path=? limit ?, ?";
        for (String path : bookmarkList){
            TravelImage image = get(TravelImage.class, sql, path, begin, pageSize);
            myBookmarksPageItems.add(image);
        }
        return myBookmarksPageItems;
    }

    public long getMyImagesRecordCount(int uid) throws SQLException {
        // 求总记录数
        String sql = "SELECT count(*) FROM travels.travelimage WHERE uid=?";
        return getForValue(sql, uid);
    }

    public List<TravelImage> getMyImagesPageItems(int begin, int pageSize, int uid) throws SQLException {
        List<TravelImage> myImagesPageItems = new ArrayList<>();
        String sql = "SELECT ImageID imageID, Title title, Description description," +
                "     Latitude latitude, Longitude longitude, CityCode cityCode, Country_RegionCodeISO country_regionCode," +
                "     UID, PATH path, Content content FROM travels.travelimage WHERE uid=? limit ?, ?;";
        myImagesPageItems = getForList(TravelImage.class, sql, uid, begin, pageSize);
        return myImagesPageItems;
    }
}
