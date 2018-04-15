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
		<form class="form-horizontal" role="form" id="funcForm">
			<div class="list-item">
				<div class="col-sm-3 item-left">功能名称</div>
				<div class="col-sm-9 item-right">
                 			<input type="text" class="form-control" name="name" value="${func.name}" data-toggle="popover" data-placement="top" placeholder="请输入功能名称" >
                 			<input type="hidden" class="form-control" name="funcId" value="${func.funcId}">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">功能图标</div>
				<div class="col-sm-9 item-right">
	                  <input type="text" class="form-control" name="tag" value="${func.tag}" placeholder="请输入...">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">功能链接</div>
				<div class="col-sm-9 item-right">
	               <input type="text" class="form-control" name="url" value="${func.url}" placeholder="请输入...">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">排序</div>
				<div class="col-sm-9 item-right">
	               <input type="text" class="form-control" name="sort" value="${func.sort}" placeholder="请输入...">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">描述</div>
				<div class="col-sm-9 item-right">
	                  <textarea class="form-control" rows="3" placeholder="请输入内容"  name="description">${func.description}</textarea>
				</div>
			</div>
			<div class="submit-btn">
           		<button type="button" class="btn btn-primary"  name="signup" onclick="btnSubmit()">提交</button>
                 <button type="button" class="btn btn-info" id="closeBtn">关闭</button>
       		</div>
			</form>
	</section>
	<script type="text/javascript">
	
	 function btnSubmit(){
		 $('#funcForm').data("bootstrapValidator").validate();
		 if($('#funcForm').data("bootstrapValidator").isValid()){
			 $.ajax({
				 url:"${wmsUrl}/admin/system/funcMng/editFunc.shtml",
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
	          message: '描述',
	          stringLength: {/*长度提示*/
                  max: 256,
                  message: '不能超过256个字符'
              }
	  	  }
      }
  });
	
	
	
	</script>
</body>
</html>
