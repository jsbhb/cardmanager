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
<section class="content-wrapper query">
	<section class="content-header">
	      <ol class="breadcrumb">
	        <li>财务管理</li>
	        <li class="active">订单退款</li>
	      </ol>
	      <div class="search">
	      	<input type="text" name="orderId" placeholder="请输入订单编号">
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
			            <select class="form-control" name="status" id="status">
	                   	  <option value="8">退单</option>
	                   	  <option selected="selected" value="21">退款中</option>
		                </select>
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
			            <select class="form-control" name="orderFlag" id="orderFlag">
	                   	  <option selected="selected" value="">订单类型</option>
	                   	  <option value="0">跨境</option>
	                   	  <option value="2">一般贸易</option>
		                </select>
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
			            <select class="form-control" name="orderSource" id="orderSource">
	                   	  <option selected="selected" value="">订单来源</option>
	                   	  <option value="0">PC商城</option>
	                   	  <option value="1">手机商城</option>
	                   	  <option value="3">有赞</option>
	                   	  <option value="4">线下</option>
	                   	  <option value="5">展厅</option>
	                   	  <option value="6">大客户</option>
	                   	  <option value="7">福利商城</option>
		                </select>
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
			            <input type="text"  name="gradeName" id="gradeName" readonly style="background:#fff;" placeholder="选择分级" >
						<input type="hidden" class="form-control" name="gradeId" id="gradeId" >
					</div>
				</div>
			    <div class="select-content">
	           		<ul class="first-ul" style="margin-left:10px;">
	           			<c:forEach var="menu" items="${list}">
	           				<c:set var="menu" value="${menu}" scope="request" />
	           				<%@include file="recursive.jsp"%>  
						</c:forEach>
	           		</ul>
	           	</div>
				<div class="col-xs-3">
					<div class="searchItem">
						<input type="text" class="form-control" name="orderId" placeholder="请输入订单号">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
						<input type="text" class="form-control" name="itemId" placeholder="请输入商品编号">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
						<input type="text" class="form-control" name="itemCode" placeholder="请输入商家编码">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchBtns">
						 <div class="lessSearchBtn">简易搜索</div>
                         <button type="button" class="query" id="querybtns" name="signup">提交</button>
                         <button type="button" class="clear">清除选项</button>
                    </div>
                </div>
            </div>
		</div>	
		<div class="list-content">
			<div class="row content-container">
				<div class="col-md-12 container-right active">
					<table id="orderTable" class="table table-hover myClass">
						<thead>
							<tr>
								<th>订单编号</th>
								<th>状态</th>
								<th>快递公司</th>
								<th>物流单号</th>
								<th>供应商</th>
								<th>支付总金额</th>
								<th>消费者</th>
								<th>订单来源</th>
								<th>所属分级</th>
								<th>交易时间</th>
								<th width="12%">操作</th>
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
	url :  "${wmsUrl}/admin/order/stockOutMng/dataList.shtml",
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
		str = "<tr style='text-align:center'><td colspan=11><h5>没有查到数据</h5></td></tr>";
		$("#orderTable tbody").html(str);
		return;
	}

	for (var i = 0; i < list.length; i++) {
		str += "<tr>";
		
		var status = list[i].status;
		str += "<td>" + list[i].orderId;
		switch(status){
			case 0:str += "</td><td>待处理";break;
			case 1:str += "</td><td>已付款";break;
			case 2:str += "</td><td>支付单报关";break;
			case 3:str += "</td><td>已发仓库";break;
			case 4:str += "</td><td>已报海关";break;
			case 5:str += "</td><td>单证放行";break;
			case 6:str += "</td><td>已发货";break;
			case 7:str += "</td><td>已收货";break;
			case 8:str += "</td><td>退单";break;
			case 9:str += "</td><td>超时取消";break;
			case 11:str += "</td><td>资金池不足";break;
			case 12:str += "</td><td>待发货";break;
			case 21:str += "</td><td>退款中";break;
			case 99:str += "</td><td>异常状态";break;
			default:str += "</td><td>未知状态";
		}
		
		var express = list[i].orderExpressList;
		var expressName = "";
		var expressId ="";
		if(express !=null){
			for(var j=0;j<express.length;j++){
				expressName += (express[j].expressName == null ? "" : express[j].expressName);
				expressId += (express[j].expressId == null ? "" : express[j].expressId);
			}
		}
		str += "</td><td>" + expressName;
		str += "</td><td>" + expressId;
		str += "</td><td>" + (list[i].supplierName == null ? "" : list[i].supplierName);
		str += "</td><td>" + list[i].orderDetail.payment;
		str += "</td><td>" + list[i].customerName;
		var tmpCenterId = list[i].centerId;
		var tmpCenterName = "";
		if (tmpCenterId == -1) {
			tmpCenterName = "订货平台";
		}
// 		var centerSelect = document.getElementById("centerId");
// 		var options = centerSelect.options;
// 		for(var j=0;j<options.length;j++){
// 			if (tmpCenterId==options[j].value) {
// 				tmpCenterName = options[j].text;
// 				break;
// 			}
// 		}
// 		str += "</td><td>" + (tmpCenterName == "" ? "" : tmpCenterName);
		str += "</td><td>" + (list[i].centerName == "" ? "" : list[i].centerName);
// 		var tmpShopId = list[i].shopId;
// 		var tmpShopName = "";
// 		var shopSelect = document.getElementById("shopId");
// 		var soptions = shopSelect.options;
// 		for(var j=0;j<soptions.length;j++){
// 			if (tmpShopId==soptions[j].value) {
// 				tmpShopName = soptions[j].text;
// 				break;
// 			}
// 		}
// 		str += "</td><td>" + (tmpShopName == "" ? "" : tmpShopName);
		str += "</td><td>" + (list[i].shopName == "" ? "" : list[i].shopName);
		str += "</td><td>" + (list[i].orderDetail.payTime == null ? "" : list[i].orderDetail.payTime);
		var arr = [21];
		var index = $.inArray(status,arr);
		str += "</td><td>";
		str += "<a href='javascript:void(0);' class='table-btns' onclick='toShow(\""+list[i].orderId+"\")'>详情</a>";
		if(index >= 0){
			str += "<a href='javascript:void(0);' class='table-btns' onclick='toAudit(\""+list[i].orderId+"\")'>审核处理</a>";
		}
		
// 		if (true) {
// 			str += "<td align='left'>";
// 			str += "<button type='button' class='btn btn-warning' onclick='toShow(\""+list[i].orderId+"\")'>订单详情</button>";
// 			str += "<button type='button' class='btn btn-danger' onclick='toAudit(\""+list[i].orderId+"\")' >审核处理</button>";
// 			str += "</td>";
// 		}
		
		str += "</td></tr>";
	}
		

	$("#orderTable tbody").html(str);
}
	

function toShow(orderId){
	var index = layer.open({
		  title:"查看订单详情",		
		  type: 2,
		  content: '${wmsUrl}/admin/finance/orderBackMng/toShow.shtml?orderId='+orderId,
		  maxmin: true
		});
		layer.full(index);
}

function toAudit(orderId){
	var index = layer.open({
		  title:"审核订单退款",		
		  type: 2,
		  area:['60%','40%'],
		  content: '${wmsUrl}/admin/finance/orderBackMng/toAudit.shtml?orderId='+orderId,
		  maxmin: false
		});
}

//点击展开
$('.select-content').on('click','li span i:not(active)',function(){
	$(this).addClass('active');
	$(this).parent().next().stop();
	$(this).parent().next().slideDown(300);
});
//点击收缩
$('.select-content').on('click','li span i.active',function(){
	$(this).removeClass('active');
	$(this).parent().next().stop();
	$(this).parent().next().slideUp(300);
});

//点击展开下拉列表
$('#gradeName').click(function(){
	$('.select-content').css('width',$(this).outerWidth());
	$('.select-content').css('left',$(this).offset().left);
	$('.select-content').css('top',$(this).offset().top + $(this).height());
	$('.select-content').stop();
	$('.select-content').slideDown(300);
});

//点击空白隐藏下拉列表
$('html').click(function(event){
	var el = event.target || event.srcelement;
	if(!$(el).parents('.select-content').length > 0 && $(el).attr('id') != "gradeName"){
		$('.select-content').stop();
		$('.select-content').slideUp(300);
	}
});
//点击选择分类
$('.select-content').on('click','span',function(event){
	var el = event.target || event.srcelement;
	if(el.nodeName != 'I'){
		var name = $(this).attr('data-name');
		var id = $(this).attr('data-id');
		$('#gradeName').val(name);
		$('#gradeId').val(id);
		$('.select-content').stop();
		$('.select-content').slideUp(300);
	}
});
</script>
</body>
</html>
