<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title> ERROR！！</title>
    <%@include file="resource.jsp" %>
  </head>
  <body>
  <div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">
					<i class="fa fa-bar-chart-o fa-fw"></i>出错了
				</h3>
			</div>
			<div class="panel-body">
				${msg}
			</div>
		</div>
	</div>
  </div>
   
  </body>
</html>