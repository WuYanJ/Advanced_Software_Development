package com.wyj.Filter;


import com.wyj.Model.TravelUser;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    /**
     * 专门用于拦截请求，可以做权限检查
     */
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpSession session = request.getSession();
        TravelUser user = (TravelUser) session.getAttribute("travelUser");
        if(user == null){
            request.getRequestDispatcher("/login.jsp").forward(servletRequest, servletResponse);
            return;
        } else {
            // 放行，程序继续往下访问
            filterChain.doFilter(servletRequest, servletResponse);
        }
    }

    @Override
    public void destroy() {

    }
}
