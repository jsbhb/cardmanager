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
	        <li>物流管理</li>
	        <li class="active">快递公司</li>
	      </ol>
	      <div class="search">
	      	<input type="text" name="deliveryName" placeholder="请输入快递名称">
	      	<div class="searchBtn"><i class="fa fa-search fa-fw"></i></div>
	      	<div class="moreSearchBtn">高级搜索</div>
		  </div>
    </section>	
	<section class="content">
		<div class="moreSearchContent">
			<div class="row form-horizontal list-content">
				<div class="col-xs-3">
					<div class="searchItem">
			           <input type="text" class="form-control" name="hidDeliveryName" placeholder="请输入快递名称">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
			           <input type="text" class="form-control" name="deliveryCode" placeholder="请输入快递代码">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
			            <select class="form-control" name="status">
		                	<option selected="selected" value="">全部</option>
		                	<option value="0">停用</option>
		                	<option value="1">启用</option>
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
			<div class="row">
				<div class="col-md-10 list-btns">
					<button type="button" onclick="toEdit(-1)">新增快递</button>
				</div>
			</div>
			<div class="row content-container">
				<div class="col-md-12 container-right active">
					<table id="itemTable" class="table table-hover myClass">
						<thead>
							<tr>
								<th width="25%">快递名称</th>
								<th width="25%">快递代码</th>
								<th width="25%">使用状态</th>
								<th width="25%">操作</th>
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
	url :  "${wmsUrl}/admin/expressMng/deliveryDataList.shtml",
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
	var str = "";
	
	if (list == null || list.length == 0) {
		str = "<tr style='text-align:center'><td colspan=7><h4>没有查到数据</h4></td></tr>";
		$("#itemTable tbody").html(str);
		return;
	}

	for (var i = 0; i < list.length; i++) {
		str += "<tr>";
		str += "<td>" + list[i].deliveryName;
		str += "</td><td>" + list[i].deliveryCode;
		var status = list[i].status;
		switch(status){
			case 0:str += "</td><td>停用";break;
			case 1:str += "</td><td>启用";break;
			default:str += "</td><td>未知状态："+status;
		}
		str += "</td><td>";
		str += "<a href='javascript:void(0);' onclick='toEdit("+list[i].id+")' >编辑</a>";
		str += "</td></tr>";
	}
	$("#itemTable tbody").html(str);
}

function toEdit(id){
	var path = '${wmsUrl}/admin/expressMng/toEditDelivery.shtml';
	if("-1" != id){
		path += '?id=';
		path += id;
	}
	var index = layer.open({
		  title:"维护快递公司",		
		  type: 2,
		  area:['80%','40%'],
		  content: path,
		  maxmin: false
		});
}
</script>
</body>
</html>
