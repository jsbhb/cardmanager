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
<title>出库单管理</title>
<%@include file="../../resource.jsp"%>
</head>

<body>
	<div id="page-wrapper">
		<div class="container-fluid">
			<!-- Page Heading -->
			<div class="row">
				<div class="col-lg-12">
					<ol class="breadcrumb">
						<li><i class="fa fa-fighter-jet fa-fw"></i>出库业务</li>
						<li class="active"><i class="fa fa-user-md fa-fw"></i>大货出库</li>
					</ol>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="query">
						<div class="row" style="padding-left:15px">
							<div class="form-group">
								<label>系统编号:</label> <input type="text" class="form-control"   name="orderId">
							</div>
							<div class="form-group">
								<label>出库单号:</label> <input type="text" class="form-control"   name="orderCode">
							</div>
							<div class="form-group">
								<label>商家编号:</label> <input type="text" class="form-control" name="supplierId">
							</div>
							<div class="form-group">
								<label>商家名称:</label> <input type="text" class="form-control" name="supplierName">
							</div>
						</div>
						<div class="row" style="padding-left:15px">
							<div class="form-group">
								<label>单据状态:</label>
								<select name="state" class="form-control span2"  id="state">
									<option value="-1">全部</option>
									<option value="0">未处理</option>
									<option value="1">接单确认</option>
									<option value="2">录入确认</option>
									<option value="3">拒单</option>
									<option value="4">取消订单</option>
								</select>
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
						<div class="row" style="padding-left:15px">
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
								<i class="fa fa-bar-chart-o fa-fw"></i>出库列表
							</h3>
						</div>
						<div class="panel-body">
							<table id="stockOutTable" class="table table-hover">
								<thead>
									<tr>
										<th>操作</th>
										<th>订单编码</th>
										<th>店铺</th>
										<th>仓库订单编码</th>
										<th>状态</th>
										<th>商户编号</th>
										<th>所属商户</th>
										<th>订单创建时间</th>
										<th>最后更新时间</th>
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
	
	<div class="modal fade" id="dealModal" tabindex="-1" role="dialog" aria-hidden="true">
	   <div class="modal-dialog">
	      <div class="modal-content" >
	         <div class="modal-header">
	            <button type="button" class="close"  aria-hidden="true" data-dismiss="modal" onclick="reloadTable()">&times;</button>
	         	<h4 class="modal-title" id="modelTitle">出库单处理</h4>
	         </div>
	         <div class="modal-body">
	         	<iframe id="dealIFrame" frameborder="0"></iframe>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="reloadTable()">取消 </button>
	         </div>
	      </div>
		</div>
	</div>
	<div class="modal fade" id="detailModal" tabindex="-1" role="dialog" aria-hidden="true">
	   <div class="modal-dialog">
	      <div class="modal-content">
	         <div class="modal-header">
	            <button type="button" class="close"  aria-hidden="true" data-dismiss="modal" onclick="reloadTable()">&times;</button>
	         	<h4 class="modal-title" id="modelTitle">出库单详情</h4>
	         </div>
	         <div class="modal-body">
	         	<iframe id="detailIFrame" frameborder="0"></iframe>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="reloadTable()">取消 </button>
	         </div>
	      </div>
		</div>
	</div>
<script type="text/javascript">

	$(".dataPicker").datetimepicker({
		format : 'yyyy-mm-dd hh:ii:ss'
	});
	/**
	 * 初始化分页信息
	 */
	var options = {
				queryForm : ".query",
				url :  "${wmsUrl}/admin/stockOut/stockOutOrder/dataList.shtml",
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
		$("#stockOutTable tbody").html("");
	
	
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
			str += "<tr><td><button type='button' class='btn btn-info' onclick='dealOrder(\""+list[i].orderId+"\")'>处理</button></td>";
			str += "<td>" + list[i].orderId +"</td>";
			str += "<td>" + list[i].shopName +"</td>";
			str += "<td>" + list[i].orderCode +"</td>";
			
			switch(list[i].state){
			case '0': str += "<td>未处理</td>";break;
			case '1': str += "<td>接单</td>";break;
  			case '2':	str += "<td>确认接单</td>";break;
  			case '3':	str += "<td>拒单</td>";break;
  			case '4':	str += "<td>取消</td>";break;
  			default: str += "</td><td>无";
		}
			
			str += "<td>" + list[i].supplierId +"</td>";
			str += "<td>" + list[i].supplierName +"</td>";
			str += "<td>" + list[i].ctime +"</td>";
			str += "<td>" + list[i].updateTime +"</td>";
			str += "</tr>";
		}
		
		
		$("#stockOutTable tbody").html(str);
	}
	
	function dealOrder(value){
		 var frameSrc = '${wmsUrl}/admin/stockOut/stockOutOrder/dealOrder.shtml?orderId='+value;
	        $("#dealIFrame").attr("src", frameSrc);
	        $('#dealModal').modal({ show: true, backdrop: 'static' });
	}
	
	</script>
</body>
</html>
