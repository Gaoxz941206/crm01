package com.myself.contacts.service;

import com.myself.contacts.entity.Contacts;

import java.util.List;

public interface ContactsService {

    /**
     * 通过联系人姓名模糊查询联系人列表
     * @param name
     * @return
     */
    List<Contacts> getAllContactsByName(String name);

    /**
     * 通过联系人id获取联系人
     * @param id
     * @return
     */
    Contacts getContactsById(String id);
}
