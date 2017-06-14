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
<title>对账</title>
<%@include file="../../resource.jsp" %>
</head>

<body>
	<div id="page-wrapper">
		<div class="container-fluid">
			<!-- Page Heading -->
			<div class="row">
				<div class="col-lg-12">
					<ol class="breadcrumb">
						<li><i class="fa fa-truck fa-fw"></i>库存处理</li>
						<li class="active"><i class="fa fa-user-md fa-fw"></i>台账处理</li>
					</ol>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="query">
						<div class="row">
							<div class="form-group">
								<label>商家编号:</label> <input type="text" class="form-control" name="supplierId">
							</div>
							<div class="form-group">
								<label>货号:</label> <input type="text" class="form-control" name="sku">
							</div>
						</div>
						<div class="row">
							<div class="form-group">
								<label>商品编号:</label> 
								<input type="text" class="form-control" name="itemId">
							</div>
							<div class="form-group">
								<label>商品编码:</label> 
								<input type="text" class="form-control" name="itemCode">
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
								<i class="fa fa-bar-chart-o fa-fw"></i>台账列表
							</h3>
						</div>
						<div class="panel-body">
							<table id="billTable" class="table table-hover table-bordered">
								<thead>
									<tr>
										<th>商家编号</th>
										<th>商家名称</th>
										<th>货号</th>
										<th>商品名称</th>
										<th>类型</th>
										<th>台账数量</th>
										<th>操作</th>
										<th>入仓类型</th>
										<th>入仓数量</th>
										<th>报检号</th>
										<th>有效期</th>
										<th>库位</th>
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
	<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-hidden="true">
	   <div class="modal-dialog">
	      <div class="modal-content">
	         <div class="modal-header">
	            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="closeAddModal()">&times;</button>
	         	<h4 class="modal-title" id="modelTitle">台账处理</h4>
	         </div>
	         <div class="modal-body">
	         	<iframe id="editIFrame" frameborder="0"></iframe>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeAddModal()">取消 </button>
	            <button type="button" class="btn btn-info" id="saveAsnBtn">新增 </button>
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
			url :  "${wmsUrl}/admin/stock/bill/dataList.shtml",
			numPerPage:"20",
			currentPage:"",
			index:"1",
			callback:rebuildTable
}

$(function(){
	 $(".pagination-nav").pagination(options);
})

/**
  * 在页面中任何嵌套层次的窗口中获取顶层窗口
  * @return 当前页面的顶层窗口对象
  */
 function getTopWindow(){
     var p = window;
    while(p != p.parent){
        p = p.parent;
     }
     return p;
 }

function reloadTable(){
	$.page.loadData(options);
}

function closeEditModal(){
	$("#editModal").modal("hide");
}

/**
 * 重构table
 */
function rebuildTable(data){
	$("#billTable tbody").html("");

	if (data == null || data.length == 0) {
		return;
	}
	
	var list = data.obj;
	
	if (list == null || list.length == 0) {
		$.zzComfirm.alertError("没有查到数据");
		return;
	}

	var trHtml = "";
	var declStatusStr = "";
	var customStatusStr = "";
	for (var i = 0; i < list.length; i++) {
		
		var records = list[i].records;
		var sumNum;
		if(records==null||records.length==0){
			trHtml += rowSpanTd(list[i],1);
			if(records[j].optType==14){
				trHtml +="<td><label>搬仓录入</label></td>";
			}else{
				trHtml +="<td><label>其他</label></td>";
			}
			trHtml +="<td></td><td></td><td></td><td></td>";
		}else{
			sumNum = 0;
			trHtml += rowSpanTd(list[i],records.length);
			
			for (var j = 0; j < records.length; j++){
				
				if(j>0){
					trHtml +="<tr>"
				}
				
				if(records[j].optType==14){
					trHtml +="<td><label>搬仓录入</label></td>";
				}else{
					trHtml +="<td><label>其他</label></td>";
				}
				trHtml +="<td><label>"+records[j].goodsQty+"</label></td>";
				trHtml +="<td><label>"+records[j].declNo+"</label></td>";
				trHtml +="<td><label>"+records[j].deadLine+"</label></td>";
				trHtml +="<td><label>"+records[j].libId+"</label></td></tr>";
			}
		}
	}
	
	$("#billTable tbody").htmlUpdate(trHtml);
}

function rowSpanTd(bill,rowspan){
	var _html = "";
	var _td = "";
	var statusStr = "";
	
	if(rowspan <= 1){
		_td = "<td>";
	}else{
		_td="<td rowspan='"+rowspan+"' style='vertical-align: middle'>";
	}
	
	_html += "<tr>"+_td + (bill.supplierId==null?"无":bill.supplierId)+"</td>";
	_html += _td + (bill.supplierName==null?"无":bill.supplierName)+"</td>";
	_html += _td + bill.sku+ "</td>";
	_html += _td + bill.goodsName+ "</td>";
	switch(bill.inventoryType){
		case "1": _html += _td +"可销售库存</td>";break;
		case "101":	_html += _td +"残次</td>";break;
		case "102":	_html += _td +"机损</td>";break;
		case "103":	_html += _td +"箱损</td>";break;
		case "201":	_html += _td +"冻结库存</td>";break;
		default: _html += _td +"无</td>";
	}
	
	_html += _td + (bill.quantity==null?"无":bill.quantity)+"</td>";
	
	var records = bill.records;
	var sumNum = 0;
	for (var j = 0; j < records.length; j++){
		sumNum += records[j].goodsQty;
	}
	
	if(sumNum != bill.quantity && "${privilege>=2}"=="true"){
		_html += _td+"<button type='button' class='btn btn-info' onclick='showEditModal("+bill.id+")'>差异<label color='red'>("+(sumNum - bill.quantity)+")</button></td>";
	}else{
		_html += _td+"<label>无需处理<label></td>";
	}
	
	return _html;
}


function showEditModal(id){
       var frameSrc = "${wmsUrl}/admin/stock/bill/dealPage.shtml?id="+id;
       $("#editIFrame").attr("src", frameSrc);
       $('#editModal').modal({ show: true, backdrop: 'static' });
}

</script>
</body>
</html>
