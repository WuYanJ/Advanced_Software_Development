package com.wyj.Model;

import java.util.Date;

public class TravelUser {
    private int UID;
    private String email;
    private String username;
    private String password;
    private int state;
    private Date dateJoined;
    private Date dateLastModified;

    public TravelUser(int UID, String email, String username, String password, int state, Date dateJoined, Date dateLastModified) {
        this.UID = UID;
        this.email = email;
        this.username = username;
        this.password = password;
        this.state = state;
        this.dateJoined = dateJoined;
        this.dateLastModified = dateLastModified;
    }

    public TravelUser() {
    }

    public int getUID() {
        return UID;
    }

    public void setUID(int UID) {
        this.UID = UID;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public Date getDateJoined() {
        return dateJoined;
    }

    public void setDateJoined(Date dateJoined) {
        this.dateJoined = dateJoined;
    }

    public Date getDateLastModified() {
        return dateLastModified;
    }

    public void setDateLastModified(Date dateLastModified) {
        this.dateLastModified = dateLastModified;
    }

    @Override
    public String toString() {
        return "TravelUser{" +
                "UID=" + UID +
                ", email='" + email + '\'' +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", state=" + state +
                ", dateJoined=" + dateJoined +
                ", dateLastModified=" + dateLastModified +
                '}';
    }
}
