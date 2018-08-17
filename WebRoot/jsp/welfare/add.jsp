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
<%@include file="../resourceLink.jsp"%>
</head>

<body>
	<section class="content-iframe">
		<form class="form-horizontal" role="form" id="catalogForm" style="margin-top:20px">
			<div class="list-item">
				<div class="col-xs-3 item-left">分级名称</div>
				<div class="col-xs-9 item-right">
			   		<select class="form-control" id="welfareGradeId" name="welfareGradeId">
		                <c:forEach var="grade" items="${gradeList}">
		                <option value="${grade.id}">${grade.name}</option>
		                </c:forEach>
		            </select>
				</div>
			</div>
			<div class="list-item">
				<div class="col-xs-3 item-left">邀请人名称</div>
				<div class="col-xs-9 item-right">
           			<input type="hidden" readonly class="form-control" name="gradeId" value="${gradeId}">
					<input type="text" class="form-control" name="name" placeholder="请输入邀请人名称">
	             </div>
			</div>
			<div class="list-item">
				<div class="col-xs-3 item-left">邀请人手机号</div>
				<div class="col-xs-9 item-right">
					<input type="text" class="form-control" name="phone" placeholder="请输入邀请人手机号">
	             </div>
			</div>
			<div class="submit-btn">
            	<button type="button" id="submitBtn">确定</button>
             </div>
		</form>
	</section>
	<%@include file="../resourceScript.jsp"%>
	<script type="text/javascript">
	
	 $("#submitBtn").click(function(){
		 if($('#catalogForm').data("bootstrapValidator").isValid()){
			 $.ajax({
				 url:"${wmsUrl}/admin/welfare/welfareMng/addInviterInfo.shtml",
				 type:'post',
				 data:JSON.stringify(sy.serializeObject($('#catalogForm'))),
				 contentType: "application/json; charset=utf-8",
				 dataType:'json',
				 success:function(data){
					 if(data.success){	
						 layer.alert("添加成功");
						 parent.layer.closeAll();
						 parent.location.reload();
					 }else{
						 layer.alert(data.msg);
					 }
				 },
				 error:function(){
					 layer.alert("添加失败，请联系客服处理");
				 }
			 });
		 }else{
			 layer.alert("信息填写有误");
		 }
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
              message: '邀请人名称不正确',
              validators: {
                  notEmpty: {
                      message: '邀请人名称不能为空！'
                  }
              }
      	  },
      	  phone: {
            message: '邀请人手机号不正确',
            validators: {
                notEmpty: {
                    message: '邀请人手机号不能为空！'
                }
            }
    	  }
      }
  });
	</script>
</body>
</html>
