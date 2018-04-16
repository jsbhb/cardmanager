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
	<section class="content-iframe content">
		<form class="form-horizontal" role="form" id="from">
			<div class="list-item">
				<div class="col-sm-3 item-left">分级类型名称</div>
				<div class="col-sm-9 item-right">
            			<input type="text" class="form-control" name="name" value="${GradeTypeDTO.name}" data-toggle="popover" data-placement="top" placeholder="请输入分级类型名称" >
            			<input type="hidden"  class="form-control" name="id" value="${GradeTypeDTO.id}" data-toggle="popover" data-placement="top">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">上级分类名称</div>
				<div class="col-sm-9 item-right">
            			<input type="text" disabled class="form-control" readonly value="${parentGradeTypeDTO.name}" name="parentName" data-toggle="popover" data-placement="top">
            			<input type="hidden"  class="form-control" value="${GradeTypeDTO.parentId}" name="parentId" data-toggle="popover" data-placement="top">
				</div>
			</div>
			<div class="list-item">
				<label class="col-sm-3 item-left"><font style="color:red">*</font>角色</label>
				<div class="col-sm-2">
                   <select class="form-control" name="role" id="roleId" style="width: 100%;">
                   	  <c:forEach var="role" items="${roles}">
                   	  	<c:if test="${role.roleId==roleId}">
                   	  		<option value="${role.roleId}" selected>${role.roleName}</option>
                   	  	</c:if>
                   	  	<c:if test="${role.roleId!=roleId}">
                   	  		<option value="${role.roleId}">${role.roleName}</option>
                   	  	</c:if>
                   	  </c:forEach>
	                </select>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">分级类型描述</div>
				<div class="col-sm-9 item-right">
	                  <textarea class="form-control" rows="3" placeholder="请输入内容"  name="description"></textarea>
				</div>
			</div>
			<div class="submit-btn">
           			<button type="button" class="btn btn-primary"  name="signup" onclick="btnSubmit()">提交</button>
                     <button type="button" class="btn btn-info" id="resetBtn">重置</button>
                     <button type="button" class="btn btn-info" id="closeBtn">关闭</button>
       		</div>
		</form>
	</section>
	<script type="text/javascript">
	
	 function btnSubmit(){
		 $('#from').data("bootstrapValidator").validate();
		 if($('#from').data("bootstrapValidator").isValid()){
			 $.ajax({
				 url:"${wmsUrl}/admin/system/gradeType/edit.shtml",
				 type:'post',
				 data:JSON.stringify(sy.serializeObject($("#from"))),
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
	        $('#from').data('bootstrapValidator').resetForm(true);
	    });
	
	$('#from').bootstrapValidator({
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
	  	description: {
	          message: '描述'
	  	  }
      }
  });
	
	
	
	</script>
</body>
</html>
