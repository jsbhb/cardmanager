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
<script src="${wmsUrl}/plugins/ckeditor/ckeditor.js"></script>
</head>

<body >
<section class="content-wrapper" style="height:900px">
	<section class="content">
		<form class="form-horizontal" role="form" id="floorForm" >
			<div class="col-md-12">
	        	<div class="box box-info">
	        		<div class="box-header with-border">
						<div class="box-header with-border">
			            	<h5 class="box-title">新增楼层</h5>
			            	<div class="box-tools pull-right">
			                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			              	</div>
			            </div>
					</div>
		            <div class="box-body">
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">分类选择</label>
							<div class="col-sm-6">
								<div class="input-group">
									<select class="form-control" name="firstCatalogId" id="firstCatalogId" style="width: 100%;">
				                   	  <option selected="selected" value="-1">未选择</option>
				                   	  <c:forEach var="first" items="${firsts}">
				                   	  	<option value="${first.firstId}">${first.name}</option>
				                   	  </c:forEach>
					                </select>
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">页面类型</label>
							<div class="col-sm-6">
								<div class="input-group">
		                  			<input type="radio" name="pageType" value="0" checked >手机
		                  			<input type="radio" name="pageType" value="1" >H5
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">是否显示</label>
							<div class="col-sm-6">
								<div class="input-group">
		                  			<input type="radio"  name="show" value="1" checked>显示
		                  			<input type="radio"  name="show" value="0" >不显示
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">楼层名称</label>
							<div class="col-sm-6">
								<div class="input-group">
				                  	<div class="input-group-addon">
				                    	<i class="fa fa-pencil"></i>
				                  	</div>
	                  				<input type="text" class="form-control" name="name">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">别称</label>
							<div class="col-sm-6">
								<div class="input-group">
				                  	<div class="input-group-addon">
				                    	<i class="fa fa-pencil"></i>
				                  	</div>
	                  				<input type="text" class="form-control" name="enname">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">楼层大图</label>
							<div class="col-sm-6">
								<div class="input-group">
							 		<input type="hidden" class="form-control" name="picPath1" id="picPath1">
	                  				<input type="file" name="pic" id="pic"/>
	                  				<button type="button" class="btn btn-info"  onclick="uploadFile()">上传 </button>
				                </div>
							</div>
						</div>
	            	</div>
          		</div>
			</div>
			<div class="col-md-offset-1 col-md-9">
				<div class="form-group">
                     <button type="button" class="btn btn-primary" id="submitBtn">提交</button>
                 </div>
            </div>
		</form>
	</section>
</section>
	<script type="text/javascript" src="${wmsUrl}/js/ajaxfileupload.js"></script>
	<script type="text/javascript">

	
	 function refresh(){
			parent.location.reload();
	 }
	 
	 function uploadFile(){
			$.ajaxFileUpload({
				url:'${wmsUrl}/admin/mall/indexMng/uploadFile.shtml', //你处理上传文件的服务端
				secureuri:false,
				fileElementId:"pic",
				dataType: 'json',
				success: function (data){
				   if(data.success){
					   $("#picPath1").attr("type", "text")
					   $("#picPath1").val(data.msg);
				   }else{
					   layer.alert(data.msg);
				   }
				}
			})
		}
	 
	 $("#submitBtn").click(function(){
		 $('#floorForm').data("bootstrapValidator").validate();
		 if($('#floorForm').data("bootstrapValidator").isValid()){
			 
			 var url = "${wmsUrl}/admin/mall/indexMng/saveDict.shtml";
		
			 $.ajax({
				 url:url,
				 type:'post',
				 data:JSON.stringify(sy.serializeObject($('#floorForm'))),
				 contentType: "application/json; charset=utf-8",
				 dataType:'json',
				 success:function(data){
					 if(data.success){
						 refresh();
						 layer.alert("插入成功");
						 
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
	 
		
		$('#floorForm').bootstrapValidator({
		//   live: 'disabled',
		   message: 'This value is not valid',
		   feedbackIcons: {
		       valid: 'glyphicon glyphicon-ok',
		       invalid: 'glyphicon glyphicon-remove',
		       validating: 'glyphicon glyphicon-refresh'
		   },
		   fields: {
			   name: {
			 		trigger:"change",
		          	message: '分类名称未添加',
		          	validators: {
			               notEmpty: {
			                   message: '分类名称未添加！'
			               }
			           }
			   	  },
				  picPath1: {
					   trigger:"change",
			           message: '商家编码不正确',
			           validators: {
			               notEmpty: {
			                   message: '商家编码不能为空！'
			               }
			           }
			   	  }
		}});
		
		
		function toList(){
				$("#list",window.parent.document).trigger("click");
		}
	</script>
</body>
</html>
