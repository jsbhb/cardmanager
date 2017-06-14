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
<title>预包详情</title>
<%@include file="../resource.jsp" %>
</head>

<body>
	<div id="page-wrapper">
		<div class="container-fluid">
		
		<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">
						<i class="fa fa-bar-chart-o fa-fw"></i>库位明细
					</h3>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<table id="preTable" class="table table-hover">
							<thead>
								<tr>
									<th>货号</th>
									<th>名称</th>
									<th>数量</th>
									<th>冻结数量</th>
									<th>报检号</th>
									<th>效期</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${list}" var="item">
								<tr>
									<td><label>${item.sku}</label></td>	 
									<td><label>${item.skuName}</label></td>	 
									<td><label>${item.qty}</label></td>	 
									<td><label>${item.frozenqty}</label></td>	 
									<td><label>${item.declNo}</label></td>	 
									<td><label>${item.deadLine}</label></td>	 
								</tr>
							</c:forEach>
							</tbody>
						</table>
						<div class="pagination-nav">
							<ul id="pagination" class="pagination">
							</ul>
						</div>
					</div>
			</div>
		</div>
			
	</div>
</div>

</body>
</html>
