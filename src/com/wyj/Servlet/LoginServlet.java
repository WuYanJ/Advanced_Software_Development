package com.wyj.Servlet;

import com.wyj.DAO.TravelUserDao;
import com.wyj.Model.TravelUser;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import static com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
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


        TravelUserDao travelUserDao = new TravelUserDao();
        // 从request获取用户登陆信息
        String usernameORemail = request.getParameter("usernameORemail");
        String password = request.getParameter("password");
        String captcha = request.getParameter("captcha");
        if(!captcha.equals(realCaptcha)){
            request.setAttribute("message", "Wrong Captcha.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
        try {
            TravelUser travelUser = travelUserDao.login(usernameORemail, password);
            if (travelUser != null) {
                request.getSession().setAttribute("travelUser", travelUser);
                response.sendRedirect("personalInfo.jsp?username="+travelUser.getUsername());
            } else {
                request.setAttribute("message", "Username or Password is Wrong");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
