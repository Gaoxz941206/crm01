package com.myself.workbench.controller;

import com.myself.workbench.entity.ActivityRemark;
import com.myself.workbench.service.ActivityRemarkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

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

    @RequestMapping(value = "/selectById",produces = "application/json;charset=utf-8")
    @ResponseBody
    public List<ActivityRemark> getRemarksById(String id){
        return service.selectRemarksById(id);
    }

    @RequestMapping(value = "/delete",produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String deleteRemark(String id){
        return service.deleteRemark(id);
    }
}
