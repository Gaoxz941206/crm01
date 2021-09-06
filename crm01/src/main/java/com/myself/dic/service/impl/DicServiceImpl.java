package com.myself.dic.service.impl;

import com.myself.dic.dao.DicDao;
import com.myself.dic.entity.DicValue;
import com.myself.dic.service.DicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service(value = "dicServiceImpl")
public class DicServiceImpl implements DicService {

    @Autowired(required = false)
    private DicDao dao;

    public Map<String, List<DicValue>> selectDicCodeTypes(){
        Map<String, List<DicValue>> map = new HashMap<>();
        List<String> typeList = dao.selectDicCodeTypes();
        for (String type : typeList) {
            map.put(type,dao.selectValuesByTypeCode(type));
        }
        return map;
    }
}
