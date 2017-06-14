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
<title>打印空包快递单</title>
<%@include file="../../resource.jsp" %>
</head>

<body>
	<div id="page-wrapper">

		<div class="container-fluid">
			<!-- Page Heading -->
			<div class="row">
				<div class="col-lg-12">
					<ol class="breadcrumb">
						<li><i class="fa fa-fighter-jet fa-fw"></i>出库业务</li>
						<li class="active"><i class="fa fa-user-md fa-fw"></i> 打印空包快递单</li>
					</ol>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="query">
						<div class="row"  >
							<div class="form-group">
								<label>快递公司:</label> 
								<select name="carrier" id="carrier"  class="form-control span2">
									<option value="">不限</option>
										<c:forEach items="${carrierList}" var="item">
											<option value="${item.carrier }">${item.company }</option>
										</c:forEach>
								</select>
							</div>
							<div class="form-group">
								<label>订单来源:</label> 
								<select name="orderTab"  id="orderTab" class="form-control span2">
									<option value="">全部</option>
									<option value="0">菜鸟订单</option>
									<option value="1">国际物流</option>
								</select>
							</div>
							<div class="form-group">
								<label>订单分类:</label> 
								<select name="receipType" id="receipType"  class="form-control span2">
									<option value="">请选择</option>
									<option value="01">订单出库</option>
									<option value="99">换货出库</option>
								</select>
							</div>
							<div class="form-group">
								<label>海关状态:</label> 
								<select name="hgstate" id="hgstate"   class="form-control span2">
										<option value="2">单证放行</option>
										<option value="4">货物放行</option>
										<option value="1">审核</option>
								</select>
							</div>
						</div>
						<div class="row"  >
							<div class="form-group">
								<label>订单状态:</label>
								<select name="state" id="state" class="form-control span2">
										<option value="2">未打印</option>
										<option value="4">已打印</option>
										<option value="5">货物出库</option>
								</select>
							</div>
							<div class="form-group">
								<label>选择店铺:</label>
								<input name="shopId" id="shopId" type="text"  class="form-control">
								<button type="button" class="btn btn-primary" btnId="shopQuery" onclick="showShops()">店铺查询</button>
							</div>
							<div class="form-group">
								<label>店铺名称:</label> 
								<input size="16" type="text" id="shopName" forBtn="shopQuery" class="form-control" name="shopName" readonly="readonly">
							</div>
						</div>
						<div class="row"  >
							<div class="form-group">
								<label>快递单号:</label> 
								<input size="16" type="text" id="expressID"  class="form-control" name="expressID">
							</div>
							<div class="form-group">
								<label>指示单号:</label> 
								<input size="16" type="text" id="instructions"  class="form-control" name="instructions">
							</div>
							<div class="form-group">
							<label>&nbsp;货号&nbsp;:</label> 
								<input size="16" type="text" id="sku"  class="form-control" name="sku">
							</div>
							<div class="form-group">
								<label>商户名&nbsp;:</label> 
								<select name="sellerInfoId" id="sellerInfoId" class="form-control span2">
						   			<option value="" selected="selected" >全部</option>
						   			<c:forEach items="${sellerInfoList}" var="seller">
						  	 			<option value="${seller.sellerInfoId}">${seller.sellerName}</option>
						   			</c:forEach>
								</select>
							</div>
						</div>
						<button type="button" id="querybtns" class="btn btn-primary">查询</button>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default"  >
						<div class="panel-heading">
							<h3 class="panel-title">
								<i class="fa fa-bar-chart-o fa-fw"></i>订单列表
							</h3>
						</div>
						<div class="panel-body">
							<c:if test="${privilege>=2}">
								<button type="button" class="btn btn-primary" onclick="printExpress()">打印快递单</button>
							</c:if>
							<table id="OrderTable" class="table table-hover"  >
								<thead>
									<tr>
										<th><input type="checkbox" id = selectAll onclick="selectAll(this);"></th>
										<th>申报单号</th>
										<th>状态</th>
										<th>交货人姓名</th>
										<th>交货人电话</th>
										<th>买家用户名</th>
										<th>付款时间</th>
										<th>支付金额</th>
										<th>订单类型</th>
										<th>详细地址</th>
										<th>承运商</th>
										<th>快递单号</th>
										<th>邮政编码</th>
										<th>下单时间</th>
										<th>订单号</th>
										<th>店铺名称</th>
										<th>审核状态</th>
										<th>海关状态</th>
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
	<div class="modal fade" id="shopModal" tabindex="-1" role="dialog" aria-hidden="true">
	    <div class="modal-dialog"  >
	      <div class="modal-content"  >
	         <div class="modal-header">
	            <button type="button" class="close"  aria-hidden="true" data-dismiss="modal" onclick="closeShopModal()">&times;</button>
	         	<h4 class="modal-title" id="modelTitle">店铺选择</h4>
	         </div>
	         <div class="modal-body"  >
	         	<iframe id="shopIFrame" width="100%" height="80%" frameborder="0"></iframe>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeShopModal()">取消 </button>
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
				url :  "${wmsUrl}/admin/stockOut/emptyBag/dataList.shtml",
				numPerPage:"10",
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
		$("#OrderTable tbody").html("");
	
	
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
			str += "<td><input type='checkbox' name='check' value='" + list[i].orderId + "' /></td>";
			str += "<td>" + (list[i].externalNo==null?"无":list[i].externalNo) +"</td>";
			str += "<td>" + (list[i].instructions==null?"无":list[i].instructions) +"</td>";
			switch (list[i].state){
				case '3' : str += "<td>未打快递单</td>"; break;
				case '4' : str += "<td>已打快递单</td>"; break;
				case '5': str += "<td>货物出库</td>"; break;
				case '99' : str += "<td>审核已指示</td>"; break;
				case '98' : str += "<td>审核已打印</td>"; break;
				default : str += "<td>无</td>"; break;
			}
			str += "<td>" + (list[i].receiverName ==null?"无":list[i].receiverName)+ "</td>";
			str += "<td>" + (list[i].receiverMobile==null?"无":list[i].receiverMobile) +"</td>";
			str += "<td>" + (list[i].userName==null?"无":list[i].userName )+"</td>";
			str += "<td>" + (list[i].paymentDateTime==null?"无":list[i].paymentDateTime )+"</td>";
			str += "<td>" + (list[i].payment==null?"无":list[i].payment )+"</td>";
			switch (list[i].receipType){
				case '01' : str += "<td>订单出库</td>"; break;
				case '02' : str += "<td>菜鸟订单出库</td>"; break;
				case '99' : str += "<td>换货出库</td>"; break;
				default : str += "<td>无</td>"; break;
			}
			str += "<td>" + (list[i].receiverAddress==null?"无":list[i].receiverAddress) +"</td>";
			switch (list[i].carrierKey) {
				case '41956181-9' : str += "<td>邮政小包</td>"; break;
				case '55796739-0' : str += "<td>邮政速递</td>"; break;
				case '66849640-5' : str += "<td>顺丰速运</td>"; break;
				case '73698071-8' : str += "<td>中通速递</td>"; break;
				default : str += "<td>无</td>"; break;
			}
			str += "<td>" + (list[i].expressID==null?"无":list[i].expressID )+"</td>";
			str += "<td>" + (list[i].receiverZipCode==null?"无":list[i].receiverZipCode) +"</td>";
			str += "<td>" + (list[i].billDate==null?"无":list[i].billDate) +"</td>";
			str += "<td>" + (list[i].externalNo2==null?"无":list[i].externalNo2) +"</td>";
			str += "<td id='shopName'>" + (list[i].shopName==null?"无":list[i].shopName)+"</td>";
			switch (list[i].gjState) {
				case '1' : str += "<td>审核</td>"; break;
				case '2' : str += "<td>放行</td>"; break;
				case '3' : str += "<td>审核不通过</td>"; break;
				default : str += "<td>无</td>"; break;
			}
			switch (list[i].customsState) {
				case '0': str += "<td>初始订单</td>"; break;
				case '1': str += "<td>库存锁定</td>"; break;
				case '2': str += "<td>放行</td>"; break;
				case '3': str += "<td>审核不通过</td>"; break;
				case '4': str += "<td>货物放行(海关)</td>"; break;
				default : str += "<td>无</td>"; break;
			}
			str += "</tr>";
		}
		$("#OrderTable tbody").htmlUpdate(str);
	}
	
	function showShops(){
	    var frameSrc = "${wmsUrl}/admin/basic/shopInfo/showDetail.shtml";
	    $("#shopIFrame").attr("src", frameSrc);
	    $('#shopModal').modal({ show: true, backdrop: 'static' });
	}
	
	function closeShopModal(){
		$('#shopModal').modal('hide');
	}
	
	function selectAll(obj){
		$("[name='check']").each(function(){
	        this.checked = !this.checked;
	    });
	}
	
	// 打印快递单
	function printExpress(){
	    var valArr = new Array; 
	    var insArr = new Array;
	    $("[name='check']:checked").each(function(i){ 
	        valArr[i] = $(this).val(); 
	    }); 
	    var orderIds = valArr.join(',');//转换为逗号隔开的字符串 
	    if(orderIds == null || orderIds == '' || orderIds == undefined){
	    	$.zzComfirm.alertError("没有选中数据");
	    	return;
	    }
		if(valArr!=''){
			var left1 = 300;
			var top1 = 200;
			window.open('${wmsUrl}/admin/stockOut/printExpress/toPrint.shtml?orderIds='+orderIds+'&flag=0', "", "width=750,height=700,resizable=yes,location=no,scrollbars=yes,left=" + left1.toString() + ",top=" + top1.toString());
		}
	}
	</script>
</body>
</html>
