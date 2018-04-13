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
	<section class="content-wrapper">
        <div class="content">
			<form class="form-horizontal" role="form" id="funcForm">
				<div class="form-group">
					<label class="col-sm-2 control-label no-padding-right" for="form-field-1">功能名称<font style="color:red">*</font> </label>
					<div class="col-sm-3">
						<div class="input-group">
		                  <div class="input-group-addon">
		                    <i class="fa fa-user-o"></i>
		                  </div>
                  			<input type="text" class="form-control" name="name" data-toggle="popover" data-placement="top" placeholder="请输入功能名称" >
		                	<input type="hidden" class="form-control" name="parentId" value="${parent.funcId}">
		                </div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label no-padding-right" for="form-field-1">父菜单名称<font style="color:red">*</font> </label>
					<div class="col-sm-9">
						<div class="input-group">
		                  <div class="input-group-addon">
		                    <i class="fa fa-phone"></i>
		                  </div>
		                  <input type="text" class="form-control" disabled name="parentName"  value="${parent.name}">
		                </div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label no-padding-right" for="form-field-1">功能图标<font style="color:red">*</font> </label>
					<div class="col-sm-9">
						<div class="input-group">
		                  <div class="input-group-addon">
		                    <i class="fa fa-phone"></i>
		                  </div>
		                  <input type="text" class="form-control" name="tag" placeholder="请输入...">
		                </div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label no-padding-right" for="form-field-1">功能链接 </label>
					<div class="col-sm-9">
						<div class="input-group">
		                  <div class="input-group-addon">
		                    <i class="fa fa-phone"></i>
		                  </div>
		                  <input type="text" class="form-control" name="url" placeholder="请输入...">
		                </div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label no-padding-right" for="form-field-1">描述</label>
					<div class="col-sm-5">
		                  <textarea class="form-control" rows="3" placeholder="请输入内容" name="description"></textarea>
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
	</section>
	<script type="text/javascript">
	
	 function btnSubmit(){
		 
		 if($('#funcForm').data("bootstrapValidator").isValid()){
			 $.ajax({
				 url:"${wmsUrl}/admin/system/funcMng/addFunc.shtml",
				 type:'post',
				 data:JSON.stringify(sy.serializeObject($("#funcForm"))),
			     contentType: "application/json; charset=utf-8",
				 dataType:'json',
				 success:function(data){
					 if(data.success){	
						 layer.alert("插入成功");
						 parent.layer.closeAll();
						 parent.reloadTable();
					 }else{
						  layer.alert(data.msg);
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
	        $('#funcForm').data('bootstrapValidator').resetForm(true);
	    });
	
	$('#funcForm').bootstrapValidator({
      message: 'This value is not valid',
      feedbackIcons: {
          valid: 'glyphicon glyphicon-ok',
          invalid: 'glyphicon glyphicon-remove',
          validating: 'glyphicon glyphicon-refresh'
      },
      fields: {
    	  name: {
              message: '名称不正确',
              validators: {
                  notEmpty: {
                      message: '名称不能为空！'
                  }
              }
      	  },
	      tag: {
	          message: '标签'	  	 
	          },
	      url: {
	          message: '标签链接'
	  	  },
	  	description: {
	          message: '描述'
	  	  }
      }
  });
	
	
	
	</script>
</body>
</html>
