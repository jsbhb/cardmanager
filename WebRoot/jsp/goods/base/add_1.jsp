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
				<div class="col-sm-3 item-left" for="form-field-1">商品品牌<font style="color:red">*</font> </div>
				<div class="col-sm-9 item-right">
					<select class="form-control" name="brandId" id="brandId">
                 	  <option selected="selected" value="-1">选择品牌</option>
                 	  <c:forEach var="brand" items="${brands}">
                 	  	<option value="${brand.brandId}">${brand.brand}</option>
                 	  </c:forEach>
			        </select>
	                <input type="hidden" class="form-control" name="brand" id="brand"/>
					<a class="addBtn" href="javascript:void(0);" onclick="toBrand()">新增品牌</a>
	             </div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left" for="form-field-1">商品分类<font style="color:red">*</font> </div>
				<div class="col-sm-9 item-right">
					<div class="right-items">
						<select class="form-control" name="firstCatalogId" id="firstCatalogId">
	                  	  <option selected="selected" value="-1">选择分类</option>
	                  	  <c:forEach var="first" items="${firsts}">
	                  	  	<option value="${first.firstId}">${first.name}</option>
	                  	  </c:forEach>
	                	</select>	
					</div>
					<div class="right-items">
						<select class="form-control" name="secondCatalogId" id="secondCatalogId">
						<option selected="selected" value="-1">选择分类</option>
		                </select>
	                </div>
	                <div class="right-items last-items">
						<select class="form-control" hidden name="thirdCatalogId" id="thirdCatalogId">
						<option selected="selected" value="-1">选择分类</option>
		                </select>
	                </div>
					<a class="addBtn" href="javascript:void(0);" onclick="toCategory()">新增分类</a>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left" for="form-field-1">商品名称<font style="color:red">*</font> </div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="goodsName">
				</div>
			</div>
			<!-- <div class="form-group">
				<label class="col-sm-2 control-label no-padding-right" for="form-field-1">商品条码<font style="color:red">*</font> </label>
				<div class="col-sm-5">
					<div class="input-group">
	                  <div class="input-group-addon">
	                    <i class="fa fa-pencil"></i>
	                  </div>
                 			<input type="text" class="form-control" name="encode" value="${brand.encode}">
	                </div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label no-padding-right" for="form-field-1">单位<font style="color:red">*</font> </label>
				<div class="col-sm-5">
					<div class="input-group">
	                  <div class="input-group-addon">
	                    <i class="fa fa-pencil"></i>
	                  </div>
                 			<input type="text" class="form-control" name="unit" value="${brand.unit}">
	                </div>
				</div>
			</div> -->
			<div class="title">
        		<h1>海关信息(跨境商品必填)</h1>
        	</div>
			<!-- <div class="form-group">
				<label class="col-sm-2 control-label no-padding-right" for="form-field-1">hscode</label>
				<div class="col-sm-5">
					<div class="input-group">
	                  <div class="input-group-addon">
	                    <i class="fa fa-pencil"></i>
	                  </div>
                 			<input type="text" class="form-control" name="hscode" value="${brand.hscode}">
	                </div>
				</div>
			</div> -->
			<div class="list-item">
				<div class="col-sm-3 item-left" for="form-field-1">增值税率</div>
				<div class="col-sm-9 item-right">
                 	<input type="text" class="form-control" name="incrementTax" id="incrementTax">
	            	<div class="item-content">
	             		（请按小数格式输入，例：0.17）
	             	</div>
	            </div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left" for="form-field-1">海关税率</div>
				<div class="col-sm-9 item-right">
                	<input type="text" class="form-control" name="tariff" id="tariff">
	            	<div class="item-content">
	             		（请按小数格式输入，例：0.17）
	             	</div>
	            </div>
			</div>
			<div class="submit-btn">
            	<button type="button" id="submitBtn">确定</button>
                <!-- <button type="button" class="btn btn-info" id="resetBtn">重置</button> -->
             </div>
		</form>
	</section>
<%-- 	<%@ include file="../../footer.jsp"%> --%>
	<script type="text/javascript">
	
	$("#brandId").change(function(){
		$("#brand").val($("#brandId").find("option:selected").text());
	});
	
	$("#firstCatalogId").change(function(){
		var firstId = $("#firstCatalogId").val();
		var secondSelect = $("#secondCatalogId");
		var thirdSelect = $("#thirdCatalogId");
		secondSelect.empty();
		$.ajax({
			 url:"${wmsUrl}/admin/goods/catalogMng/querySecondCatalogByFirstId.shtml?firstId="+firstId,
			 type:'post',
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){
					 if (data == null || data.length == 0) {
							return;
						}
						
						var list = data.obj;
						
						if (list == null || list.length == 0) {
							return;
						}
						var str = "";
						secondSelect.append("<option value='-1'>选择分类</option>")
						for (var i = 0; i < list.length; i++) {
							secondSelect.append("<option value='"+list[i].secondId+"'>"+list[i].name+"</option>")
						}
				 }else{
					 layer.alert(data.msg);
				 }
			 },
			 error:function(){
				 layer.alert("提交失败，请联系客服处理");
			 }
		 });
		
// 		if(thirdSelect.is(":visible")){
// 			thirdSelect.hide('fast');
// 		}
	});
	
	$("#secondCatalogId").change(function(){
		
		var secondId = $("#secondCatalogId").val();
		var thirdSelect = $("#thirdCatalogId");
		thirdSelect.empty();
		$.ajax({
			 url:"${wmsUrl}/admin/goods/catalogMng/queryThirdCatalogBySecondId.shtml?secondId="+secondId,
			 type:'post',
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){
					 if (data == null || data.length == 0) {
							return;
						}
						
						var list = data.obj;
						
						if (list == null || list.length == 0) {
							return;
						}
						
						var str = "";
						for (var i = 0; i < list.length; i++) {
							thirdSelect.append("<option value='"+list[i].thirdId+"'>"+list[i].name+"</option>")
						}
						
						if(!thirdSelect.is(":visible")){
							thirdSelect.show('fast');
						}
				 }else{
					 layer.alert(data.msg);
				 }
			 },
			 error:function(){
				 layer.alert("提交失败，请联系客服处理");
			 }
		 });
	});
	
	
	 $("#submitBtn").click(function(){
		 $('#goodsBaseForm').data("bootstrapValidator").validate();
		 if($('#goodsBaseForm').data("bootstrapValidator").isValid()){
			 var tmpIncrementTax = $("#incrementTax").val();
			 if(tmpIncrementTax > 1){
				 layer.alert("增值税率填写有误，请重新填写！");
				 return;
			 }
			 var tmpTariff = $("#tariff").val();
			 if(tmpTariff > 1){
				 layer.alert("海关税率填写有误，请重新填写！");
				 return;
			 }
			 $.ajax({
				 url:"${wmsUrl}/admin/goods/baseMng/save.shtml",
				 type:'post',
				 data:JSON.stringify(sy.serializeObject($('#goodsBaseForm'))),
				 contentType: "application/json; charset=utf-8",
				 dataType:'json',
				 success:function(data){
					 if(data.success){	
						 layer.alert("新增基础商品成功");
						 parent.layer.closeAll();
						 parent.location.reload();
					 }else{
						 layer.alert(data.msg);
					 }
				 },
				 error:function(){
					 layer.alert("新增基础商品失败，请联系客服处理");
				 }
			 });
		 }else{
			 layer.alert("信息填写有误");
		 }
	 });
	
	 $('#resetBtn').click(function() {
	        $('#goodsBaseForm').data('bootstrapValidator').resetForm(true);
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
      	 brandId: {
             message: '品牌不正确',
             validators: {
                 notEmpty: {
                     message: '品牌不能为空！'
                 }
             }
     	  },
//       	 encode: {
//              message: '条形码不正确',
//              validators: {
//                  notEmpty: {
//                      message: '条形码不能为空！'
//                  }
//              }
//      	  },
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
	
	function toBrand(){
		var index = layer.open({
			  title:"新增品牌",	
			  area: ['60%', '40%'],	
			  type: 2,
			  content: '${wmsUrl}/admin/goods/brandMng/toAdd.shtml',
			  maxmin: false
			});
	}
	
	function toCategory(){
		var index = layer.open({
			  title:"新增分类",	
			  area: ['70%', '45%'],	
			  type: 2,
			  content: '${wmsUrl}/admin/goods/catalogMng/createCategoryInfo.shtml',
			  maxmin: false
			});
	}
	
	</script>
</body>
</html>
