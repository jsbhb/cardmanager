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
<title>商品管理</title>
<%@include file="../../resourceLink.jsp"%>
</head>
<body>
	<section class="content-wrapper">
		<section class="content-header">
	      <h1><i class="fa fa-street-view"></i>商品明细管理</h1>
	      <ol class="breadcrumb">
	        <li><a href="javascript:void(0);"><i class="fa fa-dashboard"></i> 首页</a></li>
	        <li>商品管理</li>
	        <li class="active">商品明细管理</li>
	      </ol>
    	</section>	
		<section class="content">
	        <div class="box box-primary">
				<div class="box-header">
				<ul id="navTab" class="nav nav-tabs">
					<li class="active"><a id="list"  href="${wmsUrl}/admin/goods/itemMng/list.shtml">明细列表</a></li>
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
			newIframeObject.src = "${wmsUrl}/admin/goods/itemMng/list.shtml";
			newIframeObject.scrolling = "yes";
			newIframeObject.frameBorder = 0;
			newIframeObject.width = width;
			newIframeObject.height = height;
			$("#page-wrapper").append(newIframeObject);
		})
	</script>
</body>
</html>
