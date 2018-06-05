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
				<div class="col-sm-3 item-left">供应商编号</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" readonly name="id" value="${supplier.id}">
				</div>
			</div>
	      	<div class="list-item">
				<div class="col-sm-3 item-left">供应商名称</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="supplierName" value="${supplier.supplierName == 'null' ? '' : supplier.supplierName}">
				</div>
			</div>
	      	<div class="list-item">
				<div class="col-sm-3 item-left">供应商代码</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="supplierCode" value="${supplier.supplierCode == 'null' ? '' : supplier.supplierCode}">
				</div>
			</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">公司名称</div>
				<div class="col-sm-9 item-right">
             		<input type="text" class="form-control" name="country" value="${supplier.country == 'null' ? '' : supplier.country}">
				</div>
			</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">省</div>
				<div class="col-sm-9 item-right">
               		<input type="text" class="form-control" name="province" value="${supplier.province == 'null' ? '' : supplier.province}">
				</div>
			</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">市</div>
				<div class="col-sm-9 item-right">
               		<input type="text" class="form-control" name="city" value="${supplier.city == 'null' ? '' : supplier.city}">
				</div>
			</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">区</div>
				<div class="col-sm-9 item-right">
               		<input type="text" class="form-control" name="area" value="${supplier.area == 'null' ? '' : supplier.area}">
				</div>
			</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">地址</div>
				<div class="col-sm-9 item-right">
               		<input type="text" class="form-control" name="address" value="${supplier.address == 'null' ? '' : supplier.address}">
				</div>
			</div>
			<div class="title">
	       		<h1>联系方式</h1>
	       	</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">负责人</div>
				<div class="col-sm-9 item-right">
	                <input type="text" class="form-control" name="operator" value="${supplier.operator == 'null' ? '' : supplier.operator}">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">电话</div>
				<div class="col-sm-9 item-right">
	                <input type="text" class="form-control" name="phone" value="${supplier.phone == 'null' ? '' : supplier.phone}">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">邮箱</div>
				<div class="col-sm-9 item-right">
	                <input type="text" class="form-control" name="email" value="${supplier.email == 'null' ? '' : supplier.email}">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">qq</div>
				<div class="col-sm-9 item-right">
	                <input type="text" class="form-control" name="qq" value="${supplier.qq == 'null' ? '' : supplier.qq}">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">传真</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="fax" value="${supplier.fax == 'null' ? '' : supplier.fax}">
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
				 url:"${wmsUrl}/admin/supplier/supplierMng/editSupplier.shtml",
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
