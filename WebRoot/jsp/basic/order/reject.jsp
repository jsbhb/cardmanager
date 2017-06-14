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
<title>订单查询</title>
<%@include file="../../resource.jsp"%>
</head>

<body>
	<div id="page-wrapper" class="navContentPageIframe">
		<div id="mask"></div>
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-12">
					<div class="query">
						<div class="row">
							<div class="form-group">
								<label>订单编号</label> <input type="text" class="form-control"
									name="externalNo2">
							</div>
							<div class="form-group">
								<label>商家编号</label> 
								<input type="text" class="form-control" forBtn="supQuery" name="sellerInfoId" id="supplierId" >
							</div>
							<div class="form-group">
								<label>商家名称</label> 
								<input type="text" class="form-control" name="supplierName" forBtn="supQuery" id="supplierName">
								<button type="button" class="btn btn-warning" btnId="supQuery" onclick="showSuppiler()">查找商家</button>
							</div>
						</div>
						<div class="row">
							<div class="form-group">
								<label>货号</label> 
								<input type="text" class="form-control" name="sku">
							</div>
							<div class="form-group">
								<label>仓储单号</label> 
								<input type="text" class="form-control" name="orderCode">
							</div>
							<div class="form-group">
								<label>接单时间</label> 
								<input size="18" type="text" id="startTime" class="form-control dataPicker" name="startTime"> 
								<span class="add-off"><i class="icon-th"></i></span> 
								<label>&nbsp;至&nbsp;</label>
								<input size="18" type="text" id="endTime" class="form-control dataPicker" name="endTime"> 
								<span class="add-on"><i class="icon-th"></i></span>
							</div>
							<div class="form-group">
								<button type="button" id="querybtns" class="btn btn-primary">查询</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default" style="overflow: auto;">
						<div class="panel-heading">
							<h3 class="panel-title">
								<i class="fa fa-bar-chart-o fa-fw"></i>拒单列表
							</h3>
						</div>
						<div class="panel-body">
							<table id="orderTable" class="table table-hover table-bordered">
								<thead>
									<tr>
										<th>进销存</th>
										<th>id</th>
										<th>商家名称</th>
										<th>商家编号</th>
										<th>订单编号</th>
										<th>仓储单号</th>
										<th>拒单原因</th>
										<th>接单时间</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<div class="pagination-nav">
							<ul id="pagination" class="pagination">
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="orderDetailModal" tabindex="-1"
		role="dialog" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true" onclick="closeOrderDetailModal()">&times;</button>
					<h4 class="modal-title" id="modelTitle">订单详情</h4>
				</div>
				<div class="modal-body" >
					<iframe id="orderDetailIFrame" width="100%" height="100%"></iframe>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal"
						onclick="closeOrderDetailModal();">关闭</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="supplierModal" tabindex="-1" role="dialog" aria-hidden="true">
	   <div class="modal-dialog" >
	      <div class="modal-content" >
	         <div class="modal-header">
	            <button type="button" class="close"  aria-hidden="true" data-dismiss="modal" onclick="closeSupModal()">&times;</button>
	         	<h4 class="modal-title" id="modelTitle">商家选择</h4>
	         </div>
	         <div class="modal-body">
	         	<iframe id="supplierIFrame" frameborder="0"></iframe>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeSupModal()">取消 </button>
	         </div>
	      </div>
		</div>
	</div>
	
</body>
</html>

<script type="text/javascript">
		$(".dataPicker").datetimepicker({
			format : 'yyyy-mm-dd hh:ii:ss'
		});
		/**
		 * 初始化分页信息
		 */
		var options = {
			queryForm : ".query",
			url : "${wmsUrl}/admin/order/rejectList.shtml",
			numPerPage : "20",
			currentPage : "",
			index : "1",
			callback : rebuildTable
		}

		$(function() {
			$(".pagination-nav").pagination(options);
		})
		
		function closeOrderDetailModal(){
			$("#orderDetailModal").modal("hide");
		}

		/**
		 * 重构table
		 */
		function rebuildTable(data) {
			$.zzComfirm.endMask();
			$("#orderTable tbody").html("");

			if (data == null || data.length == 0) {
				return;
			}

			var list = data.obj;

			if (list == null || list.length == 0) {
				$.zzComfirm.alertError("没有查到数据");
				return;
			}

			var str = "";
			var strCom = "";
			for (var i = 0; i < list.length; i++) {
				str += "<tr>";
				if ("${privilege==2}") {
					str += "<td><a target='_blank' rel='nofollow' href='${wmsUrl}/admin/inventory/list.shtml?sku="+list[i].remark+"&supplierId="+list[i].sellerInfoId+"'>进销存</a></td>";
				}
				str += "</td><td>" + list[i].orderId;
				str += "</td><td>" + list[i].sellerName;
				str += "</td><td>" + list[i].sellerInfoId;
				str += "</td><td>" + list[i].externalNo2;
				str += "</td><td>" + list[i].orderCode;
				str += "</td><td>" + list[i].remark+"<button type='button' class='btn btn-info' onclick='dealReject(\""+list[i].remark + "\")'>处理</button>";
				str += "</td><td>" + list[i].ctime;
				str += "</td></tr>";
			}
			$("#orderTable tbody").html(str);
		}
		
		function dealReject(remark){
			$.ajax({
				 url:"${wmsUrl}/admin/order/updateReject.shtml",
				 type:'post',
				 data:{"remark":remark},
				 dataType:'json',
				 success:function(data){
					 if(data.success){	
						 $.zzComfirm.alertSuccess("处理成功");
						 //window.location.reload();
						 $.page.loadData(options);
					 }else{
						 $.zzComfirm.alertError(data.msg);
					 }
				 },
				 error:function(){
					 $.zzComfirm.alertError("系统出现问题啦，快叫技术人员处理");
				 }
			 });
		}
		
		function showSuppiler(){
		    var frameSrc = "${wmsUrl}/admin/basic/sellerInfo/showDetail.shtml";
		    $("#supplierIFrame").attr("src", frameSrc);
		    $('#supplierModal').modal({ show: true, backdrop: 'static' });
		}

		function closeSupModal(){
			$('#supplierModal').modal('hide');
		}
</script>
