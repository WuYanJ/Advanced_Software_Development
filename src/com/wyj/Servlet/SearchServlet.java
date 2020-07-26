package com.wyj.Servlet;

import com.wyj.DAO.DAO;
import com.wyj.DAO.TravelImageDao;
import com.wyj.DAO.TravelUserDao;
import com.wyj.Model.TravelImage;
import com.wyj.Model.TravelUser;
import org.junit.Test;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.io.IOException;
import java.lang.reflect.Method;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

public class SearchServlet extends HttpServlet {
    TravelUserDao travelUserDao = new TravelUserDao();
    TravelImageDao travelImageDao = new TravelImageDao();
    DAO dao = new DAO();
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取servletPath： /edit.do
        String servletPath = request.getServletPath();
        // 得到edit这样的字符串
        String methodName = servletPath.substring(1);
        methodName = methodName.substring(0, methodName.length()-3);
        // 利用反射获取方法
        try {
            Method method = getClass().getDeclaredMethod(methodName, HttpServletRequest.class, HttpServletResponse.class);
            // 利用反射调用方法
            method.invoke(this, request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public void fuzzyQueryUsers(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        String fuzzySearchedUsername = request.getParameter("friendUsername");
        List<TravelUser> userResultSet = travelUserDao.fuzzyGetUsers(fuzzySearchedUsername);
        request.setAttribute("userResultSet", userResultSet);
        request.getRequestDispatcher("/friends.jsp").forward(request, response);
    }

    public void fuzzyQueryImages(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        String fuzzySearchedContent = request.getParameter("searchWith");
        String restrict = request.getParameter("select");
        switch (restrict) {
            case "title": {
                List<TravelImage> imageResultSet = travelImageDao.fuzzyGetImagesByTitle(fuzzySearchedContent);
                request.setAttribute("imageResultSet", imageResultSet);
                request.getRequestDispatcher("/searchResults.jsp").forward(request, response);
                break;
            }
        }
    }

    public void addFriend(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        TravelUser travelUser = (TravelUser) request.getSession().getAttribute("travelUser");
        String fromUser = travelUser.getUsername();
        String toUser = request.getParameter("friend");
        String sql = "INSERT INTO travels.invitation(toUser, fromUser, dateCreated, status)VALUES(?, ?, ?, ?)";
        travelUserDao.update(sql, toUser, fromUser, new Date(), 1);
        response.sendRedirect("/friends.jsp");
    }

    public void agree(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        TravelUser travelUser = (TravelUser) request.getSession().getAttribute("travelUser");
        String toUser = travelUser.getUsername();
        String fromUser = request.getParameter("friend");
        String sql = "UPDATE travels.invitation SET status=2 WHERE toUser=? AND fromUser=?";
        travelUserDao.update(sql, toUser, fromUser);
        response.sendRedirect("/JavaWeb/friends.jsp");
    }
    public void comment(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        String imageURL = request.getParameter("imageURL");
        String username = request.getParameter("username");
        String comment = request.getParameter("comment");
        String sql = "INSERT INTO travels.travelimageComment(imageURL, username, comment, dateCreated, favorAmount)VALUES(?, ?, ?)";
        dao.update(sql, imageURL, username, comment, new Date(), 0);
        response.sendRedirect("/JavaWeb/details.jsp?imageURL="+imageURL);
    }
    public void deleteMyUpload(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        String imageURL = request.getParameter("imageURL");
        String sql = "DELETE FROM travels.travelimage WHERE path=?";
        dao.update(sql, imageURL);
        response.sendRedirect("/JavaWeb/personalInfo.jsp");
    }

    public void ifVisible(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        TravelUser myself = (TravelUser) request.getSession().getAttribute("travelUser");
        String username = myself.getUsername();
        // 1 visible
        // 0 invisible
        String sql = "SELECT ifVisibleToFriend FROM travels.traveluser WHERE username=?";
        long ifVisibleToFriend = dao.getForValue(sql, username);
        if(ifVisibleToFriend != 1){
            sql = "UPDATE travels.traveluser SET ifVisibleToFriend=1 WHERE username=?";
            dao.update(sql, username);
        } else {
            sql = "UPDATE travels.traveluser SET ifVisibleToFriend=0 WHERE username=?";
            dao.update(sql, username);
        }
        response.sendRedirect("/JavaWeb/friends.jsp");
    }

    public void logout(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        request.getSession().invalidate();
        response.sendRedirect("/homepage.jsp");
    }
}
