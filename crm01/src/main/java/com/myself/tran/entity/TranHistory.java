package com.myself.tran.entity;

public class TranHistory {
    private String id;
    private String stage;
    private String money;
    private String expectedDate;
    private String createTime;
    private String createBy;
    private String tranId;

    public TranHistory() {
    }

    public TranHistory(String id, String stage, String money, String expectedDate, String createTime, String createBy, String tranId) {
        this.id = id;
        this.stage = stage;
        this.money = money;
        this.expectedDate = expectedDate;
        this.createTime = createTime;
        this.createBy = createBy;
        this.tranId = tranId;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getStage() {
        return stage;
    }

    public void setStage(String stage) {
        this.stage = stage;
    }

    public String getMoney() {
        return money;
    }

    public void setMoney(String money) {
        this.money = money;
    }

    public String getExpectedDate() {
        return expectedDate;
    }

    public void setExpectedDate(String expectedDate) {
        this.expectedDate = expectedDate;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getTranId() {
        return tranId;
    }

    public void setTranId(String tranId) {
        this.tranId = tranId;
    }
}
