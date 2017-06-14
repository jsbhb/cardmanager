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
<title>商家库存</title>
<%@include file="../resource.jsp"%>
</head>

<body>
	<input type="hidden" id="exportTask" value="warehouseQueryServiceImpl"/>
	<div id="page-wrapper">

		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-12">
					<div class="query">
						<div class="row">
							<div class="form-group">
								<label>商家编号</label> <input type="text" class="form-control" forBtn="supQuery" name="supplierId" id="supplierId">
							</div>
							<div class="form-group">
								<label>商家名称</label>  
								<input type="text" class="form-control" forBtn="supQuery" name="supplierName" id="supplierName">
							</div>
							<div class="form-group">
								<button type="button" class="btn btn-warning" btnId="supQuery" onclick="showSuppiler()">查找商家</button>
							</div>
						</div>
						<div class="row">
							<div class="form-group">
								<label>商品货号</label> 
								<input type="text" class="form-control" name="sku" id="detailSearchSku">
							</div>
							<div class="form-group">
								<label>商品名称</label> 
								<input type="text" class="form-control" name="skuName" id="detailSearchSkuName">
							</div>
							<div class="form-group">
								<button type="button" id="querybtns" class="btn btn-primary">查询</button>
								<button type="button" id="clearbtns" class="btn btn-warning" onclick="clearSearch()">清空</button>
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
							<button type="button" id="exportbtns" class="btn btn-primary btnModalExport">导出数据</button>
							<table id="warehouseTable" class="table table-hover">
								<thead>
									<tr>
										<th>详情</th>
										<th name="Supplierid">商家编号</th>
										<th name="Suppliername">商家名称</th>
										<th name="Sku">商品货号</th>
										<th name="GoodsName">商品名称</th>
										<th name="Existqty">库存数量</th>
										<th>差异数量</th>
										<th name="Waitqty">等待上架数量</th>
										<th name="Defqty">次品数量</th>
										<th name="Kbqty">空包数量</th>
										<th name="Virtualqty">虚拟仓数量</th>
										<th name="Frozenqty">冻结数量</th>
										<th name="Sdqty">锁定数量</th>
										<th name="Qty">总数</th>
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
	<div class="modal fade" id="supplierDetailModal" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="closeSupplierDetailModal()">&times;</button>
					<h4 class="modal-title" id="modelTitle">库存明细</h4>
				</div>
				<div class="modal-body">
					<iframe id="supplierDetailIFrame" width="100%" height="100%"></iframe>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal"
						onclick="closeSupplierDetailModal()">关闭</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="supplierModal" tabindex="-1" role="dialog" aria-hidden="true">
	   <div class="modal-dialog">
	      <div class="modal-content">
	         <div class="modal-header">
	            <button type="button" class="close"  aria-hidden="true" data-dismiss="modal" onclick="closeSupModal()">&times;</button>
	         	<h4 class="modal-title" id="modelTitle">商家选择</h4>
	         </div>
	         <div class="modal-body">
	         	<iframe id="supplierIFrame" frameborder="0"></iframe>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeSupModal()">取消 </button>
	         </div>
	      </div>
		</div>
	</div>
	<script type="text/javascript">
	$(document).ExportControl({terms:$(".query"),table:$("#warehouseTable"),url:"${wmsUrl}"});
	
		$(".dataPicker").datetimepicker({
			format : 'yyyy-mm-dd'
		});
		/**
		 * 初始化分页信息
		 */
		var options = {
			queryForm : ".query",
			url : "${wmsUrl}/admin/stock/querySupWarehouse/dataSupplierList.shtml",
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

			//跳过查询
			if (data.errTrace == "Return Search.") {
				return;
			}
			
			if (list == null || list.length == 0) {
				$.zzComfirm.alertError("没有查到数据");
				return;
			}

			var str = "";
			for (var i = 0; i < list.length; i++) {
				str += "<tr><td align='left'><button type='button' class='btn btn-info' onclick='showDetail(\"";
				str +=	list[i].supplierid + "\",\"" + list[i].sku + "\",\"" + list[i].suppliername + "\",\"" + list[i].goodsName
				str += "\")'>明细</button></td><td align='left'>" + list[i].supplierid;
				str += "</td><td align='left'>" + list[i].suppliername;
				str += "</td><td align='left'>" + list[i].sku;
				str += "</td><td align='left'>" + list[i].goodsName;
				str += "</td><td align='left'>" + list[i].existqty;
				str += "</td><td align='left'>" + list[i].qpqty;
				str += "</td><td align='left'>" + list[i].waitqty;
				str += "</td><td align='left'>" + list[i].defqty;
				str += "</td><td align='left'>" + list[i].kbqty;
				str += "</td><td align='left'>" + list[i].virtualqty;
				str += "</td><td align='left'>" + list[i].frozenqty;
				str += "</td><td align='left'>" + list[i].sdqty;
				str += "</td><td align='left'>" + list[i].qty;
				str += "</td></tr>";
			}

			$("#warehouseTable tbody").htmlUpdate(str);
		}

		function showDetail(supId,sku,supName,skuName) {
			var supName = encodeURI(supName);
			var skuName = encodeURI(skuName);
			var frameSrc = "${wmsUrl}/admin/stock/querySupWarehouse/supplierDetail.shtml?sku=" + sku + "&supId="+ supId + "&supName="+ supName + "&skuName="+ skuName;
			frameSrc=frameSrc.replace(/\+/g,'%2b');
			$("#supplierDetailIFrame").attr("src", frameSrc);
			$('#supplierDetailModal').modal({
				show : true,
				backdrop : 'static'
			});
		}
		
		function clearSearch() {
			$("#detailSearchSku").val("");
			$("#detailSearchSkuName").val("");
			$("#supplierId").val("");
			$("#supplierName").val("");
		}
		
		function showSuppiler(){
		    var frameSrc = "${wmsUrl}/admin/basic/sellerInfo/showDetail.shtml";
		    $("#supplierIFrame").attr("src", frameSrc);
		    $('#supplierModal').modal({ show: true, backdrop: 'static' });
		}

		function closeSupModal(){
			$('#supplierModal').modal('hide');
		}
		
		function closeSupplierDetailModal(){
			$('#supplierDetailModal').modal('hide');
		}
	</script>
</body>
</html>
