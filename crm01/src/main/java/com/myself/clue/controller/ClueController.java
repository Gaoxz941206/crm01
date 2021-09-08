package com.myself.clue.controller;

import com.myself.Utils.Page;
import com.myself.clue.entity.Clue;
import com.myself.clue.service.ClueService;
import com.myself.settings.entity.User;
import com.myself.vo.ClueQueryParam;
import com.myself.workbench.entity.Activity;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping(value = "/clue")
public class ClueController {

    @Autowired(required = false)
    private ClueService service;

    @RequestMapping(value = "/selectPage",produces = "application/json;charset=utf-8")
    @ResponseBody
    public Page<Clue> selectPage(ClueQueryParam param){
        return service.selectPage(param);
    }

    @RequestMapping(value = "/insert",produces = "application/json;charset=utf-8")
    @ResponseBody
    public Boolean insertClue(HttpSession session,Clue clue){
        clue.setCreateBy(((User)session.getAttribute("user")).getName());
        return service.insertClue(clue);
    }

    /**
     * 跳转至数据详情页
     * @param id 线索id
     * @return
     */
    @RequestMapping(value = "/gotoDetail")
    public ModelAndView gotoDetail(String id){
        ModelAndView mav = new ModelAndView();
        mav.addObject("clue",service.selectClueById(id));
        mav.addObject("actList",service.linkClueActivity(id));
        mav.setViewName("workbench/clue/detail");
        return mav;
    }

    /**
     * 局部刷新市场活动列表
     * @param clueId
     * @return
     */
    @RequestMapping(value = "updateActivity",produces = "application/json;charset=utf-8")
    @ResponseBody
    public List<Activity> updateActivityList(String clueId){
        return service.linkClueActivity(clueId);
    }

    /**
     * 添加市场活动列表
     * @param name
     * @param id
     * @return
     */
    @RequestMapping(value = "/addActivityList",produces = "application/json;charset=utf-8")
    @ResponseBody
    public List<Activity> addActivityList(String name,String id){
        return service.addActivityList(name,id);
    }

    /**
     * 关联添加市场活动
     * @param clueId
     * @param actIds
     * @return
     */
    @RequestMapping(value = "/bundActivity",produces = "application/json;charset=utf-8")
    @ResponseBody
    public Boolean bundActivity(String clueId,@RequestParam(value = "actIds[]") String[] actIds){
        return service.bundActivity(clueId,actIds);
    }

    @RequestMapping(value = "deleteActivity",produces = "application/json;charset=utf-8")
    @ResponseBody
    public int unbundActivity(String id){
        return service.deleteActivity(id);
    }
}