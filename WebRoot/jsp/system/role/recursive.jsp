<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:choose>
	<c:when test="${not empty menu.children}">
		<li>
			<span><i class="fa fa-minus fa-fw"></i>${menu.roleName}</span><a href="javascript:void(0);" >
			<a href='javascript:void(0);' class='table-btns' onclick='toAdd(${menu.roleId},${menu.parentId})' >新增</a>
			<a href='javascript:void(0);' class='table-btns' onclick='toEdit(${menu.roleId},${menu.parentId})' >修改</a>
			<ul>
				<c:forEach var="menu" items="${menu.children}">
					<c:set var="menu" value="${menu}" scope="request" />
					<jsp:include page="recursive.jsp" />
				</c:forEach>
			</ul>
		</li>
	</c:when>
	<c:when test="${empty menu.children}">
		<li><span data-id="${menu.roleId}" data-name="${menu.roleName}">${menu.roleName}</span>
		<a href='javascript:void(0);' class='table-btns' onclick='toAdd(${menu.roleId},${menu.parentId})' >新增</a>
		<a href='javascript:void(0);' class='table-btns' onclick='toEdit(${menu.roleId},${menu.parentId})' >修改</a>
		</li>
	</c:when>
</c:choose>

