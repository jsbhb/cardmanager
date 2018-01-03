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

<body>
	<section class="content">
        <div class="main-content">
			<div class="row">
				<div class="col-xs-12" >
					<form class="form-horizontal" role="form" id="specsForm" >
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">模板名称</label>
							<div class="col-sm-5">
								<div class="input-group">
		                  			<button type="text" disabled class="btn btn-info">${entity.name}</button>
				                </div>
							</div>
						</div>
						<c:forEach var="spec" items="${entity.specs}">
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">${spec.name}</label>
							<div class="col-sm-4">
								<div class="input-group">
				                  	<c:forEach var="value" items="${spec.values}">
		                  				<button type="button" disabled class="btn btn-warning">${value.value}</button>
		                  			</c:forEach>
		                  			<button type="button" disabled class="btn btn-danger"><i class="fa fa-plus"></i></button>
				                </div>
							</div>
						</div>
						</c:forEach>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"></label>
							<div class="col-sm-5">
								<div class="input-group">
		                  			<button type="button" disabled class="btn btn-danger"><i class="fa fa-plus"></i></button>
				                </div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
	<script type="text/javascript">
	
	 $("#submitBtn").click(function(){
		 if($('#brandForm').data("bootstrapValidator").isValid()){
			 $.ajax({
				 url:"${wmsUrl}/admin/goods/brandMng/editbrand.shtml",
				 type:'post',
				 data:JSON.stringify(sy.serializeObject($('#brandForm'))),
				 contentType: "application/json; charset=utf-8",
				 dataType:'json',
				 success:function(data){
					 if(data.success){	
						 layer.alert("插入成功");
						 parent.layer.closeAll();
						 parent.reloadTable();
					 }else{
						 parent.reloadTable();
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
	
	 $('#resetBtn').click(function() {
	        $('#brandForm').data('bootstrapValidator').resetForm(true);
	    });
	
	$('#brandForm').bootstrapValidator({
//      live: 'disabled',
      message: 'This value is not valid',
      feedbackIcons: {
          valid: 'glyphicon glyphicon-ok',
          invalid: 'glyphicon glyphicon-remove',
          validating: 'glyphicon glyphicon-refresh'
      },
      fields: {
    	  brand: {
              message: '品牌不正确',
              validators: {
                  notEmpty: {
                      message: '品牌不能为空！'
                  }
              }
      	  }
      }
  });
	
	
	
	</script>
</body>
</html>
