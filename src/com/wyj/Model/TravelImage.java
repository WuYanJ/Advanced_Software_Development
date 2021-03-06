package com.wyj.Model;

import java.util.Date;

public class TravelImage {
    private int imageID;
    private String title;
    private String description;
    private double latitude;
    private double longitude;
    private String cityCode;
    private String country_regionCode;
    private int UID;
    private String path;
    private String content;
    private int favor;
    private String photographer;
    private Date updatedDate;

    public Date getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(Date updatedDate) {
        this.updatedDate = updatedDate;
    }

    public int getFavor() {
        return favor;
    }
    public void setFavor(int favor){
        this.favor = favor;
    }



    public String getPhotographer() {
        return photographer;
    }

    public void setPhotographer(String photographer) {
        this.photographer = photographer;
    }

    private String topic;

    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }



    public TravelImage() {

    }

    @Override
    public String toString() {
        return "TravelImage{" +
                "imageID=" + imageID +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", latitude=" + latitude +
                ", longitude=" + longitude +
                ", cityCode='" + cityCode + '\'' +
                ", country_regionCode='" + country_regionCode + '\'' +
                ", UID=" + UID +
                ", path='" + path + '\'' +
                ", content='" + content + '\'' +
                ", favor=" + favor +
                ", photographer='" + photographer + '\'' +
                ", topic='" + topic + '\'' +
                '}';
    }

    public TravelImage(int imageID, String title, String description,
                       double latitude, double longitude, String cityCode,
                       String country_regionCode, int UID, String path,
                       String content, String topic) {
        this.imageID = imageID;
        this.title = title;
        this.description = description;
        this.latitude = latitude;
        this.longitude = longitude;
        this.cityCode = cityCode;
        this.country_regionCode = country_regionCode;
        this.UID = UID;
        this.path = path;
        this.content = content;
        this.topic = topic;
    }

    public int getImageID() {
        return imageID;
    }

    public void setImageID(int imageID) {
        this.imageID = imageID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        if (description == null) {
            return "NO DESCRIPTION.";
        }
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public String getCityCode() {
        return cityCode;
    }

    public void setCityCode(String cityCode) {
        this.cityCode = cityCode;
    }

    public String getCountry_regionCode() {
        return country_regionCode;
    }

    public void setCountry_regionCode(String country_regionCode) {
        this.country_regionCode = country_regionCode;
    }

    public int getUID() {
        return UID;
    }

    public void setUID(int UID) {
        this.UID = UID;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }


}
