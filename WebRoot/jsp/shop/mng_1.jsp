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
</head>
<body>
	<section class="content-header">
	      <ol class="breadcrumb">
	        <li><a href="javascript:void(0);">首页</a></li>
	        <li>微店管理</li>
	        <li class="active">信息维护</li>
	      </ol>
    </section>
	<section class="content-iframe content">
		<form class="form-horizontal" role="form" id="gradeConfigForm" >
			<div class="title">
	       		<h1>微店信息</h1>
	       	</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">店铺编号</div>
				<div class="col-sm-9 item-right">
					<input type="hidden" class="form-control" name="id" id="id" value="${shop.id}">
          			<input type="text" readonly class="form-control" name="gradeId" id="gradeId" value="${opt.shopId}">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">店铺名称</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="name" id="name" value="${shop.name}">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">店铺简介</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="aboutUs" id="aboutUs" value="${shop.aboutUs}">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">商品主图</div>
				<div class="col-sm-9 item-right addContent">
					<div class="item-img">
						+
						<input type="file" id="pic1"/>
					</div>
				</div>
			</div>
	        <div class="submit-btn">
	           	<button type="button" id="submitBtn">保存</button>
	       	</div>
		</form>
	</section>
	<%@include file="../resource.jsp"%>
	<script type="text/javascript" src="${wmsUrl}/js/ajaxfileupload.js"></script>
	<script type="text/javascript">
	function uploadFile() {
		$.ajaxFileUpload({
			url : '${wmsUrl}/admin/uploadFileForShop.shtml', //你处理上传文件的服务端
			secureuri : false,
			fileElementId : "pic1",
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					$("#headImg").val(data.msg);
					$("#img1").attr("src",data.msg);
				} else {
					layer.alert(data.msg);
				}
			}
		})
	}
	
	$("#submitBtn").click(function(){
		 $.ajax({
			 url:"${wmsUrl}/admin/shop/shopMng/update.shtml",
			 type:'post',
			 data:JSON.stringify(sy.serializeObject($('#gradeConfigForm'))),
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){	
					 layer.alert("保存成功");
				 }else{
					 layer.alert(data.msg);
				 }
			 },
			 error:function(){
				 layer.alert("提交失败，请联系客服处理");
			 }
		 });
	 });
	</script>
</body>
</html>
