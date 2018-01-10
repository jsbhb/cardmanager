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
	<section class="content">
        <div class="main-content">
			<div class="row">
				<div class="col-xs-12" >
					<form class="form-horizontal" role="form" id="baseForm" >
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"><h4>基本信息</h4></label>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">品牌<font style="color:red">*</font> </label>
							<div class="col-sm-2">
								<div class="input-group">
									 <select class="form-control" name="brandId" id="brandId" style="width: 100%;">
				                   	  <option selected="selected" value="-1">未选择</option>
				                   	  <c:forEach var="brand" items="${brands}">
				                   	  	<option value="${brand.brandId}">${brand.brand}</option>
				                   	  </c:forEach>
					                </select>
					               <input type="hidden" class="form-control" name="brand" id="brand"/>
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">一级分类<font style="color:red">*</font> </label>
							<div class="col-sm-2">
								<div class="input-group">
									 <select class="form-control" name="firstCatalogId" id="firstCatalogId" style="width: 100%;">
				                   	  <option selected="selected" value="-1">未选择</option>
				                   	  <c:forEach var="first" items="${firsts}">
				                   	  	<option value="${first.firstId}">${first.name}</option>
				                   	  </c:forEach>
					                </select>
				                </div>
							</div>
							<label class="col-sm-1 control-label no-padding-right" for="form-field-1">二级分类<font style="color:red">*</font> </label>
							<div class="col-sm-2">
								<div class="input-group">
									 <select class="form-control" name="secondCatalogId" id="secondCatalogId" style="width: 100%;">
					                </select>
				                </div>
							</div>
							<label class="col-sm-1 control-label no-padding-right" for="form-field-1">三级分类<font style="color:red">*</font> </label>
							<div class="col-sm-2">
								<div class="input-group">
									 <select class="form-control" hidden name="thirdCatalogId" id="thirdCatalogId" style="width: 100%;">
					                </select>
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">商品名称<font style="color:red">*</font> </label>
							<div class="col-sm-5">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
		                  			<input type="text" class="form-control" name="goodsName">
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
		                  			<input type="text" class="form-control" name="unit">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right" for="form-field-1"><h4>海关信息(*跨境商品必填)</h4></label>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">hscode</label>
							<div class="col-sm-5">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
		                  			<input type="text" class="form-control" name="hscode">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">增值税</label>
							<div class="col-sm-5">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
		                  			<input type="text" class="form-control" name="incrementTax">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">关税</label>
							<div class="col-sm-5">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
		                  			<input type="text" class="form-control" name="tariff">
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
	<%@ include file="../../footer.jsp"%>
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
		
		if(thirdSelect.is(":visible")){
			thirdSelect.hide('fast');
		}
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
		 if($('#baseForm').data("bootstrapValidator").isValid()){
			 $.ajax({
				 url:"${wmsUrl}/admin/goods/baseMng/save.shtml",
				 type:'post',
				 data:JSON.stringify(sy.serializeObject($('#baseForm'))),
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
	
	 $('#resetBtn').click(function() {
	        $('#baseForm').data('bootstrapValidator').resetForm(true);
	    });
	
	$('#baseForm').bootstrapValidator({
//      live: 'disabled',
      message: 'This value is not valid',
      feedbackIcons: {
          valid: 'glyphicon glyphicon-ok',
          invalid: 'glyphicon glyphicon-remove',
          validating: 'glyphicon glyphicon-refresh'
      },
      fields: {
    	  goodsName: {
              message: '品牌不正确',
              validators: {
                  notEmpty: {
                      message: '品牌不能为空！'
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
     	 tariff:{
			   message: '关税不正确',
			   validators: {
				   notEmpty: {
                     message: '关税不能为空'
                 },
				   regexp: {
	                   regexp: /^\d+(\.\d+)?$/,
	                   message: '关税为数字类型'
	               }
			   }
		   },
		   incrementTax:{
			   message: '增值税不正确',
			   validators: {
				   notEmpty: {
                     message: '增值税不能为空'
                 },
				   regexp: {
	                   regexp: /^\d+(\.\d+)?$/,
	                   message: '关税为数字类型'
	               }
			   }
		   }
      }
  });
	
	
	
	</script>
</body>
</html>
