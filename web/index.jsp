<%--
  Created by IntelliJ IDEA.
  User: 12697
  Date: 2020/4/18
  Time: 22:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>学生成绩管理系统</title>
    <link rel="stylesheet" href="com/css/flipclock.css">
    <link rel="stylesheet" href="com/css/homeStyle.css">
    <link rel="stylesheet" href="com/css/Icon.css">
    <link rel="stylesheet" href="com/css/style.css">
    <script type="text/javascript" src="com/js/studentJS/base.js"></script>
    <script type="text/javascript" src="com/js/studentJS/jquery.min.js"></script>
    <script type="text/javascript" src="com/js/studentJS/flipclock.js"></script>
</head>
<body>
<c:set value="${pageContext.request.session.getAttribute('identity')}" var="identity"></c:set>
<div class="container-scroller">
    <nav class="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
        <div class="navbar-brand-wrapper d-flex justify-content-center">
            <div class="navbar-brand-inner-wrapper d-flex justify-content-between align-items-center w-100">
                <a class="navbar-brand brand-logo">学生信息管理系统</a>
            </div>
        </div>
        <div class="navbar-menu-wrapper d-flex align-items-center justify-content-end">
            <ul class="navbar-nav mr-lg-4 w-100">
                <li class="nav-item nav-search d-none d-lg-block w-100">
                    <div class="input-group">
                        <div class="input-group-prepend">
                <span class="input-group-text" id="search">
                  <i class="mdi mdi-magnify"></i>
                </span>
                        </div>
                        <input type="text" class="form-control" placeholder="Search now" aria-label="search"
                               aria-describedby="search" readonly="readonly">
                    </div>
                </li>
            </ul>
            <ul class="navbar-nav navbar-nav-right">
                <li class="nav-item nav-profile dropdown">
                    <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" id="profileDropdown">
                        <span class="nav-profile-name"><c:out
                                value="${pageContext.request.getAttribute('name')}"/></span>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right navbar-dropdown" aria-labelledby="profileDropdown">
                        <a class="dropdown-item" id="logout">
                            退出
                        </a>
                    </div>
                </li>
            </ul>
            <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button"
                    data-toggle="offcanvas">
                <span class="mdi mdi-menu"></span>
            </button>
        </div>
    </nav>
    <!-- partial -->
    <div class="container-fluid page-body-wrapper">
        <!-- partial:partials/_sidebar.html -->
        <nav class="sidebar sidebar-offcanvas" id="sidebar">
            <ul class="nav">
                <li class="nav-item">
                    <a class="nav-link" href="javascript:;">
                        <i class="mdi mdi-circle-outline menu-icon"></i>
                        <span class="menu-title" id="index">首页</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="javascript:;">
                        <i class="mdi mdi-view-headline menu-icon"></i>
                        <span class="menu-title" id="info">个人信息</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="collapse" href="javascript:;" aria-expanded="false"
                       aria-controls="ui-basic">
                        <i class="mdi mdi-chart-pie menu-icon"></i>
                        <span class="menu-title" id="course">课程信息</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="javascript:;">
                        <i class="mdi mdi-grid-large menu-icon"></i>
                        <span class="menu-title" id="score">成绩信息</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="javascript:;">
                        <i class="mdi mdi-chart-pie menu-icon"></i>
                        <span class="menu-title" id="choose">选课信息</span>
                    </a>
                </li>
                <c:if test="${identity=='administrator'}">
                    <li class="nav-item">
                        <a class="nav-link" href="javascript:;">
                            <i class="mdi mdi-account menu-icon"></i>
                            <span class="menu-title" id="management">人员管理</span>
                        </a>
                    </li>
                </c:if>
                <li class="nav-item">
                    <a class="nav-link" href="javascript:;">
                        <i class="mdi mdi-emoticon menu-icon"></i>
                        <span class="menu-title" id="change">修改密码</span>
                    </a>
                </li>
            </ul>
        </nav>
        <div id="main">
            <div class="agile_info_shadow">
                <div class="img_wthee_post1">
                    <h3 class="w3_inner_tittle">欢迎登录！</h3>
                    <div class="main-example">
                        <div class="clock"></div>
                        <div class="message"></div>

                    </div>
                </div>
            </div>
            <iframe name="right" id="frame" frameborder="no" scrolling="auto" width="100%" height="100%">
            </iframe>
        </div>
    </div>
</div>
</body>
<script type="text/javascript">
    window.history.forward(1);//禁止浏览器退出后返回

    $(document).ready(function () {

        var clock;

        clock = $('.clock').FlipClock({
            clockFace: 'HourlyCounter'
        });

        //为“退出”添加事件监听
        $('#logout').click(function () {
            $.ajax({
                type: "GET",
                url: "login",
                async: false,
                data: {"logout": "false"},
                success: function (result) {
                    location.href = result;
                },
                error: function () {
                    location.href = "login.jsp";
                }
            });
        });

        $('.menu-title').click(function () {
            $('.agile_info_shadow').animate({opacity: '0'}, 100);
        });

        $('#index').click(function () {
            $('.agile_info_shadow').animate({opacity: '1'}, 100);
            $('#main>iframe').attr("src", "");
        });


        $('#info').click(function () {
            $('#main>iframe').attr("src", "choose?pageName=jsp/showInformation.jsp");
        });

        $('#course').click(function () {
            $('#main>iframe').attr("src", 'choose?pageName=jsp/courseInformation.jsp');
        });
        $('#score').click(function () {
            $('#main>iframe').attr("src", "choose?pageName=jsp/gradeInformation.jsp");
        });
        $('#choose').click(function () {
            $('#main>iframe').attr("src", "choose?pageName=jsp/chooseCourse.jsp");
        });
        $('#management').click(function () {
            $('#main>iframe').attr("src", "choose?pageName=jsp/personnelManagement.jsp");
        });
        $('#change').click(function () {
            $('#main>iframe').attr("src", "choose?pageName=jsp/changePassword.jsp");
        });

        // $('.menu-title').click(function () {
        //     let tem = $('#frame').attr("src");
        //     alert(tem);
        //     if (tem.indexOf("login.jsp") >= 0) {
        //         $.ajax({
        //             type: "GET",
        //             url: "login",
        //             async: false,
        //             data: {"logout": "false"},
        //             success: function (result) {
        //
        //                 location.href = result;
        //             },
        //             error: function () {
        //                 location.href = "login.jsp";
        //             }
        //         });
        //     }
        // });

    });
</script>
</html>
