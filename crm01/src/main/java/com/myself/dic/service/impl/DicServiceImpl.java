package com.myself.dic.service.impl;

import com.myself.dic.dao.DicDao;
import com.myself.dic.service.DicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DicServiceImpl implements DicService {

    @Autowired(required = false)
    private DicDao dao;

    public List<String> selectDicCodeTypes(){
        return dao.selectDicCodeTypes();
    }
}
