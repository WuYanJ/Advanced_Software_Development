package com.wyj.Model;

import java.util.Date;

public class Comment {
    private int id;
    private String imageURL;
    private String username;
    private String comment;
    private Date dateCreated;
    private int favorAmount;

    public Date getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }

    public int getFavorAmount() {
        return favorAmount;
    }

    public void setFavorAmount(int favorAmount) {
        this.favorAmount = favorAmount;
    }


    @Override
    public String toString() {
        return "Comment{" +
                "id=" + id +
                ", imageURL='" + imageURL + '\'' +
                ", username='" + username + '\'' +
                ", comment='" + comment + '\'' +
                '}';
    }

    public Comment(int id, String imageURL, String username, String comment, Date dateCreated, int favorAmount) {
        this.id = id;
        this.imageURL = imageURL;
        this.username = username;
        this.comment = comment;
        this.dateCreated = dateCreated;
        this.favorAmount = favorAmount;
    }

    public Comment() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }
}
