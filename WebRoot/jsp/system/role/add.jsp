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
				<div class="col-xs-12 form-horizontal">
					<form class="form-horizontal" role="form" id="roleForm">
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">角色名称<font style="color:red">*</font> </label>
							<div class="col-sm-3">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-user-o"></i>
				                  </div>
		                  			<input type="text" class="form-control" name="roleName">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">是否启用<font style="color:red">*</font> </label>
							<div class="col-sm-2">
		                   		<label>
				                  	启用<input type="radio" name="roleState" value="1" class="flat-red" checked>
				                </label>
				                <label>
				                  	停用<input type="radio" name="roleState" value="0" class="flat-red">
				                </label>
							</div>
						</div>
						</form>
						<div class="col-md-offset-3 col-md-9">
							<div class="form-group">
	                            <button type="button" class="btn btn-primary"  name="signup" onclick="btnSubmit()">提交</button>
	                            <button type="button" class="btn btn-info" id="resetBtn">重置</button>
	                            <button type="button" class="btn btn-info" id="closeBtn">关闭</button>
	                        </div>
                       </div>
				</div>
			</div>
		</div>
	</section>
	<script type="text/javascript">
	
	 function btnSubmit(){
		 
		 if($('#roleForm').data("bootstrapValidator").isValid()){
			 $.ajax({
				 url:"${wmsUrl}/admin/system/roleMng/addRole.shtml",
				 type:'post',
				 data:JSON.stringify(sy.serializeObject($("#roleForm"))),
			     contentType: "application/json; charset=utf-8",
				 dataType:'json',
				 success:function(data){
					 if(data.success){	
						 layer.alert("插入成功");
						 parent.layer.closeAll();
						 parent.reloadTable();
					 }else{
						  layer.alert(data.errInfo);
					 }
				 },
				 error:function(){
					 layer.alert("系统出现问题啦，快叫技术人员处理");
				 }
			 });
		 }else{
			 layer.alert("信息填写有误");
		 }
	 }
	
	 $('#closeBtn').click(function() {
		 parent.layer.closeAll();
	   });
	
	 $('#resetBtn').click(function() {
	        $('#roleForm').data('bootstrapValidator').resetForm(true);
	    });
	
	$('#roleForm').bootstrapValidator({
      message: 'This value is not valid',
      feedbackIcons: {
          valid: 'glyphicon glyphicon-ok',
          invalid: 'glyphicon glyphicon-remove',
          validating: 'glyphicon glyphicon-refresh'
      },
      fields: {
    	  roleName: {
              message: '名称不正确',
              validators: {
                  notEmpty: {
                      message: '名称不能为空！'
                  }
              }
      	  }
      }
  });
	
	
	
	</script>
</body>
</html>
