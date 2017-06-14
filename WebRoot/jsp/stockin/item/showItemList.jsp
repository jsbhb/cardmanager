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
<title>条形码打印</title>
<%@include file="../../resource.jsp"%>
</head>

<body>
	<div id="page-wrapper">

		<div class="container-fluid">
			<!-- Page Heading -->
			<div class="row">
				<div class="col-lg-12">
					<ol class="breadcrumb">
						<li><i class="fa fa-book fa-fw"></i>进货管理</li>
						<li class="active"><i class="fa fa-bookmark fa-fw"></i>条形码打印</li>
					</ol>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="query">
						<div class="row" style="padding-left: 15px">
							<div class="form-group">
								<label>进货号</label> <input type="text" class="form-control"
									name="asnStockId">
							</div>
							<div class="form-group">
								<label>商家编号</label> <input type="text" class="form-control"
									name="supplierId" id="supplierId">
								<button type="button" class="btn btn-warning" btnId="showSuppiler" onclick="showSuppiler()">查找商家</button>
							</div>
							<div class="form-group">
								<label>报检号</label> <input type="text" class="form-control"
									name="declNo">
							</div>
							<div class="form-group">
								<label>货号</label> <input type="text" class="form-control"
									name="sku">
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
								<i class="fa fa-bar-chart-o fa-fw"></i>商品列表
							</h3>
						</div>
						<div class="panel-body">
							<c:if test="${privilege>=2}">
								<button type="button" class="btn btn-info" onclick="buildCodeModel()">自定义条形码</button>
							</c:if>
							<table id="showItemTable" class="table table-hover">
								<thead>
									<tr>
										<th>操作</th>
										<th>进货号</th>
										<th>商家编号</th>
										<th>商家名称</th>
										<th>报检号</th>
										<th>货号</th>
										<th>数量</th>
										<th>商品名称</th>
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
		<div class="modal fade" id="buildCodeModal" tabindex="-1" role="dialog" aria-hidden="true">
		   <div class="modal-dialog">
		      <div class="modal-content">
		         <div class="modal-header">
		            <button type="button" class="close"  aria-hidden="true" data-dismiss="modal" onclick="closeModal()">&times;</button>
		         	<h4 class="modal-title" id="modelTitle">自定义条形码</h4>
		         </div>
		         <div class="modal-body">
		         	<div class="form-group">
						<label>报检号</label> <input type="text" class="form-control"  name="declNo" id="declNo">
					</div>
					<div class="form-group">
						<label>货号</label> <input type="text" class="form-control" name="sku" id="sku">
					</div>
		         </div>
		         <div class="modal-footer">
		            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeModal()">取消 </button>
		         	<button type="button" class="btn btn-info" onclick="buildBarcode()">打印 </button>
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
<script type="text/javascript">
/**
 * 初始化分页信息
 */
var options = {
	queryForm : ".query",
	url : "${wmsUrl}/admin/stockIn/itemPrint/dataList.shtml",
	numPerPage : "10",
	currentPage : "",
	index : "1",
	callback : rebuildTable
}

$(function() {
	$(".pagination-nav").pagination(options);
})

function buildCodeModel(){
	$("#buildCodeModal").modal('show');
}

function closeModal(){
	$("#buildCodeModal").modal('hide');
	$("#declNo").val("");
	$("#sku").val("");
}

/**
 * 重构table
 */
function rebuildTable(data) {
	$("#showItemTable tbody").html("");

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
		str += "<tr>";
		if ("${privilege>=2}") {
			str += "<td align='left'>";
			str += "<button type='button' class='btn btn-info' onclick='printBarcode($(this))'>打印</button>";
			str += "</td>";
		}
		str += "<td>" + list[i].asnStockId;
		str += "</td><td>" + list[i].supplierId;
		str += "</td><td>" + list[i].supplierName;
		str += "</td><td>" + list[i].declNo;
		str += "</td><td>" + list[i].sku;
		str += "</td><td>" + list[i].quantity;
		str += "</td><td>" + list[i].goodsName;
		str += "</td></tr>";
	}

	$("#showItemTable tbody").htmlUpdate(str);
}

function printBarcode(e) {
	var left1 = (screen.width - 600) / 2;
	var top1 = (screen.height - 450) / 2;

	var goodsName = $(e).parent().next().next().next().next().next().next().text();
	var declNo = $(e).parent().next().next().next().next().text();
	var sku = $(e).parent().next().next().next().next().next().text();

	goodsName=encodeURI(encodeURI(goodsName).replace(/\+/g,'%2B'));
	window.open('${wmsUrl}/admin/stockIn/itemPrint/pdfjsp.shtml?declNo='+declNo+'&sku='+sku+'&goodsName='+goodsName,"","width=1400,height=700,resizable=yes,location=no,scrollbars=yes,left=" + left1.toString() + ",top=" + top1.toString());
}

function buildBarcode() {
	var left1 = (screen.width - 600) / 2;
	var top1 = (screen.height - 450) / 2;

	var declNo = $("#declNo").val();
	var sku = $("#sku").val();
	
	if(declNo==null||""==declNo){
		$.zzComfirm.alertError("请输入报检号！！");
		return;
	}
	
	if(sku==null||""==sku){
		$.zzComfirm.alertError("请输入货号！！");
		return;
	}
	

	window.open('${wmsUrl}/admin/stockIn/itemPrint/pdfjsp.shtml?declNo='+declNo+'&sku='+sku,"","width=1400,height=700,resizable=yes,location=no,scrollbars=yes,left=" + left1.toString() + ",top=" + top1.toString());
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
