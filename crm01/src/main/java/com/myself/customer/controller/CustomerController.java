package com.myself.customer.controller;

import com.myself.customer.service.CustomerService;
import com.myself.settings.entity.User;
import com.myself.tran.entity.Tran;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping(value = "/customer")
public class CustomerController {

    @Autowired(required = false)
    private CustomerService service;

    @RequestMapping(value = "addCustomerByClue",produces = "application/json;charset=utf-8")
    @ResponseBody
    public Boolean conversionClue(HttpSession session, String clueId, Boolean isCreateTran, Tran tran){
        return service.addCustomerByClue(((User)session.getAttribute("user")).getName(),clueId,isCreateTran,tran);
    }

}
