package com.wyj.Model;

public class TravelImageNFavor {
    private int imageID;
    private int favorAmount;

    public TravelImageNFavor(int imageID, int favorAmount) {
        this.imageID = imageID;
        this.favorAmount = favorAmount;
    }

    public TravelImageNFavor() {
    }

    public int getImageID() {
        return imageID;
    }

    public void setImageID(int imageID) {
        this.imageID = imageID;
    }

    public int getFavorAmount() {
        return favorAmount;
    }

    public void setFavorAmount(int favorAmount) {
        this.favorAmount = favorAmount;
    }
}
