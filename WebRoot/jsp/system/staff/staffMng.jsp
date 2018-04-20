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
<title>人员管理</title>
<%@include file="../../resourceLink.jsp"%>
</head>
<body>
	<section class="content-wrapper">
		<section class="content">
	        <div class="box">
				<div class="box-header">
				<ul id="navTab" class="nav nav-tabs">
					<li class="active"><a href="${wmsUrl}/admin/system/staffMng/list.shtml">角色列表</a></li>
				</ul>
				</div>
				<div class="box-body">
					<div id="page-wrapper">
					</div>
				</div>
			</div>
		</section>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script type="text/javascript" src="${wmsUrl}/js/navPage.js"></script>
	<script type="text/javascript">
		$(function(){
			var width = "100%";
			var height = window.innerHeight-139;
			$("#page-wrapper").empty();
			var newIframeObject = document.createElement("IFRAME");
			newIframeObject.src = "${wmsUrl}/admin/system/staffMng/list.shtml";
			newIframeObject.scrolling = "yes";
			newIframeObject.frameBorder = 0;
			newIframeObject.width = width;
			newIframeObject.height = height;
			$("#page-wrapper").append(newIframeObject);
		})
	</script>
</body>
</html>
