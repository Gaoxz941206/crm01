package com.myself.clue.entity;

public class Clue {
    private String id;    //主键
    private String fullName;   //
    private String appellation;   //
    private String owner;     //
    private String company;   //
    private String job;   //
    private String email;     //
    private String phone;     //
    private String website;   //
    private String mPhone;    //
    private String state;     //
    private String source;    //
    private String createBy;      //
    private String createTime;    //
    private String editBy;    //
    private String editTime;      //
    private String description;   //
    private String contactSummary;    //
    private String nextContactTime;   //
    private String address;   //

    public Clue() {
    }

    public Clue(String id, String fullName, String appellation, String owner, String company, String job, String email, String phone, String website, String mPhone, String state, String source, String createBy, String createTime, String editBy, String editTime, String description, String contactSummary, String nextContactTime, String address) {
        this.id = id;
        this.fullName = fullName;
        this.appellation = appellation;
        this.owner = owner;
        this.company = company;
        this.job = job;
        this.email = email;
        this.phone = phone;
        this.website = website;
        this.mPhone = mPhone;
        this.state = state;
        this.source = source;
        this.createBy = createBy;
        this.createTime = createTime;
        this.editBy = editBy;
        this.editTime = editTime;
        this.description = description;
        this.contactSummary = contactSummary;
        this.nextContactTime = nextContactTime;
        this.address = address;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getAppellation() {
        return appellation;
    }

    public void setAppellation(String appellation) {
        this.appellation = appellation;
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getJob() {
        return job;
    }

    public void setJob(String job) {
        this.job = job;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
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

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getEditBy() {
        return editBy;
    }

    public void setEditBy(String editBy) {
        this.editBy = editBy;
    }

    public String getEditTime() {
        return editTime;
    }

    public void setEditTime(String editTime) {
        this.editTime = editTime;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getContactSummary() {
        return contactSummary;
    }

    public void setContactSummary(String contactSummary) {
        this.contactSummary = contactSummary;
    }

    public String getNextContactTime() {
        return nextContactTime;
    }

    public void setNextContactTime(String nextContactTime) {
        this.nextContactTime = nextContactTime;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
