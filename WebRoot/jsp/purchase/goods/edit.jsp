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
					<form class="form-horizontal" role="form" id="purchaseGoodsEditForm" >
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right" for="form-field-1"><h4>商品订购信息</h4></label>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">商品名称</label>
							<div class="col-sm-5">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
		                  			<input type="text" class="form-control" name="goodsName" id="goodsName" readonly="readonly" value="${goodsItem.goodsName}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">订货价</label>
							<div class="col-sm-5">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
					              <input type="hidden" class="form-control" name="itemId" id="itemId" value="${price.itemId}"/>
		                  	      <input type="text" class="form-control" name="retailPrice" value="${price.retailPrice}">
				                </div>
							</div>
							<label class="control-label no-padding-left" for="form-field-1">总部分销价：${chkGoodsPrice.fxPrice}</label>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">最小起批量</label>
							<div class="col-sm-5">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
		                  			<input type="text" class="form-control" name="min" id="min" value="${price.min}">
				                </div>
							</div>
							<label class="control-label no-padding-left" for="form-field-1">总部最小起批量：${chkGoodsPrice.min}</label>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">最大起批量</label>
							<div class="col-sm-5">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
		                  			<input type="text" class="form-control" name="max" id="max" value="${price.max}">
				                </div>
							</div>
							<label class="control-label no-padding-left" for="form-field-1">总部最大起批量：${chkGoodsPrice.max}</label>
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
		 if($('#purchaseGoodsEditForm').data("bootstrapValidator").isValid()){
			 var tmpMin = Number($("#min").val());
			 var tmpMax = Number($("#max").val());
			 if (tmpMin > tmpMax) {
				 layer.alert("填写的最小起批量大于最大起批量，请修改！");
				 return;
			 }
			 $.ajax({
				 url:"${wmsUrl}/admin/purchase/goodsMng/editGoodsPrice.shtml",
				 type:'post',
				 data:JSON.stringify(sy.serializeObject($('#purchaseGoodsEditForm'))),
				 contentType: "application/json; charset=utf-8",
				 dataType:'json',
				 success:function(data){
					 if(data.success){	
						 layer.alert("编辑成功");
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
	        $('#purchaseGoodsEditForm').data('bootstrapValidator').resetForm(true);
	    });
	
	$('#purchaseGoodsEditForm').bootstrapValidator({
//      live: 'disabled',
      message: 'This value is not valid',
      feedbackIcons: {
          valid: 'glyphicon glyphicon-ok',
          invalid: 'glyphicon glyphicon-remove',
          validating: 'glyphicon glyphicon-refresh'
      },
      fields: {
    	   retailPrice:{
			   message: '订货价不正确',
			   validators: {
				   notEmpty: {
                     message: '订货价不能为空'
                 },
				   regexp: {
	                   regexp: /^\d+(\.\d+)?$/,
	                   message: '订货价为数字类型'
	               }
			   }
		   },
		   min:{
			   message: '最小起批量不正确',
			   validators: {
				   notEmpty: {
                     message: '最小起批量不能为空'
                 },
				   regexp: {
	                   regexp: /^\d+(\.\d+)?$/,
	                   message: '最小起批量为数字类型'
	               }
			   }
		   },
		   max:{
			   message: '最大起批量不正确',
			   validators: {
				   notEmpty: {
                     message: '最大起批量不能为空'
                 },
				   regexp: {
	                   regexp: /^\d+(\.\d+)?$/,
	                   message: '最大起批量为数字类型'
	               }
			   }
		   }
      }
  });
	
	</script>
</body>
</html>
