package com.myself.customer.dao;

import com.myself.customer.entity.Customer;
import com.myself.vo.CustomerQueryParam;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CustomerDao {

    /**
     * 添加客户
     * @param customer 客户信息
     * @return
     */
    int insertCustomer(Customer customer);

    /**
     * 条件查询获取总记录条数
     * @param param
     * @return
     */
    int getTotalSize(CustomerQueryParam param);

    /**
     * 条件分页查询
     * @param param
     * @return
     */
    List<Customer> selectCustomersPage(CustomerQueryParam param);
}
