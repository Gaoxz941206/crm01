package com.myself.tran.service.impl;

import com.myself.tran.dao.TranDao;
import com.myself.tran.entity.Tran;
import com.myself.tran.service.TranService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TranServiceImpl implements TranService {

    @Autowired(required = false)
    private TranDao dao;



    @Override
    public int addTran(Tran tran) {
        return 0;
    }
}
