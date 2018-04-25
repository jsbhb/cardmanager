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
		<form class="form-horizontal" role="form" id="gradeForm" >
			<div class="title">
	       		<h1>提现审核信息</h1>
	       	</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">角色名称</div>
				<div class="col-sm-9 item-right">
					<input type="text" readonly class="form-control" name="operatorName"value="${Detail.operatorName}">
                  	<input type="hidden" readonly class="form-control" name="id" id="id" value="${Detail.id}">
				</div>
			</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">提现金额</div>
				<div class="col-sm-9 item-right">
                	<input type="text" readonly class="form-control" name="outMoney" value="${Detail.outMoney}">
				</div>
			</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">审核结果</div>
				<div class="col-sm-9 item-right">
                	<label>
	                  	同意<input type="radio" name="pass" id="pass" value="true" class="flat-red">
	                </label>
	                <label>
	                  	拒绝<input type="radio" name="pass" id="pass" value="false" class="flat-red" checked>
	                </label>
				</div>
			</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">交易流水号</div>
				<div class="col-sm-9 item-right">
                	<input type="text" class="form-control" name="payNo" id="payNo">
				</div>
			</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">备注</div>
				<div class="col-sm-9 item-right">
                	<input type="text" class="form-control" name="remark" id="remark">
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
		 var pass=$('input:radio[name="pass"]:checked').val();
		 if (pass == true) {
			 if ($("#payNo").val() == "") {
				 layer.alert("请填写转账流水号！");
				 return;
			 }
		 }
		 $.ajax({
			 url:"${wmsUrl}/admin/finance/withdrawalsMng/audit.shtml",
			 type:'post',
			 data:JSON.stringify(sy.serializeObject($('#gradeForm'))),
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){	
					 layer.alert("审核成功");
					 parent.layer.closeAll();
					 parent.reloadTable();
				 }else{
					 parent.reloadTable();
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
