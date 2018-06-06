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
<%@include file="../../resourceLink.jsp"%>
</head>
<body>
<section class="content-wrapper query content-iframe">
	<section class="content-header">
	      <ol class="breadcrumb">
	        <li><a href="javascript:void(0);">财务管理</a></li>
	        <c:choose>
		        <c:when test="${customerType == 0}">
	        		<li class="active">供应商资金池维护</li>
				</c:when>
				<c:otherwise>
	        		<li class="active">区域中心资金池维护</li>
				</c:otherwise>
	        </c:choose>
	      </ol>
	      <div class="search">
	      	<input type="text" name="customerName" id="customerName" placeholder="输入客户名称" >
	      	<div class="searchBtn"><i class="fa fa-search fa-fw"></i></div>
	      	<div class="moreSearchBtn">高级搜索</div>
		  </div>
    </section>
	<section class="content">
		<div id="image" style="width:100%;height:100%;display: none;background:rgba(0,0,0,0.5);margin-left:-25px;margin-top:-62px;">
			<img alt="loading..." src="${wmsUrl}/img/loader.gif" style="position:fixed;top:50%;left:50%;margin-left:-16px;margin-top:-16px;" />
		</div>
		<div class="moreSearchContent">
			<div class="row form-horizontal list-content">
				<c:if test="${supplierId!=null}">
					<div class="col-xs-3">
						<div class="searchItem">
				            <select class="form-control" name="supplierId" id="supplierId">
		                   	  <option selected="selected" value="">供应商</option>
		                   	  <c:forEach var="supplier" items="${supplierId}">
		                   	  	<option value="${supplier.id}">${supplier.supplierName}</option>
		                   	  </c:forEach>
			                </select>
						</div>
					</div>
					<div class="col-xs-3">
						<div class="searchItem">
							<input type="text" class="form-control" name="customerCode" placeholder="请输入客户代码">
						</div>
					</div>
				</c:if>
				<c:if test="${centerId!=null}">
					<div class="col-xs-3">
						<div class="searchItem">
				            <select class="form-control" name="centerId" id="centerId">
		                   	  <option selected="selected" value="">区域中心</option>
		                   	  <c:forEach var="center" items="${centerId}">
		                   	  	<option value="${center.gradeId}">${center.gradeName}</option>
		                   	  </c:forEach>
			                </select>
						</div>
					</div>
				</c:if>
				<div class="col-xs-3">
					<div class="searchItem">
			            <select class="form-control" name="customerStatus" id="customerStatus">
	                   	  <option selected="selected" value="">客户状态</option>
	                   	  <option value="1">正常</option>
	                   	  <option value="2">预警</option>
		                </select>
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchBtns">
						 <div class="lessSearchBtn">简易搜索</div>
                         <button type="button" class="query" id="querybtns" name="signup">提交</button>
                         <button type="button" class="clear" id="clearbtns">清除选项</button>
                    </div>
                </div>
            </div>
		</div>
		<div class="default-content">
			<div class="today-orders">
				<c:choose>
			        <c:when test="${customerType == 0}">
						<div class="today-orders-item">
							<a href="javascript:void(0);" id="total" onclick="totalCustomer()">${totalInfo.total}</a>
							<p>供应商</p>
						</div>
					</c:when>
					<c:otherwise>
						<div class="today-orders-item">
							<a href="javascript:void(0);" id="total" onclick="totalCustomer()">${totalInfo.total}</a>
							<p>区域中心</p>
						</div>
					</c:otherwise>
		        </c:choose>
		        <div class="today-orders-item">
					<a href="javascript:void(0);" id="money">${totalInfo.money}</a>
					<p>总可用金额</p>
				</div>
				<div class="today-orders-item">
					<a href="javascript:void(0);" id="warning" onclick="warningCustomer()">${totalInfo.warning}</a>
					<p>预警</p>（可用金额低于3000）
				</div>
			</div>
		</div>
		<div class="list-content">
			<div class="row">
				<div class="col-md-10 list-btns">
					<button type="button" onclick="toAdd(${customerType})">添加资金池记录</button>
					<button type="button" onclick="excelExport(${customerType})">导出资金池记录</button>
				</div>
			</div>
			<div class="row content-container">
				<div class="col-md-12 container-right active">
					<table id="orderTable" class="table table-hover myClass">
						<thead>
							<tr>
								<th>客户名称</th>
								<th>客户类型</th>
								<c:if test="${customerType == 0}">
									<th>客户代码</th>
								</c:if>
								<c:if test="${customerType == 1}">
									<th>客户公司</th>
								</c:if>
								<th>可用金额</th>
								<th>已用金额</th>
								<th>累计金额</th>
								<th>状态</th>
								<th>操作</th>
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
	</section>
</section>
	
<%@include file="../../resourceScript.jsp"%>
<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
<script src="${wmsUrl}/js/mainpage.js"></script>
<script type="text/javascript">
//点击搜索按钮
$('.searchBtn').on('click',function(){
	$("#querybtns").click();
});

/**
 * 初始化分页信息
 */
var options = {
	queryForm : ".query",
	url :  "${wmsUrl}/admin/finance/capitalPoolMng/dataListByType.shtml?customerType=${customerType}",
	numPerPage:"10",
	currentPage:"",
	index:"1",
	callback:rebuildTable
}


$(function(){
	 $(".pagination-nav").pagination(options);
})


function reloadTable(){
	$.page.loadData(options);
}


/**
 * 重构table
 */
function rebuildTable(data){
	$("#orderTable tbody").html("");

	if (data == null || data.length == 0) {
		return;
	}
	
	var list = data.obj;
	var str = "";
	
	if (list == null || list.length == 0) {
		str = "<tr style='text-align:center'><td colspan=8><h5>没有查到数据</h5></td></tr>";
		$("#orderTable tbody").html(str);
		return;
	}

	for (var i = 0; i < list.length; i++) {
		var tmpStatus = "";
		if (list[i].money < 3000) {
			str += "<tr style='color: #FF0000'>";
			tmpStatus = "预警";
		} else {
			str += "<tr>";
			tmpStatus = "正常";
		}
		str += "<td>" + (list[i].customerName == "" ? "" : list[i].customerName);
		var customerType = list[i].customerType;
		switch(customerType){
			case 0:str += "</td><td>供应商";break;
			case 1:str += "</td><td>区域中心";break;
			default:str += "</td><td>其他";
		}
		str += "</td><td>" + (list[i].customerCode == null ? "" : list[i].customerCode);
		str += "</td><td>" + list[i].money;
		str += "</td><td>" + list[i].useMoney;
		str += "</td><td>" + list[i].countMoney;
		str += "</td><td>" + tmpStatus;
		str += "</td><td>";
		str += "<a href='javascript:void(0);' class='table-btns' onclick='toShow("+list[i].customerId+")'>查看详情</a>";
		str += "</td></tr>";
	}
	$("#orderTable tbody").html(str);
}

function toShow(customerId){
	var index = layer.open({
	  title:"查看详情",
	  type: 2,
	  content: '${wmsUrl}/admin/finance/capitalPoolMng/showCapitalManagementDetail.shtml?customerId='+customerId
	});
	layer.full(index);
}

function toAdd(customerType){
	var url = "";
	if (customerType == 0) {
		url = "${wmsUrl}/admin/finance/capitalPoolMng/toSupplierAdd.shtml";
	} else {
		url = "${wmsUrl}/admin/finance/capitalPoolMng/toCenterAdd.shtml";
	}
	var index = layer.open({
	  title:"添加资金池记录",		
	  type: 2,
	  content: url,
	  maxmin: true
	});
	layer.full(index);
}

function excelExport(customerType){
	window.open("${wmsUrl}/admin/finance/capitalPoolMng/downLoadCapitalPoolRecordExcel.shtml?customerType="+customerType);
}

function warningCustomer(){
	$("#clearbtns").click();
	$("#customerName").val("");
	$("#customerStatus").val(2);
	$("#querybtns").click();
}

function totalCustomer(){
	$("#clearbtns").click();
	$("#customerName").val("");
	$("#querybtns").click();
}
</script>
</body>
</html>
