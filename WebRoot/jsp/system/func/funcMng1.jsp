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
<%@include file="../../resource.jsp"%>
<script src="${wmsUrl}/js/pagination.js"></script>

</head>
<body>
<section class="content-wrapper">
	<section class="content-header query">
	      <ol class="breadcrumb">
	        <li><a href="javascript:void(0);"><i class="fa fa-dashboard"></i>系统管理</a></li>
	        <li class="active">功能列表</li>
	      </ol>
	      <div class="search">
	      	<input type="text" name="name" placeholder="输入功能名称" >
	      	<input type="hidden" name="queryAll" value="true">
	      	<input type="hidden" name="parentId" value="">
	      	<input type="hidden" name="backId" value="">
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
						<button type="button" onclick="toAdd()">新增模块</button>
						<button id="backBtn" type="button" onclick="back()">返回上级菜单</button>
	<div id="content-wrapper">
		<section class="content-header">
			<!-- Page Heading -->
			<h1>系统管理
		    <small>功能管理</small>
		    </h1>
			<!-- /.row -->

			<ol class="breadcrumb">
		        <li><a href="javascript:void(0);"><i class="fa fa-dashboard"></i>首页</a></li>
		        <li><a href="javascript:void(0);">系统管理</a></li>
		        <li class="active">功能管理</li>
		     </ol>
		</section>
		<section class="content">
		<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">
								<i class="fa fa-bar-chart-o fa-fw"></i>功能列表
							</h3>
						</div>
						<div class="panel-body">
							<c:if test="${priviledge>1}">
								<button type="submit" class="btn btn-default">新增</button>
							</c:if>
							<table id="funcTable" class="table table-hover">
								<thead>
									<tr>
										<th>操作</th>
										<th>名称</th>
										<th>tag</th>
										<th>创建日期</th>
										<th>更新日期</th>
										<th>操作人</th>
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
				<div class="row">
					<div class="col-md-12">
						<table id="baseTable" class="table table-hover myClass">
							<thead>
								<tr>
									<th>ID</th>
									<th>名称</th>
									<th>父菜单</th>
									<th>地址</th>
									<th>排序</th>
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
	
<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
<script type="text/javascript">

$(function(){
	$("#backBtn").hide();
})
/**
 * 初始化分页信息
 */
var options = {
			queryForm : ".query",
			url :  "${wmsUrl}/admin/system/funcMng/dataList1.shtml",
			numPerPage:"100",
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
		
		str += "<td>" + list[i].funcId;
		str += "<td>" + list[i].name;
		
		str += "</td><td>" + (list[i].parentName==null?"":list[i].parentName);
		str += "</td><td>" + (list[i].url==null?"":list[i].url);
		str += "</td><td>" + (list[i].sort==null?"0":list[i].sort);
		
		str += "</td><td><a href='javascript:void(0);' class='table-btns' onclick='child("+list[i].funcId+")'>子菜单</a>";
		str += "&nbsp;&nbsp;&nbsp<a href='javascript:void(0);' class='table-btns' onclick='toEdit("+list[i].funcId+")'>编辑</a>";
		str += "</td></tr>";
	}

	$("#baseTable tbody").html(str);
}

function child(parentId){
	var backId = $("[name='parentId']").val(); 
	$("[name='parentId']").val(parentId);
	$("[name='backId']").val(backId)
	
	$("#backBtn").show();
	reloadTable();
}

function back(){
	var backId = $("[name='backId']").val(); 
	$("[name='parentId']").val(backId);
	$("[name='backId']").val("");
	
	
	var parentId = $("[name='parentId']").val();
	
	if(parentId==null||parentId==""){
		$("#backBtn").hide();
	}
	
	reloadTable();
}
	
function toAdd(){
	
	var id = $("[name='parentId']").val();
	
	var index = layer.open({
		  type: 2,
		  content: '${wmsUrl}/admin/system/funcMng/toAdd.shtml?parentId='+id,
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
		  type: 2,
		  content: '${wmsUrl}/admin/system/funcMng/toEdit.shtml?func_id='+id,
		  area: ['320px', '195px'],
		  maxmin: true
		});
		layer.full(index);
}

</script>
</body>
</html>
