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
		<form class="form-horizontal" role="form" id="taskForm" style="margin-top:20px;">
	       	<div class="list-item">
				<div class="col-sm-3 item-left">调度器名称</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="jobName" id="jobName" value="${task.jobName}" readonly>
					<input type="hidden" class="form-control" name="id" id="id" value="${task.id}"/>
					<input type="hidden" class="form-control" name="jobGroup" id="jobGroup" value="${task.jobGroup}"/>
				</div>
			</div>
<!-- 			<div class="list-item"> -->
<!-- 				<div class="col-sm-3 item-left">执行时间</div> -->
<!-- 				<div class="col-sm-9 item-right"> -->
<!-- 					<label><input type="checkbox" name="execTime" value="0"/>00:00</label> -->
<!-- 					<label><input type="checkbox" name="execTime" value="1"/>01:00</label> -->
<!-- 					<label><input type="checkbox" name="execTime" value="2"/>02:00</label> -->
<!-- 					<label><input type="checkbox" name="execTime" value="3"/>03:00</label> -->
<!-- 					<label><input type="checkbox" name="execTime" value="4"/>04:00</label> -->
<!-- 					<label><input type="checkbox" name="execTime" value="5"/>05:00</label> -->
<!-- 					<label><input type="checkbox" name="execTime" value="6"/>06:00</label> -->
<!-- 					<label><input type="checkbox" name="execTime" value="7"/>07:00</label> -->
<!-- 					<br/> -->
<!-- 					<label><input type="checkbox" name="execTime" value="8"/>08:00</label> -->
<!-- 					<label><input type="checkbox" name="execTime" value="9"/>09:00</label> -->
<!-- 					<label><input type="checkbox" name="execTime" value="10"/>10:00</label> -->
<!-- 					<label><input type="checkbox" name="execTime" value="11"/>11:00</label> -->
<!-- 					<label><input type="checkbox" name="execTime" value="12"/>12:00</label> -->
<!-- 					<label><input type="checkbox" name="execTime" value="13"/>13:00</label> -->
<!-- 					<label><input type="checkbox" name="execTime" value="14"/>14:00</label> -->
<!-- 					<label><input type="checkbox" name="execTime" value="15"/>15:00</label> -->
<!-- 					<br/> -->
<!-- 					<label><input type="checkbox" name="execTime" value="16"/>16:00</label> -->
<!-- 					<label><input type="checkbox" name="execTime" value="17"/>17:00</label> -->
<!-- 					<label><input type="checkbox" name="execTime" value="18"/>18:00</label> -->
<!-- 					<label><input type="checkbox" name="execTime" value="19"/>19:00</label> -->
<!-- 					<label><input type="checkbox" name="execTime" value="20"/>20:00</label> -->
<!-- 					<label><input type="checkbox" name="execTime" value="21"/>21:00</label> -->
<!-- 					<label><input type="checkbox" name="execTime" value="22"/>22:00</label> -->
<!-- 					<label><input type="checkbox" name="execTime" value="23"/>23:00</label> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 			<div class="list-item"> -->
<!-- 				<div class="col-sm-3 item-left">重复日期</div> -->
<!-- 				<div class="col-sm-9 item-right"> -->
<!-- 					<label><input type="checkbox" name="repDate" value="1"/>周一</label> -->
<!-- 					<label><input type="checkbox" name="repDate" value="2"/>周二</label> -->
<!-- 					<label><input type="checkbox" name="repDate" value="3"/>周三</label> -->
<!-- 					<label><input type="checkbox" name="repDate" value="4"/>周四</label> -->
<!-- 					<label><input type="checkbox" name="repDate" value="5"/>周五</label> -->
<!-- 					<label><input type="checkbox" name="repDate" value="6"/>周六</label> -->
<!-- 					<label><input type="checkbox" name="repDate" value="7"/>周日</label> -->
<!-- 				</div> -->
<!-- 			</div> -->
			<div class="list-item">
				<div class="col-sm-3 item-left">执行间隔</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="cronExpression" id="cronExpression" value="${task.cronExpression}">
				</div>
			</div>
			
	        <div class="submit-btn">
	           	<button type="button" id="submitBtn">保存信息</button>
	       	</div>
		</form>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script type="text/javascript">	 
	 $("#submitBtn").click(function(){
		 $.ajax({
			 url:"${wmsUrl}/admin/system/timetaskMng/edit.shtml",
			 type:'post',
			 data:JSON.stringify(sy.serializeObject($('#taskForm'))),
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){	
					 layer.alert("保存成功");
					 parent.layer.closeAll();
					 parent.location.reload();
				 }else{
					 layer.alert(data.msg);
				 }
			 },
			 error:function(){
				 layer.alert("保存失败，请联系客服处理");
			 }
		 });
	 });
	</script>
</body>
</html>
