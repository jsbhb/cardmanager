<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:choose>
	<c:when test="${not empty menu.childern}">
		<li>
			<span><i class="fa fa-minus fa-fw"></i>${menu.name}</span><input type="text" placeholder="请输入分润比例，例如0.17" parentId="${menu.parentId}" id="${menu.id}" value = "${map[menu.id]}">
			<ul>
				<c:forEach var="menu" items="${menu.childern}">
					<c:set var="menu" value="${menu}" scope="request" />
					<jsp:include page="recursive.jsp" />
				</c:forEach>
			</ul>
		</li>
	</c:when>
	<c:when test="${empty menu.childern}">
		<li><span>${menu.name}</span><input type="text" placeholder="请输入分润比例，例如0.17" parentId="${menu.parentId}" id="${menu.id}" value = "${map[menu.id]}"></li>
	</c:when>
</c:choose>

