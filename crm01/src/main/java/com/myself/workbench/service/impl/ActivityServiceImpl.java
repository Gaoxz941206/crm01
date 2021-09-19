package com.myself.workbench.service.impl;

import com.myself.Utils.Page;
import com.myself.Utils.TimeFormat;
import com.myself.Utils.UUid;
import com.myself.settings.dao.UserDao;
import com.myself.settings.entity.User;
import com.myself.vo.ActivityQueryParam;
import com.myself.vo.Activity_User;
import com.myself.workbench.dao.ActivityDao;
import com.myself.workbench.dao.ActivityRemarkDao;
import com.myself.workbench.entity.Activity;
import com.myself.workbench.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ActivityServiceImpl implements ActivityService {

    @Autowired(required = false)
    private ActivityDao dao;

    @Autowired(required = false)
    private ActivityRemarkDao remarkDao;

    @Autowired(required = false)
    private UserDao userDao;

    /**
     * 添加市场活动信息
     * @param activity
     * @return
     */
    @Override
    public int activityInsert(Activity activity) {
        activity.setId(UUid.getUUID());
        activity.setCreateTime(TimeFormat.getCurrentAllTime());
        return dao.activityInsert(activity);
    }

    /**
     * 在页面加载时，无条件分页查询市场活动信息
     * @param param
     * @return
     */
    @Override
    public Page<Activity_User> loadQuery(ActivityQueryParam param) {
        Page<Activity_User> page = new Page<>();
        page.setPageNo(param.getPageNo());
        page.setPageSize(param.getPageSize());
        param.setPageNo((param.getPageNo()-1)*param.getPageSize());
        page.setTotalSize(dao.selectTotalNum(param));
        page.setList(dao.activityPageQuery(param));
        return page;
    }

    /**
     * 修改市场活动信息之前先按id查询该市场活动信息和用户列表
     * @param id
     * @return
     */
    @Override
    public Map<Object,Object> selectActivityById(String id) {
        Map<Object,Object> map = new HashMap<>();
        List<User> list = userDao.selectAllUsers();
        Activity activity = dao.selectActivityById(id);
        map.put("list",list);
        map.put("activity",activity);
        return map;
    }

    /**
     * 市场活动信息删除  开启事物
     * @param actIds  市场活动信息id数组
     * @return      成功删除的数量
     */
    @Transactional(
            propagation = Propagation.REQUIRED,
            isolation = Isolation.DEFAULT,
            readOnly = false,
            timeout = -1,
            rollbackFor = {RuntimeException.class}
    )
    @Override
    public String activityDelete(String[] actIds) {
        int actNum = 0;
        int actRemarkNum = 0;
        for (String id : actIds) {
            actRemarkNum += remarkDao.activityRemarkDelete(id);
        }
        for (String id : actIds) {
            actNum += dao.activityDelete(id);
        }
        String msg = "";
        if(actNum == actIds.length){
            msg = "成功删除 "+actNum+" 条市场活动记录 和 "+actRemarkNum+" 条市场活动备注记录！";
        }else {
            msg = "删除失败！";
        }
        return msg;
    }

    /**
     * 更新市场活动信息
     * @param activity  新的市场活动信息
     * @param user      修改人、时间
     * @return
     */
    @Override
    public String updateActivity(Activity activity, User user) {
        activity.setEditTime(TimeFormat.getCurrentAllTime());
        activity.setEditBy(user.getName());
        String msg = "";
        if(dao.updateActivity(activity) == 1){
            msg = "修改市场活动信息成功";
        }else {
            msg = "修改市场活动信息失败";
        }
        return msg;
    }

    /**
     * 根据市场活动名称模糊查询市场活动列表
     * @param name
     * @return
     */
    @Override
    public List<Activity> selectActivityByName(String name) {
        return dao.selectAllActivities_1(name);
    }

    /**
     * 根据市场活动id查询市场活动
     * @param id
     * @return
     */
    @Override
    public Activity selectActivity(String id) {
        return dao.selectActivityById(id);
    }
}
