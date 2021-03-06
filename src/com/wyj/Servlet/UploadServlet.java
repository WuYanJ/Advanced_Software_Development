package com.wyj.Servlet;

import com.wyj.DAO.DAO;
import com.wyj.Model.TravelImage;
import com.wyj.Model.TravelUser;
import com.wyj.Utils.DataBaseUtils;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;
import java.util.List;


@WebServlet("/uploadServlet")
public class UploadServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Cookie[] cookies = request.getCookies();
        // 应该是null
        String username = null;
        TravelUser myself = (TravelUser) request.getSession().getAttribute("travelUser");
        username = myself.getUsername();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        DAO dao = new DAO();
        TravelImage imageToBeStored = new TravelImage();
        String sql = "INSERT INTO travels.travelimage (title, description, cityCode, country_regionCodeISO, " +
                "UID, path, content, updatedDate, favor)VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        // 1 得到FileItem对象的集合
        // 创建FileItem对象的工厂
        DiskFileItemFactory factory = new DiskFileItemFactory();
        // 设置内存临界值 - 超过后将产生临时文件并存储于临时目录中
        factory.setSizeThreshold(1024*500); //500kb
        // 设置临时存储目录
        File tempDirectory = new File("/Users/wuyanjie/tempDirectory");
        factory.setRepository(tempDirectory);

        ServletFileUpload upload = new ServletFileUpload(factory);

//         设置最大文件上传值
//        upload.setFileSizeMax(MAX_FILE_SIZE);

        // 设置最大请求值 (包含文件和表单数据)
        upload.setSizeMax(1024*1024*5);// 5mb
        try {
            List<FileItem> items = upload.parseRequest(request);
            // 2 遍历items，若是一个一般的表单域，打印信息
            String previousPath = "";
            for(FileItem item: items) {
                if(item.isFormField()) {
                    // 一个个set，封装成一个image对象，存入数据库
                    // item.getName()获取的是文件的名字
                    String name = item.getFieldName();
                    String value = item.getString();
                    if(name.equals("photographer")){
//                        username = value;
                        continue;
                    }
                    if(name.equals("previousPath")){
                        previousPath = value;
                        continue;
                    }
                    if(name.equals("ifModify")){
                        if(value.equals("true")){
                            updateImage(imageToBeStored, previousPath, myself, response);
                            break;
                        }
                        continue;
                    }
                    BeanUtils.setProperty(imageToBeStored, name, value);
                }
                // 若是文件，把文件保存到本机目录下
                else {
                    String fieldName = item.getFieldName();
                    // image's path要存入数据库
                    String fileName = item.getName();
                    imageToBeStored.setPath(fileName);
                    String contentType = item.getContentType();
                    boolean isInMemory = item.isInMemory();
                    long sizeInBytes = item.getSize();
                    System.out.println(fieldName);
                    System.out.println(fileName);
                    System.out.println(contentType);
                    System.out.println(isInMemory);
                    System.out.println(sizeInBytes);
                    InputStream inputStream = item.getInputStream();
                    byte[] buffer = new byte[1024];
                    int len = 0;
//                    fileName = "/Users/wuyanjie/storeDir/"+fileName;
                    String fileLargePath;
                    String fileMediumPath;
                    String fileSmallPath;
                    String fileSquare_mediumPath;
                    String fileSquare_smallPath;
                    String fileSquare_tinyPath;
                    String fileThumbPath;

                    fileLargePath = getServletContext().getRealPath("/static/image/travel-images/large") + "/" + fileName;
                    fileMediumPath = getServletContext().getRealPath("/static/image/travel-images/medium") + "/" + fileName;
                    fileSmallPath = getServletContext().getRealPath("/static/image/travel-images/small") + "/" + fileName;

                    System.out.println(">"+getServletContext().getRealPath("/static/image/travel-images"));
                    File fileLarge = new File(fileLargePath);
                    OutputStream outputStream = new FileOutputStream(fileLarge);

                    while((len = inputStream.read(buffer)) != -1) {
                        outputStream.write(buffer, 0, len);
                    }
                    File fileMedium = new File(fileMediumPath);
                    outputStream = new FileOutputStream(fileMedium);

                    while((len = inputStream.read(buffer)) != -1) {
                        outputStream.write(buffer, 0, len);
                    }

                    File fileSmall = new File(fileSmallPath);
                    outputStream = new FileOutputStream(fileSmall);

                    while((len = inputStream.read(buffer)) != -1) {
                        outputStream.write(buffer, 0, len);
                    }

                    System.out.println("----------");
                    outputStream.close();
                    inputStream.close();
                }
            }
            connection = DataBaseUtils.getConn();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setObject(1, imageToBeStored.getTitle());
            preparedStatement.setObject(2, imageToBeStored.getDescription());
            preparedStatement.setObject(3, imageToBeStored.getCityCode());
            preparedStatement.setObject(4, imageToBeStored.getCountry_regionCode());
            preparedStatement.setObject(5, myself.getUID());
            preparedStatement.setObject(6, imageToBeStored.getPath());
            preparedStatement.setObject(7, imageToBeStored.getContent());
            preparedStatement.setObject(8, new Date());
            preparedStatement.setObject(9, 0);
            preparedStatement.executeUpdate();
            response.sendRedirect("pageMyImages.page");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DataBaseUtils.releaseDB(null, preparedStatement, connection);
        }

        // 1 获取请求信息，获取不到，因为编码方式变成二进制的方式提交，因此文本信息获取不到
//        String file = request.getParameter("file");
//        String desc = request.getParameter("desc");

        InputStream inputStream = request.getInputStream();
        Reader reader = new InputStreamReader(inputStream);
        BufferedReader bufferedReader = new BufferedReader(reader);

        String string = null;
        while((string = bufferedReader.readLine()) != null) {
            System.out.println(string);
        }
    }

    private void updateImage(TravelImage imageToBeStored, String previousPath, TravelUser myself, HttpServletResponse response) throws SQLException, IOException, ClassNotFoundException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        String sql = "UPDATE travels.travelimage SET title=?, description=?, cityCode=?, country_regionCodeISO=?, UID=?, path=?, content=?, updatedDate=?, favor=? WHERE path='" + previousPath + "'";
        connection = DataBaseUtils.getConn();
        preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setObject(1, imageToBeStored.getTitle());
        preparedStatement.setObject(2, imageToBeStored.getDescription());
        preparedStatement.setObject(3, imageToBeStored.getCityCode());
        preparedStatement.setObject(4, imageToBeStored.getCountry_regionCode());
        preparedStatement.setObject(5, myself.getUID());
        preparedStatement.setObject(6, imageToBeStored.getPath());
        preparedStatement.setObject(7, imageToBeStored.getContent());
        preparedStatement.setObject(8, new Date());
        preparedStatement.setObject(9, 0);
        preparedStatement.executeUpdate();
        response.sendRedirect("pageMyImages.page");
    }
}
