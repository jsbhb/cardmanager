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
<%@include file="../../../resourceLink.jsp"%>
</head>
<body>
<section class="content-wrapper query">
    <section class="content-header">
		      <ol class="breadcrumb">
		        <li><a href="javascript:void(0);">分机返佣管理</a></li>
		        <li class="active">公式管理</li>
		      </ol>
		      <div class="search">
		      	<input type="text" name="gradeTypeName" placeholder="输入分级类型名称" >
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
					<button type="button" onclick="toAdd()">创建公式</button>
				</div>
			</div>
			<div class="col-md-12 ">
				<table id="baseTable" class="table table-hover myClass">
					<thead>
						<tr>
							<th>编号</th>
							<th>分级类型名称</th>
							<th>返佣公式(rebate代表区域中心返佣)</th>
							<th>创建时间</th>
							<th>更新时间</th>
							<th>操作人</th>
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
<%@include file="../../../resourceScript.jsp"%>
<script src="${wmsUrl}/js/pagination.js"></script>
<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
<script type="text/javascript">


/**
 * 初始化分页信息
 */
var options = {
			queryForm : ".query",
			url :  "${wmsUrl}/admin/system/gradeType/typerebate/dataList.shtml",
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
		str = "<tr style='text-align:center'><td colspan=7><h5>没有查到数据</h5></td></tr>";
		$("#baseTable tbody").html(str);
		return;
	}

	for (var i = 0; i < list.length; i++) {
		str += "<tr>";
		str += "<td>" + list[i].id;
		str += "</td><td>" + (list[i].gradeTypeName == null ? "" : list[i].gradeTypeName);
		str += "</td><td>" + list[i].formula;
		str += "</td><td>" + (list[i].createTime == null ? "" : list[i].createTime);
		str += "</td><td>" + (list[i].updateTime == null ? "" : list[i].updateTime);
		str += "</td><td>" + (list[i].opt == null ? "" : list[i].opt);
		str += "<td align='left'>";
		str += "<a href='#' onclick='toEdit("+list[i].id+")'>编辑</a>";
		str += "</td>";
		str += "</td></tr>";
	}

	$("#baseTable tbody").html(str);
}
	
function toEdit(id){
	var index = layer.open({
		 title:"公式编辑",		
		 area: ['80%', '40%'],		
		 type: 2,
		 content: '${wmsUrl}/admin/system/gradeType/typerebate/toEdit.shtml?id='+id,
		 maxmin: false
	});
}


function toAdd(){
	var index = layer.open({
		  title:"新增公式",
		  area: ['80%', '40%'],	
		  type: 2,
		  content: '${wmsUrl}/admin/system/gradeType/typerebate/toAdd.shtml',
		  maxmin: false
	});
}

</script>
</body>
</html>
