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
<title>订单查询</title>
<%@include file="../../resource.jsp"%>
</head>

<body>
	<div class="row nav-row">
		<ul id="navTab" class="nav nav-tabs">
			<li class="active"><a href="${wmsUrl}/admin/order/list.shtml">订单查询</a></li>
			<li><a href="${wmsUrl}/admin/order/oorList.shtml">制单查询</a></li>
			<li><a href="${wmsUrl}/admin/order/rejectOrder.shtml">拒单处理</a></li>
			<c:if test="${privilege>=2}">
			<li><a href="${wmsUrl}/admin/statistic/order/list.shtml">统计查看</a></li>
			</c:if>
		</ul>
	</div>
	<div id="page-wrapper" class="navPageIframe">
	</div>
	<script type="text/javascript" src="${wmsUrl}/js/navPage.js"></script>
	<script type="text/javascript">
		$(function(){
			var width = "100%";
		 	var height = "100%";
			$("#page-wrapper").empty();
			var newIframeObject = document.createElement("IFRAME");
			newIframeObject.src = "${wmsUrl}/admin/order/list.shtml";
			newIframeObject.frameBorder = 0;
			newIframeObject.scrolling = "no";
			newIframeObject.width = width;
			newIframeObject.height = height;
			$("#page-wrapper").append(newIframeObject);
		})
	</script>
</body>
</html>
