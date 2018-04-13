<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!Doctype html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<title>错误</title>
		<link rel="stylesheet" media="screen" href="${wmsUrl}/css/error-style.css">
		
	</head>
	<body>

		<p class="error">${code}</p>
		
		<div class="content">
			<h2>错误内容</h2>
			
			<p class="text">
				${msg}
			</p>
		</div>
		
	</body>
</html>