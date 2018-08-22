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
			<div class="list-item">
				<div class="col-sm-3 item-left">店铺推广地址</div>
				<div class="col-sm-9 item-right">
					<input type="text" readonly class="form-control" name="strExtensionLink" value="${strExtensionLink}">
				</div>
			</div>
			<c:if test="${strWelfareType == 1}">
				<div class="list-item">
					<div class="col-sm-3 item-left">福利网站地址</div>
					<div class="col-sm-9 item-right">
						<input type="text" readonly class="form-control" name="strWelfareUrlLink" value="${strWelfareUrlLink}">
					</div>
				</div>
			</c:if>
	        <div class="submit-btn">
	           	<button type="button" id="submitBtn" onclick="downLoadFile('+${strLink}+')">下载微店地址</button>
	           	<button type="button" id="submitBtn" onclick="downLoadFile('+${strExtensionLink}+')">下载店铺推广地址</button>
				<c:if test="${strWelfareType == 1}">
		           	<button type="button" id="submitBtn" onclick="downLoadFile('+${strWelfareUrlLink}+')">下载福利网站地址</button>
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
	</script>
</body>
</html>
