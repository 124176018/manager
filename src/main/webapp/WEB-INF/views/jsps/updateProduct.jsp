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

    <title>商品修改</title>

    <meta
            content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'
            name='viewport'/>
    <meta name="viewport" content="width=device-width"/>


    <!-- Bootstrap core CSS     -->
    <link
            href="${pageContext.request.contextPath}/css/bootstrap.min.css"
            rel="stylesheet"/>

    <!-- Animation library for notifications   -->
    <link
            href="${pageContext.request.contextPath}/css/animate.min.css"
            rel="stylesheet"/>

    <!--  Light Bootstrap Table core CSS    -->
    <link
            href="${pageContext.request.contextPath}/css/light-bootstrap-dashboard.css"
            rel="stylesheet"/>


    <!--  CSS for Demo Purpose, don't include it in your project     -->
    <link
            href="${pageContext.request.contextPath}/css/demo.css"
            rel="stylesheet"/>


    <!--     Fonts and icons     -->
    <style type="text/css">
        .new-contentarea {
            width: 100%;
            overflow: hidden;
            margin: 0 auto;
            position: relative;
        }

        .new-contentarea label {
            width: 100%;
            height: 100%;
            display: block;
        }

        .new-contentarea input[type=file] {
            width: 188px;
            height: 60px;
            background: #333;
            margin: 0 auto;
            position: absolute;
            right: 50%;
            margin-right: -94px;
            top: 0;
            right /*\**/: 0px \9;
            margin-right /*\**/: 0px \9;
            width /*\**/: 10px \9;
            opacity: 0;
            filter: alpha(opacity=0);
            z-index: 2;
        }

        a.upload-img {
            width: 165px;
            display: inline-block;
            margin-bottom: 10px;
            height: 57px;
            line-height: 57px;
            font-size: 20px;
            color: #FFFFFF;
            background-color: #f38e81;
            border-radius: 3px;
            text-decoration: none;
            cursor: pointer;
        }

        a.upload-img:hover {
            background-color: #ec7e70;
        }

        .tc {
            text-align: center;
        }
    </style>
    <link
            href="${pageContext.request.contextPath}/css/pe-icon-7-stroke.css"
            rel="stylesheet"/>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/XMLHttpRequest.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.10.2.js"></script>
    <script type="text/javascript">
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
                        $("#csid").append("<option value=" + csname + " >" + csname + "</option>")
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
    <script type="text/javascript">

        function checked(form) {
            var pname = form.pname;
            var cid = form.cid;
            var market_price = form.market_price;
            var shop_price = form.shop_price;
            var pdesc = form.pdesc;

            if (pname.value == null || pname.value == "") {
                alert("商品名称不能为空");
                return false;
            } else if (cid.value == 0) {
                alert("一级类目不能为空");
                return false;
            } else if (market_price.value == null || market_price.value == "") {
                alert("价格不能为空");
                return false;
            } else if (shop_price.value == null || shop_price.value == "") {
                alert("价格不能为空");
                return false;
            } else if (pdesc.value == null || pdesc.value == "") {
                alert("商品详情不能为空");
                return false;
            }
            ;
        }

        //动态图片标签的id
        var i = 0;
        var j = "${fn:length(imageList)}";

        //点击添加file上传标签
        function addFile() {
            i = i + 1;
            if (i <= 4 - j) {

                $("#innerFile")
                    .append(
                        "<img id='img" + i + "' src='' width='106' alt=''><span id='delete" + i + "'></span>");
                $("#innerFile")
                    .append(
                        "<input type='file' id='addfile"
                        + i
                        + "' name='files' class='form-control' onchange='changepic("
                        + i + ")' accept='image/*'/>");
            } else {
                alert("本条新闻最多上传4张照片");
            }
        }

        //回显新增图片
        function changepic(i) {
            var filePath = $("#addfile" + i).val();
            if (filePath != null && filePath != "") {
                filePath = filePath.substring(filePath.lastIndexOf("."))
                    .toLowerCase();
                if (filePath != ".png" && filePath != ".jpg" && filePath != ".jpeg"
                    && filePath != ".gif") {
                    alert('上传错误,文件格式必须为：png/jpg/jpeg/gif');
                    $("#addfile" + i).val("");
                    return;
                }
                var reads = new FileReader();
                f = document.getElementById('addfile' + i).files[0];
                reads.readAsDataURL(f);
                reads.onload = function (e) {
                    document.getElementById('img' + i).src = this.result;
                    if ($("#b" + i).val() == null || $("#b" + i).val() == "") {
                        $("#delete" + i).append(
                            "<button type='button' id='b" + i
                            + "'onclick='movePic(" + i + ")' value='b"
                            + i + "'>移除</button>");
                    }
                };
            } else {
                $("#delete" + i).remove();
                $("#img" + i).remove();
            }
        }

        //移除新增图片
        function movePic(i) {
            $("#delete" + i).remove();
            $("#addfile" + i).remove();
            $("#img" + i).remove();
        }

        //移除修改图片
        function delPic(i) {
            if (confirm("确认移除该图片吗？")) {
                $
                    .ajax({
                        url: "${pageContext.request.contextPath}/product/ajaxdelimage",
                        type: "get",
                        dataType: "text",
                        data: {
                            pid: i,
                        },
                        success: function (data) {
                            alert(data);
                            if (data == "yes") {
                                $("#span" + i).remove();

                            }
                        }
                    });

            }
        }

        //点击添加file上传标签主图
        function addFile1() {

            i = i + 1;
            if (i > 2) {
                alert("只能传一张主图");

            } else {

                $("#innerFile")
                    .append(
                        "<img id='img" + i + "' src='' width='106' alt=''><span id='button" + i + "'></span>");
                $("#innerFile")
                    .append(
                        "<input type='file' id='addfile" + i + "' name='filename' class='form-control' onchange='changepic(" + i + ")' accept='image/*'/>");
                // accept='image/*不限制图像的格式
            }
        }
    </script>


</head>
<body>

<div class="wrapper">


    <div class="sidebar" data-color="grow" data-image="images/sidebar-5.jpg">
        <div class="sidebar-wrapper">
            <div class="logo">
                <a href="${pageContext.request.contextPath}/" class="simple-text">
                    <img src="${pageContext.request.contextPath}/images/logo.png">
                </a>
            </div>

            <ul class="nav">
                <li>
                    <a href="${pageContext.request.contextPath}/product/getproduct">
                        <i class="pe-7s-graph"></i>
                        <p>商品列表</p>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/product/getaddproduct">
                        <i class="pe-7s-user"></i>
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
                    <a class="navbar-brand" href="${pageContext.request.contextPath}/">新闻管理系统</a>
                </div>
                <div class="collapse navbar-collapse">
                    <ul class="nav navbar-nav navbar-left">
                        <li class="dropdown">
                            <a href="${pageContext.request.contextPath}/" class="dropdown-toggle"
                               data-toggle="dropdown">
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
                    <div class="col-md-8">
                        <div class="card">
                            <div class="header">
                                <h4 class="title">修改商品</h4>
                            </div>
                            <div class="content">
                                <!-- biaodian-->
                                <form action="${pageContext.request.contextPath}/product/uuproduct?pid=${product.pid}"
                                      method="post" enctype="multipart/form-data" onsubmit="return checked(this)">
                                    <div class="row">
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <label>商品名称</label>
                                                <input type="text" class="form-control" name="pname" id="pname"
                                                       value="${product.pname}">
                                                <c:forEach items=" ${product}" var="ee">


                                                </c:forEach>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label>一级类目</label>
                                                <c:forEach items="${product.categories.categorysSeconds}" var="dd">
                                                    <input type="hidden" id="cssid" value="${dd.csid}">
                                                </c:forEach>
                                                <select id="cid" name="cid">
                                                    <option value="0" selected="selected">一级类目</option>
                                                    <c:forEach items="${cateone}" var="ss">
                                                        <option value="${ss.cid}" <c:if
                                                            test="${product.categories.cid==ss.cid}">selected </c:if><span>${ss.cname}</span></option>
                                                    </c:forEach>
                                                </select>

                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>二级类目</label>
                                                <select id="csid" name="csname">
                                                    <option selected="selected" value="">二级类目</option>
                                                </select>

                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>商城价格</label>
                                                <input type="number" class="form-control" id="market_price"
                                                       placeholder="商城价格" name="market_price"
                                                       value="${product.market_price}" min="1">
                                                <span id="recMsg"></span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>市场价格</label>
                                                <input type="number" class="form-control" id="shop_price"
                                                       placeholder="市场价格" name="shop_price"
                                                       value="${product.shop_price}" min="1">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <p>
                                                    <button id="addFlie1" type="button" onclick="addFile1()">添加商品主图片
                                                    </button>
                                                    <c:if test="${!empty param.msg}">
                                                        <font color="red">${param.msg=='singleTooBig'?'某个文件内存超限':'文件总量内存超限'}</font>
                                                    </c:if>
                                                    <c:if test="${!empty param.Picmsg}">
                                                        <font color="red">上传文件格式与图片不符</font>
                                                    </c:if>
                                                </p>
                                                <div>
															<span id="span${product.pid}"> <img width="106px"
                                                                                                id="image${product.pid}"
                                                                                                src="${pageContext.request.contextPath}/${product.pimage}">
																<button id='button${product.pid}' type='button'
                                                                        onclick='delPic("${product.pid}")'>移除</button>
																<p>${fn:split(product.pimage,'/')[1]}</p>
                                                            </span>
                                                </div>
                                                <span id="innerFile"></span>


                                                <p>
                                                    <button id="addFlie" type="button" onclick="addFile()">添加商品详情图片
                                                    </button>
                                                    <c:if test="${!empty param.msg}">
                                                        <font color="red">${param.msg=='singleTooBig'?'某个文件内存超限':'文件总量内存超限'}</font>
                                                    </c:if>
                                                    <c:if test="${!empty param.Picmsg}">
                                                        <font color="red">上传文件格式与图片不符</font>
                                                    </c:if>
                                                </p>
                                                <c:forEach items="${imageList}" var="image">
                                                    <c:if test="${!empty image.pid}">
                                                        <div>
															<span id="span${image.pid}"> <img width="106px"
                                                                                              id="image${image.pid}"
                                                                                              src="${pageContext.request.contextPath}/${image.thumbnail}">
																<button id='button${image.pid}' type='button'
                                                                        onclick='delPic("${image.pid}")'>移除</button>
																<p>${fn:split(image.thumbnail,'/')[1]}</p>
                                                            </span>
                                                        </div>
                                                    </c:if>
                                                </c:forEach>
                                                <span id="innerFile"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>商品简介</label>
                                                <textarea class="form-control" rows="10" name="pdesc"
                                                          id="pdesc">${product.pdesc}</textarea>

                                            </div>
                                        </div>
                                    </div>

                                    <input type="hidden" name="icon"
                                           value="ICon\2018\09-25\e3b25415-a75c-49f1-9fcf-456091c4b2a7_001.gif">
                                    <button type="submit" id="sbb"
                                            class="btn btn-info btn-fill pull-right">修改
                                    </button>
                                    <div class="clearfix"></div>

                                </form>
                            </div>
                        </div>
                    </div>


                    <div class="col-md-4">
                        <div class="card card-user">
                            <div class="image">
                                <img src="${pageContext.request.contextPath}/images/userleft.bg.jpg"
                                     alt="/newsSystem."/>
                            </div>
                            <div class="content">
                                <div class="author">
                                    <a href="#">

                                        <img class="avatar border-gray"
                                             src="${pageContext.request.contextPath}/images\faces\face-3.jpg"
                                             alt="/newsSystem."/>


                                        <h4 class="title">admin<br/>
                                            <small>爱尚教育部</small>
                                        </h4>
                                    </a>
                                </div>
                                <p class="description text-center"> admin是一位 <br>
                                    18岁的女孩, 在<br>
                                    爱尚教育部努力工作
                                </p>
                            </div>
                            <hr>
                            <div class="text-center">
                                <button href="#" class="btn btn-simple"><i class="fa fa-facebook-square"></i></button>
                                <button href="#" class="btn btn-simple"><i class="fa fa-twitter"></i></button>
                                <button href="#" class="btn btn-simple"><i class="fa fa-google-plus-square"></i>
                                </button>

                            </div>
                        </div>
                    </div>


                </div>
            </div>
        </div>


        <footer class="footer">
            <div class="container-fluid">
                <nav class="pull-left">
                    <ul>
                        <li>
                            <a href="${pageContext.request.contextPath}/">
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
                    &copy; 2017 当前累计登陆访问次数 ： <a href="#" target="_blank" title="联系我们"> 623</a> - 统计来自 <a href="#"
                                                                                                         title="爱尚实训"
                                                                                                         target="_blank">爱尚教育</a>
                </p>
            </div>
        </footer>
    </div>
</div>


</body>

<!--   Core JS Files   -->
<script
        src="${pageContext.request.contextPath}/js/jquery-1.10.2.js"
        type="text/javascript"></script>
<script
        src="${pageContext.request.contextPath}/js/bootstrap.min.js"
        type="text/javascript"></script>

<!--  Checkbox, Radio & Switch Plugins -->
<script
        src="${pageContext.request.contextPath}/js/bootstrap-checkbox-radio-switch.js"></script>

<!--  Charts Plugin -->
<script
        src="${pageContext.request.contextPath}/js/chartist.min.js"></script>

<!--  Notifications Plugin    -->
<script
        src="${pageContext.request.contextPath}/js/bootstrap-notify.js"></script>


<!-- Light Bootstrap Table Core javascript and methods for Demo purpose -->
<script
        src="${pageContext.request.contextPath}/js/light-bootstrap-dashboard.js"></script>

<!-- Light Bootstrap Table DEMO methods, don't include it in your project! -->
<script
        src="${pageContext.request.contextPath}/js/demo.js"></script>

</html>