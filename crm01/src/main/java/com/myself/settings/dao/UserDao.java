package com.myself.settings.dao;

import com.myself.settings.entity.User;

import java.util.List;

public interface UserDao {
    User selectUserById(String loginAct);
    List<User> selectAllUsers();
}
