package com.wyj.servlet;

import com.wyj.dao.UserDao;
import com.wyj.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        request.setCharacterEncoding("utf-8");

        //获取用户注册信息
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        //实例化UserDao对象
        UserDao userDao = new UserDao();
        if (username != null) {
            //实例化一个User对象
            User newUser = new User();

            //对用户对象的属性进行赋值
            newUser.setUsername(username);
            newUser.setPassword(password);
            newUser.setEmail(email);

            // 在数据库中存储newUser对象
//            userDao.saveUser(newUser);

            response.sendRedirect("personalInfo.jsp?username=" + username + "&email=" + email);
        } else {
            request.setAttribute("info", "错误操作，请重新注册! <br>");
            request.getRequestDispatcher("message.jsp").forward(request, response);
        }
    }
}
