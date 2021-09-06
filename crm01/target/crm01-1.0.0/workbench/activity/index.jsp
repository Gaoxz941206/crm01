<%--
  Created by IntelliJ IDEA.
  User: gaoxz
  Date: 2021-08-12
  Time: 10:58
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


        <link rel="stylesheet" type="text/css" href="jquery/bs_pagination/jquery.bs_pagination.min.css">
        <script type="text/javascript" src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
        <script type="text/javascript" src="jquery/bs_pagination/en.js"></script>

        <script type="text/javascript">
			$(function () {
				//日期窗口
				$(".time").datetimepicker({
					minView:"month",
					language:"zh-CN",
					format:"yyyy-mm-dd",
					autoclose:true,
					todayBtn:true,
					pickerPosition:"bottom-left"
				});
				//弹出添加模态窗口之前先查询所有用户列表，添加到模态窗口中的下拉项中
				$("#addBtn").click(function () {
					$.ajax({
						url:"user/selectAll",
						type:"get",
						dataType:"json",
						success:function (result) {
							$("#create-owner").empty();
							$.each(result,function (index,value) {
								$("#create-owner").append("<option value='"+value.id+"'>"+value.name+"</option>");
							});
							$("#create-owner").val("${user.id}");
						}
					});
					$("#createActivityModal").modal("show");//弹出模态窗口
				});
				//弹出修改模态窗口之前，先获取要修改的信息
				$("#editBtn").click(function () {
					if($("input[name=checked]:checked").length === 1){
						var actId = $("input[name=checked]:checked").val();
						$.ajax({
							url:"activity/selectById",
							data:{id:actId},
							type:"get",
							dataType:"json",
							success:function (result) {
                                $("#edit-marketActivityOwner").empty();
                                $.each(result.list,function (index,value) {
                                    $("#edit-marketActivityOwner").append("<option value='"+value.id+"'>"+value.name+"</option>");
                                });
                                $("#edit-marketActivityOwner").val(result.activity.owner);
								$("#actId").val(actId);
								$("#edit-marketActivityName").val(result.activity.name);
								$("#edit-startTime").val(result.activity.startDate);
								$("#edit-endTime").val(result.activity.endDate);
								$("#edit-cost").val(result.activity.cost);
								$("#edit-describe").val(result.activity.description);
							}
						});
						$("#editActivityModal").modal("show");  //弹出窗口
					}else {
						alert("请重新选择需要修改的市场活动");
					}
				});
				//市场活动修改
				$("#updateBtn").click(function () {
					var id = $.trim($("#actId").val());
					var owner = $("#edit-marketActivityOwner").val();
					var name= $.trim($("#edit-marketActivityName").val());
					var startDate = $("#edit-startTime").val();
					var endDate = $("#edit-endTime").val();
					var cost = $.trim($("#edit-cost").val());
					var description = $.trim($("#edit-describe").val());
					if(name === "" || name === null){
						alert("活动名称不能为空");
					}else if(startDate === "" || startDate === null){
						alert("活动开始时间不能为空");
					}else if(endDate === "" || endDate === null){
						alert("活动结束时间不能为空");
					}else {
						$.ajax({
							url:"activity/update",
							data:{
								id:id,
								owner:owner,
								name:name,
								startDate:startDate,
								endDate:endDate,
								cost:cost,
								description:description
							},
							type:"get",
							dataType:"text",
							success:function (result) {
								alert(result);
							}
						})
						var pageNo = $.trim($("#pageNo").val());
						var pageSize = $.trim($("#pageSize").val());
						ajaxPageQuery(pageNo,pageSize);
					}
				});
				//执行添加市场活动操作
				$("#insertBtn").click(function () {
					var owner = $.trim($("#create-owner").val());
					var name = $.trim($("#create-name").val());
					var startDate = $.trim($("#create-startDate").val());
					var endDate = $.trim($("#create-endDate").val());
					var cost = $.trim($("#create-cost").val());
					var description = $.trim($("#create-description").val());
					if(owner === "" || owner === null){
						alert("所有者不能为空！");
					}else if(name === "" || name === null){
						alert("名称不能为空！");
					}else {
						$.ajax({
							url:"activity/insert",
							data:{
								owner:owner,
								name:name,
								startDate:startDate,
								endDate:endDate,
								cost:cost,
								description:description
							},
							type: "post",
							dataType: "text",
							success:function(result){
								if("success" === result){
									document.forms["activityForm"].reset();
									$("#createActivityModal").modal("hide");
									var pageNo = $.trim($("#pageNo").val());
									var pageSize = $.trim($("#pageSize").val());
									ajaxPageQuery(pageNo,pageSize);
								}else {
									alert("添加市场活动失败！");
								}
							}
						})
					}
				});
				//局部刷新查询列表
				function ajaxPageQuery(pageNo,pageSize) {
					$("input[type='checkbox']").prop("checked",false);	//刷新后复选框取消
					var queryName = $.trim($("#query_name").val());
					var queryOwner = $.trim($("#query_owner").val());
					var queryStartTime = $.trim($("#query_startTime").val());
					var queryEndTime = $.trim($("#query_endTime").val());
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
						url:"activity/selectAll",
						data:{
							queryName:queryName,
							queryOwner:queryOwner,
							queryStartTime:queryStartTime,
							queryEndTime:queryEndTime,
							pageNo:pageNo,
							pageSize:pageSize
						},
						type:"get",
						dataType:"json",
						success:function (result) {
							var htmlText = "";
							$.each(result.list,function (i,n) {
								htmlText += "<tr class='active'>"+
										"<td><input type='checkbox' name='checked' value='"+n.actId+"'/></td>"+
										"<td><a href='activityRemark/gotoRemark?id="+n.actId+"' style='text-decoration: none; cursor: pointer;'>"+n.actName+"</a></td>"+
										"<td>"+n.userName+"</td>"+
										"<td>"+n.actStartDate+"</td>"+
										"<td>"+n.actEndDate+"</td>"+
										"</tr>";
							});
							$("#activityList").html(htmlText);
							$("#pageNoSpan").html(result.pageNo);
							$("#pageSize").val(result.pageSize);
							$("#totalSizeSpan").html(result.totalSize);
							var totalPage = (result.totalSize) % (result.pageSize) === 0 ?
									parseInt(result.totalSize / result.pageSize) :
									(parseInt(result.totalSize / result.pageSize) + 1);
							$("#totalPageSpan").html(totalPage);
						}
					})
				}
				//信息删除
                $("#delBtn").click(function () {
                    if($("input[name='checked']:checked").length > 0){
                        if(window.confirm("您确定要删除已选中的市场活动信息吗？")){
                            var actIds = new Array();
                            for (var i=0;i<$("input[name='checked']:checked").length;i++){
                                actIds[i] = $("input[name='checked']:checked")[i].value;
                            }
                        $.ajax({
                            url:"activity/delete",
                            data:{
                                actIds:actIds
                            },
                            type:"post",
                            dataType:"text",
                            success:function (result) {
                                alert(result);
								var pageSize = $.trim($("#pageSize").val());
								ajaxPageQuery(1,pageSize);
                            }
                        })
                        }
                    }
                });
				//全选与反选
				$("#checkAll").click(function () {
					$("input[name='checked']").prop("checked",this.checked);
				});
				//复选框单击
				$("#activityList").on("click",$("input[name='checked']"),function () {
					$("#checkAll").prop("checked",$("input[name='checked']").length === $("input[name='checked']:checked").length)
				});
				//页面刷新时
				$(window).load(function () {
					var pageNo = $.trim($("#pageNo").val());
					var pageSize = $.trim($("#pageSize").val());
					ajaxPageQuery(pageNo,pageSize);
				});
				//点击查询按钮
				$("#queryBtn").click(function () {
					var pageNo = $.trim($("#pageNo").val());
					var pageSize = $.trim($("#pageSize").val());
					ajaxPageQuery(pageNo,pageSize);
				});
				//页面跳转
				$("#goBtn").click(function () {
					var pageNo = $.trim($("#pageNo").val());
					var pageSize = $.trim($("#pageSize").val());
					ajaxPageQuery(pageNo,pageSize);
				})
				//首页按钮
				$("#firstBtn").click(function () {
					var pageNo = $.trim($("#pageNoSpan").html());
					var pageSize = $.trim($("#pageSize").val());
					if(pageNo !== 1){
						ajaxPageQuery(1,pageSize);
					}
				})
				//前一页按钮
				$("#perBtn").click(function () {
					var pageNo = $.trim($("#pageNoSpan").html());
					var pageSize = $.trim($("#pageSize").val());
					if(pageNo > 1){
						ajaxPageQuery(parseInt(pageNo)-1,pageSize);
					}
				})
				//后一页按钮
				$("#nextBtn").click(function () {
					var pageNo = $.trim($("#pageNoSpan").html());
					var pageSize = $.trim($("#pageSize").val());
					var totalPage = $.trim($("#totalPageSpan").html());
					if(pageNo < totalPage){
						ajaxPageQuery(parseInt(pageNo)+1,pageSize);
					}
				})
				//尾页按钮
				$("#lastBtn").click(function () {
					var pageNo = $.trim($("#pageNoSpan").html());
					var pageSize = $.trim($("#pageSize").val());
					var totalPage = $.trim($("#totalPageSpan").html());
					if(pageNo !== totalPage){
						ajaxPageQuery(parseInt(totalPage),pageSize);
					}
				})
			});
        </script>
</head>
<body>
	<!-- 创建市场活动的模态窗口 -->
	<div class="modal fade" id="createActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">创建市场活动</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" name="activityForm" role="form">
					
						<div class="form-group">
							<label for="create-owner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-owner">

								</select>
							</div>
                            <label for="create-name" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-name">
                            </div>
						</div>
						
						<div class="form-group">
							<label for="create-startDate" class="col-sm-2 control-label">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="create-startDate">
							</div>
							<label for="create-endDate" class="col-sm-2 control-label">结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="create-endDate">
							</div>
						</div>
                        <div class="form-group">
                            <label for="create-cost" class="col-sm-2 control-label">成本</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-cost">
                            </div>
                        </div>
						<div class="form-group">
							<label for="create-description" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-description"></textarea>
							</div>
						</div>
						
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="insertBtn">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改市场活动的模态窗口 -->
	<div class="modal fade" id="editActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel2">修改市场活动</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form">
						<input type="hidden" id="actId">
						<div class="form-group">
							<label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-marketActivityOwner">

								</select>
							</div>
                            <label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-marketActivityName">
                            </div>
						</div>

						<div class="form-group">
							<label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="edit-startTime">
							</div>
							<label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="edit-endTime">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-cost" class="col-sm-2 control-label">成本</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-cost">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="edit-describe"></textarea>
							</div>
						</div>
						
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<input type="button" class="btn btn-primary" id="updateBtn" data-dismiss="modal" value="更新">
				</div>
			</div>
		</div>
	</div>
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>市场活动列表</h3>
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
				      <input class="form-control" type="text" id="query_name">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input class="form-control" type="text" id="query_owner">
				    </div>
				  </div>


				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">开始日期</div>
					  <input class="form-control" type="text" id="query_startTime" />
				    </div>
				  </div>
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">结束日期</div>
					  <input class="form-control" type="text" id="query_endTime">
				    </div>
				  </div>
				  
				  <input type="button" id="queryBtn" class="btn btn-default" value="查询">
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" id="addBtn"><span class="glyphicon glyphicon-plus"></span>创建</button>
				  <button type="button" class="btn btn-default" id="editBtn"><span class="glyphicon glyphicon-pencil"></span>修改</button>
				  <button type="button" class="btn btn-danger" id="delBtn"><span class="glyphicon glyphicon-minus"></span>删除</button>
				</div>
				
			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="checkAll"/></td>
							<td>名称</td>
                            <td>所有者</td>
							<td>开始日期</td>
							<td>结束日期</td>
						</tr>
					</thead>
					<tbody id="activityList">

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