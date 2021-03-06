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
    <link type="text/css" rel="stylesheet" href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" />
    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>

<script type="text/javascript">
	//默认情况下取消和保存按钮是隐藏的
	var cancelAndSaveBtnDefault = true;

	$(function(){
		$("#remark").focus(function(){
			if(cancelAndSaveBtnDefault){
				//设置remarkDiv的高度为130px
				$("#remarkDiv").css("height","130px");
				//显示
				$("#cancelAndSaveBtn").show("2000");
				cancelAndSaveBtnDefault = false;
			}
		});
		$("#cancelBtn").click(function(){
			//显示
			$("#cancelAndSaveBtn").hide();
			//设置remarkDiv的高度为130px
			$("#remarkDiv").css("height","90px");
			cancelAndSaveBtnDefault = true;
		});
		$(".remarkDiv").mouseover(function(){
			$(this).children("div").children("div").show();
		});
		$(".remarkDiv").mouseout(function(){
			$(this).children("div").children("div").hide();
		});
		$(".myHref").mouseover(function(){
			$(this).children("span").css("color","red");
		});
		$(".myHref").mouseout(function(){
			$(this).children("span").css("color","#E6E6E6");
		});

		//点击编辑按钮弹出“修改市场活动”模态窗口
		$("#editActivityBtn").click(function () {
			$.ajax({
				url:"activity/selectById",
				data:{id:"${activity.id}"},
				type:"get",
				dataType:"json",
				success:function (result) {
					$("#edit-Owner").empty();
					$.each(result.list,function (index,value) {
						$("#edit-Owner").append("<option value='"+value.id+"'>"+value.name+"</option>");
					});
					$("#edit-Owner").val(result.activity.owner);
					$("#edit-Name").val(result.activity.name);
					$("#edit-startTime").val(result.activity.startDate);
					$("#edit-endTime").val(result.activity.endDate);
					$("#edit-cost").val(result.activity.cost);
					$("#edit-describe").val(result.activity.description);
				}
			});
			$("#editActivityModal").modal("show");  //弹出窗口
		});
		//修改市场活动信息
		$("#updateBtn").click(function () {
			var id = $("#activityId").val();
			var owner = $("#edit-Owner").val();
			var name= $.trim($("#edit-Name").val());
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
			}
		});
		//页面加载完毕后执行备注列表查询
		queryRemarkList();
		//处理备注的编辑和删除按钮
        $("#remarkBody").on("mouseover",".remarkDiv",function () {
            $(this).children("div").children("div").show();
        });
        $("#remarkBody").on("mouseout",".remarkDiv",function () {
            $(this).children("div").children("div").hide();
        });
	});

	//根据id查询备注列表
	function queryRemarkList() {
		$.ajax({
			url:"activityRemark/selectById",
			data:{id:"${activity.id}"},
			type:"get",
			dataType:"json",
			success:function (result) {
                var htmlText = "";
				$.each(result,function (num,value) {
                    htmlText += '<div id="'+value.id+'" class="remarkDiv" style="height: 60px;">';
                    htmlText += 	'<img title="${activity.owner}" src="image/user-thumbnail.png" style="width: 30px; height:30px;">';
                    htmlText += 	'<div style="position: relative; top: -40px; left: 40px;">';
                    htmlText += 		'<h5 id="h'+value.id+'">'+value.noteContent+'</h5>';
                    htmlText += 		'<font color="gray">市场活动</font> <font color="gray">-</font> <b>${activity.name}</b> <small id="s'+value.id+'" style="color: gray;">'+(value.editFlag === "0" ? value.createTime+"  由  "+value.createBy+" 创建" : value.editTime+"  由  "+value.editBy+" 修改")+"</small>";
                    htmlText += 		'<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">';
                    htmlText += 		    '<a class="myHref" href="javascript:void(0);" onclick="editRemark(\''+value.id+'\')"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #00FF00;"></span></a>'+'&nbsp;&nbsp;&nbsp;&nbsp;';
                    htmlText += 		    '<a class="myHref" href="javascript:void(0);" onclick="deleteRemark(\''+value.id+'\')"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #FF0000;"></span></a>';
                    htmlText += 		'</div>';
                    htmlText += 	'</div>';
                    htmlText += '</div>';
				});
				$("#remarkDiv").before(htmlText);
			}
		})
	};

	//删除备注
    function deleteRemark(id) {
        $.ajax({
            url:"activityRemark/delete",
            data:{id:id},
            type:"post",
            dataType:"text",
            success:function(result){
                if(result === "删除备注成功"){
                    alert(result);
                    $("#"+id).remove();
                }else {
                    alert(result);
                }
            }
        });
    };

    //添加备注
    function saveRemark(){
        var remarkText = $.trim($("#remark").val());
        if(remarkText === "" || remarkText === null){
            alert("备注信息不能为空");
        }else{
            $.ajax({
                url:"activityRemark/insert",
                data:{
                    activityId:"${activity.id}",
                    noteContent:remarkText
                },
                type:"post",
                dataType:"json",
                success:function (result) {
                    if(result.success){
                        var htmlText = "";
                        htmlText += '<div id="'+result.remark.id+'" class="remarkDiv" style="height: 60px;">';
                        htmlText += 	'<img title="${activity.owner}" src="image/user-thumbnail.png" style="width: 30px; height:30px;">';
                        htmlText += 	'<div style="position: relative; top: -40px; left: 40px;">';
                        htmlText += 		'<h5 id="h'+result.remark.id+'">'+result.remark.noteContent+'</h5>';
                        htmlText += 		'<font color="gray">市场活动</font> <font color="gray">-</font> <b>${activity.name}</b> <small id="s'+result.remark.id+'" style="color: gray;">'+(result.remark.createTime+"  由  "+result.remark.createBy+" 创建")+'</small>';
                        htmlText += 		'<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">';
                        htmlText += 		    '<a class="myHref" href="javascript:void(0);" onclick="editRemark(\''+result.remark.id+'\')"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #00FF00;"></span></a>&nbsp;&nbsp;&nbsp;&nbsp;';
                        htmlText += 		    '<a class="myHref" href="javascript:void(0);" onclick="deleteRemark(\''+result.remark.id+'\')"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #FF0000;"></span></a>';
                        htmlText += 		'</div>';
                        htmlText += 	'</div>';
                        htmlText += '</div>';
                        $("#remarkDiv").before(htmlText);
                        $("#remark").val("");
                        alert("添加备注成功");
                    }else {
                        alert("添加备注失败");
                    }
                }
            })
        }
    }

    //修改备注信息之前弹出模态窗口
    function  editRemark(id) {
        $.ajax({
            url:"activityRemark/selectRemarkById",
            data:{id:id},
            type:"get",
            dataType:"json",
            success:function (result) {
                $("#remarkId").val(id);
                $("#noteContent").val(result.noteContent);
            }
        });
        $("#editRemarkModal").modal("show");
    }

    //修改备注信息
    function remarkUpdate(){
        var id = $.trim($("#remarkId").val());
        var noteContent = $.trim($("#noteContent").val());
        if(noteContent === "" || noteContent === null){
            alert("备注内容不能为空");
        }else {
            $.ajax({
                url:"activityRemark/update",
                data:{
                    id:id,
                    noteContent:noteContent
                },
                type:"post",
                dataType:"json",
                success:function(result){
                    if(result.success){
                        $("#h"+id).html(result.remark.noteContent);
                        $("#s"+id).html(result.remark.editTime+" 由 "+result.remark.editBy+" 修改");
                        $("#editRemarkModal").modal("hide");
                    }else {
                        $("#editRemarkModal").modal("hide");
                        alert("备注修改失败");
                    }
                }
            })
        }
    }
</script>

</head>
<body>
	
	<!-- 修改市场活动备注的模态窗口 -->
	<div class="modal fade" id="editRemarkModal" role="dialog">
		<%-- 备注的id --%>
		<input type="hidden" id="remarkId">
        <div class="modal-dialog" role="document" style="width: 40%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel1">修改备注</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form">
                        <div class="form-group">
                            <label for="edit-describe" class="col-sm-2 control-label">内容</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="3" id="noteContent"></textarea>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <input type="button" class="btn btn-primary" id="updateRemarkBtn" onclick="remarkUpdate()" value="更新">
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
                    <h4 class="modal-title" id="myModalLabel">修改市场活动</h4>
                </div>
                <div class="modal-body">

                    <form class="form-horizontal" role="form">

                        <div class="form-group">
                            <label for="edit-Owner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <select class="form-control" id="edit-Owner">

                                </select>
                            </div>
                            <label for="edit-Name" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-Name" value="发传单">
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
                    <button type="button" class="btn btn-primary" data-dismiss="modal" id="updateBtn">更新</button>
                </div>
            </div>
        </div>
    </div>

	<!-- 返回按钮 -->
	<div style="position: relative; top: 35px; left: 10px;">
		<a href="javascript:void(0);" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left" style="font-size: 20px; color: #DDDDDD"></span></a>
	</div>
	
	<!-- 大标题 -->
	<div style="position: relative; left: 40px; top: -30px;">
		<div class="page-header">
			<h3>市场活动-${activity.name} <small>${activity.startDate} ~ ${activity.endDate}</small></h3>
		</div>
		<div style="position: relative; height: 50px; width: 250px;  top: -72px; left: 700px;">
			<button type="button" class="btn btn-default" data-toggle="modal" id="editActivityBtn"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
			<button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
		</div>
	</div>
	
	<!-- 详细信息 -->
	<div style="position: relative; top: -70px;">
		<div style="position: relative; left: 40px; height: 30px;">
			<div style="width: 300px; color: gray;">所有者</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${activity.owner}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">名称</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${activity.name}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>

		<div style="position: relative; left: 40px; height: 30px; top: 10px;">
			<div style="width: 300px; color: gray;">开始日期</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${activity.startDate}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">结束日期</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${activity.endDate}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 20px;">
			<div style="width: 300px; color: gray;">成本</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${activity.cost}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 30px;">
			<div style="width: 300px; color: gray;">创建者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${activity.createBy}&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;">${activity.createTime}</small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 40px;">
			<div style="width: 300px; color: gray;">修改者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${activity.editBy}&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;">${activity.editTime}</small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 50px;">
			<div style="width: 300px; color: gray;">描述</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b>
					${activity.description}
				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
	</div>
	
	<!-- 备注 -->
	<div id="remarkBody" style="position: relative; top: 30px; left: 40px;">
		<div class="page-header">
			<h4>备注</h4>
		</div>

		<div id="remarkDiv" style="background-color: #E6E6E6; width: 870px; height: 90px;">
			<form role="form" style="position: relative;top: 10px; left: 10px;">
				<textarea id="remark" class="form-control" style="width: 850px; resize : none;" rows="2"  placeholder="添加备注..."></textarea>
				<p id="cancelAndSaveBtn" style="position: relative;left: 737px; top: 10px; display: none;">
					<input id="cancelBtn" type="button" class="btn btn-default" value="取消">
					<input type="button" class="btn btn-primary" onclick="saveRemark()" value="保存">
				</p>
			</form>
		</div>
	</div>
	<div style="height: 200px;"></div>
</body>
</html>