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
</head>

<body>
	<section class="content-header">
	      <ol class="breadcrumb">
	        <li><a href="javascript:void(0);">首页</a></li>
	        <li>商品管理</li>
	        <li class="active">新增商品</li>
	      </ol>
    </section>
	<section class="content-iframe content">
	    <div class="choose-content">
	    	<h1>选择上货方式</h1>
	    	<a class="choose-content-item" href="add.jsp">
	    		<i class="fa fa-child fa-fw"></i>
	    		<span>自助上货</span>
	    	</a>
	    	<a class="choose-content-item">
	    		<i class="fa  fa-file-excel-o fa-fw"></i>
	    		<span>批量导入</span>
	    	</a>
	    </div>
	</section>
	<%@include file="../../resource.jsp"%>
	<script>
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
