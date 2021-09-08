package com.myself.clue.service;

import com.myself.Utils.Page;
import com.myself.clue.entity.Clue;
import com.myself.vo.ClueQueryParam;
import com.myself.workbench.entity.Activity;

import java.util.List;

public interface ClueService {
    /**
     * 条件分页查询所有线索
     * @param param 查询条件
     * @return
     */
    Page<Clue> selectPage(ClueQueryParam param);

    /**
     * 添加线索
     * @param clue
     * @return  是否成功
     */
    Boolean insertClue(Clue clue);

    /**
     * 根据id查询线索
     * @param id 线索id
     * @return
     */
    Clue selectClueById(String id);

    /**
     * 根据线索id联查市场活动
     * @param clueId
     * @return
     */
    List<Activity> linkClueActivity(String clueId);

    /**
     * 根据名称条件查询所有市场活动列表
     * @param name
     * @return
     */
    List<Activity> addActivityList(String name,String id);

    /**
     * 关联市场活动
     * @param clueId 线索id
     * @param actId  市场活动id数组
     * @return
     */
    Boolean bundActivity(String clueId,String[] actId);

    /**
     * 根据线索_市场活动关联表中的id删除关联关系
     * @param id    线索_市场活动关联表中的id
     * @return
     */
    int deleteActivity(String id);
}
