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
<link rel="stylesheet" href="${wmsUrl}/css/component/broadcast.css">
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
               			<input type="radio" name="pageType" onchange="changePageType(this.value)" value="0" checked > <span>PC</span>
               			<input type="radio" name="pageType" onchange="changePageType(this.value)" value="1" > <span>H5</span>
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
				<div class="col-sm-3 item-left">楼层顺序</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="sort">
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
			<div class="scrollImg-content broadcast"></div>
	        <div class="submit-btn">
	           	<button type="button" id="submitBtn">提交</button>
	       	</div>
		</form>
	</section>
</section>
	<%@include file="../../resourceScript.jsp"%>
	<script src="${wmsUrl}/js/component/broadcast.js"></script>
<%-- 	<script src="${wmsUrl}/plugins/ckeditor/ckeditor.js"></script> --%>
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
						 if (data.msg != null) {
							 updateStaticFolderNameById(data.msg);
						 } else {
	 						 refresh();
	 						 layer.alert("插入成功");
						 }
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
			var imagSize = document.getElementById("pic").files[0].size;
			if(imagSize>1024*1024*3) {
				layer.alert("图片大小请控制在3M以内，当前图片为："+(imagSize/(1024*1024)).toFixed(2)+"M");
				return true;
			}
			var baseUrl = "${wmsUrl}/admin/uploadFileWithType.shtml";
			var pageTypeValue = $("input[name='pageType']:checked").val();
			var tmpType = "";
			if (pageTypeValue == 0) {
				tmpType = "PC-floor";
			} else if (pageTypeValue == 1) {
				tmpType = "H5-floor";
			}
			baseUrl = baseUrl + "?type=" + tmpType + "&key=${key}";
			$.ajaxFileUpload({
// 				url : '${wmsUrl}/admin/uploadFileForGrade.shtml', //你处理上传文件的服务端
				url : baseUrl, //你处理上传文件的服务端
				secureuri : false,
				fileElementId : "pic",
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						var imgHt = '<img src="'+data.msg+'"><div class="bgColor"><i class="fa fa-trash fa-fw"></i><i class="fa fa-search fa-fw"></i></div>';
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
		$('.item-right').on('click','.bgColor i.fa-trash',function(){
			var ht = '<div class="item-img" id="content" >+<input type="file" id="pic" name="pic"/><input type="hidden" name="picPath1" id="picPath1" value=""></div>';
			$(this).parent().parent().removeClass("choose");
			$(this).parent().parent().parent().html(ht);
		});
		
		function changePageType(radioValue) {
			var ht = '<div class="item-img" id="content" >+<input type="file" id="pic" name="pic"/><input type="hidden" name="picPath1" id="picPath1" value=""></div>';
			$("#content").removeClass("choose");
			$("#content").parent().html(ht);
		}
		 
		function updateStaticFolderNameById(movePath) {
			var oldPath = movePath.split("|")[0];
			var newPath = movePath.split("|")[1];
			
			$.ajax({
				 url:"${renameApiUrl}",
				 method:'post',
				 contentType: "application/json; charset=utf-8",
				 dataType:'json',
				 data:JSON.stringify([{"old":oldPath,"new":newPath}]),
				 success:function(data){
					 if(data.success){
						 refresh();
						 layer.alert("插入成功");
					 }else{
						 layer.alert("楼层图片保存目录重命名失败，请联系客服处理");
					 }
				 },
				 error:function(){
					 layer.alert("新建楼层时重命名目录异常，请联系客服处理");
				 }
			 });
		}
		
		function setPicImgListData() {
			var valArr = new Array;
			var tmpPicPath="";
			for(var i=1;i<5;i++) {
				tmpPicPath = $("#picPath"+i).val();
				if (tmpPicPath != null && tmpPicPath != "") {
					valArr.push(tmpPicPath);
				}
			}
			if (valArr != undefined && valArr.length > 0) {
				var data = {
			        imgList: valArr,
			        imgWidth: 500,
			        imgHeight: 500,
			        activeIndex: 0,
			        host: "${wmsUrl}"
			    };
			    setImgScroll('broadcast',data);
			} else {
				layer.alert("请先上传图片！");
			}
		}
		
		//图片放大
		$('.item-right').on('click','.bgColor i.fa-search',function(){
			setPicImgListData();
		});
	</script>
</body>
</html>
