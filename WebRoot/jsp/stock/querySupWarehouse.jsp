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
<title>商家库存</title>
<%@include file="../resource.jsp"%>
</head>
<body>
	<div class="row nav-row">
		<ul id="navTab" class="nav nav-tabs">
			<li class="active"><a href="${wmsUrl}/admin/stock/querySupWarehouse/SupWarehouseList.shtml">商家库存</a></li>
			<li><a href="${wmsUrl}/admin/stock/querySupWarehouse/supplierDetail.shtml">商家库存明细</a></li>
		</ul>
	</div>
	<div id="page-wrapper">
	</div>
	<script type="text/javascript" src="${wmsUrl}/js/navPage.js"></script>
	<script type="text/javascript">
		$(function(){
			$("#page-wrapper").empty();
			var newIframeObject = document.createElement("IFRAME");
			newIframeObject.src = "${wmsUrl}/admin/stock/querySupWarehouse/SupWarehouseList.shtml";
			newIframeObject.frameBorder = 0;
			$("#page-wrapper").append(newIframeObject);
		})
	</script>
</body>
</html>
