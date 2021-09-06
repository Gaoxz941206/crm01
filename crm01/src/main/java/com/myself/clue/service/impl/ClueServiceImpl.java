package com.myself.clue.service.impl;

import com.myself.Utils.Page;
import com.myself.clue.dao.ClueDao;
import com.myself.clue.entity.Clue;
import com.myself.clue.service.ClueService;
import com.myself.vo.Activity_User;
import com.myself.vo.ClueQueryParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ClueServiceImpl implements ClueService {

    @Autowired(required = false)
    private ClueDao dao;

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
}
