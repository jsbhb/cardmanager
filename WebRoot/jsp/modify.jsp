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
	<section class="content">
        <div class="main-content">
			<div class="row">
				<div class="col-xs-12" >
					<form class="form-horizontal" role="form" id="modifyForm" >
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">旧密码<font style="color:red">*</font> </label>
							<div class="col-sm-5">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
		                  			<input type="text" class="form-control" name="oldPwd">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">新密码<font style="color:red">*</font> </label>
							<div class="col-sm-5">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
		                  			<input type="text" class="form-control" name="newPwd">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">确认密码<font style="color:red">*</font> </label>
							<div class="col-sm-5">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
		                  			<input type="text" class="form-control" name="chkPwd">
				                </div>
							</div>
						</div>
						<div class="col-md-offset-3 col-md-9">
							<div class="form-group">
	                            <button type="button" class="btn btn-primary" id="submitBtn">提交</button>
	                        </div>
                       </div>
					</form>
				</div>
			</div>
		</div>
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
