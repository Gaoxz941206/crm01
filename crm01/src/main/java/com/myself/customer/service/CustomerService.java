package com.myself.customer.service;

import org.apache.ibatis.annotations.Param;

public interface CustomerService {

    /**
     * 将线索转换成客户
     * @param clueId 线索id
     * @param name 创建人
     * @return
     */
    Boolean addCustomerByClue(String name, String clueId);
}
