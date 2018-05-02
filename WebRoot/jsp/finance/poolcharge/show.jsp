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
	<section class="content-iframe content">
		<form class="form-horizontal" role="form" id="gradeForm">
			<div class="title">
	       		<h1>分级信息</h1>
	       	</div>
	       	<div class="list-item">
				<div class="col-xs-3 item-left">分级名称</div>
				<div class="col-xs-9 item-right">
					<input type="text" readonly class="form-control" name="centerName" id="centerName" value="${centerName}">
                  	<input type="hidden" readonly class="form-control" name="centerId" id="centerId" value="${centerId}">
				</div>
			</div>
	       	<div class="list-item">
				<div class="col-xs-3 item-left">充值金额</div>
				<div class="col-xs-9 item-right">
                	<input type="text" class="form-control" name="money" id="money">
				</div>
			</div>
	       	<div class="list-item">
				<div class="col-xs-3 item-left">交易流水号</div>
				<div class="col-xs-9 item-right">
                	<input type="text" class="form-control" name="payNo" id="payNo">
				</div>
			</div>
			<div class="submit-btn">
	           	<button type="button" id="submitBtn">提交</button>
	       	</div>
		</form>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script type="text/javascript">
	
	 $("#submitBtn").click(function(){
		 if($('#gradeForm').data("bootstrapValidator").isValid()){
			 if ($("#money").val() <= 0) {
				 layer.alert("充值不正确，请重新填写充值金额");
				 return;
			 }
			 $.ajax({
				 url:"${wmsUrl}/admin/finance/capitalPoolMng/charge.shtml",
				 type:'post',
// 				 data:JSON.stringify(sy.serializeObject($('#gradeForm'))),
				 data:{
					 centerId : $("#centerId").val(),
					 money : $("#money").val(),
					 payNo : $("#payNo").val()
					 },
// 				 contentType: "application/json; charset=utf-8",
				 dataType:'json',
				 success:function(data){
					 if(data.success){	
						 layer.alert("充值成功");
						 parent.layer.closeAll();
						 parent.reloadTable();
					 }else{
						 parent.reloadTable();
						 layer.alert(data.msg);
					 }
				 },
				 error:function(){
					 layer.alert("充值失败，请重试");
				 }
			 });
		 }else{
			 layer.alert("信息填写有误");
		 }
	 });
	
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
    	  money: {
              message: '充值金额不正确',
              validators: {
                  notEmpty: {
                      message: '充值金额不能为空'
                  },
                  numeric: {
                      message: '充值金额只能输入数字'
                  },
              }
      	  },
      	  payNo: {
	      		message: '转账流水号不正确',
	            validators: {
	                notEmpty: {
	                    message: '转账流水号不能为空'
	                },
	                stringLength: {
	                    min: 8,
	                    max: 30,
	                    message: '转账流水号必须在8-30位字符'
	                },
	            }
	  	  }
      }
  });
	</script>
</body>
</html>
