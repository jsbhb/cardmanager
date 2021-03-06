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
       		<h1>订单基础信息</h1>
       	</div>
       	<div class="list-item">
			<div class="col-sm-3 item-left">订单编号</div>
			<div class="col-sm-9 item-right">
				<input type="text" class="form-control" readonly  value="${order.orderId}">
			</div>
		</div>
       	<div class="list-item">
			<div class="col-sm-3 item-left">供应商</div>
			<div class="col-sm-9 item-right">
				<input type="text" class="form-control" readonly  value="${order.supplierName}">
			</div>
		</div>
       	<div class="list-item">
			<div class="col-sm-3 item-left">消费者编号</div>
			<div class="col-sm-9 item-right">
				<input type="text" class="form-control" readonly  value="${order.userId}">
			</div>
		</div>
       	<div class="list-item">
			<div class="col-sm-3 item-left">消费者名称</div>
			<div class="col-sm-9 item-right">
				<input type="text" class="form-control" readonly  value="${user.userDetail.name}">
			</div>
		</div>
       	<div class="list-item">
			<div class="col-sm-3 item-left">状态</div>
			<div class="col-sm-9 item-right">
				<c:if test="${order.status==0}">待支付</c:if>
                <c:if test="${order.status==1}">已付款</c:if>
                <c:if test="${order.status==2}">支付单报关</c:if>
                <c:if test="${order.status==3}">已发仓库</c:if>
                <c:if test="${order.status==4}">已报海关</c:if>
                <c:if test="${order.status==5}">单证放行</c:if>
                <c:if test="${order.status==6}">已发货</c:if>
                <c:if test="${order.status==7}">已收货</c:if>
                <c:if test="${order.status==8}">退单</c:if>
                <c:if test="${order.status==9}">超时取消</c:if>
                <c:if test="${order.status==11}">资金池不足</c:if>
                <c:choose>
                <c:when test="${order.orderFlag==0}">
                <c:if test="${order.status==12}">海关申报中</c:if>
                </c:when>
                <c:otherwise>
                <c:if test="${order.status==12}">待发货</c:if>
                </c:otherwise>
                </c:choose>
                <c:if test="${order.status==21}">退款中</c:if>
                <c:if test="${order.status==99}">异常状态</c:if>
			</div>
		</div>
       	<div class="list-item">
			<div class="col-sm-3 item-left">创建时间</div>
			<div class="col-sm-9 item-right">
				<input type="text" class="form-control" name="area" readonly value="${order.createTime}">
			</div>
		</div>
       	<div class="list-item">
			<div class="col-sm-3 item-left">操作人</div>
			<div class="col-sm-9 item-right">
				<c:choose>
					<c:when test="${order.opt!=null}">
						<input type="text" class="form-control" name="opt" readonly value="${order.opt}">
					</c:when>
					<c:otherwise>
						<input type="text" class="form-control" name="opt" readonly value="消费者">
					</c:otherwise>
				</c:choose>
			</div>
		</div>
       	<div class="list-item">
			<div class="col-sm-3 item-left">订单来源</div>
			<div class="col-sm-9 item-right">
				<c:choose>
				<c:when test="${order.orderSource==0}">
					<input type="text" class="form-control" readonly value="PC商城">
				</c:when>
				<c:when test="${order.orderSource==1}">
					<input type="text" class="form-control" readonly value="手机商城">
				</c:when>
				<c:when test="${order.orderSource==3}">
					<input type="text" class="form-control" readonly value="有赞">
				</c:when>
				<c:when test="${order.orderSource==4}">
					<input type="text" class="form-control" readonly value="线下">
				</c:when>
				<c:when test="${order.orderSource==5}">
					<input type="text" class="form-control" readonly value="展厅">
				</c:when>
				<c:when test="${order.orderSource==6}">
					<input type="text" class="form-control" readonly value="大客户">
				</c:when>
				<c:when test="${order.orderSource==7}">
					<input type="text" class="form-control" readonly value="福利商城">
				</c:when>
				<c:when test="${order.orderSource==8}">
					<input type="text" class="form-control" readonly value="后台订单">
				</c:when>
				<c:when test="${order.orderSource==9}">
					<input type="text" class="form-control" readonly value="太平惠汇">
				</c:when>
				<c:when test="${order.orderSource==10}">
					<input type="text" class="form-control" readonly value="小程序">
				</c:when>
				<c:when test="${order.orderSource==11}">
					<input type="text" class="form-control" readonly value="聚民惠">
				</c:when>
				<c:when test="${order.orderSource==12}">
					<input type="text" class="form-control" readonly value="拼多多">
				</c:when>
				<c:when test="${order.orderSource==13}">
					<input type="text" class="form-control" readonly value="易捷北京">
				</c:when>
				<c:when test="${order.orderSource==14}">
					<input type="text" class="form-control" readonly value="自营">
				</c:when>
				<c:when test="${order.orderSource==15}">
					<input type="text" class="form-control" readonly value="金融工厂">
				</c:when>
				<c:when test="${order.orderSource==16}">
					<input type="text" class="form-control" readonly value="中信乐益通">
				</c:when>
				<c:when test="${order.orderSource==17}">
					<input type="text" class="form-control" readonly value="波罗蜜">
				</c:when>
				<c:when test="${order.orderSource==18}">
					<input type="text" class="form-control" readonly value="马上消费金融">
				</c:when>
				<c:when test="${order.orderSource==19}">
					<input type="text" class="form-control" readonly value="供销e家">
				</c:when>
				<c:when test="${order.orderSource==20}">
					<input type="text" class="form-control" readonly value="淘宝">
				</c:when>
				<c:otherwise>
					<input type="text" class="form-control" name="area" readonly value="订货平台">
				</c:otherwise>
				</c:choose>
			</div>
		</div>
       	<div class="list-item">
			<div class="col-sm-3 item-left">所属分级</div>
			<div class="col-sm-9 item-right">
				<c:choose>
				<c:when test="${order.shopName!=null}">
					<input type="text" class="form-control" name="area" readonly value="${order.shopName}">
				</c:when>
				<c:otherwise>
					<input type="text" class="form-control" name="area" readonly value="${order.centerName}">
				</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div class="title">
       		<h1>订单详情</h1>
       	</div>
       	<div class="list-item">
			<div class="col-sm-3 item-left">支付类型</div>
			<div class="col-sm-9 item-right">
				<c:if test="${order.orderDetail.payType==1}"><input type="text" class="form-control" readonly value="微信"></c:if>
				<c:if test="${order.orderDetail.payType==2}"><input type="text" class="form-control" readonly value="支付宝"></c:if>
				<c:if test="${order.orderDetail.payType==3}"><input type="text" class="form-control" readonly value="银联"></c:if>
				<c:if test="${order.orderDetail.payType==4}"><input type="text" class="form-control" readonly value="转账"></c:if>
				<c:if test="${order.orderDetail.payType==5}"><input type="text" class="form-control" readonly value="其他"></c:if>
				<c:if test="${order.orderDetail.payType==6}"><input type="text" class="form-control" readonly value="月结"></c:if>
			</div>
		</div>
       	<div class="list-item">
			<div class="col-sm-3 item-left">支付金额</div>
			<div class="col-sm-9 item-right">
				<input type="text" class="form-control" readonly  value="<fmt:formatNumber type="number" value="${order.orderDetail.payment-order.orderDetail.rebateFee}" pattern="0.00" maxFractionDigits="2"/>">
			</div>
		</div>
       	<div class="list-item">
			<div class="col-sm-3 item-left">返佣抵扣</div>
			<div class="col-sm-9 item-right">
				<input type="text" class="form-control" readonly  value="${order.orderDetail.rebateFee}">
			</div>
		</div>
       	<div class="list-item">
			<div class="col-sm-3 item-left">税费</div>
			<div class="col-sm-9 item-right">
				<input type="text" class="form-control" readonly  value="${order.orderDetail.taxFee}">
			</div>
		</div>
       	<div class="list-item">
			<div class="col-sm-3 item-left">邮费</div>
			<div class="col-sm-9 item-right">
				<input type="text" class="form-control" readonly  value="${order.orderDetail.postFee}">
			</div>
		</div>
       	<div class="list-item">
			<div class="col-sm-3 item-left">消费税</div>
			<div class="col-sm-9 item-right">
				<input type="text" class="form-control" readonly  value="${order.orderDetail.exciseTax}">
			</div>
		</div>
       	<div class="list-item">
			<div class="col-sm-3 item-left">增值税</div>
			<div class="col-sm-9 item-right">
				<input type="text" class="form-control" readonly  value="${order.orderDetail.incrementTax}">
			</div>
		</div>
       	<div class="list-item">
			<div class="col-sm-3 item-left">支付时间</div>
			<div class="col-sm-9 item-right">
				<input type="text" class="form-control" readonly  value="${order.orderDetail.payTime}">
			</div>
		</div>
       	<div class="list-item">
			<div class="col-sm-3 item-left">交易流水号</div>
			<div class="col-sm-9 item-right">
				<input type="text" class="form-control" readonly  value="${order.orderDetail.payNo}">
			</div>
		</div>
		<div class="title">
       		<h1>物流信息</h1>
       	</div>
       	<c:if test="${orderExpressList!=null}">
			<c:forEach var="express" items="${orderExpressList}">
		       	<div class="list-item">
					<div class="col-sm-3 item-left">快递公司</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" readonly  value="${express.expressName}">
					</div>
				</div>
		       	<div class="list-item">
					<div class="col-sm-3 item-left">快递单号</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" readonly  value="${express.expressId}">
					</div>
				</div>
			</c:forEach>
		</c:if>
		<div class="title">
       		<h1>收货人信息</h1>
       	</div>
       	<div class="list-item">
			<div class="col-sm-3 item-left">名称</div>
			<div class="col-sm-9 item-right">
				<input type="text" class="form-control" readonly  value="${order.orderDetail.receiveName}">
			</div>
		</div>
       	<div class="list-item">
			<div class="col-sm-3 item-left">电话</div>
			<div class="col-sm-9 item-right">
				<input type="text" class="form-control" readonly  value="${order.orderDetail.receivePhone}">
			</div>
		</div>
       	<div class="list-item">
			<div class="col-sm-3 item-left">收货地址</div>
			<div class="col-sm-9 item-right">
				<input type="text" class="form-control" readonly  value="${order.orderDetail.receiveProvince}${order.orderDetail.receiveCity}${order.orderDetail.receiveArea}">
			</div>
		</div>
       	<div class="list-item">
			<div class="col-sm-3 item-left">详细地址</div>
			<div class="col-sm-9 item-right">
				<input type="text" class="form-control" readonly  value="${order.orderDetail.receiveAddress}">
			</div>
		</div>
       	<div class="list-item">
			<div class="col-sm-3 item-left">买家留言</div>
			<div class="col-sm-9 item-right">
				<input type="text" class="form-control" readonly  value="${order.remark}">
			</div>
		</div>
       	<div class="list-item">
			<div class="col-sm-3 item-left">收货时间</div>
			<div class="col-sm-9 item-right">
				<input type="text" class="form-control" readonly  value="${order.deliveryTime}">
			</div>
		</div>
		<div class="title">
       		<h1>订单商品</h1>
       	</div>
		<div class="list-content" style="padding-bottom:40px; min-height:0;">
			<div class="row">
				<div class="col-md-12">
					<table id="goodsTable" class="table table-hover myClass">
						<thead>
							<tr>
								<th>商品编号</th>
								<th>商家编码</th>
								<th>自有编码</th>
								<th>商品名称</th>
								<th>商品规格</th>
								<th>商品价格</th>
								<th>实际价格</th>
								<th>数量</th>
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
		url :  "${wmsUrl}/admin/order/stockOutMng/dataListForOrderGoods.shtml?orderId="+"${order.orderId}",
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
			str += "</td><td>" + list[i].itemId;
			str += "</td><td>" + list[i].itemCode;
			str += "</td><td>" + list[i].sku;
			str += "</td><td>" + list[i].itemName;
			str += "</td><td>" + (list[i].itemInfo == null ? "" :list[i].itemInfo);
			str += "</td><td>" + list[i].itemPrice;
			str += "</td><td>" + list[i].actualPrice;
			str += "</td><td>" + list[i].itemQuantity;
			str += "</td></tr>";
		}

		$("#goodsTable tbody").html(str);
	}
	</script>
</body>
</html>