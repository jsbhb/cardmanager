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
	       		<h1>基础信息</h1>
	       	</div>
			<c:if test="${supplierId!=null}">
		       	<div class="list-item">
					<div class="col-sm-3 item-left">供应商</div>
					<div class="col-sm-9 item-right">
						<select class="form-control" name="customerId" id="customerId">
	                   	  <c:forEach var="supplier" items="${supplierId}">
	                   	  	<option value="${supplier.id}">${supplier.supplierName}</option>
	                   	  </c:forEach>
		                </select>
						<input type="hidden" class="form-control" id="customerName" name="customerName" value="${supplierId[0].supplierName}">
						<input type="hidden" class="form-control" id="customerType" name="customerType" value="${customerType}">
					</div>
				</div>
			</c:if>
			<c:if test="${centerId!=null}">
		       	<div class="list-item">
					<div class="col-sm-3 item-left">区域中心</div>
					<div class="col-sm-9 item-right">
						<select class="form-control" name="customerId" id="customerId">
	                   	  <c:forEach var="center" items="${centerId}">
	                   	  	<option value="${center.gradeId}">${center.gradeName}</option>
	                   	  </c:forEach>
		                </select>
						<input type="hidden" class="form-control" id="customerName" name="customerName" value="${centerId[0].gradeName}">
						<input type="hidden" class="form-control" id="customerType" name="customerType" value="${customerType}">
					</div>
				</div>
			</c:if>
			<div class="list-item">
				<div class="col-sm-3 item-left">支付类型</div>
				<div class="col-sm-9 item-right">
					<select class="form-control" name="payType" id="payType">
                   	  <option selected="selected" value="0">收入</option>
                   	  <option value="1">支出</option>
	                </select>
				</div>
			</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">支付流水号</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" id="payNo" name="payNo">
				</div>
			</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">金额</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" id="money" name="money">
				</div>
			</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">备注</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" id="remark" name="remark">
				</div>
			</div>
			<div class="title">
	       		<h1>业务信息</h1>
	       	</div>
			<div class="row">
				<div class="col-md-10 list-btns">
					<button type="button" id="newItemBtn">新增业务信息</button>
				</div>
			</div>
			<div id="itemInfo">
		       	<div class="list-item">
					<div class="col-sm-3 item-left">订单号</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="orderId">
					</div>
				</div>
		       	<div class="list-item">
					<div class="col-sm-3 item-left">商品编号</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="itemId">
					</div>
				</div>
		       	<div class="list-item">
					<div class="col-sm-3 item-left">商家编码</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="itemCode">
					</div>
				</div>
		       	<div class="list-item">
					<div class="col-sm-3 item-left">商品数量</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="itemQuantity">
					</div>
				</div>
		       	<div class="list-item">
					<div class="col-sm-3 item-left">商品价格</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="itemPrice">
					</div>
				</div>
		       	<div class="list-item">
					<div class="col-sm-3 item-left">商品条形码</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="itemEncode">
					</div>
				</div>
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
	
	$("#customerId").change(function(){
		var options=$("#customerId option:selected");
		var customerName = options.text();
		$("#customerName").val(customerName);
	});
	
	$("#newItemBtn").click(function(){
		var ht = '<div class="list-item"><div class="col-sm-3 item-left">订单号</div><div class="col-sm-9 item-right"><input type="text" class="form-control" name="orderId"></div></div>';
		ht = ht + '<div class="list-item"><div class="col-sm-3 item-left">商品编号</div><div class="col-sm-9 item-right"><input type="text" class="form-control" name="itemId"></div></div>';
		ht = ht + '<div class="list-item"><div class="col-sm-3 item-left">商家编码</div><div class="col-sm-9 item-right"><input type="text" class="form-control" name="itemCode"></div></div>';
		ht = ht + '<div class="list-item"><div class="col-sm-3 item-left">商品数量</div><div class="col-sm-9 item-right"><input type="text" class="form-control" name="itemQuantity"></div></div>';
		ht = ht + '<div class="list-item"><div class="col-sm-3 item-left">商品价格</div><div class="col-sm-9 item-right"><input type="text" class="form-control" name="itemPrice"></div></div>';
		ht = ht + '<div class="list-item"><div class="col-sm-3 item-left">商品条形码</div><div class="col-sm-9 item-right"><input type="text" class="form-control" name="itemEncode"></div></div>';
		$('#itemInfo').append(ht);
	 });
	
	$('#itemForm').bootstrapValidator({
	//   live: 'disabled',
	   message: 'This value is not valid',
	   feedbackIcons: {
	       valid: 'glyphicon glyphicon-ok',
	       invalid: 'glyphicon glyphicon-remove',
	       validating: 'glyphicon glyphicon-refresh'
	   },
	   fields: {
		  money:{
			   message: '金额不正确',
			   validators: {
				   notEmpty: {
					   message: '金额不能为空'
				   },
				   numeric: {
					   message: '金额只能输入数字'
				   }
			   }
		  }
	   }
	});
	
	$("#submitBtn").click(function(){
		$('#itemForm').data("bootstrapValidator").validate();
		 if($('#itemForm').data("bootstrapValidator").isValid()){
			var customerId = $("#customerId").val();
	    	var customerName = $("#customerName").val();
	    	var customerType = $("#customerType").val();
	    	var payType = $("#payType").val();
	    	var money = $("#money").val();
	    	if (money <= 0) {
	    		layer.alert("金额必须大于0");
	    		return;
	    	}
	    	var payNo = $("#payNo").val();
	    	var remark = $("#remark").val();

			var data = [];
	    	var tmpStr = "";
	    	$("input[name='orderId']").each(function(){
	    		tmpStr+=$(this).val()+',';
		    });
	    	orderIdObj = tmpStr.substring(0,tmpStr.length-1).split(",");
	    	tmpStr = "";
	    	$("input[name='itemId']").each(function(){
	    		tmpStr+=$(this).val()+',';
		    });
	    	itemIdObj = tmpStr.substring(0,tmpStr.length-1).split(",");
	    	tmpStr = "";
	    	$("input[name='itemCode']").each(function(){
	    		tmpStr+=$(this).val()+',';
		    });
	    	itemCodeObj = tmpStr.substring(0,tmpStr.length-1).split(",");
	    	tmpStr = "";
	    	$("input[name='itemQuantity']").each(function(){
	    		tmpStr+=$(this).val()+',';
		    });
	    	itemQuantityObj = tmpStr.substring(0,tmpStr.length-1).split(",");
	    	tmpStr = "";
	    	$("input[name='itemPrice']").each(function(){
	    		tmpStr+=$(this).val()+',';
		    });
	    	itemPriceObj = tmpStr.substring(0,tmpStr.length-1).split(",");
	    	tmpStr = "";
	    	$("input[name='itemEncode']").each(function(){
	    		tmpStr+=$(this).val()+',';
		    });
	    	itemEncodeObj = tmpStr.substring(0,tmpStr.length-1).split(",");
	    	for(i=0;i<orderIdObj.length;i++){
		    	data.push({
	    			'orderId': orderIdObj[i],
	    			'itemId': itemIdObj[i],
	    			'itemCode': itemCodeObj[i],
	    			'itemQuantity': itemQuantityObj[i],
	    			'itemPrice': itemPriceObj[i],
	    			'itemEncode': itemEncodeObj[i]
	    		});
		    }
	    	
	    	var formData={};
	    	formData["customerId"] = customerId;
	    	formData["customerName"] = customerName;
	    	formData["customerType"] = customerType;
	    	formData["payType"] = payType;
	    	formData["money"] = money;
	    	formData["payNo"] = payNo;
	    	formData["remark"] = remark;
	    	formData["itemList"] = data;
	    	
			$.ajax({
				url:"${wmsUrl}/admin/finance/capitalPoolMng/addCapitalPoolInfo.shtml",
				type:'post',
				contentType: "application/json; charset=utf-8",
				dataType:'json',
				data : JSON.stringify(formData),
				success:function(data){
					if(data.success){
						parent.layer.closeAll();
						parent.location.reload();
					}else{
						layer.alert(data.msg);
					}
				},
				error:function(){
					layer.alert("提交失败，请联系客服处理");
				}
			});
		 }
	 });
	</script>
</body>
</html>