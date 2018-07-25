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
	       	<div class="list-item">
				<div class="col-sm-3 item-left">区域中心</div>
				<div class="col-sm-9 item-right">
					<select class="form-control" name="customerId" id="customerId">
                   	  <c:forEach var="center" items="${centerId}">
                   	  	<option value="${center.gradeId}">${center.gradeName}</option>
                   	  </c:forEach>
	                </select>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">支付类型</div>
				<div class="col-sm-9 item-right">
					<select class="form-control" name="payType" id="payType" onchange = "change()">
                   	  <option selected="selected" value="0">充值</option>
                   	  <option value="1">消费</option>
	                </select>
	                <div class="item-content">
		             	（充值：增加资金池可用金额；消费：减少资金池可用金额）
		            </div>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">业务类型</div>
				<div class="col-sm-9 item-right">
					<select class="form-control" name="bussinessType" id="bussinessType">
	                </select>
	                <div class="item-content">
		             	（支付类型为充值：可选现金充值和信用充值；支付类型为消费：可选清算）
		            </div>
				</div>
			</div>
	       	<div class="list-item" id="payInfo">
				<div class="col-sm-3 item-left">支付流水号</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" id="payNo" name="payNo">
					<div class="item-content">
		             	（银行转账流水号，没有可不填）
		            </div>
				</div>
			</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">金额</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" id="money" name="money">
	                <div class="item-content">
		             	（当前业务产生的总金额，必填	）
		            </div>
				</div>
			</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">备注</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" id="remark" name="remark">
				</div>
			</div>
       	</div>
		
        <div class="submit-btn">
           	<button type="button" id="submitBtn">保存信息</button>
       	</div>
		</form>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
	<script type="text/javascript">
	var sysnFlg = true;
	
	$(function(){
		change();
	})
	
	$("#bussinessType").change(function(){
		if ($("#bussinessType").val() == 0) {
			$('#payInfo').stop();
			$('#payInfo').slideDown(300);
		} else {
			$('#payInfo').stop();
			$('#payInfo').slideUp(300);
		}
	});
	$("#payType").change(function(){
		if ($("#payType").val() != 0) {
			$('#payInfo').stop();
			$('#payInfo').slideUp(300);
		} else {
			$('#payInfo').stop();
			$('#payInfo').slideDown(300);
		}
	});
	
	function change(){
		var selected = $("#payType option:selected").val();
		$('#bussinessType').html();
		var ht = "";
		if(selected == 0){
			ht = '<option value=\"0\">现金充值</option>';
			ht += '<option value=\"1\">信用充值</option>';
		} else if(selected == 1){
			ht += '<option value=\"3\">清算</option>';
		}
		$('#bussinessType').html(ht);
	 }
	
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
		if (!sysnFlg) {
			return;
		}
		$('#itemForm').data("bootstrapValidator").validate();
		 if($('#itemForm').data("bootstrapValidator").isValid()){
			var customerId = $("#customerId").val();
	    	var payType = $("#payType").val();
	    	var bussinessType = $("#bussinessType").val();
	    	var money = $("#money").val();
	    	if (money < 0) {
	    		layer.alert("金额不能小于0");
	    		return;
	    	}
	    	var payNo = $("#payNo").val();
	    	var remark = $("#remark").val();

			var data = [];
	    	var formData={};
	    	formData["centerId"] = customerId;
	    	formData["bussinessType"] = bussinessType;
	    	formData["payType"] = payType;
	    	formData["money"] = money;
	    	formData["payNo"] = payNo;
	    	formData["remark"] = remark;
	    	
	    	sysnFlg = false;
			$.ajax({
				url:"${wmsUrl}/admin/finance/capitalPoolMng/addCapitalPool.shtml",
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
				},
				complete:function() {
					sysnFlg = true;
				}
			});
		 }
	 });
	</script>
</body>
</html>