<%--
  Created by IntelliJ IDEA.
  User: gaoxz
  Date: 2021-08-12
  Time: 14:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getScheme()+"://"+
                  request.getServerName()+":"+
                  request.getServerPort()+
                  request.getContextPath()+"/";
%>
<html>
<head>
    <meta charset="UTF-8">
    <base href="<%=path%>">
    <link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#btn1").click(function () {
               login();
            })
            $(window).keyup(function (event) {
                if(event.keyCode === 13){
                    login();
                }
            })
        })

        //自定义登录方法
        function login() {
            var loginAct = $.trim($("#loginAct").val());
            var loginPwd = $.trim($("#loginPwd").val());
            if(loginAct === ""){
                alert("用户名不能为空！");
            }else if(loginPwd === ""){
                alert("密码不能为空！");
            }else {
                $.ajax({
                    url:"user/login",
                    data:{
                        loginAct:loginAct,
                        loginPwd:loginPwd
                    },
                    type:"post",
                    dataType:"json",
                    success:function (result) {
                        if(result.isSuccess){
                            document.location = "workbench/index.jsp";
                        }else {
                            $("#msg").html(result.msg);
                        }
                    }
                })
            }
        }
    </script>
</head>
<body>
<div style="position: absolute; top: 0px; left: 0px; width: 60%;">
    <img src="image/IMG_7114.JPG" style="width: 100%; height: 90%; position: relative; top: 50px;">
</div>
<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
    <div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">CRM &nbsp;<span style="font-size: 12px;">&copy;2017&nbsp;动力节点</span></div>
</div>

<div style="position: absolute; top: 120px; right: 100px;width:450px;height:400px;border:1px solid #D5D5D5">
    <div style="position: absolute; top: 0px; right: 60px;">
        <div class="page-header">
            <h1>登录</h1>
        </div>
        <form action="workbench/index.html" class="form-horizontal" role="form">
            <div class="form-group form-group-lg">
                <div style="width: 350px;">
                    <input class="form-control" type="text" id="loginAct" name="loginAct" placeholder="用户名">
                </div>
                <div style="width: 350px; position: relative;top: 20px;">
                    <input class="form-control" type="password" id="loginPwd" name="loginPwd" placeholder="密码">
                </div>
                <div class="checkbox"  style="position: relative;top: 30px; left: 10px;">

                    <span id="msg" style="color: red"></span>

                </div>
                <input type="button" id="btn1" class="btn btn-primary btn-lg btn-block" value="登录" style="width: 350px; position: relative;top: 45px;">
            </div>
        </form>
    </div>
</div>
</body>
</html>
