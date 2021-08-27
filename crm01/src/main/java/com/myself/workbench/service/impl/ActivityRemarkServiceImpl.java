package com.myself.workbench.service.impl;

import com.myself.workbench.dao.ActivityRemarkDao;
import com.myself.workbench.entity.Activity;
import com.myself.workbench.entity.ActivityRemark;
import com.myself.workbench.service.ActivityRemarkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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
}
