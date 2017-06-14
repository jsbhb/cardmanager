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
<title>理货查看</title>
<%@include file="../../resource.jsp" %>
</head>

<body>
	<div id="page-wrapper">
		<div class="container-fluid">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">
						<i class="fa fa-bar-chart-o fa-fw"></i>商家信息
					</h3>
				</div>
				<div class="panel-body">
					<table class="table table-bordered">
						<tr>
							<td><label>商家编码:</label></td>
							<td><label>${asnStock.supplierId}</label>	 
							<td><label>商家名称:</label></td>
							<td><label>${asnStock.supplierName}</label></td>
						</tr>
					</table>
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">
						<i class="fa fa-bar-chart-o fa-fw"></i>进货信息
					</h3>
				</div>
				<div class="panel-body">
					<table class="table table-bordered">
						<tr>
							<td><label>进货号:</label></td><td><label style="color:red">${asnStock.asnStockId}</label></td>
							<td><label>报检号:</label></td><td><label>${asnStock.declNo}</label></td>
						</tr>
						<tr>
							<td><label>状态:</label></td>
							<td>
								<c:if test="${asnStock.status==0}"><label style="color:red">初始化</label></c:if>
								<c:if test="${asnStock.status==1}"><label style="color:red">预进货</label></c:if>
								<c:if test="${asnStock.status==2}"><label style="color:red">到港</label></c:if>
								<c:if test="${asnStock.status==4}"><label style="color:red">精点</label></c:if>
								<c:if test="${asnStock.status==5}"><label style="color:red">报备失败</label></c:if>
								<c:if test="${asnStock.status==6}"><label style="color:red">报备成功</label></c:if>
								<c:if test="${asnStock.status==7}"><label style="color:red">上架</label></c:if>
								<c:if test="${asnStock.status==11}"><label style="color:red">精点差异</label></c:if>
								<c:if test="${asnStock.status==21}"><label style="color:red">采购单差异</label></c:if>
								<c:if test="${asnStock.status==41}"><label style="color:red">改单</label></c:if>
								<c:if test="${asnStock.status==99}"><label style="color:red">已粗点</label></c:if>
							</td> 
							<td><label>是否转关:</label></td>
							<td>
								<c:if test="${asnStock.type==0}"><label>本地</label></c:if>
								<c:if test="${asnStock.type==1}"><label>转关</label></c:if>
							</td>
						</tr>
						<tr>
							<td><label>进仓时间:</label></td>
							<td><label>${asnStock.actualFeedTime}</label></td>	 
							<td><label>到港时间:</label></td>
							<td><label>${asnStock.actualArrivalTime}</label></td>
						</tr>
						<tr>
							<td><label>计划信息:</label></td>
							<td colspan="3"><label>${asnStock.planInfo}</label></td>	 
						</tr>
						<tr>
							<td><label>备注:</label></td>
							<td colspan="3"><label>${asnStock.remark}</label></td>
						</tr>
					</table>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<c:if test="${asnStock.status==4}">
						<button type="button" class="btn btn-info" onclick="receipt()">打印入库凭证</button>
					</c:if>
					<table id="asnTable" class="table table-hover table-bordered">
						<thead>
							<tr>
								<th>货号</th>
								<th>商品名称</th>
								<th>单位</th>
								<th>状态</th>
								<th>合同数量</th>
								<th>良品总数</th>
								<th>次品总数</th>
								<th>粗点总数</th>
								<th>虚拟1</th>
								<th>虚拟2</th>
								<th>处理</th>
								<th>良品数量</th>
								<th>次品数量</th>
								<th>生产日期</th>
								<th>过期日期</th>
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
<script type="text/javascript">
var options = {
		queryForm : ".query",
		url :  "${wmsUrl}/admin/stockIn/tally/asnTallyList.shtml?asnStockId=${asnStock.asnStockId}",
		numPerPage:"100",
		currentPage:"",
		index:"1",
		callback:rebuildTable
}

$(function(){
	 $(".pagination-nav").pagination(options);
})

/**
* 重构table
*/
function rebuildTable(data){
	$("#asnTable tbody").html("");

	if (data == null || data.length == 0) {
		return;
	}
	
	var list = data.obj;
	
	if (list == null || list.length == 0) {
		$.zzComfirm.alertError("没有查到数据");
		return;
	}

	var trHtml = "";
	var item;
	var rowsplan;
	var qpSum =0;
	var defSum = 0
	for (var i = 0; i < list.length; i++) {
		item = list[i].items;
		
		if(item==null||item.length==0){
			trHtml += rowSpanTd(list[i],1);
			trHtml +="<td></td><td></td><td></td><td></td><td></td><td></td>";
		}else{
			trHtml += rowSpanTd(list[i],item.length);
			for (var j = 0; j < item.length; j++){
				trHtml +="<td><label>"+item[j].goodsqpQty+"</label></td>";
				trHtml +="<td><label>"+item[j].goodsdefQty+"</label></td>";
				trHtml +="<td><label>"+item[j].productionTime+"</label></td>";
				trHtml +="<td><label>"+item[j].deadLine+"</label></td></tr>";
			}
		}
	}
	
	$("#asnTable tbody").html(trHtml);
}

function receipt(){
	var left1 = (screen.width-600)/2;
	var top1 = (screen.height-450)/2;
	window.open('${wmsUrl}/admin/stockIn/tally/receiptPrint.shtml?asnStockId=${asnStock.asnStockId}',"","width=1400,height=700,resizable=yes,location=no,scrollbars=yes,left=" + left1.toString() + ",top=" + top1.toString());
}

/*--------暂时不用人工报备功能！-------*/
function back(){
	$.ajax({
		 url:"${wmsUrl}/admin/stockIn/tally/back.shtml?asnStockId=${asnStock.asnStockId}",
		 type:'post',
		 data:{},
		 dataType:'json',
		 success:function(data){
			 if(data.success){	
				 $.zzComfirm.alertSuccess("处理通过！");
				 window.location.reload();
			 }else{
				 $.zzComfirm.alertError(data.msg);
			 }
		 },
		 error:function(){
			 $.zzComfirm.alertError("系统出现问题啦，快叫技术人员处理");
		 }
	 });
}

function rowSpanTd(goods,rowspan){
	var _html = "";
	var _td = "";
	var statusStr = "";
	
	if(rowspan <= 1){
		_td = "<td>";
	}else{
		_td="<td rowspan='"+rowspan+"' style='vertical-align: middle'>";
	}
	
	_html +="<tr>"+_td+"<label>"+goods.sku+"</label></td>";
	_html +=_td+"<label>"+goods.goodsName+"</label></td>";
	_html +=_td+"<label>"+goods.unit+"</label></td>";
	
	switch(goods.status){
		case 0: statusStr = "<lable style='color:red'>未粗点</label>";break;
		case 1: statusStr = "<lable style='color:red'>已粗点</label>";break;
		case 2: statusStr = "<lable style='color:red'>已精点</label>";break;
		case 3: statusStr = "<lable style='color:red'>报备成功</label>";break;
		case 4: statusStr = "<lable style='color:red'>报备失败</label>";break;
		case 5: statusStr = "<lable style='color:red'>已上架</label>";break;
		case 11: statusStr = "<lable style='color:red'>精点差异</label>";break;
		case 21: statusStr = "<lable style='color:red'>采购单差异</label>";break;
	}
	
	_html +=_td+statusStr+"</td>";
	_html +=_td+"<label>"+goods.quantity+"</label></td>";
	_html +=_td+"<label>"+goods.jdqpqty+"</label></td>";
	_html +=_td+"<label>"+goods.jddefqty+"</label></td>";
	_html +=_td+"<label>"+goods.roughqty+"</label></td>";
	_html +=_td+"<label>"+goods.kbqty+"</label></td>";
	_html +=_td+"<label>"+goods.virtualqty+"</label></td>";
	
	
	if(goods.status == '11'){
		var vNum
		if('${asnStock.type == 1}' == 'true'){
			vNum = goods.jdqpqty+goods.jddefqty-goods.roughqty;
		}else{
			vNum = goods.jdqpqty+goods.jddefqty-goods.quantity;
		}
		
		if("${privilege>=2}"=="true"){
			_html +=_td+"<label><button type='button' class='btn btn-info' onclick='checkDeal("+goods.id+","+vNum+")'>虚拟</button></label></td>";
		}else{
			_html +=_td+"</td>";
		}
	}else{
		_html +=_td+"</td>";
	}
	
	
	return _html;
}

function checkDeal(asnGoodsId,vNum){
	$.ajax({
		 url:"${wmsUrl}/admin/stockIn/tally/checkDeal.shtml?asnGoodsId="+asnGoodsId+"&vNum="+vNum,
		 type:'post',
		 data:{},
		 dataType:'json',
		 success:function(data){
			 if(data.success){	
				 $.zzComfirm.alertSuccess("处理通过！");
				 window.location.reload();
			 }else{
				 $.zzComfirm.alertError(data.msg);
			 }
		 },
		 error:function(){
			 $.zzComfirm.alertError("系统出现问题啦，快叫技术人员处理");
		 }
	 });
}


</script>
</body>
</html>
