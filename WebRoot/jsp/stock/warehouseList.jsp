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
<title>库存查询</title>
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
						<li class="active"><i class="fa fa-bookmark fa-fw"></i>库存查询</li>
					</ol>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="query">
						<div class="row">
							<div class="form-group">
								<label>货号</label> <input type="text" class="form-control"
									name="sku" id="searchSku">
							</div>
							<div class="form-group">
								<label>商品名称</label> <input type="text" class="form-control"
									name="skuName" id="searchSkuName">
							</div>
							<div class="form-group">
								<button type="button" id="querybtns" class="btn btn-primary">查询</button>
								<button type="button" id="clearbtns" class="btn btn-warning" onclick="clearSku()">清空</button>
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
										<th>详情</th>
										<th>货号</th>
										<th>商品名称</th>
										<th>库存数量</th>
										<th>等待上架数量</th>
										<th>次品数量</th>
										<th>空包数量</th>
										<th>虚拟仓数量</th>
										<th>冻结数量</th>
										<th>锁定数量</th>
										<th>总数</th>
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
	<div class="modal fade" id="detailModal" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="closeDetailModal()">&times;</button>
					<h4 class="modal-title" id="modelTitle">库存明细</h4>
				</div>
				<div class="modal-body">
					<iframe id="detailIFrame"></iframe>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal"
						onclick="closeDetailModal()">关闭</button>
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
			url : "${wmsUrl}/admin/stock/queryWarehouse/dataList.shtml",
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
			for (var i = 0; i < list.length; i++) {
				str += "<tr><td align='left' style='line-height: 30px;'><button type='button' class='btn btn-info' onclick='showDetail(\"";
				str +=	list[i].sku
				str += "\")'>明细</button></td><td align='left' style='line-height: 30px;'>" + list[i].sku;
				str += "</td><td align='left' style='line-height: 30px;'>" + list[i].goodsName;
				str += "</td><td align='left' style='line-height: 30px;'>" + list[i].existqty;
				str += "</td><td align='left' style='line-height: 30px;'>" + list[i].waitqty;
				str += "</td><td align='left' style='line-height: 30px;'>" + list[i].defqty;
				str += "</td><td align='left' style='line-height: 30px;'>" + list[i].kbqty;
				str += "</td><td align='left' style='line-height: 30px;'>" + list[i].virtualqty;
				str += "</td><td align='left' style='line-height: 30px;'>" + list[i].frozenqty;
				str += "</td><td align='left' style='line-height: 30px;'>" + list[i].sdqty;
				str += "</td><td align='left' style='line-height: 30px;'>" + list[i].qty;
				str += "</td></tr>";
			}

			$("#warehouseTable tbody").htmlUpdate(str);
		}

		function showDetail(sku) {
			var frameSrc = "${wmsUrl}/admin/stock/queryWarehouse/detail.shtml?warehouseSku=" + sku;
			$("#detailIFrame").attr("src", frameSrc);
			$('#detailModal').modal({
				show : true,
				backdrop : 'static'
			});
		}
		
		function clearSku(){
			$("#searchSku").val("");
			$("#searchSkuName").val("");
		}
		
		function closeDetailModal(){
			$('#detailModal').modal('hide');
		}
	</script>
</body>
</html>
