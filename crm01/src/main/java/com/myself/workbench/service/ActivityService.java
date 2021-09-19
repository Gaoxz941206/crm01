package com.myself.workbench.service;

import com.myself.Utils.Page;
import com.myself.settings.entity.User;
import com.myself.vo.ActivityQueryParam;
import com.myself.vo.Activity_User;
import com.myself.workbench.entity.Activity;

import java.util.List;
import java.util.Map;

public interface ActivityService {
    /**
     * 添加市场活动信息
     * @param activity
     * @return
     */
    int activityInsert(Activity activity);

    /**
     * 在页面加载时，无条件分页查询市场活动信息
     * @param param pageNo = 1 ; pageSize = 5
     * @return
     */
    Page<Activity_User> loadQuery(ActivityQueryParam param);

    /**
     * 市场活动信息删除
     * @param actIds  市场活动信息id数组
     * @return      成功删除的数量
     */
    String activityDelete(String[] actIds);

    /**
     *  修改市场活动信息之前先按id查询该市场活动信息和用户列表
     *  @param id
     * @return
     */
    Map<Object,Object> selectActivityById(String id);

    /**
     * 更新市场活动信息
     * @param activity   新的市场活动信息
     * @param user       修改人、时间
     * @return
     */
    String updateActivity(Activity activity, User user);

    /**
     * 根据市场活动名称模糊查询市场活动列表
     * @param name
     * @return
     */
    List<Activity> selectActivityByName(String name);

    /**
     * 根据市场活动id查询市场活动
     * @param id
     * @return
     */
    Activity selectActivity(String id);
}
