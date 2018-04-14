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
</head>
<body>
	<section class="content-wrapper">
		<section class="content-header">
	      <ol class="breadcrumb">
	        <li><a href="javascript:void(0);">首页</a></li>
	        <li>商城管理</li>
	        <li class="active">首页设置</li>
	      </ol>
	    </section>	
		<section class="content">
			<div class="list-tabBar">
				<ul>
					<li class="active" data-url="${wmsUrl}/admin/mall/indexMng/list.shtml">楼层设置</li>
					<li data-url="${wmsUrl}/admin/mall/indexMng/banner.shtml">PC轮播设置</li>
					<li data-url="${wmsUrl}/admin/mall/indexMng/h5Banner.shtml">H5轮播设置</li>
					<li data-url="${wmsUrl}/admin/mall/indexMng/ad.shtml">广告设置</li>
				</ul>
			</div>
			<div class="box-body">
				<div id="page-wrapper">
				</div>
			</div>
		</section>
	</section>
	<%@include file="../../resource.jsp"%>
	<script type="text/javascript" src="${wmsUrl}/js/navPage.js"></script>
	<script type="text/javascript">
		$(function(){
			var width = "100%";
			var height = window.innerHeight-139;
			$("#page-wrapper").empty();
			var newIframeObject = document.createElement("IFRAME");
			newIframeObject.src = "${wmsUrl}/admin/mall/indexMng/list.shtml";
			newIframeObject.scrolling = "yes";
			newIframeObject.frameBorder = 0;
			newIframeObject.width = width;
			newIframeObject.height = height;
			$("#page-wrapper").append(newIframeObject);
			
			$('.list-tabBar').on('click','li',function(){
				var url = $(this).attr('data-url');
				$("#page-wrapper iframe").attr('src',url);
			});
		})
	</script>
</body>
</html>
