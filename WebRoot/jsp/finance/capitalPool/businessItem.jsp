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
	<section class="content-iframe content">
		<form class="form-horizontal" role="form" id="itemForm">
		<div class="title">
       		<h1>基础信息</h1>
       	</div>
       	<div class="list-item">
			<div class="col-sm-3 item-left">客户名称</div>
			<div class="col-sm-9 item-right">
				<input type="text" class="form-control" readonly value="${capitalManagementDetail.customerName}">
			</div>
		</div>
       	<div class="list-item">
			<div class="col-sm-3 item-left">支付类型</div>
			<div class="col-sm-9 item-right">
				<c:choose>
				<c:when test="${capitalManagementDetail.payType==0}">
					<input type="text" class="form-control" readonly value="充值">
				</c:when>
				<c:otherwise>
					<input type="text" class="form-control" readonly value="消费">
				</c:otherwise>
				</c:choose>
			</div>
		</div>
       	<div class="list-item">
			<div class="col-sm-3 item-left">支付流水号</div>
			<div class="col-sm-9 item-right">
				<input type="text" class="form-control" readonly value="${capitalManagementDetail.payNo}">
			</div>
		</div>
       	<div class="list-item">
			<div class="col-sm-3 item-left">金额</div>
			<div class="col-sm-9 item-right">
				<input type="text" class="form-control" readonly value="${capitalManagementDetail.money}">
			</div>
		</div>
       	<div class="list-item">
			<div class="col-sm-3 item-left">备注</div>
			<div class="col-sm-9 item-right">
				<input type="text" class="form-control" readonly value="${capitalManagementDetail.remark}">
			</div>
		</div>
       	<div class="list-item">
			<div class="col-sm-3 item-left">业务流水号</div>
			<div class="col-sm-9 item-right">
				<input type="text" class="form-control" readonly value="${capitalManagementDetail.businessNo}">
			</div>
		</div>
		<div class="title">
       		<h1>业务信息</h1>
       	</div>
		<div class="list-content" style="padding-bottom:40px; min-height:0;">
			<div class="row">
				<div class="col-md-12">
					<table id="goodsTable" class="table table-hover myClass">
						<thead>
							<tr>
								<th>订单号</th>
								<th>商品名称</th>
								<th>商品编号</th>
								<th>商家编码</th>
								<th>商品数量</th>
								<th>商品价格</th>
								<th>条形码</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
			</div>
		</div>	
		<div class="pagination-nav">
			<ul id="pagination" class="pagination">
			</ul>
		</div>
		</form>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
	<script type="text/javascript">
	
	/**
	 * 初始化分页信息
	 */
	var options = {
		queryForm : ".query",
		url :  "${wmsUrl}/admin/finance/capitalPoolMng/dataListByBusinessNo.shtml?businessNo="+"${capitalManagementDetail.businessNo}",
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
		$("#goodsTable tbody").html("");

		if (data == null || data.length == 0) {
			return;
		}
		
		var list = data.obj;
		var str = "";
		
		if (list == null || list.length == 0) {
			str = "<tr style='text-align:center'><td colspan=7><h5>没有查到数据</h5></td></tr>";
			$("#goodsTable tbody").html(str);
			return;
		}

		for (var i = 0; i < list.length; i++) {
			str += "<tr>";
			str += "</td><td>" + list[i].orderId;
			str += "</td><td>" + list[i].goodsName;
			str += "</td><td>" + list[i].itemId;
			str += "</td><td>" + list[i].itemCode;
			str += "</td><td>" + (list[i].itemQuantity == null ? "" : list[i].itemQuantity);
			str += "</td><td>" + (list[i].itemPrice == null ? "" : list[i].itemPrice);
			str += "</td><td>" + list[i].itemEncode;
			str += "</td></tr>";
		}

		$("#goodsTable tbody").html(str);
	}
	</script>
</body>
</html>