package com.myself.contacts.service.impl;

import com.myself.contacts.dao.ContactsDao;
import com.myself.contacts.entity.Contacts;
import com.myself.contacts.service.ContactsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Service
public class ContactsServiceImpl implements ContactsService {

    @Autowired(required = false)
    private ContactsDao dao;

    /**
     * 用于添加交易页面中点击联系人查询按钮
     * 通过联系人姓名模糊查询联系人列表
     * @param name
     * @return
     */
    @Override
    public List<Contacts> getAllContactsByName(String name) {
        return dao.selectContactsByName(name);
    }

    /**
     * 通过联系人id获取联系人
     * @param id
     * @return
     */
    @Override
    public Contacts getContactsById(String id) {
        return dao.selectContactsById(id);
    }

}
