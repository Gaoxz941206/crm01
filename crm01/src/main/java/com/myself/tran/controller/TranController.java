package com.myself.tran.controller;

import com.myself.settings.service.UserService;
import com.myself.tran.service.TranService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("/tran")
public class TranController {

    @Autowired(required = false)
    private TranService service;

    @Autowired(required = false)
    private UserService userService;

    /***
     * 查询所有用户信息，转发至添加页面中的"所有者"
     * @return
     */
    @RequestMapping(value = "queryUsers")
    public ModelAndView queryUsers(){
        ModelAndView mav = new ModelAndView();
        mav.addObject("userList",userService.selectAllUsers());
        mav.setViewName("workbench/transaction/save");
        return mav;
    }

}
