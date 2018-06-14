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
					<select class="form-control" name="brandId" id="brandId">
		                <c:forEach var="brand" items="${brands}">
		                	<option value="${brand.brandId}">${brand.brand}</option>
		                </c:forEach>
		            </select>
				</div>
			</div>
            <input type="hidden" class="form-control" name="goodsId" id="goodsId" value=""/>
	      	<div class="list-item">
				<div class="col-sm-3 item-left">商品名称</div>
				<div class="col-sm-9 item-right">
               		<input type="text" class="form-control" name="goodsName" id="goodsName" value="">
				</div>
			</div>
	      	<div class="list-item">
				<div class="col-sm-3 item-left">商品规格</div>
				<div class="col-sm-9 item-right">
	                 <input type="text" class="form-control" name="specs" value="">
				</div>
			</div>
	      	<div class="list-item">
				<div class="col-sm-3 item-left">原产国</div>
				<div class="col-sm-9 item-right">
	                 <input type="text" class="form-control" name="origin" value="">
				</div>
			</div>
	      	<div class="list-item">
				<div class="col-sm-3 item-left">适用年龄</div>
				<div class="col-sm-9 item-right">
	                 <input type="text" class="form-control" name="useAge" value="">
				</div>
			</div>
	      	<div class="list-item">
				<div class="col-sm-3 item-left">推荐理由</div>
				<div class="col-sm-9 item-right">
					<textarea class="form-control" name="reason"></textarea>
             		<div class="item-content">
		             	（请用英文分号';'作为多个值的分隔符）
		            </div>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">商品图片</div>
				<div class="col-sm-9 item-right addContent">
					<div class="item-img" id="content" >
						+
						<input type="file" id="pic" name="pic" />
						<input type="hidden" class="form-control" name="headImg" id="headImg"> 
					</div>
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
			 var tmpBrandId = $("#brandId").val();
			 if(tmpBrandId == -1){
				 layer.alert("请选择品牌信息");
				 return;
			 }
			 
			 var url = "${wmsUrl}/admin/label/goodsExtensionMng/editGoodsInfo.shtml";
			 var formData = sy.serializeObject($('#goodsForm'));
			 
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
				  useAge: {
						trigger:"change",
						message: '适用年龄不正确',
						validators: {
							notEmpty: {
								message: '适用年龄不能为空！'
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
			var id = $(this).parent().attr("data-id");
			var nextId =  parseInt(id)+1;
			
			var imagSize = document.getElementById("pic"+id).files[0].size;
			if(imagSize>1024*1024*3) {
				layer.alert("图片大小请控制在3M以内，当前图片为："+(imagSize/(1024*1024)).toFixed(2)+"M");
				return true;
			}
			
			$.ajaxFileUpload({
				url : '${wmsUrl}/admin/uploadFileForGrade.shtml', //你处理上传文件的服务端
				secureuri : false,
				fileElementId : "pic"+id,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						var ht = '<div class="item-img" id="content'+nextId+'" data-id="'+nextId+'">+<input type="file" id="pic'+nextId+'" name="pic"/></div>';
						var imgHt = '<img src="'+data.msg+'"><div class="bgColor"><i class="fa fa-trash fa-fw"></i></div>';
						var imgPath = imgHt+ '<input type="hidden" value='+data.msg+' id="picPath'+id+'" name="picPath">'
						$('.addContent').append(ht);
						$("#content"+id).html(imgPath);
						$("#content"+id).addClass('choose');
					} else {
						layer.alert(data.msg);
					}
				}
			})
		});
		//删除主图
		$('.item-right').on('click','.bgColor i',function(){
			$(this).parent().parent().remove();
		});
	</script>
</body>
</html>
