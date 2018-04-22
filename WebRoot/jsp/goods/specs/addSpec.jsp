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
	<section class="content-wrapper" style="height: 900px">
		<section class="content">
			<form class="form-horizontal" role="form" id="specsForm">
				<div class="col-md-12">
					<div class="box box-info">
						<div class="box-header with-border">
							<h5 class="box-title">添加规格值</h5>
						</div>
						<div class="box-body">
							<div class="form-group">
								<label class='col-sm-3 control-label no-padding-right' for='form-field-1'>规格名称</label>
								<div class='col-sm-6'>
									<div class='input-group'>
										<input type='text' class='form-control' name="specsName"/>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class='col-sm-3 control-label no-padding-right' for='form-field-1'>规格值</label>
								<div class='col-sm-6'>
									<div class='input-group'>
										<textarea type='text' class='form-control' name="specsValue"></textarea>
			                  			<input type="hidden" class="form-control" name="templateId" value="${templateId}">
										请用英文分号';'作为多个值得分隔符
									</div>
								</div>
							</div>
							<div class="col-md-offset-1 col-md-9">
								<div class="form-group">
									<button type="button" class="btn btn-primary" id="submitBtn">提交</button>
								</div>            			
							</div>
						</div>
					</div>
				</div>
			</form>
		</section>
	</section>
<%@include file="../../resourceScript.jsp"%>
<script src="${wmsUrl}/plugins/ckeditor/ckeditor.js"></script>
	<script type="text/javascript">
 
 $("#submitBtn").click(function(){
	 if($('#specsForm').data("bootstrapValidator").isValid()){
		 $.ajax({
			 url:"${wmsUrl}/admin/goods/specsMng/saveSpecs.shtml",
			 type:'post',
			 data:JSON.stringify(sy.serializeObject($('#specsForm'))),
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){
					 parent.location.reload();
					 layer.alert("插入成功");
					 
				 }else{
					 layer.alert(data.msg);
				 }
			 },
			 error:function(){
				 layer.alert("提交失败，请联系客服处理");
			 }
		 });
	 }else{
		 layer.alert("信息填写有误");
	 }
 });
 
 $('#specsForm').bootstrapValidator({
   message: 'This value is not valid',
   feedbackIcons: {
       valid: 'glyphicon glyphicon-ok',
       invalid: 'glyphicon glyphicon-remove',
       validating: 'glyphicon glyphicon-refresh'
   },
   fields: {
 	  name: {
           message: '模板名称不正确',
           validators: {
               notEmpty: {
                   message: '模板名称不能为空！'
               }
           }
   	  }
   }
});
 

	
	
</script>
</body>
</html>
