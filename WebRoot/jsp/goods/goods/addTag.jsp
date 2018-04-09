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
<%@include file="../../resource.jsp"%>

<link rel="stylesheet" href="${wmsUrl}/validator/css/bootstrapValidator.min.css">
<script src="${wmsUrl}/validator/js/bootstrapValidator.min.js"></script>
</head>

<body >
<section class="content-iframe">
	<form class="form-horizontal" role="form" id="itemForm" style="margin-top:20px;">
		<div class="list-item">
			<div class="col-xs-3 item-left" for="form-field-1">标签名称</div>
			<div class="col-xs-7 item-right">
            	<input type="text" class="form-control" name="tagName" style="width:100%;">
            	<div class="item-content">
             		（请输入数字、英文和汉字，限1-10字）
             	</div>
			</div>
        </div>
		<div class="submit-btn">
            <button type="button" class="btn btn-primary" id="submitBtn">确定</button>
        </div>
	</form>
</section>
	<script type="text/javascript">
	 
	 $("#submitBtn").click(function(){
		 $('#itemForm').data("bootstrapValidator").validate();
		 if($('#itemForm').data("bootstrapValidator").isValid()){		
			 $.ajax({
				 url:"${wmsUrl}/admin/goods/goodsMng/saveTag.shtml",
				 type:'post',
				 data:JSON.stringify(sy.serializeObject($('#itemForm'))),
				 contentType: "application/json; charset=utf-8",
				 dataType:'json',
				 success:function(data){
					 if(data.success){
						 layer.alert("保存成功");
						 parent.layer.closeAll();
						 parent.refreshTag();
						 
					 }else{
						 layer.alert(data.msg);
					 }
				 },
				 error:function(){
					 layer.alert("保存失败，请联系客服处理");
				 }
			 });
		 }else{
			 layer.alert("信息填写有误");
		 }
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
		   tagName: {
          	message: '标签名称未填写！',
          	validators: {
		               notEmpty: {
		                   message: '标签名称未填写！'
		               }
	           		}
	   	  		}
			}
	   });
	</script>
</body>
</html>
