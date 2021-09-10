<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
Created by IntelliJ IDEA.
User: gaoxz
Date: 2021-08-28
Time: 15:37
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


<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />
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
			pickerPosition:"bottom-left"
		});

		$("#isCreateTransaction").click(function(){
			if(this.checked){
				$("#create-transaction2").show(200);
			}else{
				$("#create-transaction2").hide(200);
			}
		});

		//点击“放大镜”搜索市场活动列表
		$("#openSearchModalBtn").click(function(){
			$("#actSearchName").val("");
			ajaxQueryActivityByName("");
			$("#searchActivityModal").modal("show");
		});

		//回车条件查询市场活动列表
        $("#actSearchName").keydown(function (event) {
            if (event.keyCode === 13){
                ajaxQueryActivityByName($.trim($("#actSearchName").val()));
                return false;
            }
        });

        //点击提交按钮添加市场活动
        $("#addActivityBtn").click(function () {
             if($("input[name='chooses']:checked").length === 0){
                 alert("请选择市场活动");
             }else {
                 var id = $("input[name='chooses']:checked").val();
                 var name = $("#"+id).html();
                 $("#actId").val(id);
                 $("#actName").val(name);
                 $("#searchActivityModal").modal("hide");
             }
        });

        //点击转换按钮，将线索转换成客户
        $("#conversionBtn").click(function () {
			$.ajax({	//将线索转换成客户
				url:"customer/addByClue",
				data:{id:"${param.id}"},
				type: "post",
				dataType: "json",
				success:function (result) {

				}
			})
        });

	});

	//根据市场活动名称模糊查询市场活动列表
	function ajaxQueryActivityByName(actName){
		$.ajax({
			url: "activity/selectActivityByName",
			data: {name:actName},
			type:"get",
			dataType:"json",
			success:function (result) {
                var htmlText = "";
                $("#actList").html("");
                $.each(result,function (i,n) {
                    htmlText += '<tr>';
                    htmlText +=     '<td><input type="radio" value="'+n.id+'" name="chooses"/></td>';
                    htmlText +=     '<td id="'+n.id+'">'+n.name+'</td>';
                    htmlText +=     '<td>'+n.startDate+'</td>';
                    htmlText +=     '<td>'+n.endDate+'</td>';
                    htmlText +=     '<td>'+n.owner+'</td>';
                    htmlText += '</tr>';
                });
                $("#actList").html(htmlText);
			}
		})
	}


</script>

</head>
<body>
	
	<!-- 搜索市场活动的模态窗口 -->
	<div class="modal fade" id="searchActivityModal" role="dialog" >
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">搜索市场活动</h4>
				</div>
				<div class="modal-body">
					<div class="btn-group" style="position: relative; top: 18%; left: 8px;">
						<form class="form-inline" role="form">
						  <div class="form-group has-feedback">
						    <input type="text" class="form-control" id="actSearchName" style="width: 300px;" placeholder="请输入市场活动名称，支持模糊查询">
						    <span class="glyphicon glyphicon-search form-control-feedback"></span>
						  </div>
						</form>
					</div>
					<table id="activityTable" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
						<thead>
							<tr style="color: #B3B3B3;">
								<td></td>
								<td>名称</td>
								<td>开始日期</td>
								<td>结束日期</td>
								<td>所有者</td>
								<td></td>
							</tr>
						</thead>
						<tbody id="actList">

						</tbody>
					</table>
				</div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" id="addActivityBtn">提交</button>
                </div>
			</div>
		</div>
	</div>

	<div id="title" class="page-header" style="position: relative; left: 20px;">
		<h4>转换线索 <small>${param.fullName}${param.appellation}-${param.company}</small></h4>
	</div>
	<div id="create-customer" style="position: relative; left: 40px; height: 35px;">
		新建客户：${param.company}
	</div>
	<div id="create-contact" style="position: relative; left: 40px; height: 35px;">
		新建联系人：${param.fullName}
	</div>
	<div id="create-transaction1" style="position: relative; left: 40px; height: 35px; top: 25px;">
		<input type="checkbox" id="isCreateTransaction"/>
		为客户创建交易
	</div>
	<div id="create-transaction2" style="position: relative; left: 40px; top: 20px; width: 80%; background-color: #F7F7F7; display: none;" >
		<form>
		  <div class="form-group" style="width: 400px; position: relative; left: 20px;">
		    <label for="amountOfMoney">金额</label>
		    <input type="text" class="form-control" id="amountOfMoney">
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="tradeName">交易名称</label>
		    <input type="text" class="form-control" id="tradeName" value="动力节点-">
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="expectedClosingDate">预计成交日期</label>
		    <input type="text" class="form-control time" id="expectedClosingDate">
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="stage">阶段</label>
		    <select id="stage"  class="form-control">
				<option></option>
				<c:forEach items="${applicationScope.map.stage}" var="list" varStatus="status">
					<option value="${list.value}">${list.text}</option>
				</c:forEach>
		    </select>
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="actName">市场活动源&nbsp;&nbsp;<a href="javascript:void(0);" id="openSearchModalBtn" style="text-decoration: none;"><span class="glyphicon glyphicon-search"></span></a></label>
		    <input type="text" class="form-control" id="actName" placeholder="点击上面搜索" readonly>
              <input type="hidden" id="actId">
		  </div>
		</form>
		
	</div>
	
	<div id="create-owner" style="position: relative; left: 40px; height: 35px; top: 50px;">
		记录的所有者：<br>
		<b>${param.owner}</b>
	</div>
	<div id="operation" style="position: relative; left: 40px; height: 35px; top: 100px;">
		<input class="btn btn-primary" id="conversionBtn" type="button" value="转换">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input class="btn btn-default" type="button" value="取消">
	</div>
</body>
</html>