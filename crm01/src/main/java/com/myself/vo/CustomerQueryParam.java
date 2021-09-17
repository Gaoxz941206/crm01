package com.myself.vo;

public class CustomerQueryParam {
    private String name;
    private String owner;
    private String phone;
    private String website;
    private Integer pageNo;
    private Integer pageSize;

    public CustomerQueryParam() {
    }

    public CustomerQueryParam(String name, String owner, String phone, String website, Integer pageNo, Integer pageSize) {
        this.name = name;
        this.owner = owner;
        this.phone = phone;
        this.website = website;
        this.pageNo = pageNo;
        this.pageSize = pageSize;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
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
}
