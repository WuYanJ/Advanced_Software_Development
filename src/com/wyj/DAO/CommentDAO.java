package com.wyj.DAO;

import com.wyj.Model.Comment;

import java.sql.SQLException;
import java.util.List;

public class CommentDAO extends DAO{
    public List<Comment> getComments(String imageURL) throws SQLException {
        String sql = "SELECT id, imageURL, username, comment, dateCreated, favorAmount FROM travels.travelimageComment WHERE imageURL='" + imageURL + "'";
        return getForList(Comment.class, sql);
    }
    public List<Comment> getCommentsOrderByDate(String imageURL) throws SQLException {
        String sql = "SELECT id, imageURL, username, comment, dateCreated, favorAmount FROM travels.travelimageComment WHERE imageURL='" + imageURL + "' ORDER BY dateCreated";
        return getForList(Comment.class, sql);
    }
    public List<Comment> getCommentsOrderByFavor(String imageURL) throws SQLException {
        String sql = "SELECT id, imageURL, username, comment, dateCreated, favorAmount FROM travels.travelimageComment WHERE imageURL='" + imageURL + "' ORDER BY favorAmount DESC";
        return getForList(Comment.class, sql);
    }
}
