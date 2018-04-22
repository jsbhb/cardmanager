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
        <form class="form-horizontal" role="form" id="userBindCardForm" >
        	<div class="title">
	       		<h1>银行卡信息</h1>
	       	</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">银行卡号</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="cardNo" id="cardNo" onblur="checkCardNo()" value="${card.cardNo}">
	                <input type="hidden" class="form-control" name="id" id="id" value="${card.id}">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">银行名称</div>
				<div class="col-sm-9 item-right">
					<input type="text" readonly class="form-control" name="cardBank" id="cardBank" value="${card.cardBank}">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">持卡人姓名</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="cardName" id="cardName" value="${card.cardName}">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">预留电话</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="cardMobile" id="cardMobile" value="${card.cardMobile}">
				</div>
			</div>
	        <div class="submit-btn">
	           	<button type="button" id="submitBtn">解绑</button>
	       	</div>
		</form>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script type="text/javascript">	
	$("#submitBtn").click(function(){
		 $.ajax({
			 url:"${wmsUrl}/admin/user/userCardMng/delete.shtml",
			 type:'post',
			 data:JSON.stringify(sy.serializeObject($('#userBindCardForm'))),
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){	
					 layer.alert("解绑成功");
					 parent.layer.closeAll();
					 parent.reloadTable();
				 }else{
					 layer.alert(data.msg);
				 }
			 },
			 error:function(){
				 layer.alert("解绑失败，请联系客服处理");
			 }
		 });
	 });
	</script>
</body>
</html>
