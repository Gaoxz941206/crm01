package com.myself.customer.service.impl;

import com.myself.Utils.TimeFormat;
import com.myself.Utils.UUid;
import com.myself.clue.dao.ClueDao;
import com.myself.clue.entity.Clue;
import com.myself.customer.dao.CustomerDao;
import com.myself.customer.entity.Customer;
import com.myself.customer.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CustomerServiceImpl implements CustomerService {

    @Autowired(required = false)
    private CustomerDao dao;

    @Autowired(required = false)
    private ClueDao clueDao;

    /**
     * 将线索转换成客户
     * @param clueId 线索idp
     * @param name 创建人
     * @return
     */
    @Override
    public Boolean addCustomerByClue(String name, String clueId) {
        //先根据线索id查询该线索
        Clue clue = clueDao.selectClueById(clueId);

        //创建客户对象
        Customer customer = new Customer();
        customer.setId(UUid.getUUID());
        customer.setOwner(clue.getOwner());
        customer.setName(clue.getFullName());
        customer.setWebsite(clue.getWebsite());
        customer.setPhone(clue.getPhone());
        customer.setCreateBy(name);
        customer.setCreateTime(TimeFormat.getCurrentAllTime());
        customer.setContactSummary(clue.getContactSummary());
        customer.setNextContactTime(clue.getNextContactTime());
        customer.setDescription(clue.getDescription());
        customer.setAddress(clue.getAddress());

        return null;
    }
}
