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
<title>盘点详情</title>
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
							<td><label>${check.supplierId}</label>	 
							<td><label>商家名称:</label></td>
							<td><label>${check.supplierName}</label></td>
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
							<td><label>盘点编号:</label></td><td><label style="color:red">${check.id}</label></td>
							<td><label>盘点单据:</label></td><td><label>${check.orderno}</label></td>
						</tr>
						<tr>
							<td><label>状态:</label></td>
							<td>
								<c:if test="${check.status==1}"><label style="color:red">待盘点</label></c:if>
								<c:if test="${check.status==2}"><label style="color:red">已盘点</label></c:if>
								<c:if test="${check.status==3}"><label style="color:red">取消</label></c:if>
								<c:if test="${check.status==4}"><label style="color:red">盘点失败</label></c:if>
							</td> 
							<td><label>盘点类型:</label></td>
							<td>
								<c:if test="${check.orderType==1}"><label>错发</label></c:if>
								<c:if test="${check.orderType==2}"><label>漏发</label></c:if>
								<c:if test="${check.orderType==3}"><label>进货</label></c:if>
								<c:if test="${check.orderType==4}"><label>盘点</label></c:if>
								<c:if test="${check.orderType==5}"><label>其他</label></c:if>
							</td>
						</tr>
						<tr>
							<td><label>创建时间:</label></td>
							<td><label>${check.createTime}</label></td>	 
							<td><label>更新时间:</label></td>
							<td><label>${check.updateTime}</label></td>
						</tr>
						<tr>
							<td><label>最后操作人:</label></td>
							<td><label>${check.opt}</label></td>	 
							<td><label>备注:</label></td>
							<td><label>${check.remark}</label></td>	 
						</tr>
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
										<c:if test="${item.asnState=='1'}"><label style="color:red">待盘点</label></c:if>
										<c:if test="${item.asnState=='2'}"><label style="color:red">已盘点</label></c:if>
										<c:if test="${item.asnState=='3'}"><label style="color:red">取消</label></c:if>
										<c:if test="${item.asnState=='4'}"><label style="color:red">盘点失败</label></c:if>
									</td>
									<td><label>${item.opt}</label></td>
									<td><label>${item.stateName}</label></td>
									<td><label>${item.ctime}</label></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<table id="checkTable" class="table table-hover">
						<thead>
							<tr>
								<th>类型</th>
								<th>数量</th>
								<th>店铺编码</th>
								<th>店铺名称</th>
								<th>商品编号</th>
								<th>商品编码</th>
								<th>商品货号</th>
								<th>商品名称</th>
								<th>备注</th>
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
		url :  "${wmsUrl}/admin/stock/cnCheck/queryItemByCheckId.shtml?checkId=${check.id}",
		numPerPage:"1000",
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
	$("#checkTable tbody").html("");

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
		
		var type = list[i].type;

		switch(type){
			case '1':str +="<td>盘盈";break;
			case '2':str +="<td>盘亏";break;
			case '3':str +="<td>盘次品";break;
		}
		
		str += "</td><td>" + list[i].quantity;
		str += "</td><td>" + (list[i].ownerUserId==null?"无":list[i].ownerUserId);
		str += "</td><td>" + (list[i].shopName==null?"无":list[i].shopName);
		str += "</td><td>" + (list[i].itemId==null?"无":list[i].itemId);
		str += "</td><td>" + (list[i].itemCode==null?"无":list[i].itemCode);
		str += "</td><td>" + (list[i].sku==null?"无":list[i].sku);
		str += "</td><td>" + (list[i].skuName==null?"无":list[i].skuName);
		str += "</td><td>" + (list[i].remark==null?"无":list[i].remark);
		str += "</td></tr>";
	}
	
	
	$("#checkTable tbody").htmlUpdate(str);
}

</script>
</body>
</html>
