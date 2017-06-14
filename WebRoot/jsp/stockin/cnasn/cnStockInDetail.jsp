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
<title>预进货详情</title>
<%@include file="../../resource.jsp" %>
</head>

<body>
	<div id="page-wrapper">
		<div class="container-fluid">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">
						<i class="fa fa-bar-chart-o fa-fw"></i>商家信息
					</h3>
				</div>
				<div class="panel-body">
					<table class="table table-bordered">
						<tr>
							<td><label>商家编号:</label></td>
							<td><label style="color:red">${order.supplierId}</label></td>
							<td><label>商家名称:</label></td>
							<td><label>${order.supplierName}</label></td>
						</tr>
					</table>
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">
						<i class="fa fa-bar-chart-o fa-fw"></i>订单信息
					</h3>
				</div>
				<div class="panel-body">
					<table class="table table-bordered">
						<tr>
							<td><label>编号:</label></td>
							<td><label style="color:red">${order.orderId}</label></td>
							<td><label>菜鸟编号:</label></td>
							<td><label>${order.orderCode}</label></td>
						</tr>
						<tr>
							<td><label>订单类型:</label></td>
							<td>
								<label>
								<c:if test="${order.orderType==302}">
								调拨入库单
								</c:if>
								<c:if test="${order.orderType==501}">
								销退入库单
								</c:if>
								<c:if test="${order.orderType==601}">
								采购入库单
								</c:if>
								<c:if test="${order.orderType==904}">
								普通入库单
								</c:if>
								</label>
							</td>
							<td><label>订单状态:</label></td>
							<td><label style="color:red">
								<c:if test="${order.status=='0'}">
								未处理
								</c:if>
								<c:if test="${order.status=='1'}">
								接单
								</c:if>
								<c:if test="${order.status=='2'}">
								确认接单
								</c:if>
								<c:if test="${order.status=='3'}">
								拒单
								</c:if>
								<c:if test="${order.status=='4'}">
								取消
								</c:if>
								<c:if test="${order.status=='5'}">
								绑定
								</c:if>
								</label></td>
						</tr>
						<tr>
							<td><label>理货状态:</label></td>
							<td>
								<label>
								<c:if test="${order.tallyStatus=='0'}">
								未处理
								</c:if>
								<c:if test="${order.tallyStatus=='1'}">
								理货中
								</c:if>
								<c:if test="${order.tallyStatus=='2'}">
								理货完成
								</c:if>
								</label>
							</td>
							<td><label>理货审核:</label></td>
							<td><label style="color:red">
								<c:choose>
									<c:when test="${order.tallyAuditResult==null}">
										未处理
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${order.tallyAuditResult.auditStatus=='-100'}">
												审核未通过()
											</c:when>
											<c:when test="${order.status=='100'}">
											</c:when>
											<c:otherwise>
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
								</label></td>
						</tr>
						<tr>
							<td><label>订单创建时间:</label></td>
							<td><label>${order.orderCreateTime}</label></td>
							<td><label>备注:</label></td>
							<td><label>${order.remark}</label></td>
						</tr>
					</table>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<table id="itemTable" class="table table-hover table-bordered">
						<thead>
							<tr>
								<th>编号</th>
								<th>货号</th>
								<th>数量</th>
								<th>商品编号</th>
								<th>商品编码</th>
								<th>商品类型</th>
								<th>商品名称</th>
								<th>店铺编号</th>
								<th>净重</th>
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
	
	<c:if test="${supplyOrder!=null}">
		<div class="container-fluid">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">
						<i class="fa fa-bar-chart-o fa-fw"></i>差异入库单
					</h3>
				</div>
				<div class="panel-body">
					<table class="table table-bordered">
						<tr>
							<td><label>编号:</label></td>
							<td><label style="color:red">${supplyOrder.orderId}</label></td>
							<td><label>菜鸟编号:</label></td>
							<td><label>${supplyOrder.orderCode}</label></td>
						</tr>
						<tr>
							<td><label>订单类型:</label></td>
							<td>
								<label>
								<c:if test="${supplyOrder.orderType==302}">
								调拨入库单
								</c:if>
								<c:if test="${supplyOrder.orderType==501}">
								销退入库单
								</c:if>
								<c:if test="${supplyOrder.orderType==601}">
								采购入库单
								</c:if>
								<c:if test="${supplyOrder.orderType==904}">
								普通入库单
								</c:if>
								</label>
							</td>
							<td><label>订单状态:</label></td>
							<td><label style="color:red">
								<c:if test="${supplyOrder.status=='0'}">
								未处理
								</c:if>
								<c:if test="${supplyOrder.status=='1'}">
								接单
								</c:if>
								<c:if test="${supplyOrder.status=='2'}">
								确认接单
								</c:if>
								<c:if test="${supplyOrder.status=='3'}">
								拒单
								</c:if>
								<c:if test="${supplyOrder.status=='4'}">
								取消
								</c:if>
								<c:if test="${supplyOrder.status=='5'}">
								绑定
								</c:if>
								</label></td>
						</tr>
						<tr>
							<td><label>订单创建时间:</label></td>
							<td><label>${order.orderCreateTime}</label></td>
							<td><label>备注:</label></td>
							<td><label>${order.remark}</label></td>
						</tr>
					</table>
				</div>
			</div>
			
			<div class="row">
				<div class="col-lg-12">
					<table id="supplyItemTable" class="table table-hover table-bordered">
						<thead>
							<tr>
								<th>编号</th>
								<th>货号</th>
								<th>数量</th>
								<th>商品编号</th>
								<th>商品编码</th>
								<th>商品类型</th>
								<th>商品名称</th>
								<th>店铺编号</th>
								<th>净重</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
					<div class="supply-pagination-nav">
						<ul id="pagination" class="pagination">
						</ul>
					</div>
				</div>
			</div>
		</div>
	
	</c:if>

<script type="text/javascript">

var options = {
		queryForm : ".query",
		url :  "${wmsUrl}/admin/stockIn/cnAsnMng/queryItemById.shtml?orderId=${order.orderId}",
		numPerPage:"100",
		currentPage:"",
		index:"1",
		callback:rebuildTable
}

var supplyOptions = {
		queryForm : ".query",
		url :  "${wmsUrl}/admin/stockIn/cnAsnMng/queryItemById.shtml?orderId=${supplyOrder.orderId}",
		numPerPage:"100",
		currentPage:"",
		index:"1",
		callback:supplyRebuildTable
}


$(function(){
	 $(".pagination-nav").pagination(options);
	 $(".supply-pagination-nav").pagination(supplyOptions);
})

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
		$.zzComfirm.alertError("没有查到数据");
		return;
	}

	
	var str = "";
	var itemType = "";
	for (var i = 0; i < list.length; i++) {
		str += "<tr><td>"+list[i].id ;
		str += "</td><td>" + (list[i].sku==null?"":list[i].sku);
		str += "</td><td>" + (list[i].itemQuantity==null?"":list[i].itemQuantity);
		str += "</td><td>" + (list[i].itemId==null?"":list[i].itemId);
		str += "</td><td>" + (list[i].itemCode==null?"":list[i].itemCode);
		
		switch(list[i].inventoryType){
			case 1: itemType= "可销售库存(正品)";break;
			case 101: itemType= "残次";break;
			case 102: itemType= "机损";break;
			case 103: itemType= "箱损";break;
			case 301: itemType= "在途库存";break;
			case 201: itemType= "冻结库存";break;
			default: itemType= "无";
		}
		
		str += "</td><td>" + (itemType);
		str += "</td><td>" + (list[i].itemName==null?"":list[i].itemName);
		str += "</td><td>" + (list[i].ownerUserId==null?"":list[i].ownerUserId);
		str += "</td><td>" + (list[i].swt==null?"":list[i].swt);
		str += "</td></tr>";
	}
	
	
	$("#itemTable tbody").htmlUpdate(str);
}

/**
* 重构table
*/
function supplyRebuildTable(data){
	$("#supplyItemTable tbody").html("");

	if (data == null || data.length == 0) {
		return;
	}
	
	var list = data.obj;
	
	if (list == null || list.length == 0) {
		$.zzComfirm.alertError("没有查到数据");
		return;
	}

	
	var str = "";
	var itemType = "";
	for (var i = 0; i < list.length; i++) {
		str += "<tr><td>"+list[i].id ;
		str += "</td><td>" + (list[i].sku==null?"":list[i].sku);
		str += "</td><td>" + (list[i].itemQuantity==null?"":list[i].itemQuantity);
		str += "</td><td>" + (list[i].itemId==null?"":list[i].itemId);
		str += "</td><td>" + (list[i].itemCode==null?"":list[i].itemCode);
		
		switch(list[i].inventoryType){
			case 1: itemType= "可销售库存(正品)";break;
			case 101: itemType= "残次";break;
			case 102: itemType= "机损";break;
			case 103: itemType= "箱损";break;
			case 301: itemType= "在途库存";break;
			case 201: itemType= "冻结库存";break;
			default: itemType= "无";
		}
		
		str += "</td><td>" + (itemType);
		str += "</td><td>" + (list[i].itemName==null?"":list[i].itemName);
		str += "</td><td>" + (list[i].ownerUserId==null?"":list[i].ownerUserId);
		str += "</td><td>" + (list[i].swt==null?"":list[i].swt);
		str += "</td></tr>";
	}
	
	
	$("#supplyItemTable tbody").htmlUpdate(str);
}

</script>
</body>
</html>
