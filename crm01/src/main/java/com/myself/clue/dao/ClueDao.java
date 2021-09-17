package com.myself.clue.dao;

import com.myself.Utils.Page;
import com.myself.clue.entity.Clue;
import com.myself.clue.entity.Clue_Activity;
import com.myself.vo.ClueQueryParam;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ClueDao {
    /**
     * 条件分页查询所有线索
     * @param param 查询条件
     * @return
     */
    List<Clue> selectPage(ClueQueryParam param);

    /**
     * 条件查询总条目数
     * @param param 查询条件
     * @return
     */
    int getTotalSize(ClueQueryParam param);

    /**
     * 添加线索
     * @param clue
     * @return
     */
    int insertClue(Clue clue);

    /**
     * 根据线索id联查关联的市场活动
     * @param clueId
     * @return  市场活动id列表
     */
    List<String> linkClueActivity(String clueId);

    /**
     * 根据线索id查询该线索
     * @param id 线索id
     * @return
     */
    Clue selectClueById(String id);

    /**
     * 关联市场活动
     * @param ca ：线索与市场活动
     * @return
     */
    int bundActivity(Clue_Activity ca);

    /**
     * 根据线索_市场活动关联表中的id删除关联关系
     * @param id    线索_市场活动关联表中的id
     * @return
     */
    int deleteActivity(String id);

    /**
     * 根据线索_市场活动关联表中的id删除关联关系
     * @param clueId    线索id
     * @param actId     市场活动id
     * @return
     */
    int deleteClueActivity(@Param("clueId")String clueId,
                           @Param("actId")String actId);

    /**
     * 删除线索
     * @param clueId
     * @return
     */
    int deleteClue(String clueId);

    /**
     * 删除线索的备注
     * @param clueId
     * @return
     */
    int deleteClueRemark(String clueId);
}
