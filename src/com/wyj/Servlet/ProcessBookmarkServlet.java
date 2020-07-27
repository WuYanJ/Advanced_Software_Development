package com.wyj.Servlet;

import com.wyj.DAO.DAO;
import com.wyj.DAO.TravelImageDao;
import com.wyj.Model.TravelUser;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/processBookmark")
public class ProcessBookmarkServlet extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        DAO dao = new DAO();
        TravelImageDao travelImageDao = new TravelImageDao();
        int imageID = Integer.parseInt(request.getParameter("imageID"));
        String imageURL = null;
        try {
            imageURL = travelImageDao.imageID2path(imageID);
        } catch (Exception e) {
            e.printStackTrace();
        }
        String alreadyBookmarked = request.getParameter("bookmarked");
        HttpSession session = request.getSession();
        TravelUser myself = (TravelUser) session.getAttribute("travelUser");
        int uid = myself.getUID();
        String sql = "INSERT INTO travels.travelimagefavor(uid, imageID) VALUES(?, ?)";
        String sql1 = "UPDATE travels.travelimage SET favor = favor+1  WHERE imageID=?";
        String sqlDelete = "DELETE FROM travels.travelimagefavor WHERE (uid=" + uid + " AND imageID=" + imageID + ")";
        String sqlDelete1 = "UPDATE travels.travelimage SET favor = favor-1  WHERE imageID=?";
        // 若果此前已经收藏过这张照片，将这条收藏记录移除
        if(alreadyBookmarked.equals("true")) {
            try {
                dao.update(sqlDelete);
                dao.update(sqlDelete1, imageID);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } else {
            try {
                dao.update(sql, uid, imageID);
                dao.update(sql1, imageID);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect(request.getContextPath() + "/details.jsp?imageURL=" + imageURL);
    }
}
