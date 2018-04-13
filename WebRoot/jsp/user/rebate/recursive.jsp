<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:choose>
	<c:when test="${not empty menu.children}">
		<li>
			<span data-id="${menu.id}" data-name="${menu.name}"><i class="fa fa-caret-right fa-fw active"></i>${menu.name}</span>
			<ul>
				<c:forEach var="menu" items="${menu.children}">
					<c:set var="menu" value="${menu}" scope="request" />
					<jsp:include page="recursive.jsp" />
				</c:forEach>
			</ul>
		</li>
	</c:when>
	<c:when test="${empty menu.children}">
		<li><span data-id="${menu.id}" data-name="${menu.name}">${menu.name}</span></li>
	</c:when>
</c:choose>

