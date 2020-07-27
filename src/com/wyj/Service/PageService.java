package com.wyj.Service;

import com.wyj.DAO.PageDAO;
import com.wyj.Model.Page;
import com.wyj.Model.TravelImage;
import com.wyj.Model.TravelUser;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class PageService {
    PageDAO pageDAO = new PageDAO();
    public Page<TravelImage> pageMyBookmarks(int pageNo, int pageSize, int uid) throws SQLException, IOException, ClassNotFoundException {
        Page<TravelImage> pageMyBookmarks = new Page<>();
        // 赋值
        pageMyBookmarks.setPageNo(pageNo);
        pageMyBookmarks.setPageSize(pageSize);
        // 总记录数
        long recordCount = pageDAO.getMyBookmarksRecordCount(uid);
        // 设置总记录数
        pageMyBookmarks.setRecordCount(recordCount);
        // 总页数
        long pageTotal = recordCount / pageSize;
        if(recordCount % pageSize > 0) {
            pageTotal += 1;
        }
        pageMyBookmarks.setPageTotal(pageTotal);

        // 求开始索引
        int begin = (pageNo - 1) * pageSize;
        List<TravelImage> items = pageDAO.getMyBookmarksPageItems(begin, pageSize, uid);
        pageMyBookmarks.setItems(items);

        return pageMyBookmarks;
    }

}
