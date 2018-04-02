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

<link rel="stylesheet" href="${wmsUrl}/validator/css/bootstrapValidator.min.css">
<script src="${wmsUrl}/validator/js/bootstrapValidator.min.js"></script>
<script src="${wmsUrl}/js/pagination.js"></script>

</head>

<body>
	<section class="content-wrapper">
        <div class="content">
        <div class="panel-heading">
			<h3 class="panel-title">
                	<button type="button" class="btn btn-danger" id="orderBackBtn">发起订单退款</button>
			</h3>
		</div>
        	<div class="box box-info">
				<div class="box-header with-border">
					<div class="box-header with-border">
		            	<h5 class="box-title">订单基础信息</h5>
		            	<div class="box-tools pull-right">
								<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
		              	</div>
		            </div>
				</div>
			    <div class="box-body">
					<div class="row form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">订单编号</label>
							<div class="col-sm-4">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
		                  			<input type="text" class="form-control" readonly id="orderId" value="${order.orderId}">
				                </div>
							</div>
							<label class="col-sm-1 control-label no-padding-right">供应商</label>
							<div class="col-sm-4">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
		                  			<input type="text" class="form-control" readonly  value="${order.supplierName}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">消费者编号</label>
							<div class="col-sm-4">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
		                  			<input type="text" class="form-control" readonly  value="${order.userId}">
				                </div>
							</div>
							<label class="col-sm-1 control-label no-padding-right">状态</label>
							<div class="col-sm-4">
								<div class="input-group">
				                  <c:if test="${order.status==0}">待支付</c:if>
				                  <c:if test="${order.status==1}">已付款</c:if>
				                  <c:if test="${order.status==2}">支付单报关</c:if>
				                  <c:if test="${order.status==3}">已发仓库</c:if>
				                  <c:if test="${order.status==4}">已报海关</c:if>
				                  <c:if test="${order.status==5}">单证放行</c:if>
				                  <c:if test="${order.status==6}">已发货</c:if>
				                  <c:if test="${order.status==7}">已收货</c:if>
				                  <c:if test="${order.status==8}">退单</c:if>
				                  <c:if test="${order.status==9}">超时取消</c:if>
				                  <c:if test="${order.status==11}">资金池不足</c:if>
				                  <c:if test="${order.status==12}">已支付</c:if>
				                  <c:if test="${order.status==21}">退款中</c:if>
				                  <c:if test="${order.status==99}">异常状态</c:if>
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">创建时间</label>
							<div class="col-sm-4">
								<div class="input-group">
			                    	<div class="input-group-addon">
				                    	<i class="fa fa-pencil"></i>
				                	</div>
				                  	<input type="text" class="form-control" name="area" readonly value="${order.createTime}">
				                </div>
							</div>
							<label class="col-sm-1 control-label no-padding-right">所属店铺</label>
							<div class="col-sm-4">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
				                  <input type="text" class="form-control"  readonly value="${order.shopName}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">所属区域</label>
							<div class="col-sm-4">
								<div class="input-group">
			                    	<div class="input-group-addon">
				                    	<i class="fa fa-pencil"></i>
				                	</div>
				                  	<input type="text" class="form-control" name="area" readonly value="${order.centerName}">
				                </div>
							</div>
							<label class="col-sm-1 control-label no-padding-right">推手编号</label>
							<div class="col-sm-4">
								<div class="input-group">
			                    	<div class="input-group-addon">
				                    	<i class="fa fa-pencil"></i>
				                	</div>
				                  	<input type="text" class="form-control" name="pushUserId" readonly value="${order.pushUserId}">
				                </div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="box box-info">
				<div class="box-header with-border">
					<div class="box-header with-border">
		            	<h5 class="box-title">订单详情</h5>
		            	<div class="box-tools pull-right">
							<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
						</div>
		            </div>
				</div>
				<div class="box-body">
					<div class="row form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">支付类型</label>
							<div class="col-sm-4">
								<div class="input-group">
									<div class="input-group-addon">
				                    	<i class="fa fa-pencil"></i>
				                  	</div>
									<c:if test="${order.orderDetail.payType==1}"><input type="text" class="form-control" readonly  value="微信"></c:if>
									<c:if test="${order.orderDetail.payType==2}"><input type="text" class="form-control" readonly  value="支付宝"></c:if>
									<c:if test="${order.orderDetail.payType==3}"><input type="text" class="form-control" readonly  value="银联"></c:if>
				                </div>
							</div>
							<label class="col-sm-1 control-label no-padding-right">支付金额</label>
							<div class="col-sm-4">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
		                  			<input type="text" class="form-control" readonly  value="${order.orderDetail.payment}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">税费</label>
							<div class="col-sm-4">
								<div class="input-group">
								 	<div class="input-group-addon">
				                    	<i class="fa fa-pencil"></i>
				                  	</div>
		                  			<input type="text" class="form-control" readonly  value="${order.orderDetail.taxFee}">
				                </div>
							</div>
							<label class="col-sm-1 control-label no-padding-right">邮费</label>
							<div class="col-sm-4">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
		                  			<input type="text" class="form-control" readonly  value="${order.orderDetail.postFee}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">消费税</label>
							<div class="col-sm-4">
								<div class="input-group">
								 	<div class="input-group-addon">
				                    	<i class="fa fa-pencil"></i>
				                  	</div>
		                  			<input type="text" class="form-control" readonly  value="${order.orderDetail.exciseTax}">
				                </div>
							</div>
							<label class="col-sm-1 control-label no-padding-right">支付时间</label>
							<div class="col-sm-4">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
		                  			<input type="text" class="form-control" readonly  value="${order.orderDetail.payTime}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">交易流水号</label>
							<div class="col-sm-4">
								<div class="input-group">
								 	<div class="input-group-addon">
				                    	<i class="fa fa-pencil"></i>
				                  	</div>
		                  			<input type="text" class="form-control" readonly  value="${order.orderDetail.payNo}">
				                </div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="box box-info">
				<div class="box-header with-border">
					<div class="box-header with-border">
		            	<h5 class="box-title">物流信息</h5>
		            	<div class="box-tools pull-right">
							<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
						</div>
		            </div>
				</div>
				<div class="box-body">
					<div class="row form-horizontal">
						<c:if test="${order.orderExpressList!=null}">
							<c:forEach var="express" items="${order.orderExpressList}">
								<div class="form-group">
								<label class="col-sm-2 control-label no-padding-right">快递公司</label>
								<div class="col-sm-4">
									<div class="input-group">
										<div class="input-group-addon">
					                    	<i class="fa fa-pencil"></i>
					                  	</div>
			                  			<input type="text" class="form-control" readonly  value="${express.expressName}">
					                </div>
								</div>
								<label class="col-sm-1 control-label no-padding-right">快递单号</label>
								<div class="col-sm-4">
									<div class="input-group">
					                  <div class="input-group-addon">
					                    <i class="fa fa-pencil"></i>
					                  </div>
			                  			<input type="text" class="form-control" readonly  value="${express.expressId}">
					                </div>
								</div>
						</div>
							</c:forEach>
						</c:if>
					</div>
				</div>
			</div>
			<div class="box box-info">
				<div class="box-header with-border">
					<div class="box-header with-border">
		            	<h5 class="box-title">收货人信息</h5>
		            	<div class="box-tools pull-right">
							<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
						</div>
		            </div>
				</div>
				<div class="box-body">
					<div class="row form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">名称</label>
							<div class="col-sm-4">
								<div class="input-group">
									<div class="input-group-addon">
				                    	<i class="fa fa-pencil"></i>
				                  	</div>
		                  			<input type="text" class="form-control" readonly  value="${order.orderDetail.receiveName}">
				                </div>
							</div>
							<label class="col-sm-1 control-label no-padding-right">电话</label>
							<div class="col-sm-4">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
		                  			<input type="text" class="form-control" readonly  value="${order.orderDetail.receivePhone}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">收获地址</label>
							<div class="col-sm-4">
								<div class="input-group">
								 	<div class="input-group-addon">
				                    	<i class="fa fa-pencil"></i>
				                  	</div>
		                  			<input type="text" class="form-control" readonly  value="${order.orderDetail.receiveProvince}${order.orderDetail.receiveCity}${order.orderDetail.receiveArea}">
				                </div>
							</div>
							<label class="col-sm-1 control-label no-padding-right">详细地址</label>
							<div class="col-sm-4">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
		                  			<input type="text" class="form-control" readonly  value="${order.orderDetail.receiveAddress}">
				                </div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="box box-info">
				<div class="box-header with-border">
					<div class="box-header with-border">
		            	<h5 class="box-title">订单商品</h5>
		            	<div class="box-tools pull-right">
							<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
						</div>
		            </div>
				</div>
				<div class="box-body">
					<div class="row">
						<div class="col-md-12">
							<div class="panel panel-default">
								<table id="goodsTable" class="table table-hover">
									<thead>
										<tr>
											<th>明细编号</th>
											<th>商品编码</th>
											<th>sku</th>
											<th>商品名称</th>
											<th>商品价格</th>
											<th>实际价格</th>
											<th>数量</th>
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
	</section>
	<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
	<script type="text/javascript">
	
	/**
	 * 初始化分页信息
	 */
	var options = {
				queryForm : ".query",
				url :  "${wmsUrl}/admin/order/orderBackMng/dataListForOrderGoods.shtml?orderId="+"${order.orderId}",
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
		$("#goodsTable tbody").html("");

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
			str += "</td><td>" + list[i].itemId;
			str += "</td><td>" + list[i].itemCode;
			str += "</td><td>" + list[i].sku;
			str += "</td><td>" + list[i].itemName;
			str += "</td><td>" + list[i].itemPrice;
			str += "</td><td>" + list[i].actualPrice;
			str += "</td><td>" + list[i].itemQuantity;
			str += "</td></tr>";
		}

		$("#goodsTable tbody").html(str);
	}
	
	$("#orderBackBtn").click(function(){
		layer.confirm('确定要发起订单退款处理吗？', {
			  btn: ['取消','确定']
		}, function(){
			layer.closeAll();
		}, function(){
			var orderId = $("#orderId").val();
			if (orderId == "") {
				layer.alert("信息不全，请联系客服！");
				return;
			}
			$.ajax({
				 url:"${wmsUrl}/admin/order/orderBackMng/orderBack.shtml?orderId="+orderId,
				 type:'post',
// 				 data:JSON.stringify(sy.serializeObject($('#goodsForm'))),
				 contentType: "application/json; charset=utf-8",
				 dataType:'json',
				 success:function(data){
					 if(data.success){	
						 layer.alert("申请提交成功");
						 parent.layer.closeAll();
						 parent.location.reload();
					 }else{
						 layer.alert(data.msg);
					 }
				 },
				 error:function(){
					 layer.alert("申请提交失败，请联系客服处理");
				 }
			 });
		});
	 });
	</script>
</body>
</html>