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
<title>新增盘点商品</title>
<%@include file="../../resource.jsp" %>
</head>

<body>
	<div id="page-wrapper">
		<div class="container-fluid">
			<form role="form" id="goodsForm">
				<table class="table table-bordered">
					<tr>
						<td><label>商品编号:</label></td><td><input type='text' class="form-control" value="${checkItem.itemId}" id="itemId" name="itemId" readonly></td>	
						<td><label>商品编码:</label></td>
						<td>
							<input type='text' class="form-control" id="itemCode" name="itemCode" value="${checkItem.itemCode}" readonly>
							<c:if test="${checkItem==null}">
								<button type="button" class="btn btn-primary" onclick="showSupplierGoods()">商家商品</button>
							</c:if>
						</td>	 
					</tr>
					<tr>
						<td><label>店铺编码:</label></td><td><input type='text' class="form-control" value="${checkItem.ownerUserId}" id="ownerUserId" name="ownerUserId" readonly>	
							<input type='hidden' class="form-control" id="id" name="id" readonly value="${checkItem.id}">
						</td>
						<td><label>数量:</label></td><td><input type='text' class="form-control" id="quantity" name="quantity" value="${checkItem.quantity}"></td>
					</tr>
					<tr>
						<td><label>盘点类型:</label></td>
						<td>
							<select name="type"  class="form-control span2" id="orderType">
								<c:choose>
									<c:when test="${checkItem==null}">
										<option value="1" selected>盘盈</option>
										<option value="2">盘亏</option>
										<option value="3">盘次品</option>
									</c:when>
									<c:otherwise>
										<c:if test="${checkItem.type==1}">
											<option value="1" selected>盘盈</option>
											<option value="2">盘亏</option>
											<option value="3">盘次品</option>
										</c:if>
										<c:if test="${checkItem.type==2}">
											<option value="1">盘盈</option>
											<option value="2" selected>盘亏</option>
											<option value="3">盘次品</option>
										</c:if>
										<c:if test="${checkItem.type==3}">
											<option value="1">盘盈</option>
											<option value="2">盘亏</option>
											<option value="3" selected>盘次品</option>
										</c:if>
										
									</c:otherwise>
								</c:choose>
								
							</select>
						</td>
						<td><label>备注:</label></td><td><input type='text' class="form-control" id="remark" name="remark" value="${checkItem.remark}"></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	
	<div class="modal fade" id="supplierGoodsModal" tabindex="-1" role="dialog" aria-hidden="true">
	   <div class="modal-dialog">
	      <div class="modal-content">
	         <div class="modal-header">
	         	<h4 class="modal-title" id="modelTitle">商家商品库</h4>
	         </div>
	         <div class="modal-body">
	         	<iframe id="supplierGoodsIFrame" frameborder="0"></iframe>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeSupplierGoodsModal()">取消 </button>
	         </div>
	      </div>
		</div>
	</div>

<script type="text/javascript">
$(".dataPicker").datetimepicker({format: 'yyyy-mm-dd'});

function submitForm() {
	
	var itemCode = $("#itemCode").val();
	
	if(itemCode==null||itemCode==""){
		$.zzComfirm.alertError("没有商品信息！");
		return false;
	}
	
	var quantity = $("#quantity").val();
	if(isNaN(quantity)){
		$.zzComfirm.alertError("商品数量有误请重新输入！！");
		return false;
	}
	
	if(quantity==0||quantity==""){
		$.zzComfirm.alertError("未输入商品数量！！");
		return false;
	}
	
	$.ajax({
		 url:"${wmsUrl}/admin/stock/cnCheck/saveCheckItem.shtml?checkId=${check.id}",
		 type:'post',
		 data:sy.serializeObject($('#goodsForm')),
		 dataType:'json',
		 success:function(data){
			 if(data.success){	
				 $.zzComfirm.alertSuccess("保存商品成功");
				 window.parent.reloadTable();
				 window.parent.closeAddModal();
			 }else{
				 clearForm();
				 $.zzComfirm.alertError(data.msg);
			 }
		 },
		 error:function(){
			 $.zzComfirm.alertError("系统出现问题啦，快叫技术人员处理");
		 }
	 });
};

function clearForm(){
	 $("#ownerUserId").val("ownerUserId");
	 $("#itemId").val("");
	 $("#itemCode").val("");
	 $("#skuName").val("");
	 $("#quantity").val("");
	 $("#remark").val("");
}

function closeSupplierGoodsModal(){
	$("#supplierGoodsModal").modal("hide");
}

function showSupplierGoods(){
	var supplierId = "${check.supplierId}";
	if(supplierId==null||supplierId==""){
		$.zzComfirm.alertError("请先选择商家");
		return;
	}
	
    var frameSrc = "${wmsUrl}/admin/basic/sellerInfo/showSupplierGoods.shtml?supplierId="+supplierId;
    $("#supplierGoodsIFrame").attr("src", frameSrc);
    $('#supplierGoodsModal').modal({ show: true, backdrop: 'static' });
}

function closeSupGoodsModal(){
	$('#supplierGoodsModal').modal('hide');
}

function addSupGoods(selectTr){
	var itemId = selectTr.children("td").eq(0).text();
	var itemCode = selectTr.children("td").eq(1).text();
	
	$.ajax({
		 url:"${wmsUrl}/admin/basic/sellerInfo/supplierGoods.shtml?itemId="+itemId+"&itemCode="+itemCode+"&asnStockId=${asnStock.asnStockId}",
		 type:'post',
		 data:{},
		 dataType:'json',
		 success:function(data){
			 if(data.success){
				 var result = data.obj;
				 
				 if(result == null||result.length == 0){
					 $.zzComfirm.alertError("未选中商品！！");
					 return;
				 }
				 
				 $("#ownerUserId").val(result[0].ownerUserId==null?"":result[0].ownerUserId);
				 $("#itemId").val(result[0].itemId==null?"":result[0].itemId);
				 $("#itemCode").val(result[0].itemCode==null?"":result[0].itemCode);
				 $("#skuName").val(result[0].skuName==null?"":result[0].skuName);
				 $("#quantity").val("");
				 $("#remark").val("");
				 closeSupGoodsModal();
			 }else{
				 $.zzComfirm.alertError(result.errTrace);
			 }
		 },
		 error:function(){
			 $.zzComfirm.alertError("系统出现问题啦，快叫技术人员处理");
		 }
	 });
}

function checkMoney(){
	var reg = /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/;
    if (!reg.test($("#currencyValue").val())) {
    	$("#currencyValue").val("");
    	$.zzComfirm.alertError("非法货值！");
    	return;
    }
}

function checkQuantity(obj){
	var value =  $(obj).val();
	if(value==null||value==""){
		return;
	}	
	
	if(isNaN(value)){
		$.zzComfirm.alertError("非法数字！")
		$(obj).val("");
	}
}
</script>
</body>
</html>
