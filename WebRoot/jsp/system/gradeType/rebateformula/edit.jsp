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
<%@include file="../../../resourceLink.jsp"%>
</head>

<body>
	<section class="content-iframe">
       	<form class="form-horizontal" role="form" id="form" style="margin-top:20px;">
			<div class="list-item">
				<div class="col-xs-3 item-left">分级类型<font style="color:red">*</font> </div>
				<div class="col-xs-9 item-right">
           		    <input type="text" class="form-control" name="gradeTypeName" value="${rebateFormula.gradeTypeName}" readonly="readonly">
                    <input type="hidden" class="form-control" name="gradeTypeId" id="gradeTypeId" value="${rebateFormula.gradeTypeId}">
                    <input type="hidden" class="form-control" name="id" id="id" value="${rebateFormula.id}">
				</div>
			</div>
			<div class="list-item">
				<div class="col-xs-3 item-left">返佣公式<font style="color:red">*</font> </div>
				<div class="col-xs-9 item-right">
					<input type="text" class="form-control" name="formula" id="formula" value = "${rebateFormula.formula}">
	            	<div class="item-content">
	             		（请输入公式，例rebate*0.7,前面的rebate代表区域中心的返佣请不要修改）
	             	</div>
				</div>
			</div>
			<div class="submit-btn">
                <button type="button" class="btn btn-primary" id="submitBtn">确定</button>
            </div>
		</form>
	</section>
	<%@include file="../../../resourceScript.jsp"%>
	<script type="text/javascript">
	
	 $("#submitBtn").click(function(){
		 $('#form').data("bootstrapValidator").validate();
		 if($('#form').data("bootstrapValidator").isValid()){
			 var formula = $("#formula").val();
			 var reg = /^rebate\s*[\+\-\*\/]\s*\d+(\.\d+)?$/;
			 if(!reg.test(formula)){
				 layer.alert("请确认公式是否正确");
				 return 
			 }
			 var gradeTypeId = $("#gradeTypeId").val();
			 var id = $("#id").val();
			 var obj = {};
			 obj.gradeTypeId = gradeTypeId;
			 obj.formula = formula;
			 obj.id = id;
			 $.ajax({
				 url:"${wmsUrl}/admin/system/gradeType/typerebate/edit.shtml",
				 type:'post',
				 data:JSON.stringify(obj),
				 contentType: "application/json; charset=utf-8",
				 dataType:'json',
				 success:function(data){
					 if(data.success){	
						 parent.layer.closeAll();
						 parent.reloadTable();
					 }else{
						 layer.alert(data.msg);
					 }
				 },
				 error:function(){
					 layer.alert("修改失败，请联系客服处理");
				 }
			 });
		 }else{
			 layer.alert("信息填写有误");
		 }
	 });
	
	$('#form').bootstrapValidator({
//      live: 'disabled',
	      message: 'This value is not valid',
	      feedbackIcons: {
	          valid: 'glyphicon glyphicon-ok',
	          invalid: 'glyphicon glyphicon-remove',
	          validating: 'glyphicon glyphicon-refresh'
	      },
	      fields: {
	    	  formula: {
	    		  message: '公式不正确',
				   validators: {
					   notEmpty: {
						   message: '公式不能为空'
					   }
				   }
	      	  }
	      }
	  });
	</script>
</body>
</html>
