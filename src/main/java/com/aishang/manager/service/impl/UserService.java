package com.aishang.manager.service.impl;

import com.aishang.manager.dao.UserMapper;
import com.aishang.manager.po.AdminUser;

import com.aishang.manager.service.IUserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service

public class UserService implements IUserService {
    @Resource
    private UserMapper userMapper;

    @Override
    public AdminUser findUserNameAndPwd(AdminUser user) {
        return userMapper.findUserNameAndPwd(user);
    }
}
