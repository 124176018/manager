package com.aishang.manager.service;

import com.aishang.manager.po.AdminUser;

public interface IUserService {
    /*登录校验*/
    AdminUser findUserNameAndPwd(AdminUser user);
}
