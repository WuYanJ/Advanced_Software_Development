package com.wyj.Servlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/processBookmark")
public class ProcessBookmarkServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String imageURL = request.getParameter("imageURL");
        String alreadyBookmarked = request.getParameter("bookmarked");
        HttpSession session = request.getSession();

        List<String> bookmarkList = (List<String>)session.getAttribute("bookmarkList");

        // 如果是第一次收藏，创建一个新的bookmarkList
        if(bookmarkList == null) {
            bookmarkList = new ArrayList<>();
        }
        // 若果此前已经收藏过这张照片，将这条收藏记录移除
        if(alreadyBookmarked.equals("true")) {
            bookmarkList.remove(imageURL);
            System.out.println("remove: "+imageURL);
        } else {
            // 将新收藏的imageURL存入bookmarkList
            bookmarkList.add(imageURL);
            System.out.println("add: "+imageURL);
        }

        // 将更新后的bookmarkList存入session
        session.setAttribute("bookmarkList", bookmarkList);
        response.sendRedirect(request.getContextPath() + "/details.jsp?imageURL=" + imageURL);
    }
}
