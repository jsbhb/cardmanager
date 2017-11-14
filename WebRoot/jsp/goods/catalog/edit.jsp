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
					<form class="form-horizontal" role="form" id="supplierForm" >
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"><h4>基本信息</h4></label>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">供应商编号<font style="color:red">*</font> </label>
							<div class="col-sm-3">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-user-o"></i>
				                  </div>
		                  			<input type="text" class="form-control" readonly name="id" value="${supplier.id}">
				                </div>
							</div>
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">供应商名称<font style="color:red">*</font> </label>
							<div class="col-sm-3">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-user-o"></i>
				                  </div>
		                  			<input type="text" class="form-control" readonly name="supplierName" readonly value="${supplier.supplierName}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">国家<font style="color:red">*</font> </label>
							<div class="col-sm-2">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-address-book"></i>
				                  </div>
				                  <input type="text" class="form-control" name="country" placeholder="请输入..." readonly value="${supplier.country}">
				                </div>
							</div>
							<label class="col-sm-1 control-label no-padding-right" for="form-field-1">省<font style="color:red">*</font> </label>
							<div class="col-sm-2">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-address-book"></i>
				                  </div>
				                  <input type="text" class="form-control" name="province" placeholder="请输入..." readonly value="${supplier.province}">
				                </div>
							</div>
							<label class="col-sm-1 control-label no-padding-right" for="form-field-1">市<font style="color:red">*</font> </label>
							<div class="col-sm-2">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-address-book"></i>
				                  </div>
				                  <input type="text" class="form-control" name="city" placeholder="请输入..." readonly value="${supplier.city}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">区<font style="color:red">*</font> </label>
							<div class="col-sm-2">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-address-book"></i>
				                  </div>
				                  <input type="text" class="form-control" name="area" placeholder="请输入..." readonly value="${supplier.area}">
				                </div>
							</div>
							<label class="col-sm-1 control-label no-padding-right" for="form-field-1">地址<font style="color:red">*</font> </label>
							<div class="col-sm-5">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-address-book"></i>
				                  </div>
				                  <input type="text" class="form-control" name="address" readonly value="${supplier.address}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"><h4>联系方式</h4></label>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">负责人<font style="color:red">*</font> </label>
							<div class="col-sm-3">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-phone"></i>
				                  </div>
				                  <input type="text" class="form-control" name="operator" placeholder="请输入负责人名称" readonly value="${supplier.operator}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">电话<font style="color:red">*</font> </label>
							<div class="col-sm-3">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-phone"></i>
				                  </div>
				                  <input type="text" class="form-control" name="phone" placeholder="请输入..." readonly value="${supplier.phone}">
				                </div>
							</div>
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">邮箱<font style="color:red">*</font> </label>
							<div class="col-sm-3">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-phone"></i>
				                  </div>
				                  <input type="text" class="form-control" name="email" placeholder="请输入..." readonly value="${supplier.email}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">qq</label>
							<div class="col-sm-3">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-phone"></i>
				                  </div>
				                  <input type="text" class="form-control" name="qq" placeholder="请输入..." readonly value="${supplier.qq}">
				                </div>
							</div>
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">传真</label>
							<div class="col-sm-3">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-phone"></i>
				                  </div>
				                  <input type="text" class="form-control" name="fax" placeholder="请输入..." readonly value="${supplier.fax}">
				                </div>
							</div>
						</div>
						<div class="col-md-offset-3 col-md-9">
							<div class="form-group">
	                            <button type="button" disabled class="btn btn-primary" id="submitBtn">保存</button>
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
		 if($('#supplierForm').data("bootstrapValidator").isValid()){
			 $.ajax({
				 url:"${wmsUrl}/admin/supplier/supplierMng/editSupplier.shtml",
				 type:'post',
				 data:JSON.stringify(sy.serializeObject($('#supplierForm'))),
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
	        $('#supplierForm').data('bootstrapValidator').resetForm(true);
	    });
	
	$('#supplierForm').bootstrapValidator({
//      live: 'disabled',
      message: 'This value is not valid',
      feedbackIcons: {
          valid: 'glyphicon glyphicon-ok',
          invalid: 'glyphicon glyphicon-remove',
          validating: 'glyphicon glyphicon-refresh'
      },
      fields: {
    	  supplierName: {
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
      	 country: {
	          message: '国家不能为空',
	          validators: {
	              notEmpty: {
	                  message: '国家不能为空！'
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
	  	province: {
	          message: '省不能为空',
	          validators: {
	              notEmpty: {
	                  message: '省不能为空！'
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
	  	city: {
	          message: '市不能为空',
	          validators: {
	              notEmpty: {
	                  message: '市不能为空！'
	              }
	          }
	  	  },
		  area: {
		          message: '区不能为空',
		          validators: {
		              notEmpty: {
		                  message: '区不能为空！'
		              }
		          }
		  	  }
      }
  });
	
	
	
	</script>
</body>
</html>
