package com.myself.clue.service.impl;

import com.myself.Utils.Page;
import com.myself.Utils.TimeFormat;
import com.myself.Utils.UUid;
import com.myself.clue.dao.ClueDao;
import com.myself.clue.entity.Clue;
import com.myself.clue.entity.Clue_Activity;
import com.myself.clue.service.ClueService;
import com.myself.vo.ClueQueryParam;
import com.myself.workbench.dao.ActivityDao;
import com.myself.workbench.entity.Activity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ClueServiceImpl implements ClueService {

    @Autowired(required = false)
    private ClueDao dao;

    @Autowired(required = false)
    private ActivityDao actDao;

    /**
     * 条件分页查询所有线索
     * @param param 查询条件
     * @return
     */
    @Override
    public Page<Clue> selectPage(ClueQueryParam param) {
        Page<Clue> page = new Page<>();
        page.setTotalSize(dao.getTotalSize(param));
        page.setPageNo(param.getPageNo());
        page.setPageSize(param.getPageSize());
        param.setPageNo((param.getPageNo()-1)*param.getPageSize());
        List<Clue> list = dao.selectPage(param);
        page.setList(list);
        return page;
    }

    /**
     * 添加线索
     * @param clue
     * @return
     */
    @Override
    public Boolean insertClue(Clue clue) {
        clue.setId(UUid.getUUID());
        clue.setCreateTime(TimeFormat.getCurrentAllTime());
        return dao.insertClue(clue) == 1;
    }

    /**
     * 根据线索id联查市场活动
     * @param clueId
     * @return
     */
    @Override
    public List<Activity> linkClueActivity(String clueId) {
        List<String> actIdList = dao.linkClueActivity(clueId);
        List<Activity> actList = new ArrayList<>();
        for (String actId : actIdList) {
            Activity activity = actDao.selectActivityById_2(actId,clueId);
            actList.add(activity);
        }
        return actList;
    }

    /**
     * 根据id查询线索
     * @param id 线索id
     * @return
     */
    @Override
    public Clue selectClueById(String id) {
        return dao.selectClueById(id);
    }

    /**
     * 根据名称条件查询所有市场活动列表
     * @param name
     * @return
     */
    @Override
    public List<Activity> addActivityList(String name,String id) {
        List<String> actIdList = dao.linkClueActivity(id);
        if (actIdList.size() == 0){
            List<Activity> actList = actDao.selectAllActivities_1(name);
            return actList;
        }else {
            Map<Object,Object> map = new HashMap<>();
            map.put("name",name);
            map.put("list",actIdList);
            List<Activity> actList = actDao.selectAllActivities_2(map);
            return actList;
        }
    }

    /**
     * 关联市场活动 开启事务
     * @param clueId 线索id
     * @param actId  市场活动id数组
     * @return
     */
    @Transactional(
            propagation = Propagation.REQUIRED,
            isolation = Isolation.DEFAULT,
            readOnly = false,
            timeout = -1,
            rollbackFor = {RuntimeException.class}
    )
    @Override
    public Boolean bundActivity(String clueId, String[] actId) {
        Clue_Activity ca = new Clue_Activity();
        ca.setClueId(clueId);
        int result = 0;
        for (String s : actId) {
            ca.setId(UUid.getUUID());
            ca.setActivityId(s);
            result += dao.bundActivity(ca);
        }
        return result == actId.length;
    }

    /**
     * 根据线索_市场活动关联表中的id删除关联关系
     * @param id    线索_市场活动关联表中的id
     * @return
     */
    @Override
    public int deleteActivity(String id) {
        return dao.deleteActivity(id);
    }
}
