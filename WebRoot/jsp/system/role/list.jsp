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
<style type="text/css">
i {font-size:10px;}
</style>

<%@include file="../../resource.jsp"%>
<script src="${wmsUrl}/js/pagination.js"></script>

</head>
<body>
	<section class="content-wrapper">
		<section class="content-header">
		      <ol class="breadcrumb">
		        <li><a href="javascript:void(0);">系统管理</a></li>
		        <li class="active">角色管理</li>
		      </ol>
		      <div class="search">
		      	<input type="text" name="name" placeholder="输入角色名称" >
		      	<div class="searchBtn" ><i class="fa fa-search fa-fw" id="querybtns"></i></div>
			  </div>
	    </section>
		<section class="content">
			 <div id="image" style="width:100%;height:100%;display: none;background:rgba(0,0,0,0.5);margin-left:-25px;margin-top:-62px;">
				<img alt="loading..." src="${wmsUrl}/img/loader.gif" style="position:fixed;top:50%;left:50%;margin-left:-16px;margin-top:-16px;" />
			</div>
			
			<div class="list-content">
				<div class="row">
					<div class="col-md-10 list-btns">
						<button type="button" onclick="toAdd()">新增角色</button>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<table id="baseTable" class="table table-hover myClass">
							<thead>
								<tr>
									<th>角色编号</th>
									<th>角色名称</th>
									<th>启用状态</th>
									<th>角色状态</th>
									<th>创建时间</th>
									<th>更新时间</th>
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
		</section>
	</section>
<script type="text/javascript">

/**
 * 初始化分页信息
 */
var options = {
			queryForm : ".query",
			url :  "${wmsUrl}/admin/system/roleMng/dataList.shtml",
			numPerPage:"10",
			currentPage:"",
			index:"1",
			callback:rebuildTable
}


$(function(){
	 $(".pagination-nav").pagination(options);
	 var top = getTopWindow();
	 $('.breadcrumb').on('click','a',function(){
			top.location.reload();
		});
})


function reloadTable(){
	$.page.loadData(options);
}


/**
 * 重构table
 */
function rebuildTable(data){
	$("#baseTable tbody").html("");

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
		//if ("${privilege>=2}") {
		str += "<td>" + list[i].roleId;
		str += "</td><td>" + list[i].roleName;
		
		var type = list[i].roleState;
		
		if(type == "1"){
			str += "</td><td>已启用" ;
			str += "<a href='#' onclick='change("+list[i].roleId+","+0+")'><i class='fa  fa-pause-circle' style='font-size:20px;margin-left:5px'></i></a>";
		}else if(type == "0"){
			str += "</td><td>未启用";
			str += "<a href='#' onclick='change("+list[i].roleId+","+1+")'><i class='fa  fa-play-circle-o' style='font-size:20px;margin-left:5px'></i></a>";
		}else{
			str += "</td><td>无";
		}
		str += "</td><td>" + list[i].type;
		str += "</td><td>" + list[i].createTime;
		
		if(list[i].updateTime == null){
			str += "</td><td>无";
		}else{
			str += "</td><td>" + list[i].updateTime;
		}
		if (true) {
			str += "<td align='left'>";
			str += "<a href='#' onclick='toEdit("+list[i].roleId+")'>编辑</a>";
			str += "</td>";
		}
		str += "</td></tr>";
	}

	$("#baseTable tbody").html(str);
}
	
function toAdd(){
	
	var index = layer.open({
		  title:"新增角色",		
		  type: 2,
		  content: '${wmsUrl}/admin/system/roleMng/toAdd.shtml?',
		  area: ['320px', '195px'],
		  maxmin: true
		});
		layer.full(index);
}
	
function toEdit(id){
	if(id == 0 || id == null){
		layer.alert("信息不全，请联系技术人员！");
		return;
	}
	
	var index = layer.open({
		  title:"编辑角色",		
		  type: 2,
		  content: '${wmsUrl}/admin/system/roleMng/toEdit.shtml?roleId='+id,
		  area: ['320px', '195px'],
		  maxmin: true
		});
		layer.full(index);
}

function change(id,state){
	if(id == 0 || id == null){
		layer.alert("信息不全，请联系技术人员！");
		return;
	}
	
	$.ajax({
		 url:"${wmsUrl}/admin/system/roleMng/change.shtml?roleId="+id+"&roleState="+state,
		 type:'post',
	     contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 success:function(data){
			 if(data.success){	
				 reloadTable();
			 }else{
				 layer.alert(data.errInfo);
			 }
		 },
		 error:function(){
			 layer.alert("系统出现问题啦，快叫技术人员处理");
		 }
	 });
}


</script>
</body>
</html>
