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
<script src="${wmsUrl}/plugins/ckeditor/ckeditor.js"></script>

</head>

<body >
<section class="content-wrapper" style="height:900px">
	<section class="content">
		<form class="form-horizontal" role="form" id="specsForm" >
			<div class="col-md-12">
	        	<div class="box box-info">
	        		<div class="box-header with-border">
		            	<h5 class="box-title">新增规格模板</h5>
		            	<div class="box-tools pull-right">
		                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
		              	</div>
					</div>
		            <div class="box-body">
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">模板名称</label>
							<button type="button" class="btn btn-primary" id="submitBtn">提交</button>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
		                  			<input type="text" class="form-control" name="templateName">
				                </div>
				                <div class="input-group"><a href="#" onclick="addProperties()">新建属性</a></div>
							</div>
						</div>
	            	</div>
          		</div>
			</div>
		</form>
	</section>
</section>
<script type="text/javascript">
 function addProperties(){
	 var fNode = $('<div></div>');
	 var boxNode = $('<div></div>');
	 var boxHeader= $('<div></div>');
	 var boxBody = $('<div></div>');
	 var boxTool= $('<div></div>');
	 var formGroup = $('<div></div>');
	 var formGroupValue = $('<div></div>');
	 fNode.addClass("col-md-6");
	 boxNode.addClass("box box-warning");
	 boxHeader.addClass("box-header with-border");
	 boxHeader.append("<h5 class='box-title'>新属性</h5>");
	 boxBody.addClass("box-body");
	 boxTool.addClass("box-tools pull-right");
	 formGroup.addClass("form-group");
	 formGroupValue.addClass("form-group");
	 
	 
	 boxTool.append("<button type='button' class='btn btn-box-tool' data-widget='remove'><i class='fa fa-times'></i></button>");
	
	 formGroup.append("<label class='col-sm-3 control-label no-padding-right' for='form-field-1'>规格名称</label><div class='col-sm-6'><div class='input-group'><div class='input-group-addon'><i class='fa fa-pencil'></i></div><input type='text' class='form-control' name='specsName'></div></div>");
	 formGroup.appendTo(boxBody);
	 formGroupValue.append("<label class='col-sm-3 control-label no-padding-right' for='form-field-1'>规格值</label><div class='col-sm-6'><div class='input-group'><textarea type='text' class='form-control' name='specsValue'></textarea>请用英文分号';'作为多个值得分隔符</div></div>");
	 formGroupValue.appendTo(boxBody);
	 
	 boxTool.appendTo(boxHeader);
	 boxHeader.appendTo(boxNode);
	 boxBody.appendTo(boxNode);
	 boxNode.appendTo(fNode);
	 
	 $("#specsForm").append(fNode);
	 
 }
 
 $("#submitBtn").click(function(){
	 if($('#specsForm').data("bootstrapValidator").isValid()){
		 $.ajax({
			 url:"${wmsUrl}/admin/goods/specsMng/save.shtml",
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
//   live: 'disabled',
   message: 'This value is not valid',
   feedbackIcons: {
       valid: 'glyphicon glyphicon-ok',
       invalid: 'glyphicon glyphicon-remove',
       validating: 'glyphicon glyphicon-refresh'
   },
   fields: {
 	  templateName: {
           message: '模板名称不正确',
           validators: {
               notEmpty: {
                   message: '模板名称不能为空！'
               }
           }
   	  },
   	specsName: {
        message: '规则名称不正确',
        validators: {
            notEmpty: {
                message: '规则名称不能为空！'
            }
        }
	  },
	  specsValue: {
	        message: '规则值不正确',
	        validators: {
	            notEmpty: {
	                message: '规则值不能为空！'
	            }
	        }
		  }
   }
});
 

	
	
</script>
</body>
</html>
