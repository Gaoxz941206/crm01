package com.myself.vo;

/**
 * @Author Gaoxz
 * @CreateTiime 2021-09-25 16:42
 * @apiNote
 */
public class TranQueryParam {
    private String owner;
    private String name;
    private String customerId;
    private String stage;
    private String type;
    private String source;
    private String contactsId;
    private Integer pageNo;
    private Integer pageSize;

    public TranQueryParam() {
    }

    public TranQueryParam(String owner, String name, String customerId, String stage, String type, String source, String contactsId, Integer pageNo, Integer pageSize) {
        this.owner = owner;
        this.name = name;
        this.customerId = customerId;
        this.stage = stage;
        this.type = type;
        this.source = source;
        this.contactsId = contactsId;
        this.pageNo = pageNo;
        this.pageSize = pageSize;
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    public String getStage() {
        return stage;
    }

    public void setStage(String stage) {
        this.stage = stage;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getContactsId() {
        return contactsId;
    }

    public void setContactsId(String contactsId) {
        this.contactsId = contactsId;
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
