package com.myself.tran.dao;

import com.myself.tran.entity.Tran;
import org.springframework.stereotype.Repository;

@Repository
public interface TranDao {

    /**
     * 添加交易
     * @param tran
     * @return
     */
    int insertTran(Tran tran);
}
