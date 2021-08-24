package com.myself.settings.controller;

import com.myself.Utils.Encrypt;
import com.myself.Utils.TimeFormat;
import com.myself.exception.UserException;
import com.myself.settings.entity.User;
import com.myself.settings.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired(required = false)
    private UserService service;

    /**
     * 用户登录的方法
     * @param request   请求，用来获取ip地址
     * @param loginAct  登录账号
     * @param loginPwd  登录密码
     * @return  map 登录信息(是否登录成功，错误信息)
     */
    @RequestMapping(value = "/login",produces = "application/json;charset=utf-8")
    @ResponseBody
    public Map<String,Object> userLogin(HttpServletRequest request, String loginAct, String loginPwd){
        Map<String,Object> map = new HashMap<>();
        String ip = request.getRemoteAddr();
        User user = service.userLogin(loginAct,loginPwd,ip);
        request.getSession().setAttribute("user",user);
        map.put("isSuccess",true);
        return map;
    }

    /**
     * 创建市场活动，模态窗口中的用户信息列表
     * @return  所有用户
     */
    @RequestMapping(value = "/selectAll",produces = "application/json;charset=utf8")
    @ResponseBody
    public List<User> selectAllUsers(){
        return service.selectAllUsers();
    }

}
