package com.myself.workbench.service.impl;

import com.myself.Utils.TimeFormat;
import com.myself.Utils.UUid;
import com.myself.workbench.dao.ActivityRemarkDao;
import com.myself.workbench.entity.Activity;
import com.myself.workbench.entity.ActivityRemark;
import com.myself.workbench.service.ActivityRemarkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ActivityRemarkServiceImpl implements ActivityRemarkService {

    @Autowired(required = false)
    private ActivityRemarkDao remarkDao;

    @Override
    public List<ActivityRemark> selectRemarksById(String id) {
        return remarkDao.selectRemarksById(id);
    }

    /**
     * 删除备注
     * @param id 备注的id
     * @return  删除成功与否的信息
     */
    @Override
    public String deleteRemark(String id) {
        String msg = "";
        if(remarkDao.deleteRemark(id) == 1){
            msg = "删除备注成功";
        }else{
            msg = "删除备注失败";
        }
        return msg;
    }

    /**
     * 跳转至市场活动备注页面之前先查询市场活动的详细信息
     * @param id
     * @return
     */
    @Override
    public Activity selectActivityById(String id) {
        return remarkDao.selectActivityById(id);
    }

    /**
     * 添加备注
     * @param noteContent   备注信息
     * @param activityId    活动id
     * @param userName      添加人
     * @return
     */
    @Override
    public Map<Object,Object> insertRemark(String noteContent, String activityId, String userName) {
        Map<Object,Object> map = new HashMap<>();
        ActivityRemark remark = new ActivityRemark();
        remark.setId(UUid.getUUID());
        remark.setNoteContent(noteContent);
        remark.setCreateTime(TimeFormat.getCurrentAllTime());
        remark.setCreateBy(userName);
        remark.setEditFlag("0");
        remark.setActivityId(activityId);
        Boolean success = remarkDao.insertRemark(remark) == 1;
        map.put("success",success);
        map.put("remark",remark);
        return map;
    }

    /**
     * 修改备注之前先根据备注的id查找备注
     * @param id    备注的id
     * @return
     */
    @Override
    public ActivityRemark selectRemarkById(String id) {
        return remarkDao.selectRemarkById(id);
    }

    /**
     * 修改备注信息
     * @param userName  修改人
     * @param noteContent    修改后的内容
     * @param id             备注id
     * @return
     */
    @Override
    public Map<Object,Object> updateRemark(String userName, String noteContent,String id) {
        Map<Object,Object> map = new HashMap<>();
        ActivityRemark remark = new ActivityRemark();
        remark.setId(id);
        remark.setNoteContent(noteContent);
        remark.setEditTime(TimeFormat.getCurrentAllTime());
        remark.setEditBy(userName);
        remark.setEditFlag("1");
        Boolean success = remarkDao.updateRemark(remark) == 1;
        map.put("success",success);
        map.put("remark",remark);
        return  map;
    }
}
