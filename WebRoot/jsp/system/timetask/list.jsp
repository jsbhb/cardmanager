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
<%@include file="../../resourceLink.jsp"%>
</head>
<body>
<section class="content-wrapper query">
	<section class="content-header">
	      <ol class="breadcrumb">
	        <li>系统管理</li>
	        <li class="active">调度器控制台</li>
	      </ol>
	      <div class="search">
	      	<input type="text" name="jobName" placeholder="请输入调度器名称">
	      	<div class="searchBtn"><i class="fa fa-search fa-fw"></i></div>
	      	<div class="moreSearchBtn">高级搜索</div>
		  </div>
    </section>	
	<section class="content">
		<div class="moreSearchContent">
			<div class="row form-horizontal list-content">
				<div class="col-xs-3">
					<div class="searchItem">
	                  	<input type="text" class="form-control" name="jobId" placeholder="请输入调度器编码">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
			           <input type="text" class="form-control" name="jobName" placeholder="请输入调度器名称">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
			            <select class="form-control" name="status" id="status">
		                	<option selected="selected" value="-1">全部状态</option>
		                	<option value="0">停止</option>
		                	<option value="1">启动</option>
			            </select>
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
			            <select class="form-control" name="concurrent" id="concurrent">
		                	<option selected="selected" value="-1">全部并发设置</option>
		                	<option value="0">不允许并发</option>
		                	<option value="1">允许并发</option>
			            </select>
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchBtns">
						 <div class="lessSearchBtn">简易搜索</div>
                         <button type="button" class="query" id="querybtns" name="signup">提交</button>
                         <button type="button" class="clear">清除选项</button>
                    </div>
                </div>
            </div>
		</div>
		<div class="list-content">
			<div class="row content-container">
				<div class="col-md-12 container-right active">
					<table id="itemTable" class="table table-hover myClass">
						<thead>
							<tr>
								<th width="10%">调度器编码</th>
								<th width="20%">调度器名称</th>
								<th width="10%">运行状态</th>
								<th width="20%">执行间隔</th>
								<th width="20%">并发设置</th>
								<th width="20%">操作</th>
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
	</section>
</section>
	
<%@include file="../../resourceScript.jsp"%>
<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
<script type="text/javascript">


/**
 * 初始化分页信息
 */
var options = {
	queryForm : ".query",
	url :  "${wmsUrl}/admin/system/timetaskMng/dataList.shtml",
	numPerPage:"10",
	currentPage:"",
	index:"1",
	callback:rebuildTable
}


$(function(){
	 $(".pagination-nav").pagination(options);
})


function reloadTable(){
	$.page.loadData(options);
}


/**
 * 重构table
 */
function rebuildTable(data){
	$("#itemTable tbody").html("");

	if (data == null || data.length == 0) {
		return;
	}
	
	var list = data.obj;
	
	if (list == null || list.length == 0) {
		layer.alert("没有查到数据");
		return;
	}

	var str = "";
	for (var i = 0; i < list.length; i++) {
		str += "<tr>";
		str += "<td>" + list[i].id;
		str += "</td><td>" + list[i].jobName;
		var status = list[i].status;
		switch(status){
			case 0:str += "</td><td>停止";break;
			case 1:str += "</td><td>启动";break;
			default:str += "</td><td>状态错误："+status;
		}
		str += "</td><td>" + list[i].cronExpression;
		var concurrent = list[i].concurrent;
		switch(concurrent){
			case 0:str += "</td><td>不允许并发";break;
			case 1:str += "</td><td>允许并发";break;
			default:str += "</td><td>并发设置错误："+concurrent;
		}
		str += "</td><td>";
		if (status == 0) {
			str += "<a href='javascript:void(0);' class='table-btns' onclick='beStart("+list[i].id+")' >启动</a>";
		} else {
			str += "<a href='javascript:void(0);' class='table-btns' onclick='beStop("+list[i].id+")' >停止</a>";
		}
		str += "<a href='javascript:void(0);' class='table-btns' onclick='toEdit("+list[i].id+")' >编辑</a>";
		str += "</td></tr>";
	}
	$("#itemTable tbody").html(str);
}

function beStart(id){
	$.ajax({
		 url:"${wmsUrl}/admin/system/timetaskMng/startTimeTask.shtml?id="+id,
		 type:'post',
		 contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 success:function(data){
			 if(data.success){	
				 layer.alert("调度器启动成功");
				 reloadTable();
			 }else{
				 layer.alert(data.msg);
			 }
		 },
		 error:function(){
			 layer.alert("调度器启动失败，请联系客服处理");
		 }
	 });
}

function beStop(id){
	$.ajax({
		 url:"${wmsUrl}/admin/system/timetaskMng/stopTimeTask.shtml?id="+id,
		 type:'post',
		 contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 success:function(data){
			 if(data.success){	
				 layer.alert("调度器停止成功");
				 reloadTable();
			 }else{
				 layer.alert(data.msg);
			 }
		 },
		 error:function(){
			 layer.alert("调度器停止失败，请联系客服处理");
		 }
	 });
}

function toEdit(id){
	var index = layer.open({
		  title:"调度器配置",
		  type: 2,
		  area:['60%','40%'],
		  content: '${wmsUrl}/admin/system/timetaskMng/toEdit.shtml?id='+id,
		  maxmin: false
		});
}
</script>
</body>
</html>
