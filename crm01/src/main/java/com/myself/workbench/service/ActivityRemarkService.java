package com.myself.workbench.service;

import com.myself.workbench.entity.Activity;
import com.myself.workbench.entity.ActivityRemark;

import java.util.List;
import java.util.Map;

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

    /**
     * 删除备注
     * @param id 备注的id
     * @return  成功与否的信息
     */
    String deleteRemark(String id);

    /**
     * 添加备注
     * @param noteContent   备注信息
     * @param activityId    活动id
     * @param userName      添加人
     * @return
     */
    Map<Object,Object> insertRemark(String noteContent, String activityId, String userName);

    /**
     * 修改备注之前先根据备注的id查找备注
     * @param id    备注的id
     * @return
     */
    ActivityRemark selectRemarkById(String id);

    /**
     * 修改备注信息
     * @param userName  修改人
     * @param noteContent    修改后的内容
     * @param id             备注id
     * @return              修改后的备注信息
     */
    Map<Object,Object> updateRemark(String userName, String noteContent,String id);
}
