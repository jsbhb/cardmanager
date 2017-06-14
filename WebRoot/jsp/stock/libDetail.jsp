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
<title>库存明细</title>
<%@include file="../resource.jsp"%>
</head>

<body>
	<div id="page-wrapper">

		<div class="container-fluid">
			<!-- Page Heading -->
			<div class="row">
				<div class="col-lg-12">
					<ol class="breadcrumb">
						<li><i class="fa fa-book fa-fw"></i>在库业务</li>
						<li class="active"><i class="fa fa-bookmark fa-fw"></i>库存明细</li>
					</ol>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="query">
						<div class="row">
							<div class="form-group">
								<label>仓库位置</label> <input type="text" class="form-control"
									name="depart" id="depart" value="${depart}" disabled="disabled">
							</div>
							<div class="form-group">
								<label>仓库类型</label> <input type="text" class="form-control"
									name="type" id="type" value="${type}" disabled="disabled">
							</div>
							<div class="form-group">
								<label>仓位名称</label> <input type="text" class="form-control"
									name="libno" id="libno" value="${libno}" disabled="disabled">
							</div>
							<div class="form-group">
								<input type="hidden" class="form-control" name="libid"
									id="libid" value="${libId}">
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">
								<i class="fa fa-bar-chart-o fa-fw"></i>库存列表
							</h3>
						</div>
						<div class="panel-body">
							<table id="warehouseTable" class="table table-hover">
								<thead>
									<tr>
										<th>货号</th>
										<th>商品名称</th>
										<th>报检号</th>
										<th>供应商编号</th>
										<th>供应商名称</th>
										<th>库存数量</th>
										<th>生产日期</th>
										<th>过期日期</th>
										<th>更新时间</th>
									</tr>
								</thead>
								<tbody>
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
		/**
		 * 初始化分页信息
		 */
		var options = {
			queryForm : ".query",
			url : "${wmsUrl}/admin/stock/queryLibWarehouse/dataLibDetailList.shtml",
			numPerPage : "10",
			currentPage : "",
			index : "1",
			callback : rebuildTable
		}

		$(function() {
			$(".pagination-nav").pagination(options);
		})

		/**
		 * 重构table
		 */
		function rebuildTable(data) {
			$("#warehouseTable tbody").html("");

			if (data == null || data.length == 0) {
				return;
			}

			var list = data.obj;

			if (list == null || list.length == 0) {
				$.zzComfirm.alertError("没有查到数据");
				return;
			}

			var str = "";
			var strCom = "";
			for (var i = 0; i < list.length; i++) {
				str += "<tr><td align='left'>" + list[i].sku;
				str += "</td><td align='left'>" + list[i].skuName;
				str += "</td><td align='left'>" + list[i].declNo;
				str += "</td><td align='left'>" + list[i].supplierid;
				str += "</td><td align='left'>" + list[i].supplierName;
				str += "</td><td align='left'>" + (list[i].quantity*1 + list[i].waitQty*1);
				str += "</td><td align='left'>" + list[i].productionTime;
				str += "</td><td align='left'>" + list[i].deadline;
				str += "</td><td align='left'>" + list[i].updatetime;
				str += "</td></tr>";
			}

			$("#warehouseTable tbody").htmlUpdate(str);
		}
		
		$(function pageInit() {
			$("#lattice").html("");
			$.ajax({
				url : "${wmsUrl}/admin/basic/stor/getValue.shtml",
				type : "post",
				dataType : "json",
				success : function(result) {
					for (var i = 0; i < result.length; i++) {
						$("select[name='lattice']").each(
								function() {
									$(this).append(
											"<option value="+result[i].code+">"
													+ result[i].storageName
													+ "</option>");
								});
					}
				},
				error : function() {
					alert("系统崩溃啦，请联系技术");
				}
			});
		})
	</script>
</body>
</html>
