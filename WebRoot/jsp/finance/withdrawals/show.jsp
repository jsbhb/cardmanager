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
<%@include file="../../resource.jsp"%>

<%-- <link rel="stylesheet" href="${wmsUrl}/validator/css/bootstrapValidator.min.css"> --%>
<%-- <script src="${wmsUrl}/validator/js/bootstrapValidator.min.js"></script> --%>
</head>

<body>
	<section class="content">
        <div class="main-content">
			<div class="row">
				<div class="col-xs-12" >
					<form class="form-horizontal" role="form" id="gradeForm" >
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"><h4>提现申请</h4></label>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">角色名称</label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
		                  			<input type="text" readonly class="form-control" name="operatorName"value="${Detail.operatorName}">
				                  	<input type="hidden" readonly class="form-control" name="id" id="id" value="${Detail.id}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">提现金额</label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
				                  <input type="text" readonly class="form-control" name="outMoney" value="${Detail.outMoney}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">审核结果<font style="color:red">*</font> </label>
							<div class="col-sm-6">
								<label>
				                  	同意<input type="radio" name="pass" id="pass" value="true" class="flat-red">
				                </label>
				                <label>
				                  	拒绝<input type="radio" name="pass" id="pass" value="false" class="flat-red" checked>
				                </label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">交易流水号</label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
				                  <input type="text" class="form-control" name="payNo" id="payNo">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">备注</label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
				                  <input type="text" class="form-control" name="remark" id="remark">
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
	<%@ include file="../../footer.jsp"%>
	<script type="text/javascript">
	
	 $("#submitBtn").click(function(){
		 if ($("#pass").val()) {
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
