package com.myself.vo;

public class ClueQueryParam {
    private String fullName;
    private String company;
    private String phone;
    private String source;
    private String owner;
    private String mPhone;
    private String state;
    private Integer pageNo;
    private Integer pageSize;

    public ClueQueryParam() {
    }

    public ClueQueryParam(String fullName, String company, String phone, String source, String owner, String mPhone, String state, Integer pageNo, Integer pageSize) {
        this.fullName = fullName;
        this.company = company;
        this.phone = phone;
        this.source = source;
        this.owner = owner;
        this.mPhone = mPhone;
        this.state = state;
        this.pageNo = pageNo;
        this.pageSize = pageSize;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    public String getmPhone() {
        return mPhone;
    }

    public void setmPhone(String mPhone) {
        this.mPhone = mPhone;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
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
