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
			<div class="row">
				<div class="col-lg-12">
					<div class="query">
						<div class="row">
							<div class="form-group">
								<label>商品货号</label> <input type="text" class="form-control"
									name="sku" id="detailSearchSku" value="${sku}">
							</div>
							<div class="form-group">
								<label>商品名称</label> <input type="text" class="form-control"
									name="skuName" id="detailSearchSkuName" value="${skuName}">
							</div>
							<div class="form-group">
								<label>商家编号</label> <input type="text" forBtn="supQuery" class="form-control"
									name="supplierId" id="supplierId" disabled="disabled" value="${supId}">
							</div>
							<div class="form-group">
								<label>商家名称</label> <input type="text" forBtn="supQuery" class="form-control"
									name="supplierName" id="supplierName" disabled="disabled" value="${supName}">
							</div>
							<div class="form-group">
								<button type="button" class="btn btn-warning" btnId="supQuery" onclick="showSuppiler()">查找商家</button>
							</div>
						</div>
						<div class="row">
							<div class="form-group">
								<label>库位&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label> <input type="text" class="form-control"
									name="libNo" id="libNo">
							</div>
							<div class="form-group">
								<label>库位类型</label> <select  class="form-control" name="libType" id="libType">
									<option value="0" selected="selected">全部</option>
									<option value="1">良品库</option>
									<option value="2">不良品库</option>
									<option value="3">待货区</option>
									<option value="4">撤单区</option>
									<option value="5">空包区</option>
									<option value="6">虚拟仓</option>
									<option value="7">差异区</option>
								</select>
							</div>
							<div class="form-group">
								<label>自制码&nbsp;&nbsp;&nbsp;&nbsp;</label> <input type="text" class="form-control"
									name="selfNo" id="selfNo">
							</div>
							<div class="form-group">
								<label>货号编码</label> <input type="text" class="form-control"
									name="skuID" id="skuID">
							</div>
						</div>
						<div class="row">
							<div class="form-group">
								<label>过期日期:</label> 
								<input size="16" type="text" id="startTime"  class="form-control dataPicker" name="startTime">
								<span class="add-on"><i class="icon-th"></i></span>
								<label>&nbsp;至&nbsp;</label> 
								<input size="16" type="text" id="endTime"  class="form-control dataPicker" name="endTime">
								<span class="add-on"><i class="icon-th"></i></span>
							</div>
							<div class="form-group">
								<button type="button" id="querybtns" class="btn btn-primary">查询</button>
								<button type="button" id="clearbtns" class="btn btn-warning"
									onclick="clearSearch()">清空</button>
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
										<th>商家名称</th>
										<th>编号</th>
										<th>货号</th>
										<th>商品名称</th>
										<th>报检号</th>
										<th>自制码</th>
										<th>所属库位</th>
										<th>库位类型</th>
										<th>库存数量</th>
										<th>过期日期</th>
										<th>对应状态</th>
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
	<div class="modal fade" id="supplierModal" tabindex="-1" role="dialog" aria-hidden="true">
	   <div class="modal-dialog" >
	      <div class="modal-content" >
	         <div class="modal-header">
	            <button type="button" class="close"  aria-hidden="true" data-dismiss="modal" onclick="closeSupModal()">&times;</button>
	         	<h4 class="modal-title" id="modelTitle">商家选择</h4>
	         </div>
	         <div class="modal-body" >
	         	<iframe id="supplierIFrame"  frameborder="0"></iframe>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeSupModal()">取消 </button>
	         </div>
	      </div>
		</div>
	</div>
	<script type="text/javascript">
		$(".dataPicker").datetimepicker({
			format : 'yyyy-mm-dd'
		});
		/**
		 * 初始化分页信息
		 */
		var options = {
			queryForm : ".query",
			url : "${wmsUrl}/admin/stock/querySupWarehouse/dataSupplierDetailList.shtml",
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
			if (data.errTrace == "Search.") {
				return;
			} else if (data.errTrace != null) {
				$.zzComfirm.alertError(data.errTrace);
				return;
			}

			if (list == null || list.length == 0) {
				$.zzComfirm.alertError("没有查到数据");
				return;
			}

			var str = "";
			var strCom = "";
			for (var i = 0; i < list.length; i++) {
				str += "<tr ";
				if(!checkDeadLine(list[i].deadLine)){
					str += "style='color: red;'";
				}
				str +="><td align='left'>" + list[i].sellerName;
				str += "</td><td align='left'>" + list[i].sellerInfoId;
				str += "</td><td align='left'>" + list[i].sku;
				str += "</td><td align='left'>" + list[i].goodsName;
				str += "</td><td align='left'>" + list[i].declNo;
				str += "</td><td align='left'>" + list[i].declNo+"_"+list[i].kjskuid;
				str += "</td><td align='left'>" + list[i].libno;
				switch (list[i].type) {
				  case "1":
					  strCom = "良品库";
					  break;
				  case "2":
					  strCom = "不良品库";
					  break;
				  case "3":
					  strCom = "待货区";
					  break;
				  case "4":
					  strCom = "撤单区";
					  break;
				  case "5":
					  strCom = "空包区";
					  break;
				  case "6":
					  strCom = "虚拟仓";
					  break;
				  case "7":
					  strCom = "差异区";
					  break;
				}
				str += "</td><td align='left'>" + strCom;
				str += "</td><td align='left'>" + list[i].quantity;
				str += "</td><td align='left'>" + list[i].deadLine;
				switch (list[i].status) {
				  case 1:
					  strCom = "未调拨";
					  break;
				  case 2:
					  strCom = "在库";
					  break;
				  case 3:
					  strCom = "出库";
					  break;
				  case 4:
					  strCom = "锁定";
					  break;
				}
				str += "</td><td align='left'>" + strCom;
				str += "</td></tr>";
			}

			$("#warehouseTable tbody").htmlUpdate(str);
		}

		function clearSearch() {
			$("#detailSearchSku").val("");
			$("#detailSearchSkuName").val("");
			$("#supplierId").val("");
			$("#supplierName").val("");
			$("#libNo").val("");
			$("#libType").val("0");
			$("#selfNo").val("");
			$("#skuID").val("");
			$("#startTime").val("");
			$("#endTime").val("");
		}
		
		function showSuppiler(){
		    var frameSrc = "${wmsUrl}/admin/basic/sellerInfo/showDetail.shtml";
		    $("#supplierIFrame").attr("src", frameSrc);
		    $('#supplierModal').modal({ show: true, backdrop: 'static' });
		}
		
		function closeSupModal(){
			$('#supplierModal').modal('hide');
		}
		
		function checkDeadLine(deadLine){
			if(deadLine==null){
				return true;
			}
			var currentDate = new Date();
			currentDate = currentDate.valueOf();
			lastDate = currentDate + 90*24*60*60*1000;
			lastDate = new Date(lastDate);
			var deadLine = new Date(deadLine);
			if(deadLine<lastDate){
				return false;
			}
			return true;
		}
	</script>
</body>
</html>
