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
<%@include file="../../resource.jsp"%>
<script src="${wmsUrl}/js/pagination.js"></script>



</head>
<body>
<section class="content-wrapper">
	<section class="content">
		<div class="box box-info">
			<div class="box-header with-border">
				<div class="box-header with-border">
	            	<h5 class="box-title">搜索</h5>
	            	<div class="box-tools pull-right">
	                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
	              	</div>
	            </div>
			</div>
			
			<form class="form-horizontal" role="form" id="orderForm" >
		    <div class="box-body">
			<div class="row form-horizontal query">
				<div class="col-xs-4">
						<div class="form-group">
							<label class="col-sm-4 control-label no-padding-right" for="form-field-1">订单号</label>
							<div class="col-sm-8">
								<div class="input-group">
		                  			<input type="text" class="form-control" name="orderId">
				                </div>
							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label class="col-sm-4 control-label no-padding-right" for="form-field-1">商品编号</label>
							<div class="col-sm-8">
								<div class="input-group">
		                  			<input type="text" class="form-control" name="itemId">
				                </div>
							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label class="col-sm-4 control-label no-padding-right" for="form-field-1">商品编码</label>
							<div class="col-sm-8">
								<div class="input-group">
		                  			<input type="text" class="form-control" name="itemCode">
				                </div>
							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label class="col-sm-4 control-label no-padding-right" for="form-field-1">供应商</label>
							<div class="col-sm-8">
								<div class="input-group">
				                  <select class="form-control" name="supplierId" id="supplierId" style="width: 150px;">
				                   	  <option selected="selected" value="">未选择</option>
				                   	  <c:forEach var="supplier" items="${supplierId}">
				                   	  	<option value="${supplier.id}">${supplier.supplierName}</option>
				                   	  </c:forEach>
					                </select>
				                </div>
							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label class="col-sm-4 control-label no-padding-right" for="form-field-1">功能<font style="color:red">*</font> </label>
							<div class="col-sm-8">
								<div class="input-group">
				                  <select class="form-control" name="tagfunc" id="tagfunc" style="width: 150px;">
				                   	  <c:forEach var="tagFun" items="${tagFuncId}">
				                   	  	<option value="${tagFun.id}">${tagFun.funcName}</option>
				                   	  </c:forEach>
					                </select>
				                </div>
							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label class="col-sm-4 control-label no-padding-right" for="form-field-1">区域中心</label>
							<div class="col-sm-8">
								<div class="input-group">
									<select class="form-control" name="centerId" id="centerId" style="width: 160px;">
				                   	  <option selected="selected" value="">未选择</option>
				                   	  <c:forEach var="center" items="${centerId}">
		                   	  			<option value="${center.gradeId}">${center.gradeName}</option>
				                   	  </c:forEach>
					              	</select>
				                </div>
							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label class="col-sm-4 control-label no-padding-right" for="form-field-1">门店</label>
							<div class="col-sm-8">
								<div class="input-group">
									<select class="form-control" name="shopId" id="shopId" style="width: 150px;">
				                   	  <option selected="selected" value="">未选择</option>
				                   	  <c:forEach var="shop" items="${shopId}">
		                   	  			<option value="${shop.gradeId}">${shop.gradeName}</option>
				                   	  </c:forEach>
					              	</select>
				                </div>
							</div>
						</div>
					</div>
					<div class="col-md-offset-9 col-md-12">
						<div class="form-group">
                                <button type="button" class="btn btn-primary" id="querybtns">提交</button>
                                <button type="button" class="btn btn-danger" id="cancleFunc">全部推送</button>
                                <button type="button" class="btn btn-warning" onclick = "partCancleFunc()">部分推送</button>
                        </div>
                     </div>
				</div>
			</div>
			</form>
		</div>
		
	
		<div class="box box-warning">
			<div class="box-body">
				<div class="row">
					<div class="col-md-12">
						<div class="panel panel-default">
							<table id="orderTable" class="table table-hover">
								<thead>
									<tr>
										<th>选择</th>
										<th>订单编号</th>
										<th>状态</th>
										<th>快递公司</th>
										<th>物流单号</th>
										<th>供应商</th>
										<th>支付总金额</th>
										<th>消费者</th>
										<th>所属区域</th>
										<th>所属店铺</th>
										<th>推手</th>
										<th>交易时间</th>
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
			</div>
		</div>	
	</section>
	</section>
	
	<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
<script type="text/javascript">


/**
 * 初始化分页信息
 */
var options = {
			queryForm : ".query",
			url :  "${wmsUrl}/admin/order/preSellMng/dataList.shtml",
			numPerPage:"20",
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
	
	if (list == null || list.length == 0) {
		layer.alert("没有查到数据");
		return;
	}

	var str = "";
	for (var i = 0; i < list.length; i++) {
		str += "<tr>";
		
		var status = list[i].status;
		var tagFun = list[i].tagFun;
		if (tagFun == 1) {
			str += "<td>";
		} else {
			str += "<td><input type='checkbox' name='check' value='" + list[i].orderId + "' />";
		}
		str += "</td><td>" + list[i].orderId;
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
			case 12:str += "</td><td>已支付";break;
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
		str += "</td><td>" + list[i].customerName;
		var tmpCenterId = list[i].centerId;
		var tmpCenterName = "";
		if (tmpCenterId == -1) {
			tmpCenterName = "订货平台";
		}
		var centerSelect = document.getElementById("centerId");
		var options = centerSelect.options;
		for(var j=0;j<options.length;j++){
			if (tmpCenterId==options[j].value) {
				tmpCenterName = options[j].text;
				break;
			}
		}
		str += "</td><td>" + (tmpCenterName == "" ? "" : tmpCenterName);
		var tmpShopId = list[i].shopId;
		var tmpShopName = "";
		var shopSelect = document.getElementById("shopId");
		var soptions = shopSelect.options;
		for(var j=0;j<soptions.length;j++){
			if (tmpShopId==soptions[j].value) {
				tmpShopName = soptions[j].text;
				break;
			}
		}
		str += "</td><td>" + (tmpShopName == "" ? "" : tmpShopName);
		str += "</td><td>" + (list[i].pushUserName == null ? (list[i].pushUserId == null ? "" : list[i].pushUserId) : list[i].pushUserName);
		str += "</td><td>" + (list[i].orderDetail.payTime == null ? "" : list[i].orderDetail.payTime);
		if (true) {
			str += "<td align='left'>";
			str += "<button type='button' class='btn btn-warning' onclick='toShow(\""+list[i].orderId+"\")' >详情</button>";
			str += "</td>";
		}
		
		str += "</td></tr>";
	}
		

	$("#orderTable tbody").html(str);
}
	

function toShow(orderId){
	var index = layer.open({
		  title:"查看订单详情",		
		  type: 2,
		  content: '${wmsUrl}/admin/order/stockOutMng/toShow.shtml?orderId='+orderId,
		  maxmin: true
		});
		layer.full(index);
}

$("#cancleFunc").click(function(){
	$.ajax({
		 url:"${wmsUrl}/admin/order/preSellMng/cancleOrderList.shtml?tagfunc="+$("#tagfunc").val(),
		 type:"post",
// 		 data:JSON.stringify(sy.serializeObject($('#orderForm'))),
		 contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 success:function(data){
			 if(data.success){
				 layer.alert("开始执行取消功能操作，请稍后查看结果");
				 reloadTable();
			 }else{
				 layer.alert(data.msg);
			 }
		 },
		 error:function(){
			 layer.alert("取消功能失败，请联系客服处理");
		 }
	 });
});

function partCancleFunc(){
	var valArr = new Array; 
	var orderIds;
    $("[name='check']:checked").each(function(i){ 
        valArr[i] = $(this).val(); 
    }); 
    if(valArr.length==0){
    	layer.alert("请勾选要取消功能的订单数据");
    	return;
    }
    orderIds = valArr.join(',');//转换为逗号隔开的字符串 
	$.ajax({
		 url:"${wmsUrl}/admin/order/preSellMng/partCancle.shtml?orderId="+orderIds,
		 type:'post',
		 contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 success:function(data){
			 if(data.success){	
				 layer.alert("开始执行部分取消功能操作，请稍后查看结果");
				 reloadTable();
			 }else{
				 layer.alert(data.msg);
			 }
		 },
		 error:function(){
			 layer.alert("提交失败，请联系客服处理");
		 }
	 });
}
</script>
</body>
</html>
