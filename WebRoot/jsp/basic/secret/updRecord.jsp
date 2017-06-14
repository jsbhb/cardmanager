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
<title>出库业务</title>
<%@include file="../../resource.jsp"%>
</head>

<body>
	<div id="page-wrapper">

		<div class="container-fluid">
			<form role="form" id="libraryForm" class="queryTerm">
				<div class="row">
					<div class="col-lg-12">
						<ol class="breadcrumb">
							<li><i class="fa fa-book fa-fw"></i>出库业务</li>
							<li class="active"><i class="fa fa-bookmark fa-fw"></i>更新空包订单</li>
						</ol>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<label>订单编号</label><input type="text" class="form-control"
								name="orderCode" id="orderCode" value="${emptyRecord.orderCode}">
						</div>
						<div class="form-group">
							<label>订单状态</label><select class="form-control" name="state"
								disabled="disabled">
								<option value="0" selected="selected">未处理</option>
							</select>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<label>商家编号</label><input type="text" class="form-control"
								name="supplierId" id="supplierId" disabled="disabled"
								value="${emptyRecord.supplierid}">
						</div>
						<div class="form-group">
							<label>商家名称</label><input type="text" class="form-control"
								name="supplierName" id="supplierName" disabled="disabled"
								value="${emptyRecord.suppliername}">
						</div>
						<div class="form-group">
							<input type="hidden" class="form-control" name="id" id="id"
								value="${emptyRecord.id}">
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<script type="text/javascript">
	</script>
</body>
</html>
