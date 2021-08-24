package com.myself.workbench.service;

import com.myself.workbench.entity.Activity;

public interface ActivityRemarkService {
    /**
     * 跳转至市场活动备注页面之前先查询市场活动的详细信息
     * @param id
     * @return
     */
    Activity selectActivityById(String id);
}
