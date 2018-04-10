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
<script src="${wmsUrl}/validator/js/bootstrapValidator.min.js"></script>
</head>

<body>
	<section class="content-iframe">
       	<form class="form-horizontal" role="form" id="brandForm" style="margin-top:20px;">
       		
			<div class="list-item">
				<div class="col-xs-3 item-left" for="form-field-1">上级分类<font style="color:red">*</font> </div>
				<div class="col-xs-9 item-right">
					<input type="text" class="form-control" name="category">
	            	<div class="item-content">
	             		（顶级分类请选择[无]）
	             	</div>
				</div>
			</div>
       		<div class="select-content">
           		<ul class="first-ul">
           			<li>
           				<span data-id="-1"><i class="fa fa-caret-right fa-fw active"></i>无</span>
           			</li>
           			<c:forEach var="first" items="${firsts}">
	           			<li>
	           				<span data-id="${first.id}"><i class="fa fa-caret-right fa-fw active"></i>${first.name}</span>
	           				<ul class="second-ul">
	           					<c:forEach var="second" items="${first.seconds}">
									<li><span data-id="${second.id}">${second.name}</span></li>
								</c:forEach>
	           				</ul>
	           			</li>
					</c:forEach>
           		</ul>
           	</div>
			<div class="list-item">
				<div class="col-xs-3 item-left" for="form-field-1">分类名称<font style="color:red">*</font> </div>
				<div class="col-xs-9 item-right">
					<input type="text" class="form-control" name="brand">
	            	<div class="item-content">
	             		（请输入数字、英文和汉字，限1-40字）
	             	</div>
				</div>
			</div>
			<div class="submit-btn">
                <button type="button" class="btn btn-primary" id="submitBtn">确定</button>
            </div>
		</form>
	</section>
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
