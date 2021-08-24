package com.myself.vo;

public class ActivityQueryParam {
    private Integer pageNo;
    private Integer pageSize;
    private String queryName;
    private String queryOwner;
    private String queryStartTime;
    private String queryEndTime;

    public ActivityQueryParam() {
    }

    public ActivityQueryParam(Integer pageNo, Integer pageSize, String queryName, String queryOwner, String queryStartTime, String queryEndTime) {
        this.pageNo = pageNo;
        this.pageSize = pageSize;
        this.queryName = queryName;
        this.queryOwner = queryOwner;
        this.queryStartTime = queryStartTime;
        this.queryEndTime = queryEndTime;
    }

    public Integer getPageNo() {
        return pageNo;
    }

    public void setPageNo(Integer pageNo) {
        this.pageNo = pageNo;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public String getQueryName() {
        return queryName;
    }

    public void setQueryName(String queryName) {
        this.queryName = queryName;
    }

    public String getQueryOwner() {
        return queryOwner;
    }

    public void setQueryOwner(String queryOwner) {
        this.queryOwner = queryOwner;
    }

    public String getQueryStartTime() {
        return queryStartTime;
    }

    public void setQueryStartTime(String queryStartTime) {
        this.queryStartTime = queryStartTime;
    }

    public String getQueryEndTime() {
        return queryEndTime;
    }

    public void setQueryEndTime(String queryEndTime) {
        this.queryEndTime = queryEndTime;
    }
}
