package com.myself.vo;

public class Activity_User {
    private String actId;
    private String actOwner;
    private String actName;
    private String actStartDate;
    private String actEndDate;
    private String actCost;
    private String actDescription;
    private String actCreateTime;
    private String actCreateBy;
    private String actEditTime;
    private String actEditBy;
    private String userId;
    private String userName;

    public Activity_User() {
    }

    public Activity_User(String actId, String actOwner, String actName, String actStartDate, String actEndDate, String actCost, String actDescription, String actCreateTime, String actCreateBy, String actEditTime, String actEditBy, String userId, String userName) {
        this.actId = actId;
        this.actOwner = actOwner;
        this.actName = actName;
        this.actStartDate = actStartDate;
        this.actEndDate = actEndDate;
        this.actCost = actCost;
        this.actDescription = actDescription;
        this.actCreateTime = actCreateTime;
        this.actCreateBy = actCreateBy;
        this.actEditTime = actEditTime;
        this.actEditBy = actEditBy;
        this.userId = userId;
        this.userName = userName;
    }

    public String getActId() {
        return actId;
    }

    public void setActId(String actId) {
        this.actId = actId;
    }

    public String getActOwner() {
        return actOwner;
    }

    public void setActOwner(String actOwner) {
        this.actOwner = actOwner;
    }

    public String getActName() {
        return actName;
    }

    public void setActName(String actName) {
        this.actName = actName;
    }

    public String getActStartDate() {
        return actStartDate;
    }

    public void setActStartDate(String actStartDate) {
        this.actStartDate = actStartDate;
    }

    public String getActEndDate() {
        return actEndDate;
    }

    public void setActEndDate(String actEndDate) {
        this.actEndDate = actEndDate;
    }

    public String getActCost() {
        return actCost;
    }

    public void setActCost(String actCost) {
        this.actCost = actCost;
    }

    public String getActDescription() {
        return actDescription;
    }

    public void setActDescription(String actDescription) {
        this.actDescription = actDescription;
    }

    public String getActCreateTime() {
        return actCreateTime;
    }

    public void setActCreateTime(String actCreateTime) {
        this.actCreateTime = actCreateTime;
    }

    public String getActCreateBy() {
        return actCreateBy;
    }

    public void setActCreateBy(String actCreateBy) {
        this.actCreateBy = actCreateBy;
    }

    public String getActEditTime() {
        return actEditTime;
    }

    public void setActEditTime(String actEditTime) {
        this.actEditTime = actEditTime;
    }

    public String getActEditBy() {
        return actEditBy;
    }

    public void setActEditBy(String actEditBy) {
        this.actEditBy = actEditBy;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
}
