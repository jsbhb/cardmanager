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
<link rel="stylesheet" href="${wmsUrl}/validator/css/bootstrapValidator.min.css">
</head>

<body>
	<section class="content">
        <div class="main-content">
			<div class="row">
				<div class="col-xs-12" >
					<form class="form-horizontal" role="form" id="catalogForm" >
					
						<c:choose>
							<c:when  test="${type==1}">
								<div class="form-group">
									<label class="col-sm-2 control-label no-padding-right" for="form-field-1"><h4>一级分类</h4></label>
		                  			<input type="hidden" readonly class="form-control" name="type" value="${type}">
								</div>
							</c:when>
							<c:otherwise>
								<div class="form-group">
									<label class="col-sm-2 control-label no-padding-right" for="form-field-1">上级分类编号<font style="color:red">*</font> </label>
									<div class="col-sm-3">
										<div class="input-group">
						                  <div class="input-group-addon">
						                    <i class="fa fa-user-o"></i>
						                  </div>
				                  			<input type="text" readonly class="form-control" name="parentId" value="${parentId}">
				                  			<input type="hidden" readonly class="form-control" name="type" value="${type}">
						                </div>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label no-padding-right" for="form-field-1">上级分类名称<font style="color:red">*</font> </label>
									<div class="col-sm-2">
										<div class="input-group">
						                  <div class="input-group-addon">
						                    <i class="fa fa-address-book"></i>
						                  </div>
						                  <input type="text" readonly class="form-control" value="${parentName}">
						                </div>
									</div>
								</div>
							</c:otherwise>
						</c:choose>
						
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">名称<font style="color:red">*</font> </label>
							<div class="col-sm-3">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-phone"></i>
				                  </div>
				                  <input type="text" class="form-control" name="name" placeholder="请输入名称。。。">
				                </div>
							</div>
						</div>
						<div class="col-md-offset-3 col-md-9">
							<div class="form-group">
	                            <button type="button" class="btn btn-primary" id="submitBtn">提交</button>
	                            <button type="button" class="btn btn-info" id="resetBtn">重置</button>
	                        </div>
                       </div>
					</form>
				</div>
			</div>
		</div>
	</section>
	<script src="${wmsUrl}/validator/js/bootstrapValidator.min.js"></script>
	<%@include file="../../resource.jsp"%>
	<script type="text/javascript">
	
	 $("#submitBtn").click(function(){
		 if($('#catalogForm').data("bootstrapValidator").isValid()){
			 $.ajax({
				 url:"${wmsUrl}/admin/goods/catalogMng/add.shtml",
				 type:'post',
				 data:JSON.stringify(sy.serializeObject($('#catalogForm'))),
				 contentType: "application/json; charset=utf-8",
				 dataType:'json',
				 success:function(data){
					 if(data.success){	
						 layer.alert("插入成功");
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
		 }else{
			 layer.alert("信息填写有误");
		 }
	 });
	
	 $('#resetBtn').click(function() {
	        $('#catalogForm').data('bootstrapValidator').resetForm(true);
	    });
	
	$('#catalogForm').bootstrapValidator({
//      live: 'disabled',
      message: 'This value is not valid',
      feedbackIcons: {
          valid: 'glyphicon glyphicon-ok',
          invalid: 'glyphicon glyphicon-remove',
          validating: 'glyphicon glyphicon-refresh'
      },
      fields: {
    	  name: {
              message: '名字不正确',
              validators: {
                  notEmpty: {
                      message: '名字不能为空！'
                  }
              }
      	  }
      }
  });
	
	
	
	</script>
</body>
</html>
