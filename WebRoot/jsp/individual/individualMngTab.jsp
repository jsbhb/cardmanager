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
<title>个人管理</title>
<%@include file="../resource.jsp"%>
</head>
<body>
	<div class="row nav-row">
		<ul id="navTab" class="nav nav-tabs">
			<li class="active"><a href="${wmsUrl}/admin/individual/preChangePwd.shtml">密码修改</a></li>
			<li><a href="${wmsUrl}/admin/individual/indInfo.shtml">个人信息</a></li>
		</ul>
	</div>
	<div id="page-wrapper">
	</div>
	<script type="text/javascript" src="${wmsUrl}/js/navPage.js"></script>
	<script type="text/javascript">
		$(function(){
			var width = 1480;
			var height = screen.height - 200;
			$("#page-wrapper").empty();
			var newIframeObject = document.createElement("IFRAME");
			newIframeObject.src = "${wmsUrl}/admin/individual/preChangePwd.shtml";
			newIframeObject.scrolling = "yes";
			newIframeObject.frameBorder = 0;
			newIframeObject.width = width;
			newIframeObject.height = height;
			$("#page-wrapper").append(newIframeObject);
		})
	</script>
</body>
</html>
