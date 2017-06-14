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
								<i class="fa fa-bar-chart-o fa-fw"></i>入库单列表
							</h3>
						</div>
						<div class="panel-body">
							<table id="stockInTable" class="table table-hover table-bordered">
								<thead>
									<tr>
										<th>操作</th>
										<th>编号</th>
										<th>订单编码</th>
										<th>状态</th>
										<th>类型</th>
										<th>商家编号</th>
										<th>商家名称</th>
										<th>报检号</th>
										<th>理货状态</th>
										<th>是否差异单</th>
										<th>创建时间</th>
										<th>更新时间</th>
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
			</div>
		</div>
	</div>
	<div class="modal fade" id="dealModal" tabindex="-1" role="dialog" aria-hidden="true">
	   <div class="modal-dialog">
	      <div class="modal-content">
	         <div class="modal-header">
	            <button type="button" class="close"  aria-hidden="true" data-dismiss="modal" onclick="reloadTable()">&times;</button>
	         	<h4 class="modal-title" id="modelTitle">入库单处理</h4>
	         </div>
	         <div class="modal-body">
	         	<iframe id="dealIFrame" width="100%" height="100%" frameborder="0"></iframe>
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
	         	<h4 class="modal-title" id="modelTitle">入库单详情</h4>
	         </div>
	         <div class="modal-body">
	         	<iframe id="detailIFrame" width="100%" height="100%" frameborder="0"></iframe>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="reloadTable()">取消 </button>
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
				url :  "${wmsUrl}/admin/stockIn/cnAsnMng/dataList.shtml",
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
			status = list[i].status;
			
			if(status == "3"||status == "4"||status == "2" || list[i].isSupply=='1'){
				str += "<tr><td></td><td><a href='javascript:void(0)' onclick='viewDetail(\""+ list[i].orderCode+"\")' style='color:black;text-decoration:none;'>"+list[i].orderId+"</a>" ;
			}else{
				if("${privilege>=2}"=="true"){
					str += "<tr><td><button type='button' class='btn btn-info' onclick='dealOrder(\""+list[i].orderCode+"\")'>处理</button></td><td><a href='javascript:void(0)' onclick='viewDetail(\""+ list[i].orderCode+"\")' style='color:black;text-decoration:none;'>"+list[i].orderId+"</a>" ;
				}else{
					str += "<tr><td></td><td><a href='javascript:void(0)' onclick='viewDetail(\""+ list[i].orderCode+"\")' style='color:black;text-decoration:none;'>"+list[i].orderId+"</a>" ;
				}
			}
			
			str += "</td><td>" + (list[i].orderCode==null?"无":list[i].orderCode);
			
			switch(list[i].status){
				case '0': str += "</td><td>未处理";break;
				case '1': str += "</td><td>接单";break;
	  			case '2':	str += "</td><td>确认接单";break;
	  			case '3':	str += "</td><td>拒单";break;
	  			case '4':	str += "</td><td>取消";break;
	  			case '5':	str += "</td><td>已绑定";break;
	  			default: str += "</td><td>无";
			}
			
			switch(list[i].type){
				case '302': str += "</td><td>调拨入库单";break;
				case '501': str += "</td><td>销退入库单";break;
	  			case '601': str += "</td><td>采购入库单";break;
	  			case '904': str += "</td><td>普通入库单";break;
	  			default: str += "</td><td>无";
			}
			
			str += "</td><td>" + (list[i].supplierId==null?"无":list[i].supplierId);
			str += "</td><td>" + (list[i].supplierName==null?"无":list[i].supplierName);
			str += "</td><td>" + (list[i].declNo==null?"无":(list[i].declNo));
			
			switch(list[i].tallyStatus){
				case '0': str += "</td><td>未处理";break;
				case '1': str += "</td><td>理货中";break;
	  			case '2': str += "</td><td>理货完成";break;
	  			default: str += "</td><td>无";
			}
			
			switch(list[i].isSupply){
				case '0': str += "</td><td>否";break;
				case '1': str += "</td><td>差异单:"+list[i].prevOrderCode;break;
	  			default: str += "</td><td>无";
			}
			
			str += "</td><td>" + (list[i].orderCreateTime==null?"无":(list[i].orderCreateTime));
			str += "</td><td>" + (list[i].updateTime==null?"无":list[i].updateTime);
			str += "</td><td>" + (list[i].opt==null?"无":list[i].opt);
			str += "</td></tr>";
		}
		
		
		$("#stockInTable tbody").html(str);
	}
	
	function dealOrder(value){
		 var frameSrc = '${wmsUrl}/admin/stockIn/cnAsnMng/dealOrder.shtml?orderCode='+value;
	        $("#dealIFrame").attr("src", frameSrc);
	        $('#dealModal').modal({ show: true, backdrop: 'static' });
	}
	
	function viewDetail(value){
		 var frameSrc = '${wmsUrl}/admin/stockIn/cnAsnMng/viewDetail.shtml?orderCode='+value;
	        $("#detailIFrame").attr("src", frameSrc);
	        $('#detailModal').modal({ show: true, backdrop: 'static' });
	}
	
	
	</script>
</body>
</html>
