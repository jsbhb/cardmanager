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
</head>

<body>
	<section class="content-iframe content">
		<form class="form-horizontal" role="form" id="gradeForm">
			<div class="title">
	       		<h1>提现申请</h1>
	       	</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">角色名称</div>
				<div class="col-sm-9 item-right">
           			<input type="text" readonly class="form-control" name="operatorName"value="${opt.gradeName}">
	               	<input type="hidden" readonly class="form-control" name="operatorId" id="operatorId" value="${typeId}">
	               	<input type="hidden" readonly class="form-control" name="operatorType" id="operatorType" value="${type}">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">可提现金额</div>
				<div class="col-sm-9 item-right">
           			<input type="text" readonly class="form-control" name="startMoney" id="startMoney" value="${info.canBePresented}">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">提现金额</div>
				<div class="col-sm-9 item-right">
           			<input type="text" class="form-control" name="outMoney" id="outMoney" value="0">
				</div>
			</div>
			<div class="title">
	       		<h1>银行卡信息</h1>
	       	</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">银行卡列表</div>
				<div class="col-sm-9 item-right">
           			<select class="form-control" name="cardId" id="cardId">
                   	  <c:forEach var="card" items="${cards}">
           	  			<option value="${card.cardNo}#${card.cardName}#${card.cardBank}">${card.cardBank}</option>
                   	  </c:forEach>
	              	</select>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">银行名称</div>
				<div class="col-sm-9 item-right">
           			<input type="text" readonly class="form-control" name="cardBank" id="cardBank" value="${card.cardBank}">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">银行卡号</div>
				<div class="col-sm-9 item-right">
           			<input type="text" readonly class="form-control" name="cardNo" id="cardNo" value="${card.cardNo}">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">持卡人姓名</div>
				<div class="col-sm-9 item-right">
           			<input type="text" readonly class="form-control" name="cardName" id="cardName" value="${card.cardName}">
				</div>
			</div>
	        <div class="submit-btn">
	           	<button type="button" id="submitBtn">提交</button>
	       	</div>
		</form>
	</section>
	<%@include file="../../resource.jsp"%>
	<script type="text/javascript">
	
	$("#cardId").change(function(){
		var cardInfo = $("#cardId").val().split("#");
		var cardNo = cardInfo[0];
		var cardName = cardInfo[1];
		var cardBank = cardInfo[2];
		$("#cardNo").val(cardNo);
		$("#cardName").val(cardName);
		$("#cardBank").val(cardBank);
	});
	
	 $("#submitBtn").click(function(){
		 var tmpStartMoney = $("#startMoney").val();
		 var tmpOutMoney = $("#outMoney").val();
		 if (tmpOutMoney <= 0) {
			 layer.alert("提现金额不正确，请重新填写提现金额");
			 return;
		 }
		 if (tmpOutMoney - tmpStartMoney > 0) {
			 layer.alert("提现金额超出可提现金额，请重新填写提现金额");
			 return;
		 }
		 $.ajax({
			 url:"${wmsUrl}/admin/user/userWithdrawalsMng/apply.shtml",
			 type:'post',
			 data:JSON.stringify(sy.serializeObject($('#gradeForm'))),
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){	
					 layer.alert("申请已提交，请等待管理员审核");
					 parent.layer.closeAll();
					 parent.reloadTable();
				 }else{
					 parent.reloadTable();
					 layer.alert(data.msg);
				 }
			 },
			 error:function(){
				 layer.alert("申请提交失败，请重试");
			 }
		 });
  	  });
	
	
	
	</script>
</body>
</html>
