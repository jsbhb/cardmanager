<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>包材维护</title>
<%@include file="../../resource.jsp"%>
</head>

<body>
	<div id="page-wrapper">

		<div class="container-fluid">
			<form role="form" id="libraryForm">
				<div class="row">
					<div class="col-lg-12">
						<ol class="breadcrumb">
							<li><i class="fa fa-book fa-fw"></i>包材维护</li>
							<li class="active"><i class="fa fa-bookmark fa-fw"></i>维护包材数量</li>
						</ol>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<label>包材编码</label>
							<input type="text" class="form-control" name="packageId" id="packageId" readonly="readonly">
						</div>
						<div class="form-group">
							<label>包材名称</label>
							<input type="text" class="form-control" name="packageName" id="packageName" readonly="readonly">
						</div>
						<div class="form-group">
							<label>包材规格</label>
							<input type="text" class="form-control" name="packageSpec" id="packageSpec" readonly="readonly">
						</div>
						<div class="form-group">
							<label>采购数量</label>
							<input type="text" class="form-control" name="packageQty" id="packageQty" onkeyup="return ValidateNumber($(this),value)">
						</div>
					</div>
				</div>
			</form>
			
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default" style="overflow: auto;">
						<div class="panel-heading">
							<h3 class="panel-title">
								<i class="fa fa-bar-chart-o fa-fw"></i>明细列表
							</h3>
						</div>
						<div class="panel-body">
							<table id="packageNumTable" class="table table-hover">
								<thead>
									<tr>
										<th>包材编码</th>
										<th>记录月份</th>
										<th>该月购买</th>
										<th>该月使用</th>
										<th>操作时间</th>
										<th>操作人</th>
									</tr>
								</thead>
								<tbody>
								<c:forEach items="${packageNumList}" var = "item">
									<tr>
										<td>${item.packageId}</td>
										<td>${item.dydate}</td>
										<td>${item.dymqty}</td>
										<td>${item.dyyqty}</td>
										<td>${item.updateTime}</td>
										<td>${item.opt}</td>
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
	</div>
	<script type="text/javascript">
		
		function ValidateNumber(e, pnumber) {
			if (!/^\d+$/.test(pnumber)) {
				$(e).val(/^\d+/.exec($(e).val()));
			}
		}
		
		$(function pageInit() {
			getselect();
		})
		
		function getselect() {
			$("#packageId").val('${packageList.packageId}');
			$("#packageName").val('${packageList.packageName}');
			$("#packageSpec").val('${packageList.packageSpec}');
		}
	</script>
</body>
</html>
