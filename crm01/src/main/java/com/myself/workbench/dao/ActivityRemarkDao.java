package com.myself.workbench.dao;

import com.myself.workbench.entity.Activity;

public interface ActivityRemarkDao {
    /**
     * 删除市场活动同时删除备注信息
     * @param id
     * @return
     */
    int activityRemarkDelete(String id);

    /**
     * 跳转备注页面时查询详细信息(所有者是姓名)
     * @param id
     * @return
     */
    Activity selectActivityById(String id);

}
