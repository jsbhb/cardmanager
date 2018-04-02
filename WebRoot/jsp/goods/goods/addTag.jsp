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
<section class="content-wrapper">
	<section class="content">
		<form class="form-horizontal" role="form" id="itemForm" >
			<div class="col-md-12">
	        	<div class="box box-info">
	        		<div class="box-header with-border">
						<div class="box-header with-border">
			            	<h5 class="box-title">标签信息</h5>
			            	<div class="box-tools pull-right">
			                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			              	</div>
			            </div>
					</div>
		            <div class="box-body">
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">标签名称</label>
							<div class="col-sm-6">
								<div class="input-group">
				                  	<div class="input-group-addon">
				                    	<i class="fa fa-pencil"></i>
				                  	</div>
				                  	<input type="text" class="form-control" name="tagName">
				                </div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
		                     		<button type="button" class="btn btn-primary" id="submitBtn">确定</button>
		                        </div>
							</div>
						</div>
	            	</div>
          		</div>
			</div>
		</form>
	</section>
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
// 						 parent.refreshTag();
						 parent.location.reload();
						 
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
