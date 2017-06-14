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
							<li class="active"><i class="fa fa-bookmark fa-fw"></i>新增空包订单</li>
						</ol>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<label>订单编号</label><input type="text" class="form-control"
								name="orderCode" id="orderCode">
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
								name="supplierId" id="supplierId" disabled="disabled" forBtn="showSuppiler">
						</div>
						<div class="form-group">
							<label>商家名称</label><input type="text" class="form-control"
								name="supplierName" id="supplierName" disabled="disabled" forBtn="showSuppiler">
						</div>
						<div class="form-group">
							<button type="button" class="btn btn-warning" btnId="showSuppiler"
								onclick="showSuppiler()">查询商家</button>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>

	<div class="modal fade" id="supplierModal" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" aria-hidden="true"
						data-dismiss="modal" onclick="closeSupModal()">&times;</button>
					<h4 class="modal-title" id="modelTitle">商家选择</h4>
				</div>
				<div class="modal-body" >
					<iframe id="supplierIFrame" width="100%" height="100%"
						frameborder="0"></iframe>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal"
						onclick="closeSupModal()">取消</button>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	
		function showSuppiler() {
			var frameSrc = "${wmsUrl}/admin/basic/sellerInfo/showDetail.shtml";
			$("#supplierIFrame").attr("src", frameSrc);
			$('#supplierModal').modal({
				show : true,
				backdrop : 'static'
			});
		}

		function closeSupModal() {
			$('#supplierModal').modal('hide');
		}
	</script>
</body>
</html>
