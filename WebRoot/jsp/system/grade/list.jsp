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
		        <li><a href="javascript:void(0);">系统管理</a></li>
		        <li class="active">分级管理</li>
		      </ol>
		      <div class="search">
		      	<input type="text" name="gradeName" placeholder="输入分级名称" >
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
					<button type="button" onclick="toAdd()">新增分级</button>
				</div>
			</div>
			<div class="col-md-12 ">
				<table id="baseTable" class="table table-hover myClass">
					<thead>
						<tr>
							<th>等级编号</th>
							<th>名称</th>
<!-- 							<th>初始化</th> -->
							<th>上级机构</th>
							<th>类型</th>
							<th>公司</th>
							<th>负责人</th>
							<th>电话</th>
							<th>创建时间</th>
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
	</section>
</section>
<%@include file="../../resourceScript.jsp"%>
<script src="${wmsUrl}/js/pagination.js"></script>
<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
<script type="text/javascript">


/**
 * 初始化分页信息
 */
var options = {
			queryForm : ".query",
			url :  "${wmsUrl}/admin/system/gradeMng/dataList.shtml",
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
	$("#baseTable tbody").html("");

	if (data == null || data.length == 0) {
		return;
	}
	
	var list = data.obj;
	var str = "";
	
	if (list == null || list.length == 0) {
		str = "<tr style='text-align:center'><td colspan=9><h5>没有查到数据</h5></td></tr>";
		$("#baseTable tbody").html(str);
		return;
	}

	for (var i = 0; i < list.length; i++) {
		str += "<tr>";
		//if ("${privilege>=2}") {
		
		str += "<td>" + list[i].id;
		str += "</td><td>" + (list[i].gradeName == null ? "" : list[i].gradeName);
		
// 		var gradeType = list[i].gradeType;
// 		var init = list[i].init;
// 		if(gradeType == 2){
// 			if(init == 1){
// 				str += "</td><td>完成";
// 			} else {
// 				str += "</td><td>未完成";
// 				str += "<a href='#' onclick='init("+list[i].id+")'><i class='fa  fa-refresh' style='font-size:20px;margin-left:5px'></i></a>";
// 			}
// 		} else {
// 			str += "</td><td>完成";
// 		}
		
		var pgName = list[i].parentGradeName;
		
		if(pgName != null && pgName !="null" && pgName != ""){
			str += "</td><td>" + list[i].parentGradeName;
		}else{
			str += "</td><td>";
		}
		
		
// 		var type = list[i].gradeType;
// 		if(type == "0"){
// 			str += "</td><td>大贸" ;
// 		}else if(type == "1"){
// 			str += "</td><td>跨境";
// 		}else if(type == "100"){
// 			str += "</td><td>总公司";
// 		}else{
// 			str += "</td><td>无";
// 		}
		str += "</td><td>" + (list[i].gradeTypeName == null ? "" : list[i].gradeTypeName);
		str += "</td><td>" + (list[i].company == null ? "" : list[i].company);
		str += "</td><td>" + (list[i].personInCharge == null ? "" : list[i].personInCharge);
		str += "</td><td>" + (list[i].phone == null ? "" : list[i].phone);
		str += "</td><td>" + (list[i].createTime == null ? "" : list[i].createTime);
		if (true) {
			str += "<td align='left'>";
			str += "<a href='#' onclick='toEdit("+list[i].id+")'>编辑</a>";
			str += "</td>";
		}
		str += "</td></tr>";
	}

	$("#baseTable tbody").html(str);
}
	
function toEdit(id){
	var index = layer.open({
		 title:"分级编辑",		 
		  type: 2,
		  content: '${wmsUrl}/admin/system/gradeMng/toEdit.shtml?gradeId='+id,
		  maxmin: true
		});
		layer.full(index);
}


function toAdd(){
	var index = layer.open({
		  title:"新增分级",
		  type: 2,
		  content: '${wmsUrl}/admin/system/gradeMng/toAdd.shtml',
		  maxmin: true
		});
		layer.full(index);
}

function init(id){
	if(id == 0 || id == null){
		layer.alert("信息不全，请联系技术人员！");
		return;
	}
	$.ajax({
		 url:"${wmsUrl}/admin/system/gradeMng/init.shtml?id="+id,
		 type:'post',
	     contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 success:function(data){
			 if(data.success){	
				 reloadTable();
			 }else{
				  layer.alert(data.msg);
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
