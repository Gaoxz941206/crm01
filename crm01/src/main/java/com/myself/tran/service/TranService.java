package com.myself.tran.service;

import com.myself.tran.entity.Tran;

public interface TranService {

    /**
     * 添加交易
     * @param tran
     * @return
     */
    int addTran(Tran tran);
}
