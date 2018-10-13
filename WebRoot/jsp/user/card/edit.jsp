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
					<input type="text" class="form-control" name="cardNo" id="cardNo" value="${card.cardNo}">
	                <input type="hidden" class="form-control" name="id" id="id" value="${card.id}">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">开户行名称</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="cardBank" id="cardBank" value="${card.cardBank}">
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
	           	<button type="button" id="submitBtn">保存</button>
	       	</div>
		</form>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script type="text/javascript">	
	
	function checkCardNo(){
		var str = $("#cardNo").val();
		str = $.trim(str);
		if (str == "") {
			return;
		}
		$.ajax({
			 url:"${wmsUrl}/admin/user/userCardMng/checkCard.shtml?cardNo="+str,
			 type:'post',
// 			 data:{cardNo : str},
// 			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){
					 $("#cardBank").val(data.msg);
				 }else{
					 layer.alert(data.msg);
				 }
			 },
			 error:function(){
				 layer.alert("查询失败，请重试");
			 }
		 });
	}
	
	$("#submitBtn").click(function(){
		var strCardNo = $("#cardNo").val();
		strCardNo = $.trim(strCardNo);
		if (strCardNo == "") {
			layer.alert("银行卡号不能为空，请确认");
			return;
		}
		var strCardBank = $("#cardBank").val();
		strCardBank = $.trim(strCardBank);
		if (strCardBank == "") {
			layer.alert("银行名称不能为空，请确认");
			return;
		}
		var strCardName = $("#cardName").val();
		strCardName = $.trim(strCardName);
		if (strCardName == "") {
			layer.alert("持卡人名称不能为空，请确认");
			return;
		}
		var strCardMobile = $("#cardMobile").val();
		strCardMobile = $.trim(strCardMobile);
		if (strCardMobile == "") {
			layer.alert("预留电话不能为空，请确认");
			return;
		}
		 $.ajax({
			 url:"${wmsUrl}/admin/user/userCardMng/update.shtml",
			 type:'post',
			 data:JSON.stringify(sy.serializeObject($('#userBindCardForm'))),
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){	
					 layer.alert("保存成功");
					 parent.layer.closeAll();
					 parent.reloadTable();
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
