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
<title>新增商品</title>
<%@include file="../resource.jsp" %>
</head>

<body>
	<div id="page-wrapper">
		<div class="container-fluid">
			<form role="form" id="goodsForm">
				<table class="table table-bordered">
					<tr>
						<td>
							<label>货号:</label></td><td><input type='text' class="form-control" id="sku" name="sku" readonly value="${preGood.sku}">
							<input type='hidden' class="form-control" id="id" name="id" readonly value="${preGood.id}">
						</td>
						<td><label>商品名称:</label></td><td><input type='text' class="form-control" id="skuName" name="skuName" value="${preGood.skuName}" readonly></td>		 
					</tr>
					<tr>
						<c:if test="${preGood==null}">
						<td><label>商品编码:</label></td>
						<td>
							<input type='text' class="form-control" id="itemCode" name="itemCode" value="${preGood.itemCode}" readonly>
							<button type="button" class="btn btn-primary" onclick="showSupplierGoods()">商家商品</button>
						</td>
						</c:if>
						<td><label>数量:</label></td>
						<td>
							<input type='text' class="form-control" id="quantity" name="quantity" value="${preGood.quantity}" onblur="checkQuantity(this)">
						</td>	 
					</tr>
					<tr>
						<td><label>备注:</label></td><td colspan="3"><input type='text' class="form-control" id="remark" name="remark" value="${preGood.remark}"  ></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	
	<div class="modal fade" id="supplierGoodsModal" tabindex="-1" role="dialog" aria-hidden="true">
	   <div class="modal-dialog"  >
	      <div class="modal-content"  >
	         <div class="modal-header">
	         	<h4 class="modal-title" id="modelTitle">商家商品库</h4>
	         </div>
	         <div class="modal-body"  > 
	         	<iframe id="supplierGoodsIFrame" width="100%" height="100%" frameborder="0"></iframe>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeSupplierGoodsModal()">取消 </button>
	         </div>
	      </div>
		</div>
	</div>

<script type="text/javascript">

function submitForm() {
	
	var quantity = $("#quantity").val();
	if(isNaN(quantity)){
		$.zzComfirm.alertError("商品数量有误请重新输入！！");
		return false;
	}
	
	var reg = /^([1-9]\d*|[0]{1,1})$/;
	if(!reg.test(quantity)){
		$.zzComfirm.alertError("请输入正整数！！");
		isCorrected = false;
		return false;
	}
	
	if(quantity==0||quantity==""){
		$.zzComfirm.alertError("未输入商品数量！！");
		return false;
	}
	
	$.ajax({
		 url:"${wmsUrl}/admin/prePackage/prePacMng/savePreGoods.shtml?pid=${prePacInfo.pid}",
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
	 $("#sku").val("");
	 $("#itemCode").val("");
	 $("#skuName").val("");
	 $("#quantity").val("");
	 $("#remark").val("");
}

function closeSupplierGoodsModal(){
	$("#supplierGoodsModal").modal("hide");
}

function showSupplierGoods(){
	var supplierId = "${prePacInfo.supplierId}";
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
		 url:"${wmsUrl}/admin/basic/sellerInfo/supplierGoods.shtml?itemId="+itemId+"&itemCode="+itemCode,
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
				 
				 $("#sku").val(result[0].sku==null?"":result[0].sku);
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

function checkQuantity(obj){
	var value =  $(obj).val();
	if(value==null||value==""){
		$.zzComfirm.alertError("未输入商品数量！！");
		return;
	}	
	var reg = /^([1-9]\d*|[0]{1,1})$/;
	if(!reg.test(value)){
		$.zzComfirm.alertError("请输入正整数！！");
		isCorrected = false;
		return false;
	}
	if(isNaN(value)){
		$.zzComfirm.alertError("非法数字！")
		$(obj).val("");
	}
}
</script>
</body>
</html>
