package com.aishang.manager.controller;

import com.aishang.manager.po.AdminUser;
import com.aishang.manager.service.IUserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

@RequestMapping("/user")
@Controller
public class UserController {

    @Resource
    private IUserService userService;

    @Resource
    private HttpSession session;

    @RequestMapping("login")
    public String login() {
        return "login";
    }

    /*登录校验成功存入Cookie中*/
    @RequestMapping("doLogin")
    public String doLogin(AdminUser user, HttpServletResponse response, String save) throws UnsupportedEncodingException {
        AdminUser u = userService.findUserNameAndPwd(user);
        session.setAttribute("su", u);

        if (u == null) {
            return "login";
        }
        Cookie cookie = new Cookie("user", URLEncoder.encode((u.getUsername() + "-" + u.getPassword()), "UTF-8"));
        if (cookie != null) {
            if (save != null) {
                cookie.setMaxAge(60 * 60 * 24 * 7);
                cookie.setPath("/");
                response.addCookie(cookie);
            } else {
                cookie.setMaxAge(0);
                cookie.setPath("/");
                response.addCookie(cookie);
            }
            return "home";

        }
        return "login";
    }

    /*当点击退出登录的时候销毁session*/
    @RequestMapping("dologout")
    public String dologout() {
        session.invalidate();
        return "login";
    }


}
