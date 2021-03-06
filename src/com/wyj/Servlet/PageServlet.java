package com.wyj.Servlet;

import com.wyj.DAO.DAO;
import com.wyj.DAO.TravelImageDao;
import com.wyj.DAO.TravelUserDao;
import com.wyj.Model.Page;
import com.wyj.Model.TravelImage;
import com.wyj.Model.TravelUser;
import com.wyj.Service.PageService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.Method;
import java.sql.SQLException;

public class PageServlet extends HttpServlet {
    PageService pageService = new PageService();
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

        int pageIndex = methodName.indexOf(".page");
        methodName = methodName.substring(0, pageIndex);
        System.out.println(methodName);
//        methodName = methodName.substring(0, methodName.length()-5);
        // 利用反射获取方法
        try {
            Method method = getClass().getDeclaredMethod(methodName, HttpServletRequest.class, HttpServletResponse.class);
            // 利用反射调用方法
            method.invoke(this, request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void pageMyBookmarks(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException, ClassNotFoundException {
        // 1 获取请求参数pageNo和pageSize
        int pageNo = 1;
        if(request.getParameter("pageNo") != null){
            pageNo = Integer.parseInt(request.getParameter("pageNo"));
        }
        TravelUser myself = (TravelUser)request.getSession().getAttribute("travelUser");
        String sql = null;
        String username = "";
        int uid = 0;
        if(request.getParameter("username") != null){
            username = request.getParameter("username");
            sql = "SELECT uid FROM travels.traveluser WHERE username=?";
            uid = dao.getForValue(sql, username);
        } else {
            uid = myself.getUID();
        }

        int pageSize = Page.PAGE_SIZE;

        // 2 调用service.page(pageNo, pageSize):Page对象
        Page<TravelImage> pageMyBookmarks = pageService.pageMyBookmarks(pageNo, pageSize, uid);
        // 3 保存Page对象到request中
        request.setAttribute("page", pageMyBookmarks);
        //4 请求转发给jsp
        if(request.getParameter("username") != null){
            request.getRequestDispatcher("/bookmarks.jsp?username="+username+"&uid="+uid).forward(request, response);
        } else {
            request.getRequestDispatcher("/bookmarks.jsp").forward(request, response);
        }
    }

    public void pageMyImages(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        // 1 获取请求参数pageNo和pageSize
        int pageNo = 1;
        if(request.getParameter("pageNo") != null){
            pageNo = Integer.parseInt(request.getParameter("pageNo"));
        }

        TravelUser myself = (TravelUser)request.getSession().getAttribute("travelUser");
        int uid = myself.getUID();
        int pageSize = Page.PAGE_SIZE;

        // 2 调用service.page(pageNo, pageSize):Page对象
        Page<TravelImage> pageMyImages = pageService.pageMyImages(pageNo, pageSize, uid);
        // 3 保存Page对象到request中
        request.setAttribute("page", pageMyImages);
        //4 请求转发给jsp
        request.getRequestDispatcher("/personalInfo.jsp").forward(request, response);
    }
}
