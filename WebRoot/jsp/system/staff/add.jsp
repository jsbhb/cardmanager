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
        <div class="box box-default">
			<div class="box-body">
				<div class="row">
				  	<form id="gradeForm" method="post" class="form-horizontal" action="target.php">
				  	<div class="col-md-6">
						<div class="form-group">
			                <label>名称<font style="color:red">*</font>:</label>
			                <div class="input-group">
			                  <div class="input-group-addon">
			                    <i class="fa fa-user-o"></i>
			                  </div>
			                  <input type="text" class="form-control" name="userName">
			                </div>
			              </div>
			              
			              <div class="form-group">
			                <label>负责人电话<font style="color:red">*</font>:</label>
			                <div class="input-group">
			                  <div class="input-group-addon">
			                    <i class="fa fa-phone"></i>
			                  </div>
			                  <input type="text" class="form-control" name="phone">
			                </div>
			              </div>
						<div class="form-group">
			                <label>地址<font style="color:red">*</font>:</label>
			                <div class="input-group">
			                  <div class="input-group-addon">
			                    <i class="fa fa-address-book"></i>
			                  </div>
			                  <input type="text" class="form-control" name="address">
			                </div>
			              </div>
			              <div class="form-group">
			                <label>上级负责人<font style="color:red">*</font>:</label>
			                <div class="input-group">
			                  <div class="input-group-addon">
			                    <i class="fa fa-address-book"></i>
			                  </div>
			                  <input type="text" class="form-control" name="chief">
			                  <span class="input-group-btn">
		                      	<button type="button" class="btn btn-info btn-flat"><i class="fa fa-address-book-o"></i></button>
		                      </span>
			                </div>
			             </div>
			             <div class="form-group">
			                <label>描述:</label>
			                <div class="input-group">
			                  <textarea class="form-control" name="desc" placeholder="Enter ..."></textarea>
			                </div>
			              </div>
			             </div>
			            <div class="col-md-1">
			             </div>
			            <div class="col-md-5">
			            	<div class="form-group">
				                <label>等级：</label>
				                <div class="input-group">
				                  <select class="form-control select2" style="width: 100%;">
					                  <option selected="selected">二级</option>
					                  <option>三级</option>
					                  <option>四级</option>
					                </select>
				                </div>
				              </div>
				             <div class="form-group">
				                <label>公司名称<font style="color:red">*</font>:</label>
				                <div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-address-book"></i>
				                  </div>
				                  <input type="text" class="form-control" name="company">
				                </div>
				              </div>
				              <div class="form-group">
				                <label>邮编<font style="color:red">*</font>:</label>
				                <div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-address-book"></i>
				                  </div>
				                  <input type="text" class="form-control" name="post">
				                </div>
				              </div>
				              <div class="form-group">
				                <label>传真<font style="color:red">*</font>:</label>
				                <div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-address-book"></i>
				                  </div>
				                  <input type="text" class="form-control" name="fax">
				                </div>
				              </div>
						</div>
                         <div class="col-md-9">
							<div class="form-group">
	                                <button type="submit" class="btn btn-primary" name="signup" value="提交">提交</button>
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
          userName: {
              message: '名字不正确',
              validators: {
                  notEmpty: {
                      message: '用户名不能为空！'
                  },
                  stringLength: {
                      min: 4,
                      max: 30,
                      message: '用户名称必须在4-30位'
                  },
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
	  	chief: {
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
		  	  },
		  	post: {
		          message: '邮编不能为空',
		          validators: {
		              notEmpty: {
		                  message: '邮编不能为空！'
		              }
		          }
		  	  },
		  	fax: {
		          message: '传真不能为空',
		          validators: {
		              notEmpty: {
		                  message: '传真不能为空！'
		              }
		          }
		  	  }
      }
  });
	</script>
</body>
</html>
