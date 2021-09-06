package com.myself.clue.dao;

import com.myself.clue.entity.Clue;
import com.myself.vo.ClueQueryParam;
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
}
