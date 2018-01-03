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
					<form class="form-horizontal" role="form" id="gradeForm" >
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"><h4>基本信息</h4></label>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">分级名称<font style="color:red">*</font> </label>
							<div class="col-sm-5">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
		                  			<input type="text" class="form-control" name="gradeName">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">公司名称<font style="color:red">*</font> </label>
							<div class="col-sm-5">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
				                  <input type="text" class="form-control" name="company" placeholder="请输入...">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">上级机构<font style="color:red">*</font> </label>
							<div class="col-sm-5">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
				                  <input type="text" readonly class="form-control" name="parentGradeName" value="${opt.gradeName}">
				                  <input type="hidden" readonly class="form-control" name="parentId" value="${opt.gradeId}">
				                  <input type="hidden" readonly class="form-control" name="gradeLevel" value="${opt.gradeLevel+1}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"><h4>业务信息</h4></label>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">业务类型<font style="color:red">*</font> </label>
							<div class="col-sm-2">
		                   		<label>
				                  	跨境<input type="radio" name="gradeType" value="1" class="flat-red" checked>
				                </label>
				                <label>
				                  	大贸<input type="radio" name="gradeType" value="0" class="flat-red">
				                </label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">负责人<font style="color:red">*</font> </label>
							<div class="col-sm-5">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-phone"></i>
				                  </div>
				                  <input type="text" class="form-control" name="personInCharge" placeholder="请输入负责人名称">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">上级负责人<font style="color:red">*</font> </label>
							<div class="col-sm-5">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
				                   <input type="text" class="form-control" name="gradePersonInCharge" placeholder="请选择">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"><h4>联系方式</h4></label>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">负责人电话<font style="color:red">*</font> </label>
							<div class="col-sm-5">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
				                  <input type="text" class="form-control" name="phone" placeholder="请输入...">
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
	<%@ include file="../../footer.jsp"%>
	<script type="text/javascript">
	
	 $("#submitBtn").click(function(){
		 if($('#gradeForm').data("bootstrapValidator").isValid()){
			 $.ajax({
				 url:"${wmsUrl}/admin/system/gradeMng/addGrade.shtml",
				 type:'post',
				 data:JSON.stringify(sy.serializeObject($('#gradeForm'))),
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
	        $('#gradeForm').data('bootstrapValidator').resetForm(true);
	    });
	
	$('#gradeForm').bootstrapValidator({
//      live: 'disabled',
      message: 'This value is not valid',
      feedbackIcons: {
          valid: 'glyphicon glyphicon-ok',
          invalid: 'glyphicon glyphicon-remove',
          validating: 'glyphicon glyphicon-refresh'
      },
      fields: {
    	  gradeName: {
              message: '名字不正确',
              validators: {
                  notEmpty: {
                      message: '用户名不能为空！'
                  },
                  stringLength: {
                      min: 4,
                      max: 30,
                      message: '分级名称必须在4-30位字符'
                  },
              }
      	  },
      	 personInCharge: {
	          message: '负责人不能为空',
	          validators: {
	              notEmpty: {
	                  message: '负责人不能为空！'
	              }
	          }
	  	  },
	      address: {
	          message: '地址不能为空',
	          validators: {
	              notEmpty: {
	                  message: '地址不能为空！'
	              }
	          }
	  	  },
	  	gradePersonInCharge: {
	          message: '负责人不能为空',
	          validators: {
	              notEmpty: {
	                  message: '负责人不能为空！'
	              }
	          }
	  	  },
	  	phone: {
	          message: '电话不能为空',
	          validators: {
	              notEmpty: {
	                  message: '电话不能为空！'
	              }
	          }
	  	  },
	  	company: {
	          message: '公司不能为空',
	          validators: {
	              notEmpty: {
	                  message: '公司不能为空！'
	              }
	          }
	  	  }
      }
  });
	
	
	
	</script>
</body>
</html>
