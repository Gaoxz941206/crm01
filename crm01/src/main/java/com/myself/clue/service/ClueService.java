package com.myself.clue.service;

import com.myself.Utils.Page;
import com.myself.clue.entity.Clue;
import com.myself.vo.ClueQueryParam;

import java.util.List;

public interface ClueService {
    /**
     * 条件分页查询所有线索
     * @param param 查询条件
     * @return
     */
    Page<Clue> selectPage(ClueQueryParam param);
}
