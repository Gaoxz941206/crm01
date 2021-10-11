package com.myself.tran.service.impl;

import com.myself.Utils.Page;
import com.myself.Utils.TimeFormat;
import com.myself.Utils.UUid;
import com.myself.contacts.dao.ContactsDao;
import com.myself.contacts.entity.Contacts;
import com.myself.customer.dao.CustomerDao;
import com.myself.customer.entity.Customer;
import com.myself.settings.entity.User;
import com.myself.tran.dao.TranDao;
import com.myself.tran.entity.Tran;
import com.myself.tran.entity.TranHistory;
import com.myself.tran.service.TranService;
import com.myself.vo.TranHistoryPoss;
import com.myself.vo.TranQueryParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

@Service
public class TranServiceImpl implements TranService {

    @Autowired(required = false)
    private TranDao dao;

    @Autowired(required = false)
    private CustomerDao customerDao;

    @Autowired(required = false)
    private ContactsDao contactsDao;


    /**
     * 开启事物（添加交易、交易历史、客户同时成功）
     * @param session
     * @param tran
     * @param customerName
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
    public String addTran(HttpSession session,Tran tran,String customerName) {
        //bool标记
        int result = 0;

        //先判断该客户是否存在，若不存在则创建客户，存在则取出id
        Customer customer = new Customer();
        if(customerDao.selectCustomerByName(customerName) == null){
            customer.setId(UUid.getUUID());
            customer.setName(customerName);
            result += customerDao.insertCustomer(customer);
        }else {
            customer = customerDao.selectCustomerByName(customerName);
            result ++;
        }

        //补全交易信息（交易id，客户id，交易创建人、交易创建时间）
        tran.setId(UUid.getUUID());
        tran.setCustomerId(customer.getId());
        tran.setCreateBy(((User)session.getAttribute("user")).getName());
        tran.setCreateTime(TimeFormat.getCurrentAllTime());
        //创建交易
        result += dao.insertTran(tran);

        //创建交易历史对象，并补全信息
        TranHistory history = new TranHistory();
        history.setId(UUid.getUUID());
        history.setStage(tran.getStage());
        history.setMoney(tran.getMoney());
        history.setExpectedDate(tran.getExpectedDate());
        history.setTranId(tran.getId());
        history.setCreateBy(((User)session.getAttribute("user")).getName());
        history.setCreateTime(TimeFormat.getCurrentAllTime());
        //创建交易历史
        result += dao.insertTranHistory(history);

        return (result == 3) ? "添加交易成功" : "添加交易失败";
    }

    /**
     * 条件分页查询
     * @param param
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
    public Page<Tran> pageQuery(TranQueryParam param) {

        Page<Tran> page = new Page<>();

        //根据客户名称查询客户id
        if (param.getCustomerId() == null || "".equals(param.getCustomerId())) {
            param.setCustomerId(null);
        }else {
            Customer customer = customerDao.selectCustomerByName(param.getCustomerId());
            if (customer != null) {
                param.setCustomerId(customer.getId());
            }else {
                page.setPageNo(param.getPageNo());
                page.setPageSize(param.getPageSize());
                page.setTotalSize(0);
                return page;
            }
        }


        //根据联系人名称查询联系人id
        if(param.getContactsId() == null || "".equals(param.getContactsId())){
            param.setCustomerId(null);
        }else {
            Contacts contacts = contactsDao.getContactByName(param.getContactsId());
            if (contacts != null) {
                param.setContactsId(contacts.getId());
            }else {
                page.setPageNo(param.getPageNo());
                page.setPageSize(param.getPageSize());
                page.setTotalSize(0);
                return page;
            }
        }

        page.setPageNo(param.getPageNo());
        page.setPageSize(param.getPageSize());
        param.setPageNo((param.getPageNo()-1)*param.getPageSize());
        page.setTotalSize(dao.selectTotalSize(param));
        List<Tran> list = dao.selectTranLists(param);
        page.setList(list);

        return page;
    }

    /**
     * 跳转详情页
     * @param id
     * @return
     */
    @Override
    public Tran gotoDetail(String id) {
        return dao.selectTranForName(id);
    }

    /**
     * 根据交易id查询交易历史列表，request用来获取全局作用域，在全局作用域中拿到可能性
     * @param request
     * @param tranId
     * @return
     */
    @Override
    public List<TranHistoryPoss> getTranHistoryList(HttpServletRequest request, String tranId) {
        //先通过交易id获取所有交易历史列表
        List<TranHistoryPoss> possList = dao.selectHistoryPossById(tranId);
        //获取全局作用域
        ServletContext application = request.getServletContext();
        //从全局作用域中获取可能性map
        Map<String,String> pMap = (Map<String, String>) application.getAttribute("pMap");
        //将交易历史中可能性补全
        for (TranHistoryPoss historyPoss : possList) {
            String possibility = pMap.get(historyPoss.getStage());
            historyPoss.setPossibility(possibility);
        }
        return possList;
    }

    /**
     * 点击交易状态图标，变更交易状态，添加交易历史
     * @param user      更改人
     * @param tranId    交易id
     * @param stage     更改后状态
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
    public Tran changeStage(String user, String tranId, String stage) {

        //首先更改交易状态
        dao.changeStage(tranId,stage,user,TimeFormat.getCurrentAllTime());

        //查询根据id查询更改后的交易信息
        Tran tran = dao.selectTranForName(tranId);

        //添加交易历史
        TranHistory history = new TranHistory();
        history.setId(UUid.getUUID());
        history.setCreateBy(user);
        history.setCreateTime(TimeFormat.getCurrentAllTime());
        history.setExpectedDate(tran.getExpectedDate());
        history.setMoney(tran.getMoney());
        history.setStage(tran.getStage());
        history.setTranId(tranId);

        dao.insertTranHistory(history);

        return tran;
    }

    /**
     * 交易阶段统计
     * @return
     */
    @Override
    public Map<Object, Object> getEcharts() {

        Map<Object,Object> map = new HashMap<>();

        //获取交易总数量
        int total = dao.selectAllTranCount();

        //分组查询交易
        List<Map<String,Integer>> dataList = dao.selectTranGroupByStage();

        map.put("total",total);
        map.put("tran",dataList);

        return map;
    }
}
