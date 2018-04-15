<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:choose>
	<c:when test="${not empty menu.childern}">
		<li>
			<span><i class="fa fa-minus fa-fw"></i>${menu.name}</span><a href="" >
			<a href='javascript:void(0);' class='table-btns' onclick='toAdd(${menu.id},${menu.parentId})' >新增</a>
			<a href='javascript:void(0);' class='table-btns' onclick='toEdit(${menu.id},${menu.parentId})' >修改</a>
			<a href='javascript:void(0);' class='table-btns' onclick='remove(${menu.id})' >删除</a>
			<ul>
				<c:forEach var="menu" items="${menu.childern}">
					<c:set var="menu" value="${menu}" scope="request" />
					<jsp:include page="recursive.jsp" />
				</c:forEach>
			</ul>
		</li>
	</c:when>
	<c:when test="${empty menu.childern}">
		<li><span data-id="${menu.id}" data-name="${menu.name}">${menu.name}</span>
		<a href='javascript:void(0);' class='table-btns' onclick='toAdd(${menu.id},${menu.parentId})' >新增</a>
		<a href='javascript:void(0);' class='table-btns' onclick='toEdit(${menu.id},${menu.parentId})' >修改</a>
		<a href='javascript:void(0);' class='table-btns' onclick='remove(${menu.id})' >删除</a>
		</li>
	</c:when>
</c:choose>

