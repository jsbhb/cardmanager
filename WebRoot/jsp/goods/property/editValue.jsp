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
				<div class="col-xs-3 item-left">属性类型</div>
				<div class="col-xs-9 item-right">
					<input type="text" class="form-control" name="propertyType" value="${propertyType}" readonly>
				</div>
			</div>
			<div class="list-item">
				<div class="col-xs-3 item-left">属性名称</div>
				<div class="col-xs-9 item-right">
					<input type="text" class="form-control" name="name" value="${propertyValue.name}" readonly>
					<input type="hidden" class="form-control" name="id" value="${propertyValue.valueList[0].id}" readonly>
					<input type="hidden" class="form-control" name="hidTabId" value="${hidTabId}" readonly>
				</div>
			</div>
			<div class="list-item">
				<div class="col-xs-3 item-left">属性值</div>
				<div class="col-xs-9 item-right">
					<input type="text" class="form-control" name="val" value="${propertyValue.valueList[0].val}">
	            	<div class="item-content">
	             		（请输入数字、英文和汉字，限1-45字）
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
				 url:"${wmsUrl}/admin/goods/propertyMng/editValue.shtml",
				 type:'post',
				 data:JSON.stringify(sy.serializeObject($('#brandForm'))),
				 contentType: "application/json; charset=utf-8",
				 dataType:'json',
				 success:function(data){
					 if(data.success){	
						 parent.location.reload();
					 }else{
						 layer.alert(data.msg);
					 }
				 },
				 error:function(){
					 layer.alert("修改属性值失败，请联系客服处理");
				 }
			 });
		 }else{
			 layer.alert("信息填写有误");
		 }
	 });
	
	 $('#resetBtn').click(function() {
        $('#brandForm').data('bootstrapValidator').resetForm(true);
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
    	  val: {
              message: '属性值不正确',
              validators: {
                  notEmpty: {
                      message: '属性值不能为空！'
                  },
                  stringLength: {
                	  min: 1,
                	  max: 45,
                	  message: '属性值长度请控制在1-45字'
                  }
              }
      	  }
      }
     });
	</script>
</body>
</html>
