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
<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

	<script type="text/javascript">
		$(function () {
			//日期窗口
			$(".time").datetimepicker({
				minView:"month",
				language:"zh-CN",
				format:"yyyy-mm-dd",
				autoclose:true,
				todayBtn:true,
				pickerPosition:"top-left"
			});

			//点击搜索按钮查询市场活动
			$("#findActivityBtn").click(function () {
				findActivity("");
			});

			//市场活动模态窗口中按名称查询市场活动列表
			$("#activitySearch").keydown(function (event) {
				if(event.keyCode === 13){
					findActivity($.trim($("#activitySearch").val()));
					return false;
				}
			});

			//点击市场活动模态窗口中提交按钮将市场活动信息（名称、id）填入对应的栏中
			$("#chooseActivityBtn").click(function(){
				var id = $("input[name='activity']:checked").val();
				$.ajax({
					url:"activity/selectActivity",
					data:{id:id},
					type: "get",
					dataType: "json",
					success:function (result) {
						$("#create-tranActivitySource").val(result.name);
						$("#activityId").val(result.id);
					}
				})
			})
		});

		//查询并展示市场活动列表
		function findActivity(name) {
			$.ajax({
				url:"activity/selectActivityByName",
				data:{name:name},
				type:"get",
				dataType:"json",
				success:function (result) {
					var htmlText = "";
					$("#activityListBody").html(htmlText);
					$.each(result,function (i,n) {
						htmlText += '<tr>';
						htmlText += '<td><input type="radio" value="'+n.id+'" name="activity"/></td>';
						htmlText += '<td>'+n.name+'</td>';
						htmlText += '<td>'+n.startDate+'</td>';
						htmlText += '<td>'+n.endDate+'</td>';
						htmlText += '<td>'+n.owner+'</td>';
						htmlText += '</tr>';
					});
					$("#activityListBody").html(htmlText);
				}
			});
			$("#findMarketActivity").modal("show");
		}

	</script>

</head>
<body>

	<!-- 查找市场活动 -->	
	<div class="modal fade" id="findMarketActivity" role="dialog">
		<div class="modal-dialog" role="document" style="width: 80%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">查找市场活动</h4>
				</div>
				<div class="modal-body">
					<div class="btn-group" style="position: relative; top: 18%; left: 8px;">
						<form class="form-inline" role="form">
						  <div class="form-group has-feedback">
						    <input type="text" class="form-control" id="activitySearch" style="width: 300px;" placeholder="请输入市场活动名称，支持模糊查询">
						    <span class="glyphicon glyphicon-search form-control-feedback"></span>
						  </div>
						</form>
					</div>
					<table id="activityTable3" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
						<thead>
							<tr style="color: #B3B3B3;">
								<td></td>
								<td>名称</td>
								<td>开始日期</td>
								<td>结束日期</td>
								<td>所有者</td>
							</tr>
						</thead>
						<tbody id="activityListBody">

						</tbody>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<input type="button" class="btn btn-primary" data-dismiss="modal" id="chooseActivityBtn" value="提交">
				</div>
			</div>
		</div>
	</div>

	<!-- 查找联系人 -->	
	<div class="modal fade" id="findContacts" role="dialog">
		<div class="modal-dialog" role="document" style="width: 80%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">查找联系人</h4>
				</div>
				<div class="modal-body">
					<div class="btn-group" style="position: relative; top: 18%; left: 8px;">
						<form class="form-inline" role="form">
						  <div class="form-group has-feedback">
						    <input type="text" class="form-control" style="width: 300px;" placeholder="请输入联系人名称，支持模糊查询">
						    <span class="glyphicon glyphicon-search form-control-feedback"></span>
						  </div>
						</form>
					</div>
					<table id="activityTable" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
						<thead>
							<tr style="color: #B3B3B3;">
								<td></td>
								<td>名称</td>
								<td>邮箱</td>
								<td>手机</td>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><input type="radio" name="contacts"/></td>
								<td>李四</td>
								<td>lisi@bjpowernode.com</td>
								<td>12345678901</td>
							</tr>
							<tr>
								<td><input type="radio" name="contacts"/></td>
								<td>李四</td>
								<td>lisi@bjpowernode.com</td>
								<td>12345678901</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	
	
	<div style="position:  relative; left: 30px;">
		<h3>创建交易</h3>
	  	<div style="position: relative; top: -40px; left: 70%;">
			<button type="button" class="btn btn-primary">保存</button>
			<button type="button" class="btn btn-default">取消</button>
		</div>
		<hr style="position: relative; top: -40px;">
	</div>
	<form class="form-horizontal" role="form" style="position: relative; top: -30px;">
		<div class="form-group">
			<label for="create-tranOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<select class="form-control" id="create-tranOwner">
				  <c:forEach items="${userList}" var="tranUser" varStatus="status">
					<option selected="${tranUser.id}===${sessionScope.user.id} ? 'selected' : ''" value="${tranUser.name}">${tranUser.name}</option>
				  </c:forEach>
				</select>
			</div>
			<label for="create-tranMoney" class="col-sm-2 control-label">金额</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-tranMoney">
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-tranName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-tranName">
			</div>
			<label for="create-tranExpectedDate" class="col-sm-2 control-label">预计成交日期<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-tranExpectedDate">
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-tranCustomerName" class="col-sm-2 control-label">客户名称<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-tranCustomerName" placeholder="支持自动补全，输入客户不存在则新建">
			</div>
			<label for="create-tranStage" class="col-sm-2 control-label">阶段<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
			  <select class="form-control" id="create-tranStage">
			  	<option></option>
				  <c:forEach items="${applicationScope.map.stage}" var="list" varStatus="status">
					  <option value="${list.value}">${list.text}</option>
				  </c:forEach>
			  </select>
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-tranType" class="col-sm-2 control-label">类型</label>
			<div class="col-sm-10" style="width: 300px;">
				<select class="form-control" id="create-tranType">
				  <option></option>
				  <c:forEach items="${map.transactionType}" var="list" varStatus="status">
					  <option value="${list.value}">${list.text}</option>
				  </c:forEach>
				</select>
			</div>
			<label for="create-tranPossibility" class="col-sm-2 control-label">可能性</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-tranPossibility">
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-tranClueSource" class="col-sm-2 control-label">来源</label>
			<div class="col-sm-10" style="width: 300px;">
				<select class="form-control" id="create-tranClueSource">
				  <option></option>
				  <c:forEach items="${map.source}" var="list" varStatus="status">
					  <option value="${list.value}">${list.text}</option>
				  </c:forEach>
				</select>
			</div>
			<label for="create-tranActivitySource" class="col-sm-2 control-label">市场活动源&nbsp;&nbsp;<a href="javascript:void(0);" id="findActivityBtn"><span class="glyphicon glyphicon-search"></span></a></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="hidden" id="activityId">
				<input type="text" class="form-control" id="create-tranActivitySource">
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-tranContactsName" class="col-sm-2 control-label">联系人名称&nbsp;&nbsp;<a href="javascript:void(0);" data-toggle="modal" data-target="#findContacts"><span class="glyphicon glyphicon-search"></span></a></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-tranContactsName">
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-tranDescribe" class="col-sm-2 control-label">描述</label>
			<div class="col-sm-10" style="width: 70%;">
				<textarea class="form-control" rows="3" id="create-tranDescribe"></textarea>
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-tranContactSummary" class="col-sm-2 control-label">联系纪要</label>
			<div class="col-sm-10" style="width: 70%;">
				<textarea class="form-control" rows="3" id="create-tranContactSummary"></textarea>
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-tranNextContactTime" class="col-sm-2 control-label">下次联系时间</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-tranNextContactTime">
			</div>
		</div>
		
	</form>
</body>
</html>