<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <%@ page import="java.net.URLDecoder" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>登陆</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta charset="UTF-8">
    <script type="application/x-javascript">

        addEventListener("load", function () {
            setTimeout(hideURLbar, 0);
        }, false);

        function hideURLbar() {
            window.scrollTo(0, 1);
        }

    </script>
    <meta name="keywords"
          content="Flat Dark Web Login Form Responsive Templates, Iphone Widget Template, Smartphone login forms,Login form, Widget Template, Responsive Templates, a Ipad 404 Templates, Flat Responsive Templates"/>
    <link href="${pageContext.request.contextPath}/css/style.css"
          rel='stylesheet' type='text/css'/>
</head>
<body>
<script type="text/javascript">
    /*记住我切中文名字字符串*/
    window.onload = function () {
        var strcookie = decodeURI(document.cookie);//获取cookie字符串
        var arruser = strcookie.split("=");
        var arruserName = arruser[1].split("-");
        var arrusername1 = arruserName[0];
        var username = arrusername1;
        document.getElementById('username').value = username;
    };
</script>

<!--SIGN UP-->
<h1 style="font-family: '方正华隶简体'; color: #0e4277;">管理员登陆</h1>
<div class="login-form">
    <div class="close"></div>
    <div class="head-info">
        <label class="lbl-1"> </label> <label class="lbl-2"> </label> <label
            class="lbl-3"> </label>
    </div>
    <div class="clear"></div>
    <div class="avtar">
        <img src="${pageContext.request.contextPath}/images/avtar.png"/>
    </div>
    <form action="${pageContext.request.contextPath}/user/doLogin"
          method="post">
        <input type="text" class="text"
               value="${fn:split(cookie.user.value, '-')[0]}" id="username"
               name="username" onfocus="this.value = '';"
               onblur="if (this.value == '') {this.value ='${fn:split(cookie.user.value,'-')[0]}';}">

        <div class="key">
            <input type="password" value="${fn:split(cookie.user.value,'-')[1]}"
                   name="password" onfocus="this.value = '';"
                   onblur="if (this.value == '') {this.value = '${fn:split(cookie.user.value,'-')[1]}';}">
        </div>
        <input type="checkbox" class="text" name="save" value="1"
               <c:if test="${fn:split(cookie.user.value,'-')[0]!=null}">checked</c:if>><i
            style="color: #9199aa;">一周内免登陆</i>
        <div class="signin">
            <input type="submit" value="登录">
        </div>
    </form>
</div>
<div class="copy-rights">
    <p>
        Copyright &copy; 2015.Company name All rights reserved.More Templates
        <a href=# target="_blank" title="#">#</a> - Collect from <a href=#
                                                                    title=# target="_blank">#</a>
    </p>
</div>


</body>
</html>