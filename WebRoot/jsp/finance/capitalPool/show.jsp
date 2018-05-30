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
	
	<section class="content-iframe content">
		<div id="image" style="width:100%;height:100%;display: none;background:rgba(0,0,0,0.5);margin-left:-25px;margin-top:-62px;">
			<img alt="loading..." src="${wmsUrl}/img/loader.gif" style="position:fixed;top:50%;left:50%;margin-left:-16px;margin-top:-16px;" />
		</div>
		<div class="moreSearchContent" style="display: block;">
			<div class="row form-horizontal list-content">
				<div class="col-xs-3">
					<div class="searchItem">
					   	<select class="form-control" name="payType" id="payType">
						  	<option selected="selected" value="">支付类型</option>
						  	<option value="0">充值</option>
						  	<option value="1">消费</option>
					    </select>
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
						<input type="text" class="form-control" name="payNo" placeholder="支付流水号">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchBtns">
                         <button type="button" class="query" id="querybtns" name="signup">提交</button>
                         <button type="button" class="clear">清除选项</button>
                    </div>
                </div>
            </div>
		</div>
		<div class="default-content">
			<div class="today-orders">
				<div class="today-orders-item">
					<a href="javascript:void(0);" id="canBePresented">￥${CapitalManagement.money}</a>
					<p>可用金额</p>
				</div>
				<div class="today-orders-item">
					<a href="javascript:void(0);" id="alreadyPresented">￥${CapitalManagement.useMoney}</a>
					<p>已用金额</p>
				</div>
				<div class="today-orders-item">
					<a href="javascript:void(0);" id="stayToAccount">￥${CapitalManagement.countMoney}</a>
					<p>累计金额</p>
				</div>
			</div>
		</div>
		<div class="list-content">
			
			<input type="hidden" class="form-control" id="customerId" name="customerId" value="${CapitalManagement.customerId}">
			<input type="hidden" class="form-control" id="customerName" name="customerName" value="${CapitalManagement.customerName}">
			
			<div class="row content-container">
				<div class="col-md-12 container-right active">
					<table id="orderTable" class="table table-hover myClass">
						<thead>
							<tr>
								<th>客户名称</th>
								<th>支付类型</th>
								<th>金额</th>
								<th>支付流水号</th>
								<th>业务流水号</th>
								<th>备注</th>
								<th>创建时间</th>
								<th>操作人</th>
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
	url :  "${wmsUrl}/admin/finance/capitalPoolMng/dataListByCustomerId.shtml",
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
		var payType = list[i].payType;
		if (payType == 0) {
			str += "<tr style='color: #0000FF'>";
		} else {
			str += "<tr style='color: #FF0000'>";
		}
		str += "<td>" + "${CapitalManagement.customerName}";
		switch(payType){
			case 0:str += "</td><td>充值";break;
			case 1:str += "</td><td>消费";break;
			default:str += "</td><td>其他";
		}
		str += "</td><td>" + list[i].money;
		str += "</td><td>" + list[i].payNo;
		str += "</td><td>" + list[i].businessNo;
		str += "</td><td>" + list[i].remark;
		str += "</td><td>" + list[i].createTime;
		str += "</td><td>" + list[i].opt;
		str += "</td></tr>";
	}
	$("#orderTable tbody").html(str);
}
</script>
</body>
</html>
