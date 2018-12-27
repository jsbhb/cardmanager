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
</head>

<body>
	<section class="content-iframe">
		<form class="form-horizontal" role="form" id="catalogForm" style="margin-top:20px">
			<div class="list-item">
				<div class="col-sm-3 item-left">分类图标</div>
				<div class="col-sm-9 item-right addContent">
					<c:choose>
					   <c:when test="${tagPath != null && tagPath != ''}">
	           	  			<div class="item-img choose" id="content" >
								<c:choose>
									<c:when test="${tagPath.indexOf('http') != -1}">
										<img src="${tagPath}">
										<div class="bgColor"><i class="fa fa-trash fa-fw"></i><i class="fa fa-search fa-fw"></i></div>
										<input value="${tagPath}" type="hidden" name="tagPath" id="tagPath">
									</c:when>
									<c:otherwise>
										<img src="${wmsUrl}/img/default_img.jpg">
										<div class="bgColor"><i class="fa fa-trash fa-fw"></i><i class="fa fa-search fa-fw"></i></div>
										<input value="${wmsUrl}/img/default_img.jpg" type="hidden" name="tagPath" id="tagPath">
									</c:otherwise>
								</c:choose>
							</div>
					   </c:when>
					   <c:otherwise>
	               	  		<div class="item-img" id="content" >
								+
								<input type="file" id="pic" name="pic" />
								<input type="hidden" class="form-control" name="tagPath" id="tagPath"> 
							</div>
					   </c:otherwise>
					</c:choose> 
				</div>
			</div>
			<div class="scrollImg-content broadcast"></div>
        	<div class="list-item">
				<div class="col-xs-3 item-left">分类编号</div>
				<div class="col-xs-9 item-right">
					<input type="text" readonly class="form-control" name="id" value="${id}">
           			<input type="hidden"  class="form-control" name="type" value="${type}">
	             </div>
			</div>
        	<div class="list-item">
				<div class="col-xs-3 item-left">分类名称</div>
				<div class="col-xs-9 item-right">
					<input type="text" class="form-control" name="name" value="${name}">
	             </div>
			</div>
			<div class="list-item">
				<div class="col-xs-3 item-left">分类别称</div>
				<div class="col-xs-9 item-right">
					<input type="text" class="form-control" name="accessPath" value="${accessPath}">
	            	<div class="item-content">
	             		（商品分类的别称，例：myyp）
	             	</div>
	             </div>
			</div>
			<div class="list-item">
				<div class="col-xs-3 item-left">分类顺序</div>
				<div class="col-xs-9 item-right">
					<input type="text" class="form-control" name="sort"  value="${sort}">
	            	<div class="item-content">
	             		（商品分类的顺序，例：2）
	             	</div>
	             </div>
			</div>
			<div class="submit-btn">
            	<button type="button" id="submitBtn">确定</button>
             </div>
		</form>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script src="${wmsUrl}/js/component/broadcast.js"></script>
	<script type="text/javascript" src="${wmsUrl}/js/ajaxfileupload.js"></script>
	<script type="text/javascript">
	
	 $("#submitBtn").click(function(){
		 $('#catalogForm').data("bootstrapValidator").validate();
		 if($('#catalogForm').data("bootstrapValidator").isValid()){
			 var tmpGoodsPath = $("#tagPath").val();
			 if (tmpGoodsPath == "" || tmpGoodsPath == null) {
				 layer.alert("请上传分类图片！");
				 return;
			 }
			 $.ajax({
				 url:"${wmsUrl}/admin/goods/catalogMng/modify.shtml",
				 type:'post',
				 data:JSON.stringify(sy.serializeObject($('#catalogForm'))),
				 contentType: "application/json; charset=utf-8",
				 dataType:'json',
				 success:function(data){
					 if(data.success){	
						 layer.alert("更新成功");
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
	
	$('#catalogForm').bootstrapValidator({
//      live: 'disabled',
      message: 'This value is not valid',
      feedbackIcons: {
          valid: 'glyphicon glyphicon-ok',
          invalid: 'glyphicon glyphicon-remove',
          validating: 'glyphicon glyphicon-refresh'
      },
      fields: {
    	  name: {
              message: '分类名称不正确',
              validators: {
                  notEmpty: {
                      message: '分类名称不能为空！'
                  }
              }
      	  },
      	  accessPath: {
            message: '分类别称不正确',
            validators: {
                notEmpty: {
                    message: '分类别称不能为空！'
                }
            }
    	  },
      	  sort: {
              message: '分类顺序不正确',
              validators: {
                  notEmpty: {
                      message: '分类别称不能为空！'
                  },
                  digits: {
                      message: '分类顺序只能使用数字！'
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
// 			url : '${wmsUrl}/admin/uploadFileForGrade.shtml', //你处理上传文件的服务端
			url : '${wmsUrl}/admin/uploadFileWithType.shtml?type=category&key='+"${key}", //你处理上传文件的服务端
			secureuri : false,
			fileElementId : "pic",
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					var imgHt = '<img src="'+data.msg+'"><div class="bgColor"><i class="fa fa-trash fa-fw"></i><i class="fa fa-search fa-fw"></i></div>';
					var imgPath = imgHt+ '<input type="hidden" value='+data.msg+' id="tagPath" name="tagPath">'
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
		var ht = '<div class="item-img" id="content" >+<input type="file" id="pic" name="pic"/><input type="hidden" name="tagPath" id="tagPath" value=""></div>';
		$(this).parent().parent().removeClass("choose");
		$(this).parent().parent().parent().html(ht);
	});
	function setPicImgListData() {
		var valArr = new Array;
		var tmpPicPath = "";
		tmpPicPath = $("#tagPath").val();
		if (tmpPicPath != null && tmpPicPath != "") {
			valArr.push(tmpPicPath);
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
