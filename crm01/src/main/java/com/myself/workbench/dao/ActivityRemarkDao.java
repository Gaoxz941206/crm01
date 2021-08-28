package com.myself.workbench.dao;

import com.myself.workbench.entity.Activity;
import com.myself.workbench.entity.ActivityRemark;

import java.util.List;

public interface ActivityRemarkDao {
    /**
     * 删除市场活动同时删除备注信息
     * @param id   备注表中activityId
     * @return
     */
    int activityRemarkDelete(String id);

    /**
     * 跳转备注页面时查询详细信息(所有者是姓名)
     * @param id    市场活动的id
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
     * @param id    备注的id
     * @return
     */
    int deleteRemark(String id);

    /**
     *添加备注信息
     * @param remark
     * @return
     */
    int insertRemark(ActivityRemark remark);

    /**
     * 修改备注之前先根据备注的id查找备注
     * @param id    备注的id
     * @return
     */
    ActivityRemark selectRemarkById(String id);

    /**
     * 修改备注
     * @param remark
     * @return
     */
    int updateRemark(ActivityRemark remark);
}
