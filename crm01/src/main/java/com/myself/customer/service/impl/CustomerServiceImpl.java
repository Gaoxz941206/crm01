package com.myself.customer.service.impl;

import com.myself.Utils.Page;
import com.myself.Utils.TimeFormat;
import com.myself.Utils.UUid;
import com.myself.clue.dao.ClueDao;
import com.myself.clue.entity.Clue;
import com.myself.contacts.dao.ContactsDao;
import com.myself.contacts.entity.Contacts;
import com.myself.customer.dao.CustomerDao;
import com.myself.customer.entity.Customer;
import com.myself.customer.service.CustomerService;
import com.myself.tran.dao.TranDao;
import com.myself.tran.entity.Tran;
import com.myself.vo.CustomerQueryParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CustomerServiceImpl implements CustomerService {

    @Autowired(required = false)
    private CustomerDao dao;    //客户dao层

    @Autowired(required = false)
    private ClueDao clueDao;    //线索dao层

    @Autowired(required = false)
    private TranDao tranDao;    //交易dao层

    @Autowired(required = false)
    private ContactsDao contactsDao;    //联系人dao层

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

        //创建联系人
        Contacts contacts = new Contacts();
        contacts.setId(UUid.getUUID());
        contacts.setOwner(clue.getOwner());
        contacts.setSource(clue.getSource());
        contacts.setCustomerId(customer.getId());
        contacts.setFullName(clue.getFullName());
        contacts.setAppellation(clue.getAppellation());
        contacts.setEmail(clue.getEmail());
        contacts.setmPhone(clue.getmPhone());
        contacts.setJob(clue.getJob());
        contacts.setCreateBy(name);
        contacts.setCreateTime(TimeFormat.getCurrentAllTime());
        contacts.setDescription(clue.getDescription());
        contacts.setContactSummary(clue.getContactSummary());
        contacts.setNextContactTime(clue.getNextContactTime());
        contacts.setAddress(clue.getAddress());

        int result = 0; //bool标记


        //以下为添加操作
        result += dao.insertCustomer(customer);     //添加客户（将线索转换成实际客户）
        result += contactsDao.insertContact(contacts);  //添加联系人

        //当“为客户添加交易”复选框被选中时，添加交易记录
        if(isCreateTran){
            tran.setId(UUid.getUUID());
            result += tranDao.insertTran(tran);
        }

        //以下为删除操作
        List<String> actIdList = clueDao.linkClueActivity(clueId);  //先获取该线索关联的市场活动
        for (String actId : actIdList) {
            clueDao.deleteClueActivity(clueId,actId);  //删除线索关联的市场活动
        }
        clueDao.deleteClueRemark(clueId);   //删除线索的备注
        result += clueDao.deleteClue(clueId);   //删除线索表中该线索（根据clueId）

        return isCreateTran ? (result == 4) : (result == 3); //当“为客户添加交易”复选框被选中时，添加记录应该为3，否则为2
    }

    /**
     * 条件分页查询
     * @param param
     * @return
     */
    @Override
    public Page<Customer> pageQuery(CustomerQueryParam param) {
        Page<Customer> page = new Page<>();
        page.setPageNo(param.getPageNo());
        page.setPageSize(param.getPageSize());
        param.setPageNo((param.getPageNo()-1)*param.getPageSize());
        page.setTotalSize(dao.getTotalSize(param));
        page.setList(dao.selectCustomersPage(param));
        return page;
    }
}
