package com.myself.customer.service;

import com.myself.Utils.Page;
import com.myself.customer.entity.Customer;
import com.myself.tran.entity.Tran;
import com.myself.vo.CustomerQueryParam;

public interface CustomerService {

    /**
     * 将线索转换成客户
     * @param clueId 线索id
     * @param name 创建人
     * @return
     */
    Boolean addCustomerByClue(String name, String clueId, Boolean isCreateTran, Tran tran);

    /**
     * 条件分页查询
     * @param param
     * @return
     */
    Page<Customer> pageQuery(CustomerQueryParam param);
}
