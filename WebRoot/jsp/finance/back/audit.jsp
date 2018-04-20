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
		<form class="form-horizontal" role="form" id="gradeForm" >
        	<div class="title">
        		<h1>退款审核</h1>
        	</div>
        	<div class="list-item">
				<div class="col-sm-3 item-left">订单编号</div>
				<div class="col-sm-9 item-right">
                	<input type="text" readonly class="form-control" name="orderId" id="orderId" value="${orderId}">
	            </div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">交易流水号</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="payNo" id="payNo">
	            </div>
			</div>
			<div class="submit-btn">
            	<button type="button" id="submitBtn">确定</button>
            </div>
       	</form>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script type="text/javascript">
	
	 $("#submitBtn").click(function(){
		 if ($("#payNo").val() == "") {
			 layer.alert("请填写交易流水号！");
			 return;
		 }
		 $.ajax({
			 url:"${wmsUrl}/admin/finance/orderBackMng/audit.shtml?orderId="+$("#orderId").val()+"&payNo="+$("#payNo").val(),
			 type:'post',
// 			 data:JSON.stringify(sy.serializeObject($('#gradeForm'))),
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){	
					 layer.alert("审核成功");
					 parent.layer.closeAll();
					 parent.location.reload();
				 }else{
					 layer.alert(data.msg);
				 }
			 },
			 error:function(){
				 layer.alert("审核提交失败，请重试");
			 }
		 });
  	  });
	</script>
</body>
</html>
