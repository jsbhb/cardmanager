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
<title>预进货详情</title>
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
								<c:if test="${asnStock.status==99}"><label style="color:red">粗点</label></c:if>
								<c:if test="${asnStock.status==4}"><label style="color:red">精点</label></c:if>
								<c:if test="${asnStock.status==5}"><label style="color:red">报备失败</label></c:if>
								<c:if test="${asnStock.status==6}"><label style="color:red">报备成功</label></c:if>
								<c:if test="${asnStock.status==7}"><label style="color:red">上架</label></c:if>
								<c:if test="${asnStock.status==11}"><label style="color:red">精点差异</label></c:if>
								<c:if test="${asnStock.status==21}"><label style="color:red">采购单差异</label></c:if>
								<c:if test="${asnStock.status==31}"><label style="color:red">申报成功</label></c:if>
								<c:if test="${asnStock.status==32}"><label style="color:red">申报失败</label></c:if>
								<c:if test="${asnStock.status==41}"><label style="color:red">改单</label></c:if>
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
							<td><label>载货清单:</label></td>
							<td><label>${asnStock.transportGoodsNo}</label></td>	 
							<td><label>计划信息:</label></td>
							<td><label>${asnStock.planInfo}</label></td>	 
						</tr>
						<tr>
							<td><label>申报单号:</label></td>
							<td><label>${asnStock.externalNo}</label></td>
							<td><label>备注:</label></td>
							<td><label>${asnStock.remark}</label></td>
						</tr>
						<c:forEach items="${binds}" var = "item">
							<tr>
								<td colspan="1"><label>同步入库单</label></td>
								<td colspan="1"><label>${item.orderCode}</label></td>
								<td colspan="1"><label>${item.opt}</label></td>
								<td colspan="2"><label>${item.createTime}</label></td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<table class="table table-hover">
						<thead>
							<tr>
								<th>编号</th>
								<th>进货状态</th>
								<th>操作人</th>
								<th>操作名称</th>
								<th>操作时间</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${records}" var = "item">
								<tr>
									<td><label>${item.id}</label></td>
									<td>
										<c:if test="${item.asnState=='0'}"><label style="color:red">初始化</label></c:if>
										<c:if test="${item.asnState=='1'}"><label style="color:red">预进货</label></c:if>
										<c:if test="${item.asnState=='2'}"><label style="color:red">到港</label></c:if>
										<c:if test="${item.asnState=='99'}"><label style="color:red">粗点</label></c:if>
										<c:if test="${item.asnState=='4'}"><label style="color:red">精点</label></c:if>
										<c:if test="${item.asnState=='5'}"><label style="color:red">报备失败</label></c:if>
										<c:if test="${item.asnState=='6'}"><label style="color:red">报备成功</label></c:if>
										<c:if test="${item.asnState=='7'}"><label style="color:red">上架</label></c:if>
										<c:if test="${item.asnState=='11'}"><label style="color:red">精点差异</label></c:if>
										<c:if test="${item.asnState=='21'}"><label style="color:red">采购单差异</label></c:if>
										<c:if test="${item.asnState=='41'}"><label style="color:red">改单</label></c:if>
									</td>
									<td><label>${item.opt}</label></td>
									<td><label>${item.stateName}</label></td>
									<td><label>${item.ctime}</label></td>
									<td><label>${item.remark}</label></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<table id="asnTable" class="table table-hover">
						<thead>
							<tr>
								<th>编号</th>
								<th>货号</th>
								<th>商品编号</th>
								<th>商品编码</th>
								<th>商品名称</th>
								<th>单位</th>
								<th>数量</th>
								<th>净重</th>
								<th>hs编号</th>
								<th>备注</th>
								<th>创建时间</th>
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
		url :  "${wmsUrl}/admin/stockIn/asnMng/queryItemById.shtml?asnStockId=${asnStock.asnStockId}",
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

	var str = "";
	for (var i = 0; i < list.length; i++) {
		str += "<tr><td>"+list[i].id ;
		str += "</td><td>" + (list[i].sku==null?"无":list[i].sku);
		str += "</td><td>" + (list[i].itemId==null?"无":list[i].itemId);
		str += "</td><td>" + (list[i].itemCode==null?"无":list[i].itemCode);
		str += "</td><td>" + (list[i].goodsName==null?"无":list[i].goodsName);
		str += "</td><td>" + (list[i].unit==null?"无":list[i].unit);
		str += "</td><td>" + (list[i].quantity==null?"无":list[i].quantity);
		str += "</td><td>" + (list[i].currencyValue==null?"无":list[i].currencyValue);
		str += "</td><td>" + (list[i].currency==null?"无":list[i].currency);
		str += "</td><td>" + (list[i].remark==null?"无":list[i].remark);
		str += "</td><td>" + (list[i].createTime==null?"无":list[i].createTime);
		str += "</td></tr>";
	}
	
	
	$("#asnTable tbody").htmlUpdate(str);
}

</script>
</body>
</html>
