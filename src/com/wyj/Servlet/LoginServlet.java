package com.wyj.Servlet;

import com.wyj.DAO.TravelUserDao;
import com.wyj.Model.TravelUser;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("text/html;charset=utf-8");
        request.setCharacterEncoding("utf-8");
        TravelUserDao travelUserDao = new TravelUserDao();
        // 从request获取用户登陆信息
        String usernameORemail = request.getParameter("usernameORemail");
        String password = request.getParameter("password");
//        System.out.println("username:"+usernameORemail+"; password="+password);
        try {
            TravelUser travelUser = travelUserDao.login(usernameORemail, password);
            if (travelUser != null) {
                request.getSession().setAttribute("travelUser", travelUser);
                response.sendRedirect("personalInfo.jsp?username="+travelUser.getUsername());
            } else {
                request.setAttribute("info", "页面异常，请重新登录! <br>");
                request.getRequestDispatcher("message.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
