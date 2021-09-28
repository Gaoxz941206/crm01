package com.myself.tran.controller;

import com.myself.Utils.Page;
import com.myself.settings.service.UserService;
import com.myself.tran.entity.Tran;
import com.myself.tran.entity.TranHistory;
import com.myself.tran.service.TranService;
import com.myself.vo.TranHistoryPoss;
import com.myself.vo.TranQueryParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

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

    /**
     * 添加交易
     * @param session       获取用户信息
     * @param tran          交易信息
     * @param customerName  查询/添加客户
     * @return
     */
    @RequestMapping(value = "/insert",produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String addTran(HttpSession session, Tran tran,String customerName){
        String string = service.addTran(session,tran,customerName);
        return string;
    }

    /**
     * 条件分页查询交易列表
     * @param param
     * @return
     */
    @RequestMapping(value = "/pageQuery",produces = "application/json;charset=utf-8")
    @ResponseBody
    public Page<Tran> pageQuery(TranQueryParam param){
        return service.pageQuery(param);
    }

    /**
     * 跳转至详情页
     * @param id
     * @return
     */
    @RequestMapping(value = "/gotoDetail",produces = "application/json;charset=utf-8")
    @ResponseBody
    public ModelAndView gotoDetail(HttpServletRequest request, String id){
        ServletContext application = request.getServletContext();
        Map<String,String> pMap = (Map<String, String>) application.getAttribute("pMap");
        ModelAndView mav = new ModelAndView();
        mav.addObject("tran",service.gotoDetail(id));
        mav.addObject("possibility",pMap.get(service.gotoDetail(id).getStage()));
        mav.setViewName("workbench/transaction/detail");
        return mav;
    }

    @RequestMapping(value = "/getHistoryList",produces = "application/json;charset=utf-8")
    @ResponseBody
    public List<TranHistoryPoss> getHistoryList(HttpServletRequest request, String tranId){
        return service.getTranHistoryList(request,tranId);
    }
}
