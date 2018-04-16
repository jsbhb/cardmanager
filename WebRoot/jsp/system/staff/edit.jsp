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

<style  type="text/css">
	label{
		font-weight: normal;
		font-size:12px;
	}
</style>

<body>
	<section class="content">
        <div class="main-content">
			<div class="row">
				<div class="col-xs-12">
					<form class="form-horizontal" role="form" id="staffForm" >
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"><h4>基本信息</h4></label>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"><font style="color:red">*</font> 名称:</label>
							<div class="col-sm-5">
								<div class="input-group">
								  	<div class="input-group-addon">
					                    <i class="fa fa-user-o"></i>
				                    </div>
		                  			<input type="text" class="form-control" name="optName" value="${opt.optName}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"><h4>业务信息</h4></label>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"><font style="color:red">*</font>角色</label>
							<div class="col-sm-2">
			                   <select class="form-control" name="roleId" id="roleId" style="width: 100%;">
			                   	  <option selected="selected" value="-1">选择角色</option>
			                   	  <c:forEach var="role" items="${roles}">
			                   	  	<option value="${role.roleId}">${role.roleName}</option>
			                   	  </c:forEach>
				                </select>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"><font style="color:red">*</font>分级机构:</label>
							<div class="col-sm-5">
								<div class="input-group">
									<div class="input-group-addon">
					                    <i class="fa fa-user-o"></i>
				                  	</div>
				                   <input type="text"  readonly class="form-control" name="gradeName" value="${opt.gradeName}">
				                   
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"><font style="color:red">*</font>分级机构编号:</label>
							<div class="col-sm-5">
								<div class="input-group">
									<div class="input-group-addon">
					                    <i class="fa fa-user-o"></i>
				                  	</div>
				                   <input type="text"  readonly class="form-control" name="gradeId" value="${opt.gradeId}">
				                   
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"><font style="color:red">*</font>权限编号:</label>
							<div class="col-sm-5">
								<div class="input-group">
									<div class="input-group-addon">
					                    <i class="fa fa-user-o"></i>
				                  	</div>
				                   <input type="text"  readonly class="form-control" name="platId" value="${opt.platId}">
				                   
				                </div>
							</div>
						</div>
						<div class="col-md-offset-3 col-md-9">
							<div class="form-group">
	                            <button type="button" class="btn btn-primary" id="submitBtn" name="signup">提交</button>
	                            <button type="button" class="btn btn-info" id="resetBtn">重置</button>
	                        </div>
                       </div>
					</form>
				</div>
			</div>
		</div>
	</section>
	<script type="text/javascript">
	 $("#submitBtn").click(function(){
		 if($('#staffForm').data("bootstrapValidator").isValid()){
			 if($("#roleId").val()==-1){
				 layer.alert("未选择角色!");
			 }else{
				 $.ajax({
					 url:"${wmsUrl}/admin/system/staffMng/addStaff.shtml",
					 type:'post',
					 data:JSON.stringify(sy.serializeObject($('#staffForm'))),
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
						 layer.alert("提交失败，请联系客服处理");
					 }
				 }); 
			 }
			
		 }else{
			 layer.alert("信息填写有误");
		 }
	 });
	
	 $('#resetBtn').click(function() {
	        $('#staffForm').data('bootstrapValidator').resetForm(true);
	    });
	
	$('#staffForm').bootstrapValidator({
//      live: 'disabled',
      message: 'This value is not valid',
      feedbackIcons: {
          valid: 'glyphicon glyphicon-ok',
          invalid: 'glyphicon glyphicon-remove',
          validating: 'glyphicon glyphicon-refresh'
      },
      fields: {
    	  optName: {
              message: '名字不正确',
              validators: {
                  notEmpty: {
                      message: '用户名不能为空！'
                  },
                  stringLength: {
                      min: 2,
                      max: 30,
                      message: '分级名称必须在4-30位字符'
                  },
              }
      	  },
	  	phone: {
	          message: '电话不能为空',
	          validators: {
	              notEmpty: {
	                  message: '电话不能为空！'
	              }
	          }
	  	  }
      }
  });
	
	
	
	</script>
</body>
</html>
