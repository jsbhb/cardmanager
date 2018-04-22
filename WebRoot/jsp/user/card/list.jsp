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
<section class="content-wrapper">
	<section class="content-header">
	      <ol class="breadcrumb">
	        <li><a href="javascript:void(0);">首页</a></li>
	        <li>个人中心</li>
	        <li class="active">绑卡信息</li>
	      </ol>
    </section>
	<section class="content">
		<div class="list-content">
			<div class="row">
				<div class="col-md-12 list-btns">
					<button type="button" onclick="toAdd()">新增银行卡</button>
				</div>
			</div>
			<div class="row content-container">
				<div class="col-md-12 container-right active">
					<table id="cardTable" class="table table-hover myClass">
						<thead>
							<tr>
								<th width="25%">银行卡号</th>
								<th width="15%">银行名称</th>
								<th width="15%">持卡人姓名</th>
								<th width="15%">预留电话</th>
								<th width="15%">修改</th>
								<th width="15%">解绑</th>
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
			url :  "${wmsUrl}/admin/user/userCardMng/dataList.shtml",
			numPerPage:"20",
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
	$("#cardTable tbody").html("");

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
		str += "<td>" + list[i].cardNo;
		str += "</td><td>" + list[i].cardBank;
		str += "</td><td>" + list[i].cardName;
		str += "</td><td>" + list[i].cardMobile;
		str += "</td><td><a href='javascript:void(0);' class='table-btns' onclick='toEdit("+list[i].id+")'>编辑</a>";
		str += "</td><td><a href='javascript:void(0);' class='table-btns' onclick='toDelete(\""+list[i].id+"\")'>解绑</a>";
		str += "</td></tr>";
	}

	$("#cardTable tbody").html(str);
}
	
function toAdd(){
	
	var index = layer.open({
		  type: 2,
		  content: '${wmsUrl}/admin/user/userCardMng/toAdd.shtml',
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
		  content: '${wmsUrl}/admin/user/userCardMng/toEdit.shtml?cardId='+id,
		  area: ['320px', '195px'],
		  maxmin: true
		});
		layer.full(index);
}
	
function toDelete(id){
	if(id == 0 || id == null){
		layer.alert("信息不全，请联系技术人员！");
		return;
	}
	
	var index = layer.open({
		  type: 2,
		  content: '${wmsUrl}/admin/user/userCardMng/toDelete.shtml?cardId='+id,
		  area: ['320px', '195px'],
		  maxmin: true
		});
		layer.full(index);
}
</script>
</body>
</html>
