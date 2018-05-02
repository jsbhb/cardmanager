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
<style type="text/css">
	.input-group input[type=radio]{
		float:left;
		margin-top:8px;
		margin-right:5px;
	} 
	.input-group span{
		float:left;
		margin-top: 6px;  
		margin-right: 10px;
	}
</style>
</head>

<body >
<section class="content-wrapper">
	<section class="content-iframe content">
		<form class="form-horizontal" role="form" id="floorForm">
	       	<div class="list-item">
				<div class="col-sm-3 item-left">楼层分类</div>
				<div class="col-sm-9 item-right">
					<select class="form-control" name="firstCatalogId" id="firstCatalogId">
                   	  <option selected="selected" value="-1">未选择</option>
                   	  <c:forEach var="first" items="${firsts}">
                   	  	<option value="${first.firstId}">${first.name}</option>
                   	  </c:forEach>
	                </select>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">页面类型</div>
				<div class="col-sm-9 item-right">
					<div class="input-group">
               			<input type="radio" name="pageType" value="0" checked > <span>PC</span>
               			<input type="radio" name="pageType" value="1" > <span>H5</span>
	                </div>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">是否显示</div>
				<div class="col-sm-9 item-right">
					<div class="input-group">
               			<input type="radio"  name="show" value="1" checked><span>显示</span>
               			<input type="radio"  name="show" value="0" ><span>不显示</span>
	                </div>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">楼层名称</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="name">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">楼层别称</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="enname">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">楼层描述</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="description">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">楼层大图</div>
				<div class="col-sm-9 item-right addContent">
					<div class="item-img" id="content">
						+
<!-- 						<input type="file" id="pic1"/> -->
						<input type="file" id="pic" name="pic" />
						<input type="hidden" class="form-control" name="picPath1" id="picPath1"> 
					</div>
				</div>
			</div>
	        <div class="submit-btn">
	           	<button type="button" id="submitBtn">提交</button>
	       	</div>
		</form>
	</section>
</section>
	<%@include file="../../resourceScript.jsp"%>
	<script src="${wmsUrl}/plugins/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="${wmsUrl}/js/ajaxfileupload.js"></script>
	<script type="text/javascript">
	 function refresh(){
		parent.location.reload();
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
		           message: '楼层名称不正确',
		           validators: {
		               notEmpty: {
		                   message: '楼层名称不能为空！'
		               }
		           }
		   	  },
			  pic1: {
		           message: '楼层大图不正确',
		           validators: {
		               notEmpty: {
		                   message: '楼层大图不能为空！'
		               }
		           }
		   	  }
		}});
		
		function toList(){
			$("#list",window.parent.document).trigger("click");
		}
		
		//点击上传图片
		$('.item-right').on('change','.item-img input[type=file]',function(){
			$.ajaxFileUpload({
				url : '${wmsUrl}/admin/uploadFileForGrade.shtml', //你处理上传文件的服务端
				secureuri : false,
				fileElementId : "pic",
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						var imgHt = '<img src="'+data.msg+'"><div class="bgColor"><i class="fa fa-trash fa-fw"></i></div>';
						var imgPath = imgHt+ '<input type="hidden" value='+data.msg+' id="picPath1" name="picPath1">'
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
			var ht = '<div class="item-img" id="content" >+<input type="file" id="pic" name="pic"/><input type="hidden" name="picPath1" id="picPath1" value=""></div>';
			$(this).parent().parent().removeClass("choose");
			$(this).parent().parent().parent().html(ht);
		});
	</script>
</body>
</html>
