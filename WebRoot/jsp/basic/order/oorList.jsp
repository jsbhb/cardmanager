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
<title>制单查询</title>
<%@include file="../../resource.jsp"%>
</head>

<body>
	<input type="hidden" id="exportTask" value="demandOrderService"/>
	<div id="page-wrapper">
		<div id="mask"></div>
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-12">
					<div class="query">
						<div class="row">
							<div class="form-group">
								<label>申报单号</label> <input type="text" class="form-control"
									name="externalNo">
							</div>
							<div class="form-group">
								<label>订单编号</label> <input type="text" class="form-control"
									name="externalNo2">
							</div>
							<div class="form-group">
								<label>快递单号</label> <input type="text" class="form-control"
									name="expressID">
							</div>
						</div>
						<div class="row">
							<div class="form-group">
								<label>商家编号</label> <input type="text" class="form-control"
									name="sellerInfoId" id="supplierId" forBtn="showSuppiler">
							</div>
							<div class="form-group">
								<label>商家名称</label> <input type="text" class="form-control"
									name="supplierName" id="supplierName">
								<button type="button" class="btn btn-warning" btnId="showSuppiler" onclick="showSuppiler()">查找商家</button>
							</div>
						</div>
						<div class="row">
							<div class="form-group">
								<label>商品货号</label> <input type="text" class="form-control"
									name="sku">
							</div>
							<div class="form-group">
								<label>订单状态</label> <select class="form-control" name="orderState">
									<option value="">全部</option>
									<option value="0">初始状态</option>
									<option value="1">库存锁定</option>
									<option value="2">单证放行</option>
									<option value="3">分类分拣</option>
									<option value="4">快递单打印</option>
									<option value="5">出货</option>
									<option value="6">退单</option>
									<option value="11">菜鸟初始订单</option>
									<option value="12">拒单</option>
									<option value="13">菜鸟未下发</option>
									<option value="14">IM3报备失败</option>
									<option value="21">有库存，无库位</option>
								</select>
							</div>
							<div class="form-group">
								<label>制单状态</label> <select class="form-control" name="oorState">
									<option value="">全部</option>
									<option value="0">库存不足</option>
									<option value="1">库存足够</option>
									<option value="3">快递单打印</option>
									<option value="4">已拣货</option>
									<option value="5">已复核</option>
									<option value="6">已过机</option>
									<option value="-1">已取消</option>
									<option value="11">取消未放回</option>
								</select>
							</div>
						</div>
						<div class="row">
							<div class="form-group">
								<label>指示单号</label> <input type="text" class="form-control"
									name="instructions">
							</div>
							<div class="form-group">
								<label>店铺名称</label> <input type="text" class="form-control"
									name="shopName">
							</div>
							<div class="form-group">
								<label>过机时间</label> <input size="18" type="text" id="guojiStartTime"
									class="form-control dataPicker" name="guojiStartTime"> <span
									class="add-off"><i class="icon-th"></i></span> <label>&nbsp;至&nbsp;</label>
								<input size="18" type="text" id="guojiEndTime"
									class="form-control dataPicker" name="guojiEndTime"> <span
									class="add-on"><i class="icon-th"></i></span>
							</div>
						</div>
						<div class="row">
							<div class="form-group">
								<label>接单时间</label> <input size="18" type="text" id="jiedanStartTime"
									class="form-control dataPicker" name="jiedanStartTime"> <span
									class="add-off"><i class="icon-th"></i></span> <label>&nbsp;至&nbsp;</label>
								<input size="18" type="text" id="jiedanEndTime"
									class="form-control dataPicker" name="jiedanEndTime"> <span
									class="add-on"><i class="icon-th"></i></span>
							</div>
							<div class="form-group">
								<label>单证时间</label> <input size="18" type="text" id="danzhengStartTime"
									class="form-control dataPicker" name="danzhengStartTime"> <span
									class="add-on"><i class="icon-th"></i></span> <label>&nbsp;至&nbsp;</label>
								<input size="18" type="text" id="danzhengEndTime"
									class="form-control dataPicker" name="danzhengEndTime"> <span
									class="add-on"><i class="icon-th"></i></span>
							</div>
							<div class="form-group">
								<button type="button" id="querybtns" class="btn btn-primary">查询</button>
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
								<i class="fa fa-bar-chart-o fa-fw"></i>订单列表
							</h3>
						</div>
						<div class="panel-body">
							<button type="button" id="exportbtns" class="btn btn-primary btnModalExport">导出数据</button>
							<table id="orderTable" class="table table-hover">
								<thead>
									<tr>
										<th>选中</th>
										<th name="OorState">制单状态</th>
										<th name="OrderState">订单状态</th>
										<th name="ExternalNo2">订单编号</th>
										<th name="ExpressId">快递单号</th>
										<th name="Instructions">指示单号</th>
										<th name="Sku">货号</th>
										<th name="SkuName">商品名称</th>
										<th name="ItemQuantity">商品数量</th>
										<th name="aTime">接单时间</th>
										<th name="pTime">打印时间</th>
										<th name="DzTime">单证时间</th>
										<th name="GjTime">过机时间</th>
										<th name="SupplierName">商家名称</th>
										<th name="ShopName">店铺名称</th>
										<th name="ExternalNo">申报单号</th>
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
	</div>
	<script type="text/javascript">
		$(document).ExportControl({terms:$(".query"),table:$("#orderTable"),url:"${wmsUrl}"});
		/**
		 * 初始化分页信息
		 */
		var options = {
			queryForm : ".query",
			url : "${wmsUrl}/admin/order/oorDataList.shtml",
			numPerPage : "20",
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
			$.zzComfirm.endMask();
			$("#orderTable tbody").html("");

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
				str += "<tr>";
				str += "<td><input type='checkbox' name='check' value='" + list[i].orderId + "' /></td>";
				switch (list[i].oorState) {
				case "0":
					strCom = "库存不足";
					break;
				case "1":
					strCom = "库存足够";
					break;
				case "3":
					strCom = "快递单打印";
					break;
				case "4":
					strCom = "已拣货";
					break;
				case "5":
					strCom = "已复核";
					break;
				case "6":
					strCom = "已出货";
					break;
				case "10":
					strCom = "取消";
					break;
				case "11":
					strCom = "取消";
					break;
				}
				str += "</td><td>" + strCom;
				switch (list[i].orderState) {
				case "0":
					strCom = "初始状态";
					break;
				case "1":
					strCom = "库存锁定";
					break;
				case "2":
					strCom = "单证放行";
					break;
				case "3":
					strCom = "分类分拣";
					break;
				case "4":
					strCom = "快递单打印";
					break;
				case "5":
					strCom = "出货";
					break;
				case "6":
					strCom = "退单";
					break;
				case "7":
					strCom = "菜鸟未放行";
					break;
				case "11":
					strCom = "菜鸟初始订单";
					break;
				case "12":
					strCom = "拒单";
					break;
				case "13":
					strCom = "菜鸟未下发";
					break;
				case "14":
					strCom = "IM3报备失败";
					break;
				case "21":
					strCom = "有库存，无库位";
					break;
				case "-2":
					strCom = "海关审核不过废单";
					break;
				case "99":
					strCom = "审核已指示";
					break;
				case "98":
					strCom = "审核已打印";
					break;
				}
				str += "</td><td>" + strCom;
				str += "</td><td>" + list[i].externalNo2;
				str += "</td><td>" + list[i].expressId;
				str += "</td><td>" + list[i].instructions;
				str += "</td><td>" + list[i].sku;
				str += "</td><td>" + list[i].skuName;
				str += "</td><td>" + list[i].itemQuantity;
				str += "</td><td>" + list[i].aTime;
				str += "</td><td>" + list[i].pTime;
				str += "</td><td>" + list[i].dzTime;
				str += "</td><td>" + list[i].gjTime;
				str += "</td><td>" + list[i].supplierName;
				str += "</td><td>" + list[i].shopName;
				str += "</td><td>" + list[i].externalNo;
				str += "</td></tr>";
			}

			$("#orderTable tbody").htmlUpdate(str);
		}

		function showSuppiler(){
		    var frameSrc = "${wmsUrl}/admin/basic/sellerInfo/showDetail.shtml";
		    $("#supplierIFrame").attr("src", frameSrc);
		    $('#supplierModal').modal({ show: true, backdrop: 'static' });
		}

		function closeSupModal(){
			$('#supplierModal').modal('hide');
		}
	</script>
</body>
</html>