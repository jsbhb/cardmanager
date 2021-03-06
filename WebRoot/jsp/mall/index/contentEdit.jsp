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
	<section class="content-wrapper">
		<section class="content-iframe content">
				<form class="form-horizontal" role="form" id="adForm">
					<div class="list-item">
						<div class="col-sm-3 item-left">编号</div>
						<div class="col-sm-9 item-right">
							<input type="text" class="form-control" readonly name="id" value="${data.id}"> 
						</div>
					</div>
					<div class="list-item">
						<div class="col-sm-3 item-left">跳转链接</div>
						<div class="col-sm-9 item-right">
							<input type="text" class="form-control" name="href" value="${data.href}"> 
						</div>
					</div>
					<div class="list-item">
						<div class="col-sm-3 item-left">商品标题</div>
						<div class="col-sm-9 item-right">
							<input type="text" class="form-control" name="title" value="${data.title}"> 
						</div>
					</div>
					<div class="list-item">
						<div class="col-sm-3 item-left">价格</div>
						<div class="col-sm-9 item-right">
							<input type="text" class="form-control" name="price" value="${data.price}"> 
						</div>
					</div>
					<div class="list-item">
						<div class="col-sm-3 item-left">国家</div>
						<div class="col-sm-9 item-right">
							<input type="text" class="form-control" name="origin" value="${data.origin}"> 
						</div>
					</div>
					<div class="list-item">
						<div class="col-sm-3 item-left">商品编号</div>
						<div class="col-sm-9 item-right">
							<input type="text" class="form-control" name="goodsId" value="${data.goodsId}"> 
						</div>
					</div>
					<div class="list-item">
						<div class="col-sm-3 item-left">描述</div>
						<div class="col-sm-9 item-right">
							<input type="text" class="form-control" name="description" value="${data.description}"> 
						</div>
					</div>
					<div class="list-item">
						<div class="col-sm-3 item-left">大图(309*148px)</div>
						<div class="col-sm-9 item-right addContent">
							<c:choose>
							   <c:when test="${data.picPath != null && data.picPath != ''}">
		               	  			<div class="item-img choose" id="content" >
										<img src="${data.picPath}">
										<div class="bgColor"><i class="fa fa-trash fa-fw"></i><i class="fa fa-search fa-fw"></i></div>
										<input value="${data.picPath}" type="hidden" name="picPath" id="picPath">
									</div>
							   </c:when>
							   <c:otherwise>
		                	  		<div class="item-img" id="content" >
										+
										<input type="file" id="pic" name="pic" />
										<input type="hidden" class="form-control" name="picPath" id="picPath"> 
									</div>
							   </c:otherwise>
							</c:choose> 
						</div>
					</div>
					<div class="scrollImg-content broadcast"></div>
			        <div class="submit-btn">
			           	<button type="button" onclick="save()">保存</button>
			       	</div>
				</form>
		</section>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script src="${wmsUrl}/js/component/broadcast.js"></script>
<%-- 	<script src="${wmsUrl}/plugins/ckeditor/ckeditor.js"></script> --%>
	<script type="text/javascript" src="${wmsUrl}/js/ajaxfileupload.js"></script>
	<script type="text/javascript">
	
	
	//点击上传图片
	$('.item-right').on('change','.item-img input[type=file]',function(){
		var imagSize = document.getElementById("pic").files[0].size;
		if(imagSize>1024*1024*3) {
			layer.alert("图片大小请控制在3M以内，当前图片为："+(imagSize/(1024*1024)).toFixed(2)+"M");
			return true;
		}
		var baseUrl = "${wmsUrl}/admin/uploadFileWithType.shtml";
		var pageTypeValue = "${pageType}";
		var bussinessTypeValue = "${bussinessType}";
		var tmpType = "";
		if (pageTypeValue == 0) {
			tmpType = "PC";
		} else if (pageTypeValue == 1) {
			tmpType = "H5";
		}
		tmpType = tmpType + "-" + bussinessTypeValue;
		baseUrl = baseUrl + "?type=" + tmpType + "&key=${key}";
		$.ajaxFileUpload({
// 			url : '${wmsUrl}/admin/uploadFileForGrade.shtml', //你处理上传文件的服务端
			url : baseUrl, //你处理上传文件的服务端
			secureuri : false,
			fileElementId : "pic",
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					var imgHt = '<img src="'+data.msg+'"><div class="bgColor"><i class="fa fa-trash fa-fw"></i><i class="fa fa-search fa-fw"></i></div>';
					var imgPath = imgHt+ '<input type="hidden" value='+data.msg+' id="picPath" name="picPath">'
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
		var ht = '<div class="item-img" id="content" >+<input type="file" id="pic" name="pic"/><input type="hidden" name="picPath" id="picPath" value=""></div>';
		$(this).parent().parent().removeClass("choose");
		$(this).parent().parent().parent().html(ht);
	});
	
	function save(){
		$('#adForm').data("bootstrapValidator").validate();
		 if($('#adForm').data("bootstrapValidator").isValid()){
			 $.ajax({
					url : '${wmsUrl}/admin/mall/indexMng/update.shtml',
					type : 'post',
					contentType : "application/json; charset=utf-8",
					data : JSON.stringify(sy.serializeObject($('#adForm'))),
					dataType : 'json',
					success : function(data) {
						if (data.success) {
							parent.location.reload();
							layer.alert("修改成功");
						} else {
							layer.alert(data.msg);
						}
					},
					error : function() {
						layer.alert("提交失败，请联系客服处理");
					}
				});
		 }else{
			 layer.alert("提交失败，请联系客服处理");
		 }
	}
	
	$('#adForm').bootstrapValidator({
//      live: 'disabled',
      message: 'This value is not valid',
      feedbackIcons: {
          valid: 'glyphicon glyphicon-ok',
          invalid: 'glyphicon glyphicon-remove',
          validating: 'glyphicon glyphicon-refresh'
      },
      fields: {
    	  picPath: {
              message: '大图地址不能空',
              validators: {
                  notEmpty: {
                      message: '大图地址不能空！'
                  }
              }
      	  }
//       	  ,
//       	  description: {
//               message: '描述不能空',
//               validators: {
//                   notEmpty: {
//                       message: '描述不能空！'
//                   }
//               }
//       	  },
//       	  price: {
//               message: '价格不能空',
//               validators: {
//                   notEmpty: {
//                       message: '价格不能空！'
//                   }
//               }
//       	  },
//       	  goodsId: {
//               message: '商品编号不能空',
//               validators: {
//                   notEmpty: {
//                       message: '商品编号不能空！'
//                   }
//               }
//       	  },
//       	  origin: {
//               message: '国家不能空',
//               validators: {
//                   notEmpty: {
//                       message: '国家不能空！'
//                   }
//               }
//       	  },
//       	  title: {
//               message: '标题不能空',
//               validators: {
//                   notEmpty: {
//                       message: '标题不能空！'
//                   }
//               }
//       	  }
      }
  });
	
	function setPicImgListData() {
		var valArr = new Array;
		var tmpPicPath = $("#picPath").val();
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
