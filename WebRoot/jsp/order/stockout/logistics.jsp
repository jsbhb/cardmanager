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
		<div class="list-content">
			<div class="title">
	       		<h1>订单基础信息</h1>
	       	</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">订单编号</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" readonly name="orderId" value="${order.orderId}">
				</div>
			</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">供应商</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" readonly name="supplierName" value="${order.supplierName}">
				</div>
			</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">状态</div>
				<div class="col-sm-9 item-right">
	                <c:if test="${order.status==1}">已付款</c:if>
	                <c:if test="${order.status==2}">支付单报关</c:if>
	                <c:if test="${order.status==3}">已发仓库</c:if>
	                <c:if test="${order.status==4}">已报海关</c:if>
	                <c:if test="${order.status==5}">单证放行</c:if>
	                <c:if test="${order.status==12}">已支付</c:if>
	                <c:if test="${order.status==99}">异常状态</c:if>
				</div>
			</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">创建时间</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" readonly name="createTime" value="${order.createTime}">
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
					<c:otherwise>
						<input type="text" class="form-control" readonly value="订货平台">
					</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="title">
	       		<h1>物流信息</h1>
	       	</div>
			<div class="row">
				<div class="col-md-10 list-btns">
					<button type="button" id="newLogisticsBtn">新增物流信息</button>
				</div>
			</div>
			<div id="logisticsInfo">
		       	<c:if test="${orderExpressList!=null}">
					<c:forEach var="express" items="${orderExpressList}">
				       	<div class="list-item">
							<div class="col-sm-3 item-left">快递公司</div>
							<div class="col-sm-9 item-right">
								<input type="text" class="form-control" name="expressName" value="${express.expressName}">
								<input type="text" hidden="hidden" class="form-control" name="thirdInfoId" value="${express.id}">
							</div>
						</div>
				       	<div class="list-item">
							<div class="col-sm-3 item-left">快递单号</div>
							<div class="col-sm-9 item-right">
								<input type="text" class="form-control" name="expressId" value="${express.expressId}">
							</div>
						</div>
					</c:forEach>
				</c:if>
	       	</div>
       	</div>
		
        <div class="submit-btn">
           	<button type="button" id=submitBtn>保存信息</button>
       	</div>
		</form>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
	<script type="text/javascript">
	
	$("#newLogisticsBtn").click(function(){
		var ht = '<div class="list-item"><div class="col-sm-3 item-left">快递公司</div><div class="col-sm-9 item-right"><select class="form-control" name="expressNameK">';
		ht = ht + '<option value="SF">顺丰速运</option>';
		ht = ht + '<option value="HTKY">百世快递</option>';
		ht = ht + '<option value="ZTO">中通快递</option>';
		ht = ht + '<option value="STO">申通快递</option>';
		ht = ht + '<option value="YTO">圆通速递</option>';
		ht = ht + '<option value="YD">韵达速递</option>';
		ht = ht + '<option value="EMS">EMS</option>';
		ht = ht + '<option value="HHTT">天天快递</option>';
		ht = ht + '<option value="QFKD">全峰快递</option>';
		ht = ht + '<option value="GTO">国通快递</option>';
		ht = ht + '<option value="UC">优速快递</option>';
		ht = ht + '<option value="DBL">德邦</option>';
		ht = ht + '</select></div></div>';
		ht = ht + '<div class="list-item"><div class="col-sm-3 item-left">快递单号</div><div class="col-sm-9 item-right"><input type="text" class="form-control" name="expressIdV"></div></div>';
		$('#logisticsInfo').append(ht);
	 });
	
	$("#submitBtn").click(function(){
		 
		 $.ajax({
			 url:"${wmsUrl}/admin/order/stockOutMng/updateLogistics.shtml",
			 type:'post',
			 data:JSON.stringify(sy.serializeObject($('#itemForm'))),
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){
					 
				 }else{
					 layer.alert(data.msg);
				 }
			 },
			 error:function(){
				 layer.alert("提交失败，请联系客服处理");
			 }
		 });
	 });
	</script>
</body>
</html>