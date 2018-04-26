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
<%@include file="resourceLink.jsp"%>
</head>

<body>
	<section class="content-iframe">
		<form class="form-horizontal" role="form" id="modifyForm"  style="margin-top:20px;">
			<div class="list-item">
				<div class="col-xs-3 item-left">旧密码</div>
				<div class="col-xs-9 item-right">
					<input type="text" class="form-control" name="oldPwd">
				</div>
			</div>
			<div class="list-item">
				<div class="col-xs-3 item-left">新密码</div>
				<div class="col-xs-9 item-right">
					<input type="text" class="form-control" name="newPwd">
				</div>
			</div>
			<div class="list-item">
				<div class="col-xs-3 item-left">确认密码</div>
				<div class="col-xs-9 item-right">
					<input type="text" class="form-control" name="chkPwd">
				</div>
			</div>
	        <div class="submit-btn">
	           	<button type="button" id="submitBtn">保存</button>
	       	</div>
		</form>
	</section>
	<%@include file="resourceScript.jsp"%>
	<script type="text/javascript">
	 $("#submitBtn").click(function(){
		 var oldPwd = modifyForm.oldPwd.value;
		 var newPwd = modifyForm.newPwd.value;
		 var chkPwd = modifyForm.chkPwd.value;
		 if (oldPwd == null || oldPwd == "") {
			 layer.alert("请输入旧密码");
			 return;
		 }
		 if (newPwd == null || newPwd == "") {
			 layer.alert("请输入新密码");
			 return;
		 }
		 if (chkPwd == null || chkPwd == "") {
			 layer.alert("请输入确认密码");
			 return;
		 }
		 if (chkPwd != newPwd) {
			 layer.alert("两次新密码输入不一致，请确认");
			 return;
		 }
		 
		 $.ajax({
			 url:"${wmsUrl}/admin/chkModifyPwd.shtml",
			 type:'post',
			 data:JSON.stringify(sy.serializeObject($('#modifyForm'))),
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){	
					 layer.alert("提交成功");
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
		 
	 });
	</script>
</body>
</html>
