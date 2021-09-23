package com.myself.contacts.controller;

import com.myself.contacts.entity.Contacts;
import com.myself.contacts.service.ContactsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/contacts")
public class ContactsController {

    @Autowired(required = false)
    private ContactsService service;

     /**
     * 用于添加交易页面中点击联系人查询按钮
     * 通过联系人姓名模糊查询联系人列表
     * @param name
     * @return
     */
    @RequestMapping(value = "/getContactsByName",produces = "application/json;charset=utf-8")
    public @ResponseBody List<Contacts> getContactsByName(String name){
        return service.getAllContactsByName(name);
    }

    @RequestMapping(value = "/getContactsById",produces = "application/json;charset=utf-8")
    public @ResponseBody Contacts getContactsById(String id){
        return service.getContactsById(id);
    }
}
