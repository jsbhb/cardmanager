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
<title>机构管理</title>
<%@include file="../../resource.jsp" %>
</head>

<body>
	<div id="page-wrapper">
		<div class="container-fluid">
			<div class="query">
				<table class="table table-bordered">
					<tr>
						<td><label>商品编码:</label></td>
						<td><input type="text" class="form-control" id="itemCode" name="itemCode"></td>
					</tr>
					<tr>
						<td colspan="4"><button type="button" class="btn btn-primary" id="querybtns">查询</button></td>
					</tr>
				</table>
			</div>
			<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-body">
						<table id="goodsTable" class="table table-hover">
							<thead>
								<tr>
									<th>item编号</th>
									<th>item编码</th>
									<th>货号</th>
									<th>名称</th>
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
			url :  "${wmsUrl}/admin/basic/sellerInfo/supplierGoodsDataList.shtml?supplierId=${supplierId}",
			numPerPage:"10",
			currentPage:"",
			index:"1",
			callback:rebuildTable
}

$(function(){
	 $(".pagination-nav").pagination(options);
	 
})

/**
 * 重构table
 */
function rebuildTable(data){
	$("#goodsTable tbody").html("");


	if (data == null || data.length == 0) {
		return;
	}
	
	var list = data.obj;
	
	if (list == null || list.length == 0) {
		$.zzComfirm.alertError("没有查到数据");
		return;
	}

	var str = "";
	for (var i = 0; i < list.length; i++) {
		str += "<tr><td>" + list[i].itemId;
		str += "</td><td>" + list[i].itemCode;
		str += "</td><td>" + list[i].sku;
		str += "</td><td>" + list[i].skuName;
		str += "</td><td>" + list[i].uom;
		str += "</td></tr>";
	}
	
	
	$("#goodsTable tbody").htmlUpdate(str);
	
	trBind()
}

/**
 * 数据字典tr绑定选中事件
 */
function trBind() {
	$("#goodsTable tr").dblclick(sureSupplierGoods);
};

function sureSupplierGoods(){
	
	var selectTr = $(this);

	if ($(selectTr).parent().is('thead')) {
		return;
	}
	
	window.parent.addSupGoods(selectTr);
}

</script>
</body>
</html>