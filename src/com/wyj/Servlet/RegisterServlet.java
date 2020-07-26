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

import static com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        response.setContentType("text/html;charset=utf-8");
        request.setCharacterEncoding("utf-8");

        // 获取验证码
        String realCaptcha = (String) request.getSession().getAttribute(KAPTCHA_SESSION_KEY);
        // 马上删除
        request.getSession().removeAttribute(KAPTCHA_SESSION_KEY);


        //获取表单参数（用户注册信息）
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String captcha = request.getParameter("captcha");
        //实例化TravelUserDao对象
        TravelUserDao travelUserDao = new TravelUserDao();
        if(!captcha.equals(realCaptcha)){
            request.setAttribute("message", "Wrong Captcha.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
        try {
            // 检查用户名是否已经被占用
            if (!travelUserDao.travelUserExist(username)) {
                //实例化一个User对象
                TravelUser newTravelUser = new TravelUser();

                //把表单参数封装成一个TravelUser对象
                newTravelUser.setUsername(username);
                newTravelUser.setPassword(password);
                newTravelUser.setEmail(email);
                newTravelUser.setDateJoined(new java.util.Date());

                // 调用TravelUserDAO的save，在数据库中存储newUser对象
                travelUserDao.saveTravelUser(newTravelUser);

                request.getSession().setAttribute("travelUser", newTravelUser);
                response.sendRedirect("personalInfo.jsp?username=" + username);
            } else {
                // 如果已经被占用，通过转发的方式返回register.jsp
                // 在request中放入一个属性message：用户名已经被占用，请重新选择
                // 在页面上通过request.getAttribute("message")来显示
                request.setAttribute("message", "Username has already been occupied. Please choose another.");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
