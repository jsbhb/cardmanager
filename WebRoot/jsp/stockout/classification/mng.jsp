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
<title>制单拣货</title>
<%@include file="../../resource.jsp"%>
</head>
<body>
	<div class="row nav-row">
		<ul id="navTab" class="nav nav-tabs">
			<li class="active"><a href="${wmsUrl}/admin/stockOut/makeOrder/pickCar.shtml?sellerInfoId=${sellerInfoId}">拣货车制单</a></li>
			<li><a href="${wmsUrl}/admin/stockOut/makeOrder/pureOrder.shtml?sellerInfoId=${sellerInfoId}">纯单制单</a></li>
			<li><a href="${wmsUrl}/admin/stockOut/makeOrder/preOrder.shtml?sellerInfoId=${sellerInfoId}">预包制单</a></li>
		</ul>
	</div>
	<div id="page-wrapper">
	</div>
	<script type="text/javascript">
	
		$(function(){
			$("#page-wrapper").empty();
			var newIframeObject = document.createElement("IFRAME");
			newIframeObject.src = "${wmsUrl}/admin/stockOut/makeOrder/pickCar.shtml?sellerInfoId=${sellerInfoId}";
			newIframeObject.frameBorder = 0;
			$("#page-wrapper").append(newIframeObject);
			
			$('#navTab a').bind('click', function() {
				$(this).parent().tab('show');
				$("#page-wrapper").empty();
				var newIframeObject = document.createElement("IFRAME");
				newIframeObject.src = this.href;
				newIframeObject.frameBorder = 0;
				$("#page-wrapper").append(newIframeObject);
				return false;
			});
		})
	</script>
</body>
</html>
