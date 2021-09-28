package com.myself.contacts.dao;

import com.myself.contacts.entity.Contacts;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ContactsDao {

    /**
     * 添加联系人
     * @param contacts
     * @return
     */
    int insertContact(Contacts contacts);

    /**
     * 通过联系人姓名模糊查询联系人
     * @param name
     * @return
     */
    List<Contacts> selectContactsByName(@Param("name") String name);

    /**
     * 通过联系人名称查询联系人
     * @param id
     * @return
     */
    Contacts selectContactsById(String id);

    /**
     * 通过联系人名称查询联系人
     * @param name
     * @return
     */
    Contacts getContactByName(String name);

}
