package com.myself.contacts.dao;

import com.myself.contacts.entity.Contacts;
import org.springframework.stereotype.Repository;

@Repository
public interface ContactsDao {

    /**
     * 添加联系人
     * @param contacts
     * @return
     */
    int insertContact(Contacts contacts);

}
