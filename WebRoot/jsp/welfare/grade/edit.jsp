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
				<label class="col-xs-3 item-left" >客户类型<font style="color:red">*</font> </label>
				<div class="col-xs-9 item-right">
            		<input type="hidden" class="form-control" name="id" value="${grade.id}">
					<select class="form-control" name="welfareType" id="welfareType">
						<c:choose>
						   <c:when test="${grade.welfareType == 0}">
						   		<option value="0" selected="selected">普通客户</option>
						   		<option value="1">福利客户</option>
						   </c:when>
						   <c:otherwise>
						   		<option value="0">普通客户</option>
						   		<option value="1" selected="selected">福利客户</option>
						   </c:otherwise>
						</c:choose> 
	                </select>
				</div>
			</div>
			<div class="list-item" id="rebate" style="display: none">
				<label class="col-xs-3 item-left" >优惠比例<font style="color:red">*</font> </label>
				<div class="col-xs-9 item-right">
					<input type="text" class="form-control" id="welfareRebate" name="welfareRebate" value="${grade.welfareRebate}">
					<div class="item-content">
		             	（福利网站商品的优惠比例，例：0.17）
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
	
	$(function(){
		if ($("#welfareType").val() == 1) {
			$('#rebate').stop();
			$('#rebate').slideDown(300);
		}
	})
	
	$("#welfareType").change(function(){
		if ($("#welfareType").val() == 0) {
			$('#rebate').stop();
			$('#rebate').slideUp(300);
			$("#welfareRebate").val(0);
		} else if ($("#welfareType").val() == 1) {
			$('#rebate').stop();
			$('#rebate').slideDown(300);
		}
	});
	
	 $("#submitBtn").click(function(){
		 $.ajax({
			 url:"${wmsUrl}/admin/welfare/welfareMng/updWelfareType.shtml",
			 type:'post',
			 data:JSON.stringify(sy.serializeObject($('#brandForm'))),
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){	
					 parent.layer.closeAll();
// 					 parent.reloadTable();
					 parent.location.reload()
				 }else{
					 layer.alert(data.msg);
				 }
			 },
			 error:function(){
				 layer.alert("提交失败，请联系客服处理");
			 }
		 });
	 });
	</script>
</body>
</html>
