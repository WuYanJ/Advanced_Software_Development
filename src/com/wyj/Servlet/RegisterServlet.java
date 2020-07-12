package com.wyj.Servlet;

import com.wyj.DAO.TravelUserDao;
import com.wyj.Model.TravelUser;
import com.wyj.Model.User;
import com.wyj.Utils.DataBaseUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("text/html;charset=utf-8");
        request.setCharacterEncoding("utf-8");

        //获取用户注册信息
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        //实例化TravelUserDao对象
        TravelUserDao travelUserDao = new TravelUserDao();

        try {
            if (!travelUserDao.travelUserExist(username)) {
                //实例化一个User对象
                TravelUser newTravelUser = new TravelUser();

                //对用户对象的属性进行赋值
                newTravelUser.setUsername(username);
                newTravelUser.setPassword(password);
                newTravelUser.setEmail(email);
                newTravelUser.setDateJoined(new java.util.Date());

                // 在数据库中存储newUser对象
                travelUserDao.saveTravelUser(newTravelUser);

                response.sendRedirect("personalInfo.jsp?username=" + username);
            } else {
                request.setAttribute("info", "错误操作，请重新注册! <br>");
                request.getRequestDispatcher("message.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
