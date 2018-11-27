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
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@include file="../resourceLink.jsp"%>
</head>

<body>
	<section class="content-iframe content">
        <form class="form-horizontal" role="form" id="supplierForm">
			<div class="title">
	       		<h1>基本信息</h1>
	       	</div>
	      	<div class="list-item">
				<div class="col-sm-3 item-left">供应商名称</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="supplierName">
				</div>
			</div>
	      	<div class="list-item">
				<div class="col-sm-3 item-left">供应商代码</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="supplierCode">
				</div>
			</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">公司名称</div>
				<div class="col-sm-9 item-right">
             		<input type="text" class="form-control" name="country">
				</div>
			</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">省</div>
				<div class="col-sm-9 item-right">
               		<input type="text" class="form-control" name="province">
				</div>
			</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">市</div>
				<div class="col-sm-9 item-right">
               		<input type="text" class="form-control" name="city">
				</div>
			</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">区</div>
				<div class="col-sm-9 item-right">
               		<input type="text" class="form-control" name="area">
				</div>
			</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">地址</div>
				<div class="col-sm-9 item-right">
               		<input type="text" class="form-control" name="address">
				</div>
			</div>
			<div class="title">
	       		<h1>财务信息</h1>
	       	</div>
	      	<div class="list-item">
				<div class="col-sm-3 item-left">合同类型</div>
				<div class="col-sm-9 item-right">
					<select class="form-control" name="contractType" id="contractType">
                   	  <option selected="selected" value="1">一件代发</option>
                   	  <option value="2">长期供货</option>
                   	  <option value="3">框架合同</option>
                   	  <option value="4">其他</option>
	                </select>
				</div>
			</div>
	      	<div class="list-item">
				<div class="col-sm-3 item-left">付款方式</div>
				<div class="col-sm-9 item-right">
		            <select class="form-control" name="payType" id="payType">
                   	  <option selected="selected" value="1">预付款</option>
                   	  <option value="2">现付</option>
                   	  <option value="3">账期</option>
	                </select>
				</div>
			</div>
			<div class="title">
	       		<h1>联系方式</h1>
	       	</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">采购负责人</div>
				<div class="col-sm-9 item-right">
	                <input type="text" class="form-control" name="operator">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">电话</div>
				<div class="col-sm-9 item-right">
	                <input type="text" class="form-control" name="phone">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">邮箱</div>
				<div class="col-sm-9 item-right">
	                <input type="text" class="form-control" name="email">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">qq</div>
				<div class="col-sm-9 item-right">
	                <input type="text" class="form-control" name="qq">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">传真</div>
				<div class="col-sm-9 item-right">
	                <input type="text" class="form-control" name="fax">
				</div>
			</div>
			
	        <div class="submit-btn">
	           	<button type="button" id="submitBtn">保存信息</button>
	       	</div>
		</form>
	</section>
	<%@include file="../resourceScript.jsp"%>
	<script type="text/javascript">
	
	 $("#submitBtn").click(function(){
// 		 if($('#supplierForm').data("bootstrapValidator").isValid()){
			 $.ajax({
				 url:"${wmsUrl}/admin/supplier/supplierMng/addSupplier.shtml",
				 type:'post',
				 data:JSON.stringify(sy.serializeObject($('#supplierForm'))),
				 contentType: "application/json; charset=utf-8",
				 dataType:'json',
				 success:function(data){
					 if(data.success){	
						 layer.alert("插入成功");
						 parent.layer.closeAll();
						 parent.reloadTable();
					 }else{
						 parent.reloadTable();
						 layer.alert(data.msg);
					 }
				 },
				 error:function(){
					 layer.alert("提交失败，请联系客服处理");
				 }
			 });
// 		 }else{
// 			 layer.alert("信息填写有误");
// 		 }
	 });
	
	 $('#resetBtn').click(function() {
	        $('#supplierForm').data('bootstrapValidator').resetForm(true);
	    });
	
	$('#supplierForm').bootstrapValidator({
//      live: 'disabled',
      message: 'This value is not valid',
      feedbackIcons: {
          valid: 'glyphicon glyphicon-ok',
          invalid: 'glyphicon glyphicon-remove',
          validating: 'glyphicon glyphicon-refresh'
      },
      fields: {
    	  supplierName: {
              message: '名字不正确',
              validators: {
                  notEmpty: {
                      message: '用户名不能为空！'
                  },
                  stringLength: {
                      min: 2,
                      max: 30,
                      message: '分级名称必须在2-30位字符'
                  },
              }
      	  },
      	 country: {
	          message: '公司名称不能为空',
	          validators: {
	              notEmpty: {
	                  message: '公司名称不能为空！'
	              }
	          }
	  	  },
	      address: {
	          message: '地址不能为空',
	          validators: {
	              notEmpty: {
	                  message: '地址不能为空！'
	              }
	          }
	  	  },
	  	province: {
	          message: '省不能为空',
	          validators: {
	              notEmpty: {
	                  message: '省不能为空！'
	              }
	          }
	  	  },
	  	phone: {
	          message: '电话不能为空',
	          validators: {
	              notEmpty: {
	                  message: '电话不能为空！'
	              }
	          }
	  	  },
	  	city: {
	          message: '市不能为空',
	          validators: {
	              notEmpty: {
	                  message: '市不能为空！'
	              }
	          }
	  	  },
		  area: {
		          message: '区不能为空',
		          validators: {
		              notEmpty: {
		                  message: '区不能为空！'
		              }
		          }
		  	  }
      	  }
  });
	</script>
</body>
</html>
