package com.myself.workbench.service;

import com.myself.workbench.entity.Activity;
import com.myself.workbench.entity.ActivityRemark;

import java.util.List;

public interface ActivityRemarkService {
    /**
     * 跳转至市场活动备注页面之前先查询市场活动的详细信息
     * @param id
     * @return
     */
    Activity selectActivityById(String id);

    /**
     * 备注页面加载时，根据id查询备注列表
     * @param id
     * @return
     */
    List<ActivityRemark> selectRemarksById(String id);
}
