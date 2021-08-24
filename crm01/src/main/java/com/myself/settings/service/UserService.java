package com.myself.settings.service;

import com.myself.settings.entity.User;

import java.util.List;

public interface UserService {
    User userLogin(String loginAct, String logPwd, String ip);
    List<User> selectAllUsers();
}
