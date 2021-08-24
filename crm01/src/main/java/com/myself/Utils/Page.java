package com.myself.Utils;

import java.util.List;

public class Page<T> {
    private Integer pageNo;
    private Integer pageSize;
    private Integer totalSize;
    private List<T> list;

    public Page() {
    }

    public Page(Integer pageNo, Integer pageSize, Integer totalSize, List<T> list) {
        this.pageNo = pageNo;
        this.pageSize = pageSize;
        this.totalSize = totalSize;
        this.list = list;
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

    public Integer getTotalSize() {
        return totalSize;
    }

    public void setTotalSize(Integer totalSize) {
        this.totalSize = totalSize;
    }

    public List<T> getList() {
        return list;
    }

    public void setList(List<T> list) {
        this.list = list;
    }
}
