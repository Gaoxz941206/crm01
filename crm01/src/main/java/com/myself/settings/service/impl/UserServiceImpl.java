package com.myself.settings.service.impl;

import com.myself.Utils.Encrypt;
import com.myself.Utils.TimeFormat;
import com.myself.exception.UserException;
import com.myself.settings.dao.UserDao;
import com.myself.settings.entity.User;
import com.myself.settings.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao dao;

    /**
     * 创建市场活动时，模态窗口中的用户列表信息
     * @return  所有用户
     */
    @Override
    public List<User> selectAllUsers() {
        return dao.selectAllUsers();
    }


    /**
     * 用户登录
     * @param loginAct  登录账号
     * @param logPwd    登录密码
     * @param ip        登录ip地址
     * @return  用户信息（或抛出异常信息）
     */
    @Override
    public User userLogin(String loginAct, String logPwd, String ip) {
        User user = dao.selectUserById(loginAct);
        if (user == null) {
            throw new UserException("用户不存在！");
        }
        if(!Encrypt.getMD5(logPwd).equals(user.getLoginPwd())){
            throw new UserException("用户密码不正确！");
        }
        if("0".equals(user.getLockState())){
            throw new UserException("用户已被锁定！");
        }
        if(user.getExpireTime().compareTo(TimeFormat.getCurrentAllTime()) < 0){
            throw new UserException("用户已失效！");
        }
        if(!user.getAllowIps().contains(ip)){
            throw new UserException("非法的ip地址！");
        }
        return user;
    }
}
