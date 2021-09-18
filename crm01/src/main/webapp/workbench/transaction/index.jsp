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
		
		
	});

	//分页查询交易列表
	function ajaxQueryTran(pageNo,pageSize) {
		if(pageNo === "" || pageNo === null || parseInt(pageNo) <= 0){
			pageNo = 1;
		}
		if(pageSize === "" || pageSize === null || parseInt(pageSize) <= 0){
			pageSize = 5;
		}
		if(pageSize > 20){
			pageSize = 20;
		}


		$("#pageNoSpan").html(result.pageNo);
		$("#pageSize").val(result.pageSize);
		$("#totalSizeSpan").html(result.totalSize);
		var totalPage = (result.totalSize) % (result.pageSize) === 0 ?
				parseInt(result.totalSize / result.pageSize) :
				(parseInt(result.totalSize / result.pageSize) + 1);
		$("#totalPageSpan").html(totalPage);
	}

	
</script>
</head>
<body>

	
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>交易列表</h3>
			</div>
		</div>
	</div>
	
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
	
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input id="queryOwner" class="form-control" type="text">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">名称</div>
				      <input id="queryName" class="form-control" type="text">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">客户名称</div>
				      <input id="queryCustomer" class="form-control" type="text">
				    </div>
				  </div>
				  
				  <br>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">阶段</div>
					  <select id="queryStage" class="form-control">
					  	<option></option>
						  <c:forEach items="${applicationScope.map.stage}" var="list" varStatus="status">
							  <option value="${list.value}">${list.text}</option>
						  </c:forEach>
					  </select>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">类型</div>
					  <select id="queryTranType" class="form-control">
					  	<option></option>
						  <c:forEach items="${applicationScope.map.transactionType}" var="list" varStatus="status">
							  <option value="${list.value}">${list.text}</option>
						  </c:forEach>
					  </select>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">来源</div>
				      <select class="form-control" id="querySource">
						  <option></option>
						  <c:forEach items="${applicationScope.map.source}" var="list" varStatus="status">
							  <option value="${list.value}">${list.text}</option>
						  </c:forEach>
						</select>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">联系人名称</div>
				      <input id="queryContact" class="form-control" type="text">
				    </div>
				  </div>
				  
				  <button type="submit" class="btn btn-default">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 10px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" onclick="window.location.href='workbench/transaction/save.jsp';"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" onclick="window.location.href='workbench/transaction/edit.jsp';"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				
				
			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" /></td>
							<td>名称</td>
							<td>客户名称</td>
							<td>阶段</td>
							<td>类型</td>
							<td>所有者</td>
							<td>来源</td>
							<td>联系人名称</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="checkbox" /></td>
							<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='workbench/transaction/detail.jsp';">动力节点-交易01</a></td>
							<td>动力节点</td>
							<td>谈判/复审</td>
							<td>新业务</td>
							<td>zhangsan</td>
							<td>广告</td>
							<td>李四</td>
						</tr>
                        <tr class="active">
                            <td><input type="checkbox" /></td>
                            <td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='workbench/transaction/detail.jsp';">动力节点-交易01</a></td>
                            <td>动力节点</td>
                            <td>谈判/复审</td>
                            <td>新业务</td>
                            <td>zhangsan</td>
                            <td>广告</td>
                            <td>李四</td>
                        </tr>
					</tbody>
				</table>
			</div>

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
</body>
</html>