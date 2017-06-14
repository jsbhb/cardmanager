<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>任务列表</title>
<%@include file="../resource.jsp"%>
</head>

<body>
	<div id="page-wrapper">
		<div class="container-fluid">
		<div class="row">
				<div class="col-lg-12">
					<ol class="breadcrumb">
						<li><i class="fa fa-book fa-fw"></i>任务管理</li>
						<li class="active"><i class="fa fa-bookmark fa-fw"></i>任务列表</li>
					</ol>
				</div>
			</div>
			<!-- Page Heading -->
			<div class="row">
				<div class="col-lg-12">
					<div class="query">
						<div class="row" >
							<div class="form-group">
								<label>类型</label><select  class="form-control" name="taskType" id="taskType">
									<option value="" selected="selected">全部</option>
									<option value="0">导出任务</option>
								</select>
							</div>
							<div class="form-group">
								<label>描述</label> <input type="text" class="form-control"
									name="description" id="description">
							</div>
							<div class="form-group">
								<label>状态</label> <select  class="form-control" name="status" id="status">
									<option value="" selected="selected">全部</option>
									<option value="0">待处理</option>
									<option value="5">队列中</option>
									<option value="10">处理中</option>
									<option value="20">处理完毕</option>
									<option value="30">处理异常</option>
									<option value="40">过期</option>
								</select>
							</div>
						</div>
						<div class="row">
							<div class="form-group">
								<button type="button" id="querybtns" class="btn btn-primary">查询</button>
								<button type="button" id="clearbtns" class="btn btn-warning"
									onclick="clearSearch()">清空</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">
								<i class="fa fa-bar-chart-o fa-fw"></i>分类分拣列表
							</h3>
						</div>
						<div class="panel-body">
							<table id="taskRecordTable" class="table table-hover">
								<thead>
									<tr>
										<th>任务编号</th>
										<th>类型</th>
										<th>描述</th>
										<th>更新时间</th>
										<th>状态</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
							<div class="pagination-nav">
								<ul id="pagination" class="pagination">
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
	/**
	 * 初始化分页信息
	 */
	var options = {
				queryForm : ".query",
				url :  "${wmsUrl}/admin/taskRecord/dataList.shtml",
				numPerPage:"10",
				currentPage:"",
				index:"1",
				callback:rebuildTable
	}
	
	$(function(){
		$(".pagination-nav").pagination(options);
		setInterval(updateTaskList,4000);
	})
	
	function updateTaskList() {
		$.page.loadData(options);
	}
	
	/**
	 * 重构table
	 */
	function rebuildTable(data){
		$("#taskRecordTable tbody").html("");
	
		if (data == null || data.length == 0) {
			return;
		}
		
		var list = data.obj;
	
		var str = "";
		var strCom = "";
		for (var i = 0; i < list.length; i++) {
			str += "<tr>";
			str += "<td>"+list[i].id+"</td>";
			switch (list[i].taskType) {
			case 0:
				strCom = "导出任务";
				break;
			}
			str += "<td>"+strCom+"</td>";
			str += "<td>"+list[i].description+"</td>";
			str += "<td>"+list[i].uptime+"</td>";
			switch (list[i].status) {
			case 0:
				strCom = "待处理";
				break;
			case 5:
				strCom = "队列中";
				break;
			case 10:
				strCom = "处理中";
				break;
			case 20:
				strCom = "处理完毕";
				break;	
			case 30:
				strCom = "<font color='ff0000'>处理异常</font>";
				break;
			case 40:
				strCom = "过期";
				break;	
			}
			str += "<td>"+strCom+"</td>";
			if(list[i].status == 20 && list[i].taskType == 0){
				var ctime = list[i].ctime.substring(0,10).replace(/-/g,"");
				var filePath="DL/Export/"+list[i].optid+"/"+ctime+"/"+list[i].id+".xlsx";
				str += "<td><a href='${wmsUrl}/admin/taskRecord/fileDownLoad.shtml?filePath="+filePath+"'>下载文件</a></td>";
			}else if(list[i].status == 30){
				str += "<td id='task"+list[i].id+"'><a href='#' onclick='executeAgain("+list[i].id+");'>重新执行</a></td>";
			}else{
				str += "<td></td>";
			}
			
			str += "</tr>";
		}
		
		$("#taskRecordTable tbody").htmlUpdate(str);
	}
	
	function executeAgain(taskId) {
		$.ajax({
			 url:"${wmsUrl}/admin/taskRecord/executeAgain.shtml",
			 type:'post',
			 data:{
				 "taskId":taskId,
			 },
			 dataType:'json',
			 success:function(data){
				 if(data.success){	
					 $.zzComfirm.alertSuccess(data.msg);
					 $("#task2").html("待处理");
				 }else{
					 $.zzComfirm.alertError(data.msg);
				 }
			 },
			 error:function(){
				 $.zzComfirm.alertError("系统出现问题啦，快叫技术人员处理");
			 }
		 }); 
	}
	
	function clearSearch() {
		$("#taskType").val("");
		$("#description").val("");
		$("#status").val("");
	}
	</script>
</body>
</html>
