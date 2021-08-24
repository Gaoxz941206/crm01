package com.myself.workbench.controller;

import com.myself.workbench.service.ActivityRemarkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/activityRemark")
public class ActivityRemarkController {

    @Autowired(required = false)
    private ActivityRemarkService service;

    @RequestMapping(value = "/gotoRemark",produces = "application/json;charset=utf-8")
    public ModelAndView gotoActivityRemark(String id){
        ModelAndView mav = new ModelAndView();
        mav.addObject("activity",service.selectActivityById(id));
        mav.setViewName("workbench/activity/detail");
        return mav;
    }
}
