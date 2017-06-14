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
<title>订单查询</title>
<%@include file="../../resource.jsp"%>
</head>

<body>
	<div id="page-wrapper">

		<div class="container-fluid">
			<!-- Page Heading -->
			<div class="row">
				<div class="col-lg-12">
					<ol class="breadcrumb">
						<li><i class="fa fa-book fa-fw"></i>订单查询</li>
						<li class="active"><i class="fa fa-bookmark fa-fw"></i>订单详情</li>
					</ol>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="query">
						<div class="row"">
							<div class="form-group">
								<label>买家账号</label> <input type="text" class="form-control"
									name="userName" id="userName" value="${list.userName}" disabled="disabled">
							</div>
							<div class="form-group">
								<label>下单时间</label> <input type="text" class="form-control"
									name="billDate" id="billDate" value="${list.billDate}" disabled="disabled">
							</div>
							<div class="form-group">
								<label>付款时间</label> <input type="text" class="form-control"
									name="paymentDateTime" id="paymentDateTime" value="${list.paymentDateTime}" disabled="disabled">
							</div>
							<div class="form-group">
								<label>支付金额</label> <input type="text" class="form-control"
									name="payment" id="payment"	value="${list.payment}" disabled="disabled">
							</div>
						</div>
						<div class="row">
							<div class="form-group">
								<label>邮政编码</label> <input type="text" class="form-control"
									name="receiverZipCode" id="receiverZipCode" value="${list.receiverZipCode}" disabled="disabled">
							</div>
							<div class="form-group">
								<label>详细地址</label> <input type="text" class="form-control"
									name="receiverAddress" id="receiverAddress"	value="${list.receiverAddress}" disabled="disabled">
							</div>
							<div class="form-group">
								<label>商户名称</label> <input type="text" class="form-control"
									name="sellerName" id="sellerName"	value="${list.sellerName}" disabled="disabled">
							</div>
							<div class="form-group">
								<label>承运商名</label> <input type="text" class="form-control"
									name="carrierName" id="carrierName" value="${list.carrierName}" disabled="disabled">
							</div>
							<div class="form-group">
								<input type="hidden" class="form-control"
									name="orderId" id="orderId" value="${list.orderId}">
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">
								<i class="fa fa-bar-chart-o fa-fw"></i>商品明细
							</h3>
						</div>
						<div class="panel-body">
							<table id="orderDetailTable" class="table table-hover">
								<thead>
									<tr>
										<th>货号</th>
										<th>商品名称</th>
										<th>单价</th>
										<th>数量</th>
										<th>单位</th>
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
			url : "${wmsUrl}/admin/order/dataOrderDetailList.shtml",
			numPerPage : "10",
			currentPage : "",
			index : "1",
			callback : rebuildTable
		}

		$(function() {
			$(".pagination-nav").pagination(options);
		})

		/**
		 * 重构table
		 */
		function rebuildTable(data) {
			$("#orderDetailTable tbody").html("");

			if (data == null || data.length == 0) {
				return;
			}

			var list = data.obj;

			//跳过查询
			if (data.errTrace == "Search.") {
				return;
			} else if (data.errTrace != null) {
				$.zzComfirm.alertError(data.errTrace);
				return;
			}

			if (list == null || list.length == 0) {
				$.zzComfirm.alertError("没有查到数据");
				return;
			}

			var str = "";
			var strCom = "";
			for (var i = 0; i < list.length; i++) {
				str += "<tr><td align='left'>" + list[i].sku;
				str += "</td><td align='left'>" + list[i].itemName;
				str += "</td><td align='left'>" + list[i].itemPrice;
				str += "</td><td align='left'>" + list[i].itemQuantity;
				str += "</td><td align='left'>" + list[i].uom;
				str += "</td></tr>";
			}

			$("#orderDetailTable tbody").htmlUpdate(str);
		}
	</script>
</body>
</html>
