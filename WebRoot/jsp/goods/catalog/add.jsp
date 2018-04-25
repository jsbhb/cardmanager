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
				<c:when  test="${type==1}">
					<div class="list-item">
						<div class="col-sm-3 item-left">一级分类</div>
						<div class="col-sm-9 item-right">
							<input type="hidden" readonly class="form-control" name="type" value="${type}">
			             </div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="list-item">
						<div class="col-sm-3 item-left">上级分类编号</div>
						<div class="col-sm-9 item-right">
							<input type="text" readonly class="form-control" name="parentId" value="${parentId}">
                  			<input type="hidden" readonly class="form-control" name="type" value="${type}">
			             </div>
					</div>
					<div class="list-item">
						<div class="col-sm-3 item-left">上级分类名称</div>
						<div class="col-sm-9 item-right">
							<input type="text" readonly class="form-control" value="${parentName}">
			             </div>
					</div>
				</c:otherwise>
			</c:choose>
			<div class="list-item">
				<div class="col-sm-3 item-left">分类名称</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="name" placeholder="请输入分类名称">
	             </div>
			</div>
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
