<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@include file="../../resource.jsp"%>

<link rel="stylesheet" href="${wmsUrl}/validator/css/bootstrapValidator.min.css">
<script src="${wmsUrl}/validator/js/bootstrapValidator.min.js"></script>
</head>

<body>
	<section class="content-iframe">
       	<form class="form-horizontal" role="form" id="goodsBaseForm" >
        	<div class="title">
        		<h1>基本信息</h1>
        	</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">商品品牌</div>
				<div class="col-sm-9 item-right">
					<select class="form-control" name="brandId" id="brandId" disabled="disabled">
			            <option selected="selected" value="${brand.brandId}">${brand.brand}</option>
			                 	  <!-- <option selected="selected" value="-1">未选择</option>
			                 	  <c:forEach var="brand" items="${brands}">
			                 	  	<option value="${brand.brandId}">${brand.brand}</option>
			                 	  </c:forEach> -->
			        </select>
		            <input type="hidden" class="form-control" name="id" id="id" value="${brand.id}"/>
		            <input type="hidden" class="form-control" name="brand" id="brand" value="${brand.brand}"/>
	             </div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">商品分类</div>
				<div class="col-sm-9 item-right">
					<div class="right-items">
						<select class="form-control" name="firstCatalogId" id="firstCatalogId" disabled="disabled">
	                  	  <option selected="selected" value="${firstId}">${firstName}</option>
	                  	  <!-- <option selected="selected" value="-1">未选择</option>
	                  	  <c:forEach var="first" items="${firsts}">
	                  	  	<option value="${first.firstId}">${first.name}</option>
	                  	  </c:forEach> -->
	                	</select>	
					</div>
					<div class="right-items">
						<select class="form-control" name="secondCatalogId" id="secondCatalogId" disabled="disabled">
						 <option selected="selected" value="${secondId}">${secondName}</option>
		                </select>
	                </div>
	                <div class="right-items last-items">
						<select class="form-control" name="thirdCatalogId" id="thirdCatalogId" disabled="disabled">
						<option selected="selected" value="${thirdId}">${thirdName}</option>
		                </select>
	                </div>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">商品名称</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="goodsName" value="${fn:trim(brand.goodsName)}">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">计量单位</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="unit" value="${brand.unit}">
				</div>
			</div>
			<div class="title">
        		<h1>海关信息(跨境商品必填)</h1>
        	</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">海关代码</div>
				<div class="col-sm-9 item-right">
                 	<input type="text" class="form-control" name="hscode" id="hscode" <c:if test="${brand.hscode != 'null'}"> value="${fn:trim(brand.hscode)}" </c:if>>
		            <div class="item-content">
	             		（海关代码HSCode）
	             	</div>
	            </div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">增值税率</div>
				<div class="col-sm-9 item-right">
                 	<input type="text" class="form-control" name="incrementTax" value="${brand.incrementTax}">
	            	<div class="item-content">
	             		（请按小数格式输入，例：0.17）
	             	</div>
	            </div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">海关税率</div>
				<div class="col-sm-9 item-right">
                	<input type="text" class="form-control" name="tariff" value="${brand.tariff}">
	            	<div class="item-content">
	             		（请按小数格式输入，例：0.17）
	             	</div>
	            </div>
			</div>
			<div class="submit-btn">
            	<button type="button" id="submitBtn">提交</button>
             </div>
		</form>
	</section>
	<script type="text/javascript">
	
	 $("#submitBtn").click(function(){
		 $('#goodsBaseForm').data("bootstrapValidator").validate();
		 if($('#goodsBaseForm').data("bootstrapValidator").isValid()){
			 $.ajax({
				 url:"${wmsUrl}/admin/goods/baseMng/editGoodsBase.shtml",
				 type:'post',
				 data:JSON.stringify(sy.serializeObject($('#goodsBaseForm'))),
				 contentType: "application/json; charset=utf-8",
				 dataType:'json',
				 success:function(data){
					 if(data.success){	
						 layer.alert("插入成功");
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
	
	$('#goodsBaseForm').bootstrapValidator({
//      live: 'disabled',
      message: 'This value is not valid',
      feedbackIcons: {
          valid: 'glyphicon glyphicon-ok',
          invalid: 'glyphicon glyphicon-remove',
          validating: 'glyphicon glyphicon-refresh'
      },
      fields: {
    	  goodsName: {
              message: '商品名称不正确',
              validators: {
                  notEmpty: {
                      message: '商品名称不能为空！'
                  }
              }
      	  },
      	  unit: {
            message: '计量单位不正确',
            validators: {
                notEmpty: {
                    message: '计量单位不能为空！'
                }
            }
    	  },
      	  hscode: {
              message: '海关代码不正确',
              validators: {
                  notEmpty: {
                      message: '海关代码不能为空！'
                  }
              }
      	  },
     	  tariff:{
			   message: '海关税率不正确',
			   validators: {
				   notEmpty: {
                     message: '海关税率不能为空'
                 },
				   regexp: {
	                   regexp: /^\d+(\.\d+)?$/,
	                   message: '海关税率为数字类型'
	               }
			   }
		   },
		   incrementTax:{
			   message: '增值税率不正确',
			   validators: {
				   notEmpty: {
                     message: '增值税率不能为空'
                 },
				   regexp: {
	                   regexp: /^\d+(\.\d+)?$/,
	                   message: '增值税率为数字类型'
	               }
			   }
		   }
      }
  });
	</script>
</body>
</html>
