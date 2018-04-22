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
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"><h4>基本信息</h4></label>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">区域中心名称</label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
		                  			<input type="text" readonly class="form-control" name="centerName" id="centerName" value="${centerName}">
				                  	<input type="hidden" readonly class="form-control" name="centerId" id="centerId" value="${centerId}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">清算金额<font style="color:red">*</font> </label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
				                  <input type="text" class="form-control" name="money" id="money">
				                </div>
							</div>
						</div>
						<div class="col-md-offset-3 col-md-9">
							<div class="form-group">
	                            <button type="button" class="btn btn-primary" id="submitBtn">提交</button>
	                            <button type="button" class="btn btn-info" id="resetBtn">重置</button>
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
		 if($('#gradeForm').data("bootstrapValidator").isValid()){
			 if ($("#money").val() <= 0) {
				 layer.alert("清算不正确，请重新填写清算金额");
				 return;
			 }
			 $.ajax({
				 url:"${wmsUrl}/admin/finance/capitalPoolMng/liquidation.shtml",
				 type:'post',
// 				 data:JSON.stringify(sy.serializeObject($('#gradeForm'))),
				 data:{
					 centerId : $("#centerId").val(),
					 money : $("#money").val()
					 },
// 				 contentType: "application/json; charset=utf-8",
				 dataType:'json',
				 success:function(data){
					 if(data.success){	
						 layer.alert("清算成功");
						 parent.layer.closeAll();
						 parent.reloadTable();
					 }else{
						 parent.reloadTable();
						 layer.alert(data.msg);
					 }
				 },
				 error:function(){
					 layer.alert("清算失败，请重试");
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
              message: '清算金额不正确',
              validators: {
                  notEmpty: {
                      message: '清算金额不能为空'
                  },
                  numeric: {
                      message: '清算金额只能输入数字'
                  },
              }
      	  }
      }
  });
	
	
	
	</script>
</body>
</html>
