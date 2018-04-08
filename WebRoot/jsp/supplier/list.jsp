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
<%@include file="../resource.jsp"%>
<script src="${wmsUrl}/js/pagination.js"></script>



</head>
<body>
<section class="content-wrapper">
	<section class="content-header">
	      <ol class="breadcrumb">
	        <li><a href="#"><i class="fa fa-dashboard"></i>供应商管理</a></li>
	        <li class="active">供应商列表</li>
	      </ol>
	      <div class="search">
	      	<input type="text" name="name" placeholder="输入供应商名称" >
	      	<div class="searchBtn" ><i class="fa fa-search fa-fw" id="querybtns"></i></div>
		  </div>
    </section>
	<section class="content">
		<section class="content">
			 <div id="image" style="width:100%;height:100%;display: none;background:rgba(0,0,0,0.5);margin-left:-25px;margin-top:-62px;">
				<img alt="loading..." src="${wmsUrl}/img/loader.gif" style="position:fixed;top:50%;left:50%;margin-left:-16px;margin-top:-16px;" />
			</div>
			
			<div class="list-content">
				<div class="row">
					<div class="col-md-10 list-btns">
						<button type="button" onclick="toAdd()">新增员工</button>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<table id="baseTable" class="table table-hover myClass">
							<thead>
								<tr>
									<th>操作</th>
									<th>供应商名称</th>
									<th>国家省市</th>
									<th>地址</th>
									<th>负责人</th>
									<th>电话</th>
									<th>邮箱</th>
									<th>传真</th>
									<th>创建时间</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
						<div class="pagination-nav" style="float:right;margin-bottom:15px;">
							<ul id="pagination" class="pagination">
							</ul>
						</div>
					</div>
				</div>	
			</div>
		</section>
	</section>
	</section>
	
	<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
<script type="text/javascript">


/**
 * 初始化分页信息
 */
var options = {
			queryForm : ".query",
			url :  "${wmsUrl}/admin/supplier/supplierMng/dataList.shtml",
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
		
		str += "</td><td>" + list[i].supplierName;
		str += "</td><td>" + (list[i].country == null ? "" : list[i].country) +" "+(list[i].province == null ? "" : list[i].province);
		str += "</td><td>" + (list[i].city == null ? "" : list[i].city)+" "+(list[i].area == null ? "" : list[i].area)+" "+(list[i].address == null ? "" : list[i].address);
		str += "</td><td>" + (list[i].operator == null ? "" : list[i].operator);
		str += "</td><td>" + (list[i].phone == null ? "" : list[i].phone);
		str += "</td><td>" + (list[i].email == null ? "" : list[i].email);
		str += "</td><td>" + (list[i].fax == null ? "" : list[i].fax);
		str += "</td><td>" + (list[i].enterTime==null ? "" : list[i].enterTime);
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
		  title:"供应商查看",		
		  type: 2,
		  content: '${wmsUrl}/admin/supplier/supplierMng/toEdit.shtml?supplierId='+id,
		  maxmin: true
		});
		layer.full(index);
}


function toAdd(){
	var index = layer.open({
		  title:"新增供应商",		
		  type: 2,
		  content: '${wmsUrl}/admin/supplier/supplierMng/toAdd.shtml',
		  maxmin: true
		});
		layer.full(index);
}

</script>
</body>
</html>
