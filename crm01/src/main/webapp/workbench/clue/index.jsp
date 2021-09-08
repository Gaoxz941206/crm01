<%--
  Created by IntelliJ IDEA.
  User: gaoxz
  Date: 2021-08-28
  Time: 15:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />

    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

    <script type="text/javascript">
        $(function(){
            //日期窗口
            $(".time").datetimepicker({
                minView:"month",
                language:"zh-CN",
                format:"yyyy-mm-dd",
                autoclose:true,
                todayBtn:true,
                pickerPosition:"top-left"
            });

            //页面加载时查询
            ajaxPageQuery(1,5);

            //点击查询按钮查询
            $("#queryBtn").click(function () {
                var pageNo = $.trim($("#pageNo").val());
                var pageSize = $.trim($("#pageSize").val());
                ajaxPageQuery(pageNo,pageSize);
            });

            //弹出创建模态窗口之前，先查询所有者
            $("#addClueBtn").click(function () {
                $.ajax({
                    url:"user/selectAll",
                    type:"get",
                    dataType: "json",
                    success:function (result) {
                        var htmlText = "";
                        $("#create-clueOwner").html(htmlText);
                        $.each(result,function (i,n) {
                            htmlText += '<option value="'+n.name+'">'+n.name+'</option>';
                        });
                        $("#create-clueOwner").html(htmlText);
                        $("#create-clueOwner").val("${user.name}");
                    }
                });
                $("#createClueModal").modal("show");
            });

            //执行添加操作
            $("#insertClueBtn").click(function () {
                var owner = $.trim($("#create-clueOwner").val());
                var company = $.trim($("#create-clueCompany").val());
                var appellation = $.trim($("#create-clueAppellation").val());
                var fullName = $.trim($("#create-clueFullName").val());
                var job = $.trim($("#create-clueJob").val());
                var email = $.trim($("#create-clueEmail").val());
                var phone = $.trim($("#create-cluePhone").val());
                var website = $.trim($("#create-clueWebsite").val());
                var mPhone = $.trim($("#create-clueMPhone").val());
                var state = $.trim($("#create-clueState").val());
                var source = $.trim($("#create-clueSource").val());
                var description = $.trim($("#create-clueDescription").val());
                var contactSummary = $.trim($("#create-clueContactSummary").val());
                var nextContactTime = $.trim($("#create-clueNextContactTime").val());
                var address = $.trim($("#create-clueAddress").val());
                if(owner === "" || owner === null){
                    alert("所有者不能为空");
                }else if(company === "" || company === null){
                    alert("公司不能为空");
                }else if(appellation === "" || appellation === null){
                    alert("称呼不能为空");
                }else if(fullName === "" || fullName === null){
                    alert("姓名不能为空");
                }else {
                    $.ajax({
                        url:"clue/insert",
                        data: {
                            owner:owner,
                            company:company,
                            appellation:appellation,
                            fullName:fullName,
                            job:job,
                            email:email,
                            phone:phone,
                            website:website,
                            mPhone:mPhone,
                            state:state,
                            source:source,
                            description:description,
                            contactSummary:contactSummary,
                            nextContactTime:nextContactTime,
                            address:address
                        },
                        type:"post",
                        dataType:"json",
                        success:function (result) {
                            if (result){
                                document.forms["createClueForm"].reset();
                                $("#createClueModal").modal("hide");
                                var pageSize = $.trim($("#pageSize").val());
                                ajaxPageQuery(1,pageSize);
                                alert("添加线索成功");
                            }else {
                                $("#createClueModal").modal("hide");
                                alert("添加线索失败");
                            }
                        }
                    })
                }
            });
        });

        //分页查询
        function ajaxPageQuery(pageNo,pageSize) {
            //$("input[type='checkbox']").prop("checked",false);	//刷新后复选框取消
            var fullName = $.trim($("#searchFullName").val());
            var company = $.trim($("#searchCompany").val());
            var phone = $.trim($("#searchPhone").val());
            var source = $.trim($("#searchSource").val());
            var owner = $.trim($("#searchOwner").val());
            var mPhone = $.trim($("#searchMPhone").val());
            var state = $.trim($("#searchState").val());
            if(pageNo === "" || pageNo === null || parseInt(pageNo) <= 0){
                pageNo = 1;
            }
            if(pageSize === "" || pageSize === null || parseInt(pageSize) <= 0){
                pageSize = 5;
            }
            if(pageSize > 20){
                pageSize = 20;
            }
            $.ajax({
                url:"clue/selectPage",
                data:{
                    fullName:fullName,
                    company:company,
                    phone:phone,
                    source:source,
                    owner:owner,
                    mPhone:mPhone,
                    state:state,
                    pageNo:pageNo,
                    pageSize:pageSize
                },
                type:"get",
                dataType:"json",
                success:function (result) {
                    var htmlText = "";
                    $("#tbody").html(htmlText);
                    $.each(result.list,function (i,n) {
                        htmlText += '<tr>';
                        htmlText +=     '<td><input type="checkbox" /></td>';
                        htmlText +=         '<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'clue/gotoDetail?id='+n.id+'\';">'+n.fullName+n.appellation+'</a></td>';
                        htmlText +=     '<td>'+n.company+'</td>';
                        htmlText +=     '<td>'+n.phone+'</td>';
                        htmlText +=     '<td>'+n.mPhone+'</td>';
                        htmlText +=     '<td>'+n.source+'</td>';
                        htmlText +=     '<td>'+n.createBy+'</td>';
                        htmlText +=     '<td>'+n.state+'</td>';
                        htmlText += '</tr>';
                    });
                    $("#tbody").html(htmlText);
                    $("#pageNoSpan").html(result.pageNo);
                    $("#pageSize").val(result.pageSize);
                    $("#totalSizeSpan").html(result.totalSize);
                    var totalPage = (result.totalSize) % (result.pageSize) === 0 ?
                        parseInt(result.totalSize / result.pageSize) :
                        (parseInt(result.totalSize / result.pageSize) + 1);
                    $("#totalPageSpan").html(totalPage);
                }
            })
        };
    </script>
</head>
<body>

<!-- 创建线索的模态窗口 -->
<div class="modal fade" id="createClueModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 90%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">创建线索</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="createClueForm" role="form">

                    <div class="form-group">
                        <label for="create-clueOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="create-clueOwner">

                            </select>
                        </div>
                        <label for="create-clueCompany" class="col-sm-2 control-label">公司<span style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-clueCompany">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-clueAppellation" class="col-sm-2 control-label">称呼</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="create-clueAppellation">
                                <option></option>
                                <c:forEach items="${applicationScope.map.appellation}" var="list" varStatus="status">
                                    <option value="${list.value}">${list.text}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <label for="create-clueFullName" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-clueFullName">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-clueJob" class="col-sm-2 control-label">职位</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-clueJob">
                        </div>
                        <label for="create-clueEmail" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-clueEmail">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-cluePhone" class="col-sm-2 control-label">公司座机</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-cluePhone">
                        </div>
                        <label for="create-clueWebsite" class="col-sm-2 control-label">公司网站</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-clueWebsite">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-clueMPhone" class="col-sm-2 control-label">手机</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-clueMPhone">
                        </div>
                        <label for="create-clueState" class="col-sm-2 control-label">线索状态</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="create-clueState">
                                <option value=""></option>
                                <c:forEach items="${applicationScope.map.clueState}" var="list" varStatus="status">
                                    <option value="${list.value}">${list.text}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-clueSource" class="col-sm-2 control-label">线索来源</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="create-clueSource">
                                <option value=""></option>
                                <c:forEach items="${applicationScope.map.source}" var="list" varStatus="status">
                                    <option value="${list.value}">${list.text}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>


                    <div class="form-group">
                        <label for="create-clueDescription" class="col-sm-2 control-label">线索描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="create-clueDescription"></textarea>
                        </div>
                    </div>

                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>

                    <div style="position: relative;top: 15px;">
                        <div class="form-group">
                            <label for="create-clueContactSummary" class="col-sm-2 control-label">联系纪要</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="3" id="create-clueContactSummary"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="create-clueNextContactTime" class="col-sm-2 control-label">下次联系时间</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control time" id="create-clueNextContactTime">
                            </div>
                        </div>
                    </div>

                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                    <div style="position: relative;top: 20px;">
                        <div class="form-group">
                            <label for="create-clueAddress" class="col-sm-2 control-label">详细地址</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="1" id="create-clueAddress"></textarea>
                            </div>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="insertClueBtn">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改线索的模态窗口 -->
<div class="modal fade" id="editClueModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 90%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title">修改线索</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form">

                    <div class="form-group">
                        <label for="edit-clueOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-clueOwner">
                                <option>zhangsan</option>
                                <option>lisi</option>
                                <option>wangwu</option>
                            </select>
                        </div>
                        <label for="edit-company" class="col-sm-2 control-label">公司<span style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-company" value="动力节点">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-call" class="col-sm-2 control-label">称呼</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-call">
                                <option value=""></option>
                                <c:forEach items="${applicationScope.map.appellation}" var="list" varStatus="status">
                                    <option value="${list.value}">${list.text}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <label for="edit-surname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-surname" value="李四">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-job" class="col-sm-2 control-label">职位</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-job" value="CTO">
                        </div>
                        <label for="edit-email" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-email" value="lisi@bjpowernode.com">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-phone" class="col-sm-2 control-label">公司座机</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-phone" value="010-84846003">
                        </div>
                        <label for="edit-website" class="col-sm-2 control-label">公司网站</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-website" value="http://www.bjpowernode.com">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-mphone" class="col-sm-2 control-label">手机</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-mphone" value="12345678901">
                        </div>
                        <label for="edit-status" class="col-sm-2 control-label">线索状态</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-status">
                                <option value=""></option>
                                <c:forEach items="${applicationScope.map.clueState}" var="list" varStatus="status">
                                    <option value="${list.value}">${list.text}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-source" class="col-sm-2 control-label">线索来源</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-source">
                                <option value=""></option>
                                <c:forEach items="${applicationScope.map.source}" var="list" varStatus="status">
                                    <option value="${list.value}">${list.text}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="edit-describe">这是一条线索的描述信息</textarea>
                        </div>
                    </div>

                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>

                    <div style="position: relative;top: 15px;">
                        <div class="form-group">
                            <label for="edit-contactSummary" class="col-sm-2 control-label">联系纪要</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="3" id="edit-contactSummary">这个线索即将被转换</textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="edit-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-nextContactTime" value="2017-05-01">
                            </div>
                        </div>
                    </div>

                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                    <div style="position: relative;top: 20px;">
                        <div class="form-group">
                            <label for="edit-address" class="col-sm-2 control-label">详细地址</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="1" id="edit-address">北京大兴区大族企业湾</textarea>
                            </div>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal">更新</button>
            </div>
        </div>
    </div>
</div>




<div>
    <div style="position: relative; left: 10px; top: -10px;">
        <div class="page-header">
            <h3>线索列表</h3>
        </div>
    </div>
</div>

<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">

    <div style="width: 100%; position: absolute;top: 5px; left: 10px;">

        <div class="btn-toolbar" role="toolbar" style="height: 80px;">
            <form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">名称</div>
                        <input class="form-control" id="searchFullName" type="text">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">公司</div>
                        <input class="form-control" id="searchCompany" type="text">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">公司座机</div>
                        <input class="form-control" id="searchPhone" type="text">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">线索来源</div>
                        <select id="searchSource" class="form-control">
                            <option value=""></option>
                            <c:forEach items="${applicationScope.map.source}" var="list" varStatus="status">
                                <option value="${list.value}">${list.text}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <br>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">所有者</div>
                        <input class="form-control" id="searchOwner" type="text">
                    </div>
                </div>



                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">手机</div>
                        <input class="form-control" id="searchMPhone" type="text">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">线索状态</div>
                        <select id="searchState" class="form-control">
                            <option></option>
                            <option>试图联系</option>
                            <option>将来联系</option>
                            <option>已联系</option>
                            <option>虚假线索</option>
                            <option>丢失线索</option>
                            <option>未联系</option>
                            <option>需要条件</option>
                        </select>
                    </div>
                </div>

                <input type="button" id="queryBtn" class="btn btn-default" value="查询">

            </form>
        </div>
        <div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 40px;">
            <div class="btn-group" style="position: relative; top: 18%;">
                <button type="button" class="btn btn-primary" id="addClueBtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
                <button type="button" class="btn btn-default" data-toggle="modal" data-target="#editClueModal"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
                <button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
            </div>


        </div>
        <div style="position: relative;top: 50px;">
            <table class="table table-hover">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td><input type="checkbox" /></td>
                    <td>名称</td>
                    <td>公司</td>
                    <td>公司座机</td>
                    <td>手机</td>
                    <td>线索来源</td>
                    <td>所有者</td>
                    <td>线索状态</td>
                </tr>
                </thead>
                <tbody id="tbody">

                </tbody>
            </table>
        </div>

        <div style="height: 50px; position: relative;top: 60px;">
            <%--<div>
                <button type="button" class="btn btn-default" style="cursor: default;">共<b>50</b>条记录</button>
            </div>
            <div class="btn-group" style="position: relative;top: -34px; left: 110px;">
                <button type="button" class="btn btn-default" style="cursor: default;">显示</button>
                <div class="btn-group">
                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                        10
                        <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="#">20</a></li>
                        <li><a href="#">30</a></li>
                    </ul>
                </div>
                <button type="button" class="btn btn-default" style="cursor: default;">条/页</button>
            </div>
            <div style="position: relative;top: -88px; left: 285px;">
                <nav>
                    <ul class="pagination">
                        <li class="disabled"><a href="#">首页</a></li>
                        <li class="disabled"><a href="#">上一页</a></li>
                        <li class="active"><a href="#">1</a></li>
                        <li><a href="#">2</a></li>
                        <li><a href="#">3</a></li>
                        <li><a href="#">4</a></li>
                        <li><a href="#">5</a></li>
                        <li><a href="#">下一页</a></li>
                        <li class="disabled"><a href="#">末页</a></li>
                    </ul>
                </nav>
            </div>--%>

            <div style="height: 50px; position: relative;top: 30px;" align="center">
                第&nbsp;<span style="width: 30px" id="pageNoSpan"></span>&nbsp;页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                每页&nbsp;<input style="width: 30px" type="text" id="pageSize">&nbsp;条&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                共&nbsp;<span style="width: 30px" id="totalSizeSpan"></span> &nbsp;条记录&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                共&nbsp;<span style="width: 30px" id="totalPageSpan"></span> &nbsp;页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                跳转至第&nbsp;<input style="width: 30px" type="text" id="pageNo">&nbsp;页&nbsp;&nbsp;&nbsp;
                <input type="button" id="goBtn" value="跳转">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="button" id="firstBtn" value="首页" style="cursor: pointer">
                <input type="button" id="perBtn" value="上一页" style="cursor: pointer">
                <input type="button" id="nextBtn" value="下一页" style="cursor: pointer">
                <input type="button" id="lastBtn" value="尾页" style="cursor: pointer">
            </div>

        </div>



    </div>

</div>
</body>
</html>
