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
<title>绑定入库单</title>
<%@include file="../../resource.jsp" %>
</head>

<body>
	<div id="page-wrapper">
		<div id="mask"></div>
		<div class="container-fluid">
			<form role="form" id="bindForm">
				<table class="table table-bordered">
					<tr>
						<td><label>进货号:</label></td><td><input type='text' value="${sessionScope.bindStockIn.asnStockId}" class="form-control" id="asnStockId" name="asnStockId" disabled></td>	 
						<td><label>入库单号:</label></td><td><input type='text' class="form-control" id="orderCode" name="orderCode" required>
							<button type="button" class="btn btn-primary" onclick="bind()">同步入库单</button>
						</td>
					</tr>
					<tr>
						<td><label>商家编号:</label></td><td><input type='text' value="${sessionScope.bindStockIn.supplierId}" class="form-control" id="supplierId" name="supplierId" disabled></td>	 
						<td><label>商家名称:</label></td><td><input type='text' value="${sessionScope.bindStockIn.supplierName}" class="form-control" id="supplierName" name="supplierName" disabled></td>	 
					</tr>
					<c:forEach items="${sessionScope.bindStockIn.orderCodes}" var = "item">
					<tr>
						<td><label style="color:red">${item}</label></td><td><label>已同步</label></td>	 
					</tr>
					</c:forEach>
					
				</table>
				<div class="row">
					<div class="col-lg-12">
						<table id="asnTable" class="table table-hover">
							<thead>
								<tr>
									<th>货号</th>
									<th>商品编号</th>
									<th>商品编码</th>
									<th>商品名称</th>
									<th>单位</th>
									<th>数量</th>
									<th>净重</th>
									<th>hs编号</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${sessionScope.bindStockIn.asnGoodsPlans}" var = "item">
								<tr>
									<td>${item.sku}</td>
									<td>${item.itemId}</td>
									<td>${item.itemCode}</td>
									<td>${item.goodsName}</td>
									<td>${item.unit}</td>
									<td>${item.quantity}</td>
									<td>${item.swt}</td>
									<td>${item.hsCode}</td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</form>
		</div>
	</div>

<script type="text/javascript">

function submitForm() {

	var asnStockId = $("#asnStockId").val();
	
	$.ajax({
		 url:"${wmsUrl}/admin/stockIn/asnMng/bindAndSave.shtml",
		 type:'post',
		 data:{"asnStockId":asnStockId},
		 dataType:'json',
		 success:function(data){
			 if(data.success){	
				 $.zzComfirm.alertSuccess("创建预进货成功,预进货号："+asnStockId);
				 window.parent.closeBindModal();
			 }else{
				 $.zzComfirm.alertError(data.msg);
			 }
		 },
		 error:function(){
			 $.zzComfirm.alertError("系统出现问题啦，快叫技术人员处理");
		 }
	 });
};

function bind(){
	
	var orderCode = $("#orderCode").val();
	
	if(orderCode == null||orderCode ==""){
		$.zzComfirm.alertError("入库单号为空！！");
		return;
	}
	
	$.zzComfirm.startMask();
	
	$.ajax({
		 url:"${wmsUrl}/admin/stockIn/asnMng/bindStockIn.shtml",
		 type:'post',
		 data:{"orderCode":orderCode},
		 dataType:'json',
		 success:function(data){
			 $.zzComfirm.endMask();
			 $("#orderCode").val("");
			 if(data.success){
				 location.reload();
			 }else{
				 $.zzComfirm.alertError(data.msg);
			 }
		 },
		 error:function(){
			 $.zzComfirm.endMask();
			 $.zzComfirm.alertError("系统出现问题啦，快叫技术人员处理");
		 }
	 });
}

</script>
</body>
</html>
