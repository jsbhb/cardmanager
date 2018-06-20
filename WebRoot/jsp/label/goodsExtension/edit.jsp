<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@include file="../../resourceLink.jsp"%>
</head>

<body>
	<section class="content-iframe content">
		<form class="form-horizontal" role="form" id="goodsForm">
	       	<div class="list-item">
				<div class="col-sm-3 item-left">商品品牌</div>
				<div class="col-sm-9 item-right">
					<select class="form-control" id="brandId">
		                <c:forEach var="brand" items="${brands}">
		                	<c:choose>
							   <c:when test="${goodsExtensionInfo.brand == brand.brand}">
		                			<option selected="selected" value="${brand.brandId}">${brand.brand}</option>
							   </c:when>
							   <c:otherwise>
		                			<option value="${brand.brandId}">${brand.brand}</option>
							   </c:otherwise>
							</c:choose>
		                </c:forEach>
		            </select>
				</div>
			</div>
            <input type="hidden" class="form-control" name="goodsId" id="goodsId" value="${goodsExtensionInfo.goodsId}"/>
	      	<div class="list-item">
				<div class="col-sm-3 item-left">商品名称</div>
				<div class="col-sm-9 item-right">
               		<input type="text" class="form-control" name="goodsName" value="${goodsExtensionInfo.goodsName}">
				</div>
			</div>
	      	<div class="list-item">
				<div class="col-sm-3 item-left">商品规格</div>
				<div class="col-sm-9 item-right">
	                 <input type="text" class="form-control" name="specs" value="${goodsExtensionInfo.specs}">
				</div>
			</div>
	      	<div class="list-item">
				<div class="col-sm-3 item-left">产地</div>
				<div class="col-sm-9 item-right">
	                 <input type="text" class="form-control" name="origin" value="${goodsExtensionInfo.origin}">
				</div>
			</div>
	      	<div class="list-item">
				<div class="col-sm-3 item-left">自定义字段</div>
				<div class="col-sm-9 item-right">
	                 <input type="text" class="form-control" name="custom" value="${goodsExtensionInfo.custom}">
	                 <div class="item-content">
		             	（请用英文冒号':'作为分隔符。例：适用年龄:0-3岁，适合肤质:所有肤质）
		             </div>
				</div>
			</div>
	      	<div class="list-item">
				<div class="col-sm-3 item-left">保质期</div>
				<div class="col-sm-9 item-right">
	                 <input type="text" class="form-control" name="shelfLife" value="${goodsExtensionInfo.shelfLife}">
	                 <div class="item-content">
		             	（无保质期商品可不填写）
		             </div>
				</div>
			</div>
	      	<div class="list-item">
				<div class="col-sm-3 item-left">推荐理由</div>
				<div class="col-sm-9 item-right">
					<textarea class="form-control" name="reason">${goodsExtensionInfo.reason}</textarea>
             		<div class="item-content">
		             	（请用英文分号';'作为多个值的分隔符,最多支持3个分隔符）
		            </div>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">商品图片</div>
				<div class="col-sm-9 item-right addContent">
					<c:choose>
					   <c:when test="${goodsExtensionInfo.goodsPath != null && goodsExtensionInfo.goodsPath != ''}">
               	  			<div class="item-img choose" id="content" >
								<img src="${goodsExtensionInfo.goodsPath}">
								<div class="bgColor"><i class="fa fa-trash fa-fw"></i></div>
								<input value="${goodsExtensionInfo.goodsPath}" type="hidden" name="goodsPath" id="goodsPath">
							</div>
					   </c:when>
					   <c:otherwise>
                	  		<div class="item-img" id="content" >
								+
								<input type="file" id="pic" name="pic" />
								<input type="hidden" class="form-control" name="goodsPath" id="goodsPath"> 
							</div>
					   </c:otherwise>
					</c:choose>
				</div>
			</div>
			
	        <div class="submit-btn">
	           	<button type="button" id="submitBtn">保存信息</button>
	       	</div>
		</form>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script src="${wmsUrl}/plugins/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="${wmsUrl}/js/ajaxfileupload.js"></script>
	<script type="text/javascript">
	 
	 $("#submitBtn").click(function(){
		 $('#goodsForm').data("bootstrapValidator").validate();
		 if($('#goodsForm').data("bootstrapValidator").isValid()){
			 var tmpBrand = $("#brandId option:selected").text();
			 var tmpGoodsPath = $("#goodsPath").val();
			 if (tmpGoodsPath == "" || tmpGoodsPath == null) {
				 layer.alert("请上传商品图片！");
				 return;
			 }
			 var url = "${wmsUrl}/admin/label/goodsExtensionMng/editGoodsInfo.shtml";
			 
			 var formData = sy.serializeObject($('#goodsForm'));
			 formData["brand"] = tmpBrand;
			 
			 $.ajax({
				 url:url,
				 type:'post',
				 data:JSON.stringify(formData),
				 contentType: "application/json; charset=utf-8",
				 dataType:'json',
				 success:function(data){
					 if(data.success){
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
		
		$('#goodsForm').bootstrapValidator({
		//   live: 'disabled',
		   message: 'This value is not valid',
		   feedbackIcons: {
		       valid: 'glyphicon glyphicon-ok',
		       invalid: 'glyphicon glyphicon-remove',
		       validating: 'glyphicon glyphicon-refresh'
		   },
		   fields: {
				  goodsName: {
						trigger:"change",
						message: '商品名称不正确',
						validators: {
							notEmpty: {
								message: '商品名称不能为空！'
							}
						}
				  },
				  specs: {
						trigger:"change",
						message: '商品规格不正确',
						validators: {
							notEmpty: {
								message: '商品规格不能为空！'
							}
						}
				  },
				  origin: {
						trigger:"change",
						message: '原产国不正确',
						validators: {
							notEmpty: {
								message: '原产国不能为空！'
							}
						}
				  },
				  custom: {
						trigger:"change",
						message: '自定义字段不正确',
						validators: {
							notEmpty: {
								message: '自定义字段不能为空！'
							}
						}
				  },
				  reason: {
						trigger:"change",
						message: '推荐理由不正确',
						validators: {
							notEmpty: {
								message: '推荐理由不能为空！'
							}
						}
				  }
		   }
		});
		
		//点击上传图片
		$('.item-right').on('change','.item-img input[type=file]',function(){
			var imagSize = document.getElementById("pic").files[0].size;
			if(imagSize>1024*1024*3) {
				layer.alert("图片大小请控制在3M以内，当前图片为："+(imagSize/(1024*1024)).toFixed(2)+"M");
				return true;
			}
			$.ajaxFileUpload({
				url : '${wmsUrl}/admin/uploadFileForGrade.shtml', //你处理上传文件的服务端
				secureuri : false,
				fileElementId : "pic",
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						var imgHt = '<img src="'+data.msg+'"><div class="bgColor"><i class="fa fa-trash fa-fw"></i></div>';
						var imgPath = imgHt+ '<input type="hidden" value='+data.msg+' id="goodsPath" name="goodsPath">'
						$("#content").html(imgPath);
						$("#content").addClass('choose');
					} else {
						layer.alert(data.msg);
					}
				}
			})
		});
		//删除主图
		$('.item-right').on('click','.bgColor i',function(){
			var ht = '<div class="item-img" id="content" >+<input type="file" id="pic" name="pic"/><input type="hidden" name="goodsPath" id="goodsPath" value=""></div>';
			$(this).parent().parent().removeClass("choose");
			$(this).parent().parent().parent().html(ht);
		});
	</script>
</body>
</html>
