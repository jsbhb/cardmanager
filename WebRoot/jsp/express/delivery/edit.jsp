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
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@include file="../../resourceLink.jsp"%>
</head>

<body>
	<section class="content-iframe">
       	<form class="form-horizontal" role="form" id="brandForm" style="margin-top:20px;">
			<div class="list-item">
				<div class="col-xs-3 item-left">快递名称<font style="color:red">*</font> </div>
				<div class="col-xs-9 item-right">
					<input type="text" class="form-control" name="deliveryName" value="${info.deliveryName}">
		            <input type="hidden" class="form-control" name="id" value="${info.id}"/>
	            	<div class="item-content">
	             		（请输入快递公司名称，例：中通速递）
	             	</div>
				</div>
			</div>
			<div class="list-item">
				<div class="col-xs-3 item-left">快递代码<font style="color:red">*</font> </div>
				<div class="col-xs-9 item-right">
					<input type="text" class="form-control" name="deliveryCode" value="${info.deliveryCode}">
	            	<div class="item-content">
	             		（请输入快递公司代码，例：ZTO）
	             	</div>
				</div>
			</div>
			<div class="list-item">
				<div class="col-xs-3 item-left">使用状态<font style="color:red">*</font> </div>
				<div class="col-xs-9 item-right">
					<select class="form-control" name="status">
						<c:choose>
						<c:when test="${info.status==1}">
							<option selected="selected" value="1">启用</option>
                 	  		<option value="0">停用</option>
						</c:when>
						<c:otherwise>
							<option value="1">启用</option>
                 	  		<option selected="selected" value="0">停用</option>
						</c:otherwise>
						</c:choose>
			        </select>
				</div>
			</div>
			<div class="submit-btn">
                <button type="button" class="btn btn-primary" id="submitBtn">确定</button>
            </div>
		</form>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script type="text/javascript">
	
	$("#submitBtn").click(function(){
		 $('#brandForm').data("bootstrapValidator").validate();
		 if($('#brandForm').data("bootstrapValidator").isValid()){
			 $.ajax({
				 url:"${wmsUrl}/admin/expressMng/toUpdateDelivery.shtml",
				 type:'post',
				 data:JSON.stringify(sy.serializeObject($('#brandForm'))),
				 contentType: "application/json; charset=utf-8",
				 dataType:'json',
				 success:function(data){
					 if(data.success){	
						 parent.location.reload();
					 }else{
						 layer.alert(data.msg);
					 }
				 },
				 error:function(){
					 layer.alert("维护快递公司信息失败，请联系客服处理");
				 }
			 });
		 }else{
			 layer.alert("信息填写有误");
		 }
	 });
	
	$('#brandForm').bootstrapValidator({
	//     live: 'disabled',
	     message: 'This value is not valid',
	     feedbackIcons: {
	         valid: 'glyphicon glyphicon-ok',
	         invalid: 'glyphicon glyphicon-remove',
	         validating: 'glyphicon glyphicon-refresh'
	     },
	     fields: {
	   	 	deliveryName: {
	             message: '快递公司名称不正确',
	             validators: {
	                 notEmpty: {
	                     message: '快递公司名称不能为空！'
	                 }
	             }
	     	  },
	     	 deliveryCode: {
	             message: '快递公司代码不正确',
	             validators: {
	                 notEmpty: {
	                     message: '快递公司代码不能为空！'
	                 }
	             }
	     	  }
	     }
	 });
	</script>
</body>
</html>
