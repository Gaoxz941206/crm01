package com.myself.workbench.controller;

import com.myself.settings.entity.User;
import com.myself.workbench.entity.ActivityRemark;
import com.myself.workbench.service.ActivityRemarkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

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

    @RequestMapping(value = "/insert",produces = "application/json;charset=utf-8")
    @ResponseBody
    public Map<Object,Object> insertRemark(HttpSession session, String activityId, String noteContent){
        String userName = ((User)session.getAttribute("user")).getName();
        return service.insertRemark(noteContent,activityId,userName);
    }

    @RequestMapping(value = "/selectRemarkById",produces = "application/json;charset=utf-8")
    @ResponseBody
    public ActivityRemark selectById(String id){
        return service.selectRemarkById(id);
    }

    @RequestMapping(value = "/update",produces = "application/json;charset=utf-8")
    @ResponseBody
    public Map<Object,Object> updateRemark(HttpSession session,String id,String noteContent){
        return service.updateRemark(((User)session.getAttribute("user")).getName(),noteContent,id);
    }
}
