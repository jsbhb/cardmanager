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
</head>
<body>
	<section class="content-header">
	      <ol class="breadcrumb">
	        <li><a href="javascript:void(0);">首页</a></li>
	        <li>标签管理</li>
	        <li class="active">店铺二维码</li>
	      </ol>
    </section>
	<section class="content-iframe content">
		<form class="form-horizontal" role="form" id="gradeConfigForm" >
			<div class="title">
	       		<h1>店铺信息</h1>
	       	</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">店铺编号</div>
				<div class="col-sm-9 item-right">
					<input type="text" readonly class="form-control" name="shopId" value="${opt.gradeId}">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">店铺名称</div>
				<div class="col-sm-9 item-right">
					<input type="text" readonly class="form-control" name="gradeName" value="${opt.gradeName}">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">微店链接地址</div>
				<div class="col-sm-9 item-right">
					<input type="text" readonly class="form-control" name="strLink" value="${strLink}">
				</div>
			</div>
			<c:if test="${strExtensionLinkShow == true}">
				<div class="list-item">
					<div class="col-sm-3 item-left">邀请开店地址</div>
					<div class="col-sm-9 item-right">
						<input type="text" readonly class="form-control" name="strExtensionLink" value="${strExtensionLink}">
					</div>
				</div>
			</c:if>
			<c:if test="${strWelfareType == 1}">
				<div class="list-item">
					<div class="col-sm-3 item-left">福利网站地址</div>
					<div class="col-sm-9 item-right">
						<input type="text" readonly class="form-control" name="strWelfareUrlLink" value="${strWelfareUrlLink}">
					</div>
				</div>
			</c:if>
	        <div class="submit-btn">
	           	<button type="button" id="submitBtn" onclick="downLoadFile('${strLink}')">下载微店地址</button>
	           	<button type="button" id="submitBtn" onclick="getWxAppletCode(${opt.gradeId})">预览小程序码</button>
	           	<c:if test="${strExtensionLinkShow == true}">
	           		<button type="button" id="submitBtn" onclick="downLoadFile('${strExtensionLink}')">下载邀请开店地址</button>
				</c:if>
				<c:if test="${strWelfareType == 1}">
		           	<button type="button" id="submitBtn" onclick="downLoadFile('${strWelfareUrlLink}')">下载福利网站地址</button>
				</c:if>
	       	</div>
		</form>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script type="text/javascript">
	function downLoadFile(path){
		window.open("${wmsUrl}/admin/label/shopQRMng/downLoadFile.shtml?path="+path.replace("&","%26"));
// 		location.href="${wmsUrl}/admin/label/shopQRMng/downLoadFile.shtml?path="+path.replace("&","%26");
	}
	
	function getWxAppletCode(gradeId) {
		var reqUrl = "${wmsUrl}/admin/applet/code.shtml";
		
		var param = {};
		param["scene"] = "shopId=" + gradeId;
		param["page"] = "web/index/index";
		param["width"] = 400;
		
		reqUrl += "?needToCoverLogo=true";
		postAjaxToGetInfo(reqUrl,param);
		
//	 	layer.confirm('是否用商品默认主图替换二维码中的LOGO？', {
//	 	  btn: ['确认替换','无需替换'] //按钮
//	 	}, function(index){
//	 		reqUrl += "?needToCoverLogo=true";
//	 		postAjaxToGetInfo(reqUrl,param);
//	         layer.close(index);
//	 	}, function(index){
//	 		reqUrl += "?needToCoverLogo=false";
//	 		postAjaxToGetInfo(reqUrl,param);
//	         layer.close(index);
//	 	});
	}

	function postAjaxToGetInfo(reqUrl, param) {
		var win = window.open();
		$.ajax({
			 url:reqUrl,
			 type:'post',
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 data:JSON.stringify(param),
			 success:function(data){
				 if(data.success){
					 win.location.href=data.data;
				 } else {
					 win.close();
					 layer.alert(data.msg);
				 }
			 },
			 error:function(data){
				 win.close();
				 layer.alert(data.msg);
			 }
		});
	}
	</script>
</body>
</html>
