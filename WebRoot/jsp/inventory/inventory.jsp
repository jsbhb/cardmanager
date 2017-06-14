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
<title>进销存查询</title>
<%@include file="../resource.jsp"%>
</head>

<style type="text/css">

.num{
	width: 14% !important;
	background-color: #4e8eb7 !important;
	color: #ffffff;
	font-weight: bold;
	height: 90px;
	font-size: 16px;
	margin:10px;
}

.mark{
	width: 2% !important;
	background-color: #ffffff;
	color: #4e8eb7 !important;
	font-weight: bold;
	height: 90px;
	font-size: 16px;margin:10px;
}

</style>

<body>
	<div id="page-wrapper">
		<div id="mask"></div>
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-12">
					<div class="query">
						<div class="row" style="padding-left: 15px">
							<div class="form-group">
								<label>货号</label> <input type="text" class="form-control" name="sku" value="${sku}"/>
							</div>
							<div class="form-group">
								<label>商家编号</label>
								<input class="form-control" name="supplierId" forBtn="supQuery"  id="supplierId" value="${supplierId}"/>
							</div>
							<div class="form-group">
								<label>商家名称</label> 
								<input type="text" class="form-control" name="supplierName" forBtn="supQuery" id="supplierName"/>
								<button type="button" class="btn btn-warning" btnId="supQuery" onclick="showSuppiler()">查找商家</button>
							</div>
						</div>
						<div class="form-group">
							<button type="button" id="querybtns" class="btn btn-primary">查询</button>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default" style="overflow: auto;">
						<div class="panel-heading">
							<h3 class="panel-title">
								<i class="fa fa-bar-chart-o fa-fw"></i>商品信息
							</h3>
						</div>
						<div class="panel-body">
							<table id="skuInfoTable" class="table table-bordered">
								<tbody>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default" style="overflow: auto;">
						<div class="panel-heading">
							<h3 class="panel-title">
								<i class="fa fa-bar-chart-o fa-fw"></i>进销存信息
							</h3>
						</div>
						<div class="panel-body">
							<div class="form-group" id="inventoryTable">
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default" style="overflow: auto;">
						<div class="panel-heading">
							<h3 class="panel-title">
								<i class="fa fa-bar-chart-o fa-fw"></i>库存信息
							</h3>
						</div>
						<div class="panel-body">
							<table id="warehouseTable" class="table table-hover table-border">
								<thead>
									<tr>
										<th>总上架</th>
										<th>良品数量</th>
										<th>次品数量</th>
										<th>冻结数量</th>
										<th>虚拟数量</th>
										<th>空包数量</th>
										<th>待上架数量</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default" style="overflow: auto;">
						<div class="panel-heading">
							<h3 class="panel-title">
								<i class="fa fa-bar-chart-o fa-fw"></i>批次信息
							</h3>
						</div>
						<div class="panel-body">
							<table id="poTable" class="table table-hover table-border">
								<thead>
									<tr>
										<th>数量</th>
										<th>冻结数量</th>
										<th>效期</th>
										<th>报检号</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default" style="overflow: auto;">
						<div class="panel-heading">
							<h3 class="panel-title">
								<i class="fa fa-bar-chart-o fa-fw"></i>库位信息
							</h3>
						</div>
						<div class="panel-body">
							<table id="libraryTable" class="table table-hover table-border">
								<thead>
									<tr>
										<th>区域类型</th>
										<th>库位类型</th>
										<th>数量</th>
										<th>冻结数量</th>
										<th>库位数量</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
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
		         	<iframe id="supplierIFrame" width="100%" height="100%" frameborder="0"></iframe>
		         </div>
		         <div class="modal-footer">
		            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeSupModal()">取消 </button>
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
		url : "${wmsUrl}/admin/inventory/inventory.shtml",
		index : "1",
		callback : buildContent
	}
	
	$(function() {
		$("body").pageInit(options);
	})
	
	/**
	 * 重构table
	 */
	function buildContent(data) {
		$.zzComfirm.endMask();
		$("#skuInfoTable tbody").html("");
	
		if (data == null || data.length == 0) {
			return;
		}
	
		var obj = data.obj;
	
		if (obj == null || obj.length == 0) {
			$.zzComfirm.alertError("没有查到数据");
			return;
		}
		
		var str = "";
		
		if(obj.skuInfo != null){
			var skuInfo = obj.skuInfo;
			for (var i = 0; i < skuInfo.length; i++) {
				str +="<tr><td>商家</td><td>"+skuInfo[i].supplierName+"</td>";
				str +="<td>商家编号</td><td>"+skuInfo[i].supplierId+"</td>";
				str +="<td>货号</td><td>"+skuInfo[i].sku+"</td></tr>";
				str +="<tr><td>名称</td><td>"+skuInfo[i].skuName+"</td>";
				str +="<td>后端id</td><td>"+skuInfo[i].itemId+"</td>";
				str +="<td>商品编码</td><td>"+skuInfo[i].itemCode+"</td></tr>";
			}
		}
		
		$("#skuInfoTable tbody").html(str);
	
		$("#inventoryTable").html("");
		
		var inventoryStr = "";
		
		if(obj.stockInInventory!=null){
			inventoryStr += "<div class='row' style='margin-top: 20px;'><div class='col-lg-12'><div class='col-sm-6 col-md-4 col-lg-3 col-set num'><span>进货</span><h3>"+obj.stockInInventory.quantity+"</h3></div>";
		}else{
			inventoryStr += "<div class='row' style='margin-top: 20px;'><div class='col-lg-12'><div class='col-sm-6 col-md-4 col-lg-3 col-set num'><span>进货</span><h3>0</h3></div>";
		}
		
		
		if(obj.stockOutInventory!=null){
			inventoryStr += "<div class='col-sm-6 col-md-4 col-lg-3 col-set num'><span>出货</span><h3>"+obj.stockOutInventory.quantity+"</h3></div>";
		}else{
			inventoryStr += "<div class='col-sm-6 col-md-4 col-lg-3 col-set num'><span>出货</span><h3>0</h3></div>";
		}
		
		
		var bakQuantity = 0;
		var bakArray = obj.bakInventory;
		if(bakArray!=null&&bakArray.length!=0){
			for (var i = 0; i < bakArray.length; i++) {
				bakQuantity += bakArray[i].quantity;
			}
			inventoryStr += "<div class='col-sm-6 col-md-4 col-lg-3 col-set num'><span>备份</span><h3>"+bakQuantity+"</h3></div>";
		}else{
			inventoryStr += "<div class='col-sm-6 col-md-4 col-lg-3 col-set num'><span>备份</span><h3>0</h3></div>";
		}
		
		
		var checkArray = obj.checkInventory;
		
		if(checkArray!=null&&checkArray.length!=0){
			var over = 0;
			var less = 0;
			var def = 0;
			for (var i = 0; i < checkArray.length; i++) {
				if(checkArray[i].type == 1){
					over += checkArray[i].quantity;
				}
				if(checkArray[i].type == 2){
					less += checkArray[i].quantity;
				}
				if(checkArray[i].type == 3){
					def += checkArray[i].quantity;
				}
			}
			inventoryStr += "<div class='col-sm-6 col-md-4 col-lg-3 col-set num'><span>盘盈</span><h3>"+over+"</h3></div>";
			inventoryStr += "<div class='col-sm-6 col-md-4 col-lg-3 col-set num'><span>盘亏</span><h3>"+less+"</h3></div>";
			inventoryStr += "<div class='col-sm-6 col-md-4 col-lg-3 col-set num'><span>盘次品</span><h3>"+def+"</h3></div></div>";
		}
		
		$("#inventoryTable").html(inventoryStr);
		
		$("#warehouseTable tbody").html("");	
		var warehouseStr = "";
		
		if(obj.warehouse!=null ||obj.warehouse.length==0){
			var warehouse = obj.warehouse;
			for(var i = 0;i<warehouse.length;i++){
				warehouseStr += "<tr><td>"+(warehouse[i].sumQuantity==null?"0":warehouse[i].sumQuantity);
				warehouseStr += "</td><td>"+(warehouse[i].quantity==null?"0":warehouse[i].quantity);
				warehouseStr += "</td><td>"+(warehouse[i].defQuantity==null?"0":warehouse[i].defQuantity);
				warehouseStr += "</td><td>"+(warehouse[i].frozenQuantity==null?"0":warehouse[i].frozenQuantity);
				warehouseStr += "</td><td>"+(warehouse[i].virtualQuantity==null?"0":warehouse[i].virtualQuantity);
				warehouseStr += "</td><td>"+(warehouse[i].emptyQuantity==null?"0":warehouse[i].emptyQuantity);
				warehouseStr += "</td><td>"+(warehouse[i].waitPutOnQuantity==null?"0":warehouse[i].waitPutOnQuantity);
				warehouseStr += "</td></tr>";
			}
		}else{
			warehouseStr += "<div class='row' style='margin-top: 20px;'><div class='col-lg-12'><div class='col-sm-6 col-md-4 col-lg-3 col-set num'><span>无进货信息</span><h3>0</h3></div>";
		}
		
		$("#warehouseTable tbody").html(warehouseStr);
		
		$("#poTable tbody").html("");	
		var poStr = "";
		
		if(obj.po!=null ||obj.po.length==0){
			var po = obj.po;
			for(var i = 0;i<po.length;i++){
				poStr += "<tr><td>" + po[i].quantity;
				poStr += "</td><td>" + po[i].frozenQuantity;
				poStr += "</td><td>" + po[i].deadline;
				poStr += "</td><td>" + po[i].declNo;
				poStr += "</td></tr>";
			}
		}
		
		$("#poTable tbody").html(poStr);
		
		$("#libraryTable tbody").html("");
		var libraryStr = ""; 
		
		if(obj.library!=null ||obj.library.length==0){
			var library = obj.library;
			
			
			for(var i = 0;i<library.length;i++){
				
				switch(library[i].type){
					case '1':libraryStr += "<tr><td>良品";break;
					case '2':libraryStr += "<tr><td>次品";break;
					case '3':libraryStr += "<tr><td>待货区";break;
					case '4':libraryStr += "<tr><td>撤单区";break;
					case '5':libraryStr += "<tr><td>空包区";break;
					case '6':libraryStr += "<tr><td>虚拟区";break;
					case '7':libraryStr += "<tr><td>差异区";break;
					defult:libraryStr += "<tr><td>无";
				}
				
				switch(library[i].qpType){
					case '1':libraryStr += "</td><td>存储区";break;
					case '2':libraryStr += "</td><td>拣货区";break;
					case '3':libraryStr += "</td><td>特殊区";break;
					defult:libraryStr += "</td><td>无";
				}
				
				libraryStr += "</td><td>" + library[i].quantity;
				libraryStr += "</td><td>" + library[i].frozenQuantity;
				libraryStr += "</td><td>" + library[i].num;
				libraryStr += "</td></tr>";
			}
		}
		
		$("#libraryTable tbody").html(libraryStr);
		
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
