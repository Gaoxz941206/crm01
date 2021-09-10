package com.myself.workbench.controller;

import com.myself.Utils.Page;
import com.myself.settings.entity.User;
import com.myself.vo.ActivityQueryParam;
import com.myself.vo.Activity_User;
import com.myself.workbench.entity.Activity;
import com.myself.workbench.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/activity")
public class ActivityController {

    @Autowired(required = false)
    private ActivityService service;

    /**
     * 添加市场活动
     * @param session   获取当前用户信息
     * @param activity  市场活动参数
     * @return  true:添加成功 false：添加失败
     */
    @RequestMapping(value = "/insert")
    @ResponseBody
    public String activityInsert(HttpSession session,Activity activity){
        activity.setCreateBy(((User)session.getAttribute("user")).getName());
        int result = service.activityInsert(activity);
        if(result == 1){
            return "success";
        }else {
            return "fail";
        }
    }

    /**
     * 在页面加载时，无条件分页查询市场活动信息
     * @param param pageNo = 1 ; pageSize = 5
     * @return
     */
    @RequestMapping(value = "/selectAll",produces = "application/json;charset=utf-8")
    @ResponseBody
    public Page<Activity_User> activityAllQuery(ActivityQueryParam param){
        return service.loadQuery(param);
    }

    /**
     * 删除市场活动信息
     * @param actIds  需要删除的市场活动信息id数组
     * @return
     */
    @RequestMapping(value = "/delete",produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String activityDelete(@RequestParam(value = "actIds[]") String[] actIds){
        return service.activityDelete(actIds);
    }

    /**
     * 修改市场活动信息之前先按id查询该市场活动信息
     * @param id
     * @return
     */
    @RequestMapping(value = "/selectById",produces = "application/json;charset=utf-8")
    @ResponseBody
    public Map<Object,Object> selectActivityById(String id){
        return service.selectActivityById(id);
    }

    /**
     * 修改市场活动信息
     * @param session       获取用户信息(市场活动信息修改人、时间)
     * @param activity      新的市场活动信息
     * @return
     */
    @RequestMapping(value = "/update",produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String updateActivity(HttpSession session,Activity activity){
        User user = (User) session.getAttribute("user");
        return service.updateActivity(activity,user);
    }

    @RequestMapping(value = "/selectActivityByName",produces = "application/json;charset=utf-8")
    @ResponseBody
    public List<Activity> selectActivityByName(String name){
        List<Activity> list = service.selectActivityByName(name);
        return list;
    }
}
