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
<title>出库业务</title>
<%@include file="../../resource.jsp"%>
</head>

<body>
	<div id="page-wrapper">

		<div class="container-fluid">
			<!-- Page Heading -->
			<div class="row">
				<div class="col-lg-12">
					<ol class="breadcrumb">
						<li><i class="fa fa-book fa-fw"></i>出库业务</li>
						<li class="active"><i class="fa fa-bookmark fa-fw"></i>绑定空包</li>
					</ol>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="query">
						<div class="row">
							<div class="form-group">
								<label>订单编号</label> <input type="text" class="form-control"
									name="orderCode" id="orderCode">
							</div>
							<div class="form-group">
								<label>商家编号</label> 
								<input type="text"  class="form-control" name="supplierId" id="supplierId">
								<button type="button" btnId="supQuery" class="btn btn-warning" onclick="showSuppiler()">查找商家</button>
							</div>
							<div class="form-group">
								<label>商家名称</label> 
								<input type="text" forBtn="supQuery" class="form-control" name="supplierName" id="supplierName">
							</div>
							<div class="form-group">
								<label>处理状态</label> <select class="form-control" name="state">
									<option value="">全部</option>
									<option value="0" selected="selected">未处理</option>
									<option value="1">已处理</option>
								</select>
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
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">
								<i class="fa fa-bar-chart-o fa-fw"></i>空包订单列表
							</h3>
						</div>
						<div class="panel-body">
							<c:if test="${privilege>=2}">
								<button type="button" class="btn btn-primary" onclick="showAddModal()">新增</button>
								<button type="button" class="btn btn-warning" onclick="showUpdModal()">更新</button>
							</c:if>
							<c:if test="${privilege==3}">
								<button type="button" class="btn btn-danger" onclick="delRecord()">删除</button>
							</c:if>
							<table id="emptyRecordTable" class="table table-hover">
								<thead>
									<tr>
										<th>选中</th>
										<th>编号</th>
										<th>订单编号</th>
										<th>处理状态</th>
										<th>商家编号</th>
										<th>商家名称</th>
										<th>操作人</th>
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
	<div class="modal fade" id="addModal" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true" onclick="closeAddModal()">&times;</button>
					<h4 class="modal-title" id="modelTitle">新增空包订单</h4>
				</div>
				<div class="modal-body">
					<iframe id="addIFrame" width="100%" height="100%"></iframe>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="saveRecordBtn">新增</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal"
						onclick="closeAddModal()">关闭</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="updModal" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog" >
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true" onclick="closeUpdModal()">&times;</button>
					<h4 class="modal-title" id="modelTitle">更新空包订单</h4>
				</div>
				<div class="modal-body">
					<iframe id="updIFrame" width="100%" height="100%"></iframe>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="updRecordBtn">更新</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal"
						onclick="closeUpdModal()">关闭</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="supplierModal" tabindex="-1" role="dialog" aria-hidden="true">
	   <div class="modal-dialog">
	      <div class="modal-content">
	         <div class="modal-header">
	            <button type="button" class="close"  aria-hidden="true" data-dismiss="modal" onclick="closeSupModal()">&times;</button>
	         	<h4 class="modal-title" id="modelTitle">商家选择</h4>
	         </div>
	         <div class="modal-body">
	         	<iframe id="supplierIFrame" width="100%" height="100%" frameborder="0"></iframe>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeSupModal()">取消 </button>
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
			url : "${wmsUrl}/admin/secret/empty/dataList.shtml",
			numPerPage : "10",
			currentPage : "",
			index : "1",
			callback : rebuildTable
		}

		$(function() {
			$(".pagination-nav").pagination(options);

			//新增功能
			$("#saveRecordBtn")
					.click(
							function() {
								var orderCode = $("#addIFrame").contents()
										.find("#orderCode").val().trim();
								if (orderCode == "") {
									$.zzComfirm.alertError("未输入订单编号");
									return;
								}
								var supplierId = $("#addIFrame").contents()
										.find("#supplierId").val().trim();
								if (supplierId == "") {
									$.zzComfirm.alertError("未选择对应商家");
									return;
								}
								var supplierName = $("#addIFrame").contents()
										.find("#supplierName").val().trim();
								var state = $("#addIFrame").contents().find(
										"#state").val();

								$
										.ajax({
											type : "post",
											data : {
												'orderCode' : orderCode,
												'supplierid' : supplierId,
												'suppliername' : supplierName,
												'state' : state
											},
											dataType : 'json',
											url : '${wmsUrl}/admin/secret/empty/saveEmptyRecord.shtml',
											success : function(data) {
												if (data.success) {
													$.zzComfirm
															.alertSuccess("操作成功！");
													$("#addModal")
															.modal('hide');
													$("#querybtns").trigger(
															"click");
												} else {
													$.zzComfirm
															.alertError(data.msg);
												}
											},
											error : function(data) {
												$.zzComfirm
														.alertError("操作失败，请联系管理员！");
											}
										});
								return false;
							});

			//更新功能
			$("#updRecordBtn")
					.click(
							function() {
								var id = $("#updIFrame").contents().find("#id")
										.val().trim();
								if (id == "") {
									$.zzComfirm.alertError("网络异常，请退出页面后重试");
									return;
								}
								var orderCode = $("#updIFrame").contents()
										.find("#orderCode").val().trim();
								if (orderCode == "") {
									$.zzComfirm.alertError("未输入订单编号");
									return;
								}

								$
										.ajax({
											type : "post",
											data : {
												'id' : id,
												'orderCode' : orderCode
											},
											dataType : 'json',
											url : '${wmsUrl}/admin/secret/empty/editRecord.shtml',
											success : function(data) {
												if (data.success) {
													$.zzComfirm
															.alertSuccess("操作成功！");
													$("#updModal")
															.modal('hide');
													$("#querybtns").trigger(
															"click");
												} else {
													$.zzComfirm
															.alertError(data.msg);
												}
											},
											error : function(data) {
												$.zzComfirm
														.alertError("操作失败，请联系管理员！");
											}
										});
								return false;
							});
		})

		/**
		 * 重构table
		 */
		function rebuildTable(data) {
			$("#emptyRecordTable tbody").html("");

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
				str += "<tr><td align='left'><input type='checkbox' id='check' name='check' onclick='switchCheck($(this))'";
				str += "</td><td align='left'>" + list[i].id;
				str += "</td><td align='left'>" + list[i].orderCode;
				switch (list[i].state) {
				case "0":
					strCom = "未处理";
					break;
				case "1":
					strCom = "已处理";
					break;
				}
				str += "</td><td align='left'>" + strCom;
				str += "</td><td align='left'>" + list[i].supplierid;
				str += "</td><td align='left'>" + list[i].suppliername;
				str += "</td><td align='left'>" + list[i].opt;
				str += "</td><td align='left'>" + list[i].ctime;
				str += "</td></tr>";
			}

			$("#emptyRecordTable tbody").htmlUpdate(str);
		}

		function switchCheck(e) {
			if (!$(e).is(':checked')) {
				return;
			}
			$("[name='check']").removeAttr("checked");
			$(e).prop("checked", true);
			return;
		}

		function showAddModal() {
			var frameSrc = "${wmsUrl}/admin/secret/empty/addRecord.shtml";
			$("#addIFrame").attr("src", frameSrc);
			$('#addModal').modal({
				show : true,
				backdrop : 'static'
			});
		}

		function delRecord() {
			var _idx = null;
			$("input[id^='check']").each(function() {
				if ($(this).is(':checked')) {
					_idx = $(this).parent().next().text();
				}
			});
			if (_idx == null) {
				alert("请选择要删除的记录");
				return;
			}
			if (!check()) {
				return;
			}
			$.ajax({
				type : 'POST',
				url : "${wmsUrl}/admin/secret/empty/delEmptyRecord.shtml",
				data : {
					id : _idx
				},
				success : function(data) {
					if (data.success) {
						$.zzComfirm.alertSuccess("操作成功！");
						$("#querybtns").trigger("click");
					} else {
						$.zzComfirm.alertError(data.msg);
					}
				},
				error : function(data) {
					$.zzComfirm.alertError("操作失败，请联系管理员！");
				},
				dataType : 'json'
			});
		}

		function check() {
			var cf = confirm("数据删除后将彻底消失，确认删除吗？");
			if (cf == false) {
				return false;
			} else {
				return true;
			}
		}

		function showUpdModal() {
			var _idx = null;
			var _state = null;
			$("input[id^='check']").each(function() {
				if ($(this).is(':checked')) {
					_idx = $(this).parent().next().text();
					_state = $(this).parent().next().next().next().text();
				}
			});
			if (_idx == null) {
				alert("请选择要更新的记录");
				return;
			}
			if (_state == "已处理") {
				alert("已处理的订单无法进行更新");
				return;
			}
			var frameSrc = "${wmsUrl}/admin/secret/empty/updRecord.shtml?id="
					+ _idx;
			$("#updIFrame").attr("src", frameSrc);
			$('#updModal').modal({
				show : true,
				backdrop : 'static'
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
		
		function closeUpdModal(){
			$('#updModal').modal('hide');
		}
		
		function closeAddModal(){
			$('#addModal').modal('hide');
		}
	</script>
</body>
</html>
