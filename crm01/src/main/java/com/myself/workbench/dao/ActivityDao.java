package com.myself.workbench.dao;

import com.myself.vo.ActivityQueryParam;
import com.myself.vo.Activity_User;
import com.myself.workbench.entity.Activity;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface ActivityDao {
    /**
     * 添加市场活动信息
     * @param activity
     * @return
     */
    int activityInsert(Activity activity);

    /**
     *      分页查询
     * @param param             查询参数：
     *                          pageNo            当前页码
     *                          pageSize          每页显示的条数
     *                          queryName         带参查询：名称
     *                          queryOwner        带参查询：所有者
     *                          queryStartTime    带参查询：开始时间
     *                          queryEndTime      带参查询：结束时间
     * @return  返回：分页对象Page、市场活动列表List
     */
    List<Activity_User> activityPageQuery(@Param("param") ActivityQueryParam param);

    /**
     * 查询总记录条数
     * @param param
     * @return
     */
    int selectTotalNum(@Param("param") ActivityQueryParam param);

    /**
     * 市场活动信息删除
     * @param actId  市场活动信息id
     * @return      成功删除的数量
     */
    int activityDelete(String actId);

    /**
     * 修改市场活动信息之前先按id查询该市场活动信息
     * @param id
     * @return
     */
    Activity selectActivityById(String id);

    /**
     * 修改市场活动信息之前先按id查询该市场活动信息（所有者为名称）
     * @param actId : 市场活动id  clueId : 线索id
     * @return
     */
    Activity selectActivityById_2(@Param("actId") String actId,
                                  @Param("clueId") String clueId);

    /**
     * 更新市场活动信息
     * @param activity
     * @return
     */
    int updateActivity(Activity activity);

    /**
     * 按名称模糊查询所有市场活动
     * @param name 包含：没有关联市场活动时模糊查询的名称
     * @return
     */
    List<Activity> selectAllActivities_1(String name);

    /**
     * 按名称模糊查询所有市场活动
     * @param map 包含：已关联市场活动时模糊查询的名称、已关联的市场活动id列表
     * @return
     */
    List<Activity> selectAllActivities_2(Map<Object,Object> map);
}
