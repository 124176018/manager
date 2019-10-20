package com.aishang.manager.dao;

import com.aishang.manager.po.AdminUser;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper {
    AdminUser findUserNameAndPwd(AdminUser user);

}
