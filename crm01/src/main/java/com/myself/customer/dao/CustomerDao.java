package com.myself.customer.dao;

import com.myself.customer.entity.Customer;
import org.springframework.stereotype.Repository;

@Repository
public interface CustomerDao {

    /**
     * 添加客户
     * @param customer 客户信息
     * @return
     */
    int insertCustomer(Customer customer);
}
