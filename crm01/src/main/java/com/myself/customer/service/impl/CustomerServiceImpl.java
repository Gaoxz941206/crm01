package com.myself.customer.service.impl;

import com.myself.Utils.TimeFormat;
import com.myself.Utils.UUid;
import com.myself.clue.dao.ClueDao;
import com.myself.clue.entity.Clue;
import com.myself.customer.dao.CustomerDao;
import com.myself.customer.entity.Customer;
import com.myself.customer.service.CustomerService;
import com.myself.tran.dao.TranDao;
import com.myself.tran.entity.Tran;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CustomerServiceImpl implements CustomerService {

    @Autowired(required = false)
    private CustomerDao dao;    //客户dao层

    @Autowired(required = false)
    private ClueDao clueDao;    //线索dao层

    @Autowired(required = false)
    private TranDao tranDao;    //交易dao层

    /**
     * 将线索转换成客户  开启事物
     * @param clueId 线索idp
     * @param name 创建人
     * @return
     */
    @Transactional(
            propagation = Propagation.REQUIRED,
            isolation = Isolation.DEFAULT,
            readOnly = false,
            timeout = -1,
            rollbackFor = {RuntimeException.class}
    )
    @Override
    public Boolean addCustomerByClue(String name, String clueId, Boolean isCreateTran, Tran tran) {
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

        int result = 0; //bool标记

        //输出线索表中该线索（根据clueId）
        result += clueDao.deleteClue(clueId);
        //添加客户（将线索转换成实际客户）
        result += dao.insertCustomer(customer);

        //当“为客户添加交易”复选框被选中时，添加交易记录
        if(isCreateTran){
            tran.setId(UUid.getUUID());
            result += tranDao.insertTran(tran);
        }

        return isCreateTran ? (result == 3) : (result == 2); //当“为客户添加交易”复选框被选中时，添加记录应该为3，否则为2
    }
}
