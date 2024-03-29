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
		<form class="form-horizontal" role="form" id="catalogForm" style="margin-top:20px">
        	<c:choose>
				<c:when test="${type!='value'}">
					<div class="list-item">
						<div class="col-xs-3 item-left">规格分类名称</div>
						<div class="col-xs-9 item-right">
							<input type="hidden" readonly class="form-control" name="id" value="${id}">
							<input type="text" class="form-control" name="name" value="${name}" placeholder="请输入规格分类名称">
			             </div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="list-item">
						<div class="col-xs-3 item-left">规格分类编号</div>
						<div class="col-xs-9 item-right">
							<input type="text" readonly class="form-control" name="specsId" value="${specsId}">
			             </div>
					</div>
					<div class="list-item">
						<div class="col-xs-3 item-left">规格分类名称</div>
						<div class="col-xs-9 item-right">
							<input type="text" readonly class="form-control" value="${name}">
			             </div>
					</div>
					<div class="list-item">
						<div class="col-xs-3 item-left">规格值</div>
						<div class="col-xs-9 item-right">
							<input type="hidden" readonly class="form-control" name="id" value="${id}">
							<input type="text" class="form-control" name="value" value="${value}" placeholder="请输入规格值">
			             </div>
					</div>
				</c:otherwise>
			</c:choose>
			<div class="submit-btn">
            	<button type="button" id="submitBtn">确定</button>
            	<button type="button" id="resetBtn">重置</button>
             </div>
		</form>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script type="text/javascript">
	
	 $("#submitBtn").click(function(){
		 if($('#catalogForm').data("bootstrapValidator").isValid()){
			 var type = "${type}";
			 var strUrl = "${wmsUrl}/admin/goods/specsMng/";
			 if (type!="value") {
				 strUrl = strUrl + "updateSpecs.shtml";
			 } else {
				 strUrl = strUrl + "updateSpecsValue.shtml";
			 }
			 $.ajax({
				 url:strUrl,
				 type:'post',
				 data:JSON.stringify(sy.serializeObject($('#catalogForm'))),
				 contentType: "application/json; charset=utf-8",
				 dataType:'json',
				 success:function(data){
					 if(data.success){	
						 layer.alert("修改成功");
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
              message: '名称不正确',
              validators: {
                  notEmpty: {
                      message: '名称不能为空！'
                  }
              }
      	  }
      }
  });
	
	
	
	</script>
</body>
</html>
