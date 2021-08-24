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
     * 跳转至市场活动备注页面之前先查询市场活动的详细信息
     * @param id
     * @return
     */
    @Override
    public Activity selectActivityById(String id) {
        return remarkDao.selectActivityById(id);
    }
}
