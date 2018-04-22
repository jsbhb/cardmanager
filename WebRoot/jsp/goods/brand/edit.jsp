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
<%@include file="../../resourceLink.jsp"%>
</head>

<body>
	<section class="content-iframe">
       	<form class="form-horizontal" role="form" id="brandForm" style="margin-top:20px;">
			<div class="list-item">
				<div class="col-xs-3 item-left" for="form-field-1">品牌名称<font style="color:red">*</font> </div>
				<div class="col-xs-9 item-right">
           		    <input type="hidden" class="form-control" name="id" value="${brand.id}">
                    <input type="hidden" class="form-control" name="brandId" value="${brand.brandId}">
					<input type="text" class="form-control" name="brand" value="${brand.brand}">
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
	<%@include file="../../resourceScript.jsp"%>
	<script type="text/javascript">
	
	 $("#submitBtn").click(function(){
		 if($('#brandForm').data("bootstrapValidator").isValid()){
			 $.ajax({
				 url:"${wmsUrl}/admin/goods/brandMng/modify.shtml",
				 type:'post',
				 data:JSON.stringify(sy.serializeObject($('#brandForm'))),
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
		 }else{
			 layer.alert("信息填写有误");
		 }
	 });
	
	$('#brandForm').bootstrapValidator({
//      live: 'disabled',
	      message: 'This value is not valid',
	      feedbackIcons: {
	          valid: 'glyphicon glyphicon-ok',
	          invalid: 'glyphicon glyphicon-remove',
	          validating: 'glyphicon glyphicon-refresh'
	      },
	      fields: {
	    	  brand: {
	              message: '品牌名称不正确',
	              validators: {
	                  notEmpty: {
	                      message: '品牌名称不能为空！'
	                  }
	              }
	      	  }
	      }
	  });
	</script>
</body>
</html>
