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
	<section class="content">
        <div class="main-content">
			<div class="row">
				<div class="col-xs-12" >
					<form class="form-horizontal" role="form" id="gradeForm" >
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"><h4>新增返充申请</h4></label>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">角色名称</label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
		                  			<input type="text" readonly class="form-control" name="operatorName"value="${opt.gradeName}">
				                  	<input type="hidden" readonly class="form-control" name="centerId" id="centerId" value="${typeId}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">可使用金额</label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
				                  <input type="text" readonly class="form-control" name="startMoney" id="startMoney" value="${info.canBePresented}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">资金池余额</label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
				                  <input type="text" readonly class="form-control" name="poolMoney" id="poolMoney" value="${entity.money}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">返充金额</label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
				                  <input type="text" class="form-control" name="money" id="money" value="0">
				                </div>
							</div>
						</div>
						<div class="col-md-offset-3 col-md-9">
							<div class="form-group">
	                            <button type="button" class="btn btn-primary" id="submitBtn">提交</button>
	                        </div>
                       </div>
					</form>
				</div>
			</div>
		</div>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script type="text/javascript">
	
	 $("#submitBtn").click(function(){
		 var tmpStartMoney = $("#startMoney").val();
		 var tmpMoney = $("#money").val();
		 if (tmpMoney <= 0) {
			 layer.alert("返充金额不正确，请重新填写返充金额");
			 return;
		 }
		 if (tmpMoney - tmpStartMoney > 0) {
			 layer.alert("返充金额超出可使用金额，请重新填写返充金额");
			 return;
		 }
		 $.ajax({
			 url:"${wmsUrl}/admin/user/userRefillingMng/apply.shtml",
			 type:'post',
			 data:JSON.stringify(sy.serializeObject($('#gradeForm'))),
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){	
					 layer.alert("申请已提交，请等待管理员审核");
					 parent.layer.closeAll();
					 parent.reloadTable();
				 }else{
					 parent.reloadTable();
					 layer.alert(data.msg);
				 }
			 },
			 error:function(){
				 layer.alert("申请提交失败，请重试");
			 }
		 });
  	  });
	
	
	
	</script>
</body>
</html>
