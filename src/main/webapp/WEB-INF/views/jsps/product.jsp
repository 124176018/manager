<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <meta charset="utf-8"/>
    <link rel="icon" type="image/png"
          href="${pageContext.request.contextPath}/img/favicon.ico">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

    <title>管理页面</title>

    <meta
            content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'
            name='viewport'/>
    <meta name="viewport" content="width=device-width"/>
    <!-- Bootstrap core CSS     -->
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css"
          rel="stylesheet"/>
    <!-- Animation library for notifications   -->
    <link href="${pageContext.request.contextPath}/css/animate.min.css"
          rel="stylesheet"/>
    <!--  Light Bootstrap Table core CSS    -->
    <link
            href="${pageContext.request.contextPath}/css/light-bootstrap-dashboard.css"
            rel="stylesheet"/>
    <!--  CSS for Demo Purpose, don't include it in your project     -->
    <link href="${pageContext.request.contextPath}/css/demo.css"
          rel="stylesheet"/>
    <!--     Fonts and icons     -->
    <link href="${pageContext.request.contextPath}/css/pe-icon-7-stroke.css"
          rel="stylesheet"/>

    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.10.2.js"></script>
    <script type="text/javascript">

        function dele(pid) {
            if (!confirm("是否删除这个商品？删除请点击“确定”")) {
                return false;
            }
            $.ajax({
                url: "${pageContext.request.contextPath}/product/deproduct",
                type: "get",
                datatype: "text",
                data: {
                    pid: pid,

                },
                success: function (data) {
                    if (data.trim() == "yes") {

                        window.location.reload();
                    }
                }
            })

        }

        /*省市联动*/
        function findonetwo() {
            var csid = $("#csid");
            $.ajax({
                url: "${pageContext.request.contextPath}/product/doaddproduct",
                type: "get",
                datatype: "json",
                data: {
                    cid: $("#cid").val(),
                },
                success: function (data) {
                    var dataobj = eval(data);
                    csid.html("");
                    $.each(dataobj, function (key, val) {
                        var csname = val.csname;
                        var csid = val.csid;
                        if (csid == cssid) {
                            $("#csid").append("<option value=" + csid + " selected>" + csname + "</option>")
                        }
                        $("#csid").append("<option value=" + csid + " >" + csname + "</option>")
                    })
                }
            })

        }

        $(function () {
            findonetwo();
        })
        $(function () {
            $("#cid").change(function () {
                findonetwo();
            })
        })
    </script>
</head>
<body>

<div class="wrapper">


    <div class="sidebar" data-color="grow" data-image="images/sidebar-5.jpg">
        <div class="sidebar-wrapper">
            <div class="logo">
                <a href="#" class="simple-text">
                    <img src="${pageContext.request.contextPath}/images/logo.png">
                </a>
            </div>

            <ul class="nav">
                <li>
                    <a href="${pageContext.request.contextPath}/product/getproduct">
                        <i class="pe-7s-news-paper"></i>
                        <p>商品列表</p>
                    </a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/product/getaddproduct">
                        <i class="pe-7s-note2"></i>
                        <p>添加商品</p>
                    </a>
                </li>
            </ul>
        </div>
    </div>


    <div class="main-panel">

        <nav class="navbar navbar-default navbar-fixed">
            <div class="container-fluid">
                <div class="navbar-header">
                    <!-- <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navigation-example-2">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button> -->
                    <a class="navbar-brand" href="#">微购后台管理系统</a>
                </div>
                <div class="collapse navbar-collapse">
                    <ul class="nav navbar-nav navbar-left">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="pe-7s-graph">消息</i>
                                <b class="caret"></b>
                                <span class="notification">5</span>
                            </a>
                            <ul class="dropdown-menu">
                                <li><a href="#">Notification 1</a></li>
                                <li><a href="#">Notification 2</a></li>
                                <li><a href="#">Notification 3</a></li>
                                <li><a href="#">Notification 4</a></li>
                                <li><a href="#">Another notification</a></li>
                            </ul>
                        </li>


                    </ul>

                    <ul class="nav navbar-nav navbar-right">

                        <li>
                            <a href="${pageContext.request.contextPath}/user/dologout">
                                安全退出
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>


        <div class="content">
            <div class="container-fluid">
                <div class="row">

                    <div class="col-md-12">
                        <div class="card">
                            <div class="header">
                                <h4 class="title">用户管理</h4>
                                <p class="category">Here is a subtitle for this table</p>
                                <form action="${pageContext.request.contextPath}/product/getproduct?pageNow=${allProduct.pageNow}"
                                      method="post">
                                    <div style="float:left;  width: 130px;">
                                        <select name="cid" id="cid" class="form-control" style="width: 130px;">
                                            <option selected="selected" value="0">一级类目</option>
                                            <c:forEach items="${onecate}" var="yj">
                                                <option value="${yj.cid}" <c:if
                                                    test="${allProduct.cid==yj.cid}">selected </c:if><span>${yj.cname}</span></option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div style="float:left;  width: 130px;">
                                        <input type="hidden" id="cssid" value="${allProduct.csid}">
                                        <select name="csid" id="csid" class="form-control" style="width: 130px;">
                                            <option selected="selected" value="-1">二级类目</option>

                                        </select>
                                    </div>

                                    <div style="float:left; margin:0 2px; width: 130px;">
                                        <input type="text" class="form-control" placeholder="查询名称" name="pname"
                                               value="${allProduct.pname}">
                                    </div>
                                    <div style="float:left; margin:0 2px; width: 65px;">
                                        <button type="submit" class="btn btn-info btn-fill pull-right">查询</button>
                                    </div>
                                </form>
                            </div>
                            <div class="content table-responsive table-full-width">
                                <table class="table table-hover table-striped">
                                    <thead>
                                    <th>商品ID</th>
                                    <th>商品图片</th>
                                    <th>商品名称</th>
                                    <th>销售价格</th>
                                    <th>进货价格</th>
                                    <th>二级类目</th>
                                    <th>上传时间</th>
                                    <th>操作</th>
                                    <th>操作</th>


                                    </thead>
                                    <tbody>

                                    <c:forEach items="${pageBenForProduct.list}" var="hb">
                                        <tr height="35px">
                                            <td>${hb.pid}</td>
                                            <th><img src="${pageContext.request.contextPath}/${hb.pimage}" width="60"
                                                     height="60"></th>
                                            <td>${hb.pname}</td>
                                            <td>${hb.market_price}</td>
                                            <td>${hb.shop_price}</td>
                                            <td><c:forEach items="${findallsecondsmap}" var="yy">
                                                <c:if test="${hb.csid==yy.csid}">${yy.csname}</c:if> </c:forEach>
                                            </td>
                                            <td>${hb.pdate}</td>
                                            <td style="font-size: 12px"><a
                                                    href="${pageContext.request.contextPath}/product/uproduct?pid=${hb.pid}">修改</a>
                                            </td>
                                            <td style="font-size: 12px"><a id="del" name="del"
                                                                           onclick=" dele(${hb.pid}) ">删除</a></td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>

                            </div>
                            <div style="margin: 0 0 0px 50px; padding: 0 0 20px 0; width: 70%;">
                                第【${allProduct.pageNow}】页&nbsp&nbsp&nbsp&nbsp&nbsp共【${allProduct.pageCount}】页
                                <%--上一页--%>
                                <c:if test="${allProduct.pageNow!=1}">
                                    <a href="${pageContext.request.contextPath}/product/getproduct?cid=${allProduct.cid}&csid=${allProduct.csid}&pname=${allProduct.pname}&pageNow=${allProduct.pageNow-1}"
                                       class="about left-r f-l">【上一页】</a>
                                </c:if>

                                <%--如果是第一页,不允许点击--%>
                                <c:if test="${allProduct.pageNow != 1}">
                                    <c:choose>
                                        <c:when test="${allProduct.pageNow == 1}">

                                            <a href="${pageContext.request.contextPath}/product/getproduct?cid=${allProduct.cid}&csid=${allProduct.csid}&pname=${allProduct.pname}&pageNow=1"
                                               aria-label="Previous">
                                                <span aria-hidden="true">首页</span>
                                            </a>

                                        </c:when>
                                        <c:otherwise>
                                            <%-- 点击到首页--%>

                                            <a href="${pageContext.request.contextPath}/product/getproduct?cid=${allProduct.cid}&csid=${allProduct.csid}&pname=${allProduct.pname}&pageNow=1"
                                               aria-label="Previous">
                                                <span aria-hidden="true">首页</span>
                                            </a>

                                        </c:otherwise>
                                    </c:choose>
                                </c:if>

                                <%--中间分页--%>
                                <c:choose>
                                    <c:when test="${allProduct.pageCount <= 6}">
                                        <c:set var="begin" value="1"/>
                                        <c:set var="end" value="${allProduct.pageCount}"/>
                                    </c:when>
                                    <%--页数超过了6页--%>
                                    <c:otherwise>
                                        <c:set var="begin" value="${allProduct.pageNow - 1}"/>
                                        <c:set var="end" value="${allProduct.pageNow + 3}"/>
                                        <%--如果begin减1后为0,设置起始页为1,最大页为6--%>
                                        <c:if test="${begin -1 <= 0}">
                                            <c:set var="begin" value="1"/>
                                            <c:set var="end" value="6"/>
                                        </c:if>
                                        <%--如果end超过最大页,设置起始页=最大页-5--%>
                                        <c:if test="${end > allProduct.pageCount}">
                                            <c:set var="begin" value="${allProduct.pageCount - 5}"/>
                                            <c:set var="end" value="${allProduct.pageCount}"/>
                                        </c:if>
                                    </c:otherwise>
                                </c:choose>
                                <%--遍历--%>
                                <c:forEach var="i" begin="${begin}" end="${end}">
                                    <%--当前页,选中--%>
                                    <c:choose>
                                        <c:when test="${i == allProduct.pageNow}">
                                            <a href="${pageContext.request.contextPath}/product/getproduct?cid=${allProduct.cid}&csid=${allProduct.csid}&pname=${allProduct.pname}&pageNow=${i}">【${i}】</a>
                                        </c:when>
                                        <%--不是当前页--%>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/product/getproduct?cid=${allProduct.cid}&csid=${allProduct.csid}&pname=${allProduct.pname}&pageNow=${i}">【${i}】</a>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>


                                <%--如果是最后一页,不允许点击--%>
                                <c:if test="${allProduct.pageNow != allProduct.pageCount}">
                                    <c:choose>
                                        <c:when test="${allProduct.pageNow == allProduct.pageCount}">

                                            <a href="${pageContext.request.contextPath}/product/getproduct?cid=${allProduct.cid}&csid=${allProduct.csid}&pname=${allProduct.pname}&pageNow=${allProduct.pageCount}"
                                               aria-label="Previous">
                                                <span aria-hidden="true">尾页</span>
                                            </a>

                                        </c:when>
                                        <c:otherwise>
                                            <%-- 点击到尾页--%>

                                            <a href="${pageContext.request.contextPath}/product/getproduct?cid=${allProduct.cid}&csid=${allProduct.csid}&pname=${allProduct.pname}&pageNow=${allProduct.pageCount}"
                                               aria-label="Next">
                                                <span aria-hidden="true">尾页</span>
                                            </a>

                                        </c:otherwise>
                                    </c:choose>
                                </c:if>

                                <c:if test="${allProduct.pageNow!=allProduct.pageCount}">
                                    <a href="${pageContext.request.contextPath}/product/getproduct?cid=${allProduct.cid}&csid=${allProduct.csid}&pname=${allProduct.pname}&pageNow=${allProduct.pageNow+1}"
                                       class="about left-l f-l">【下一页】</a>
                                </c:if>


                            </div>


                            <form action="${pageContext.request.contextPath}/product/getproduct?cid=${allProduct.cid}&csid=${allProduct.csid}&pname=${allProduct.pname}"
                                  method="post">
                                <div style=" float: right; margin:-50px 80px 0 0; width: 60px; height: 40px">
                                    <input type="number" id="skipNum" class="form-control" placeholder="页面" size=2
                                           name="pageNow" min="1" max="${allProduct.pageCount}">
                                </div>
                                <div style="float: right; margin:-50px 10px 0 0; width: 60px; height: 40px">
                                    <button type="submit" id="skipBut" class="btn btn-info btn-fill pull-right"
                                            name="${allProduct.pageNow}">跳转
                                    </button>
                                </div>
                            </form>


                        </div>
                    </div>

                </div>

                <footer class="footer">
                    <div class="container-fluid">
                        <nav class="pull-left">
                            <ul>
                                <li>
                                    <a href="#">
                                        浏览效果界面
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        Company
                                    </a>
                                </li>
                                <li>
                                    <a href="http://localhost:8080/">
                                        Tomcat管理页
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        微博
                                    </a>
                                </li>
                            </ul>
                        </nav>
                        <p class="copyright pull-right">
                            &copy; 2017 当前累计登陆访问次数 ： <a href="#" target="_blank" title="联系我们"> 623</a> - 统计来自 <a
                                href="#" title="爱尚实训" target="_blank">爱尚教育</a>
                        </p>
                    </div>
                </footer>
            </div>
        </div>
    </div>
</div>


</body>

<%--<!--   Core JS Files   -->--%>
<%--<script src="js/jquery-1.10.2.js"--%>
<%--type="text/javascript"></script>--%>
<%--<script src="js/bootstrap.min.js"--%>
<%--type="text/javascript"></script>--%>

<%--<!--  Checkbox, Radio & Switch Plugins -->--%>
<%--<script--%>
<%--src="js/bootstrap-checkbox-radio-switch.js"></script>--%>

<%--<!--  Charts Plugin -->--%>
<%--<script src="js/chartist.min.js"></script>--%>

<%--<!--  Notifications Plugin    -->--%>
<%--<script src="js/bootstrap-notify.js"></script>--%>


<%--<!-- Light Bootstrap Table Core javascript and methods for Demo purpose -->--%>
<%--<script src="js/light-bootstrap-dashboard.js"></script>--%>

<%--<!-- Light Bootstrap Table DEMO methods, don't include it in your project! -->--%>
<%--<script src="js/demo.js"></script>--%>


</html>