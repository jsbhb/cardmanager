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
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@include file="../../resourceLink.jsp"%>
</head>

<body>
	<section class="content-header">
	      <ol class="breadcrumb">
	        <li><a href="javascript:void(0);">首页</a></li>
	        <li>订单管理</li>
	        <li class="active">订单维护</li>
	      </ol>
    </section>
	<section class="content-iframe content">
	    <div class="choose-content">
	    	<h1>选择订单维护方式</h1>
	    	<a class="choose-content-item" href="${wmsUrl}/admin/goods/goodsMng/toAddBatch.shtml">
	    		<i class="fa  fa-file-excel-o fa-fw"></i>
	    		<span>批量订单导入</span>
	    	</a>
	    	<a class="choose-content-item" href="${wmsUrl}/admin/goods/goodsMng/toBatchUploadPic.shtml">
	    		<i class="fa  fa-file-excel-o fa-fw"></i>
	    		<span>批量运单导入</span>
	    	</a>
	    </div>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script>
		function toWaitOpen(){
			layer.alert("功能暂未开放，敬请期待");
		}
		
		
		function jumpSrc(src){
			var p = window;
			while(p != p.parent){
				p = p.parent;
			    self.$ = parent.$;
			}
			$('.iframePage iframe').attr('src',src);
		};
	</script>
</body>
</html>