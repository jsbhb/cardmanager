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
<title>入库单管理</title>
<%@include file="../../resource.jsp" %>
</head>

<body>
	<div id="page-wrapper">
		<div id="mask"></div>
		<div class="container-fluid">
			<!-- Page Heading -->
			<div class="row">
				<div class="col-lg-12">
					<div class="query">
						<div class="row">
							<div class="form-group">
								<label>系统编号:</label> <input type="text" class="form-control"   name="orderId">
							</div>
							<div class="form-group">
								<label>入库单号:</label> <input type="text" class="form-control"   name="orderCode">
							</div>
							<div class="form-group">
								<label>商家编号:</label> <input type="text" class="form-control" name="supplierId">
							</div>
							<div class="form-group">
								<label>商家名称:</label> <input type="text" class="form-control" name="supplierName">
							</div>
						</div>
						<div class="row">
							<div class="form-group">
								<label>海关货号:</label> <input type="text" class="form-control"   name="sku">
							</div>
							<div class="form-group">
								<label>商品名称:</label> <input type="text" class="form-control"   name="skuName">
							</div>
							<div class="form-group">
								<label>商品编号:</label> <input type="text" class="form-control" name="itemId">
							</div>
							<div class="form-group">
								<label>商品编码:</label> <input type="text" class="form-control" name="itemCode">
							</div>
						</div>
						<div class="row">
							<div class="form-group">
								<label>&nbsp;&nbsp;&nbsp;报检号:</label> <input type="text" class="form-control" name="declNo">
							</div>
							<div class="form-group">
								<label>创建时间:</label> 
								<input size="16" type="text" id="startTime"  class="form-control dataPicker" name="startTime">
								<span class="add-on"><i class="icon-th"></i></span>
								<label>&nbsp;至&nbsp;</label> 
								<input size="16" type="text" id="endTime"  class="form-control dataPicker" name="endTime">
								<span class="add-on"><i class="icon-th"></i></span>
							</div>
						</div>
							<div class="row">
							<div class="form-group">
								<label>单据状态:</label>
								<select name="status" class="form-control span2"  id="status">
									<option value="-1">全部</option>
									<option value="0">未处理</option>
									<option value="1">接单确认</option>
									<option value="2">录入确认</option>
									<option value="3">拒单</option>
									<option value="4">取消订单</option>
									<option value="5">已绑定</option>
								</select>
							</div>
							<div class="form-group">
								<label>理货状态:</label>
								<select name="tallyStatus" class="form-control span2"  id="tallyStatus">
									<option value="-1">全部</option>
									<option value="0">未理货</option>
									<option value="1">理货中</option>
									<option value="2">理货完毕</option>
								</select>
							</div>
							<div class="form-group"><button type="button" id="querybtns" class="btn btn-primary">查询</button></div>
						</div>
						
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">
								<i class="fa fa-bar-chart-o fa-fw"></i>入库单明细列表
							</h3>
						</div>
						<div class="panel-body">
							<table id="stockInTable" class="table table-hover table-bordered">
								<thead>
									<tr>
										<th>编号</th>
										<th>商家编号</th>
										<th>商家名称</th>
										<th>订单编码</th>
										<th>状态</th>
										<th>货号</th>
										<th>商品名称</th>
										<th>商品编号</th>
										<th>商品编码</th>
										<th>数量</th>
										<th>报检号</th>
										<th>理货状态</th>
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
		</div>
	</div>
<script type="text/javascript">
	/**
	 * 初始化分页信息
	 */
	var options = {
				queryForm : ".query",
				url :  "${wmsUrl}/admin/stockIn/cnAsnMng/itemDataList.shtml",
				numPerPage:"10",
				currentPage:"",
				index:"1",
				callback:rebuildTable
	}
	
	      
	
	 /*页面遮罩*/
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
		$.zzComfirm.endMask();
		$("#stockInTable tbody").html("");
	
	
		if (data == null || data.length == 0) {
			
			return;
		}
		
		var list = data.obj;
		
		if (list == null || list.length == 0) {
			$.zzComfirm.alertError("没有查到数据");
			return;
		}
	
		var str = "";
		var declStatusStr = "";
		var customStatusStr = "";
		var status = "";
		var isSupply = "";
		for (var i = 0; i < list.length; i++) {
			str += "<tr><td>"+list[i].orderId;
			str += "</td><td>" + (list[i].supplierId==null?"无":list[i].supplierId);
			str += "</td><td>" + (list[i].supplierName==null?"无":list[i].supplierName);
			str += "</td><td>" + (list[i].ordercode==null?"无":list[i].ordercode);
			status = list[i].status;
			switch(list[i].status){
				case '0': str += "</td><td>未处理";break;
				case '1': str += "</td><td>接单";break;
	  			case '2':	str += "</td><td>确认接单";break;
	  			case '3':	str += "</td><td>拒单";break;
	  			case '4':	str += "</td><td>取消";break;
	  			case '5':	str += "</td><td>已绑定";break;
	  			default: str += "</td><td>无";
			}
			
			str += "</td><td>" + (list[i].sku==null?"无":list[i].sku);
			str += "</td><td>" + (list[i].itemName==null?"无":list[i].itemName);
			str += "</td><td>" + (list[i].itemId==null?"无":list[i].itemId);
			str += "</td><td>" + (list[i].itemCode==null?"无":list[i].itemCode);
			str += "</td><td>" + (list[i].itemQuantity==null?"0":list[i].itemQuantity);
			str += "</td><td>" + (list[i].declNo==null?"无":(list[i].declNo));
			
			switch(list[i].tallyStatus){
				case '0': str += "</td><td>未处理";break;
				case '1': str += "</td><td>理货中";break;
	  			case '2': str += "</td><td>理货完成";break;
	  			default: str += "</td><td>未理货";
			}
			
			str += "</td><td>" + (list[i].ctime==null?"无":(list[i].ctime));
			str += "</td></tr>";
		}
		
		
		$("#stockInTable tbody").htmlUpdate(str);
	}
	</script>
</body>
</html>
