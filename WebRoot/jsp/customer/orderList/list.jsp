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
<script src="${wmsUrl}/plugins/laydate/laydate.js"></script>
</head>
<body>
<section class="content-wrapper query">
	<section class="content-header">
	      <ol class="breadcrumb">
	        <li class="active">采购单管理</li>
	      </ol>
	      <div class="search">
	      	<input type="text" name="orderId" placeholder="输入采购单编号" >
	      	<div class="searchBtn"><i class="fa fa-search fa-fw"></i></div>
	      	<div class="moreSearchBtn">高级搜索</div>
		  </div>
    </section>
	<section class="content content-iframe">
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
	                   	  <option selected="selected" value="">采购单状态</option>
	                   	  <option value="0">待支付</option>
	                   	  <option value="1">已付款</option>
	                   	  <option value="2">支付单报关</option>
	                   	  <option value="3">已发仓库</option>
	                   	  <option value="4">已报海关</option>
	                   	  <option value="5">单证放行</option>
	                   	  <option value="6">已发货</option>
	                   	  <option value="7">已收货</option>
	                   	  <option value="8">退单</option>
	                   	  <option value="9">超时取消</option>
	                   	  <option value="11">资金池不足</option>
	                   	  <option value="12">待发货</option>
	                   	  <option value="21">退款中</option>
	                   	  <option value="99">异常状态</option>
		                </select>
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
						<input type="text" class="form-control" name="orderId" placeholder="请输入采购单号">
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
					<div class="searchItem">
						<input type="text" class="form-control" name="itemName" placeholder="请输入商品名称">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
						<input type="text" class="form-control" name="expressId" placeholder="请输入物流单号">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
						<input type="text" class="chooseTime" id="searchTime" name="searchTime" placeholder="请选择查询时间" readonly>
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
			<div class="row">
				<div class="col-md-12 container-right">
					<table id="baseTable" class="table table-hover myClass">
						<thead>
							<tr>
								<th>采购单编号</th>
								<th>采购单状态</th>
								<th>快递公司</th>
								<th>物流单号</th>
								<th>供应商</th>
								<th>总支付金额</th>
								<th>返佣抵扣</th>
								<th>收货人</th>
								<th>创建时间</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
			</div>
		</div>	
		<div class="pagination-nav">
			<ul id="pagination" class="pagination">
			</ul>
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
	url :  "${wmsUrl}/admin/customer/purchaseMng/orderDataList.shtml",
	numPerPage:"10",
	currentPage:"",
	index:"1",
	callback:rebuildTable
}


$(function(){
	 $(".pagination-nav").pagination(options);
	 var top = getTopWindow();
	 $('.breadcrumb').on('click','a',function(){
		top.location.reload();
	 });
})

laydate.render({
  elem: '#searchTime', //指定元素
  type: 'datetime',
  range: '~',
  value: null
});

function reloadTable(){
	$.page.loadData(options);
}

/**
 * 重构table
 */
function rebuildTable(data){
	$("#baseTable tbody").html("");

	if (data == null || data.length == 0) {
		return;
	}
	
	var list = data.obj;
	var str = "";
	
	if (list == null || list.length == 0) {
		str = "<tr style='text-align:center'><td colspan=11><h5>没有查到数据</h5></td></tr>";
		$("#baseTable tbody").html(str);
		return;
	}

	for (var i = 0; i < list.length; i++) {
		str += "<tr>";
		
		var status = list[i].status;
		str += "</td><td>" + list[i].orderId;
		var orderFlag = list[i].orderFlag;
		switch(status){
			case 0:str += "</td><td>待支付";break;
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
			case 12:
				if (orderFlag == 0) {
					str += "</td><td>海关申报中";
				} else if (orderFlag == 2) {
					str += "</td><td>待发货";
				}
				break;
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
				break;
			}
		}
		str += "</td><td>" + expressName;
		str += "</td><td>" + expressId;
		str += "</td><td>" + (list[i].supplierName == null ? "" : list[i].supplierName);
		str += "</td><td>" + list[i].orderDetail.payment;
		str += "</td><td>" + list[i].orderDetail.rebateFee;
		str += "</td><td>" + (list[i].orderDetail.receiveName == null ? "" : list[i].orderDetail.receiveName);
		str += "</td><td>" + (list[i].createTime == null ? "" : list[i].createTime);
		if (status == 0) {
			str += "</td><td><a href='javascript:void(0);' class='table-btns' onclick='toShow(\""+list[i].orderId+"\")'>采购单详情</a>";
			str += "<a href='javascript:void(0);' class='table-btns' style='width: 78px; height: 30px; padding: 0px;' onclick='continuePay(2,\""+list[i].orderId+"\")'><img src='${wmsUrl}/img/customer/zfb.png' alt='中国供销海外购' style='width: 78px; height: 30px'></a>";
			str += "<a href='javascript:void(0);' class='table-btns' style='width: 78px; height: 30px; padding: 0px;' onclick='continuePay(1,\""+list[i].orderId+"\")'><img src='${wmsUrl}/img/customer/wx.png' alt='中国供销海外购' style='width: 78px; height: 30px'></a>";
			str += "<a href='javascript:void(0);' class='table-btns' style='width: 78px; height: 30px; padding: 0px;' onclick='continuePay(5,\""+list[i].orderId+"\")'><img src='${wmsUrl}/img/customer/yb.png' alt='中国供销海外购' style='width: 78px; height: 30px'></a>";
		} else {
			str += "</td><td><a href='javascript:void(0);' class='table-btns' onclick='toShow(\""+list[i].orderId+"\")'>采购单详情</a>";
		}
		str += "</td></tr>";
	}
	$("#baseTable tbody").html(str);
}
	

function toShow(orderId){
	var index = layer.open({
		  title:"查看采购单详情",		
		  type: 2,
		  content: '${wmsUrl}/admin/customer/purchaseMng/toShow.shtml?orderId='+orderId,
		  maxmin: true
		});
		layer.full(index);
}

function continuePay(payType,orderId){
	var win = window.open('about:blank');
	$.ajax({
		 url:"${wmsUrl}/admin/customer/purchaseMng/continuePay.shtml?payType="+payType+"&orderId="+orderId,
		 type:'post',
		 contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 success:function(data){
			 if(data.success){
			 	if (data.msg != null && data.msg != "") {
					 var orderId = data.msg.split("|")[0];
					 var type = data.msg.split("|")[1];
					 var strInfo = data.msg.split("|")[2];
// 					 console.log(data.msg);
					 if (type == 1) {
					 	var url = "${wmsUrl}/admin/customer/purchaseMng/toPay.shtml?orderId="+orderId+"&strInfo="+strInfo;
				    	win.location.href = url;
					 } else if (type == 2) {
						 win.document.write(strInfo);
					 } else if (type == 5) {
						 win.location.href = strInfo;
					 }
				}
			 	location.reload();
			 }else{
				layer.alert(data.msg);
				 win.close();
			 }
		 },
		 error:function(){
			 layer.alert("订单支付失败，请联系客服处理");
			 win.close();
		 }
	});
}
</script>
</body>
</html>
