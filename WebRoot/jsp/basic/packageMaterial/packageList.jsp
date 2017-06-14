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
<title>包材管理</title>
<%@include file="../../resource.jsp"%>
</head>

<body>
	<div id="page-wrapper">

		<div class="container-fluid">
			<!-- Page Heading -->
			<div class="row">
				<div class="col-lg-12">
					<ol class="breadcrumb">
						<li><i class="fa fa-book fa-fw"></i>在库业务</li>
						<li class="active"><i class="fa fa-bookmark fa-fw"></i>包材管理</li>
					</ol>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="query">
						<div class="row">
							<div class="form-group">
								<label>包材编码</label> 
								<select name="id" id="id" class="form-control span2">
						   			<option value="" selected="selected" >全部</option>
						   			<c:forEach items="${packageList}" var="item">
						  	 			<option value="${item.packageId}">${item.packageId}</option>
						   			</c:forEach>
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
						<div class="row">
							<div class="form-group">
							<c:if test="${privilege>=2}">
								<button type="button" class="btn btn-primary"
									onclick="showAddModal()">新增</button>
								<button type="button" class="btn btn-warning"
									onclick="showUpdModal()">更新</button>
								<button type="button" class="btn btn-info"
									onclick="printRecord()">打印条码</button>
								<button type="button" class="btn btn-warning"
									onclick="showEditModal()">维护数量</button>
							</c:if>
							<c:if test="${privilege==3}">
								<button type="button" class="btn btn-danger"
									onclick="delRecord()">删除</button>
							</c:if>
							</div>
						</div>
						<div class="panel-heading">
							<h3 class="panel-title">
								<i class="fa fa-bar-chart-o fa-fw"></i>包材列表
							</h3>
						</div>
						<div class="panel-body">
							<table id="packageTable" class="table table-hover">
								<thead>
									<tr>
										<th>选中</th>
										<th>包材编码</th>
										<th>包材名称</th>
										<th>包材规格</th>
										<th>长</th>
										<th>宽</th>
										<th>高</th>
										<th>体积</th>
										<th>重量</th>
										<th>状态</th>
										<th>总数量</th>
										<th>当月新增数量</th>
										<th>当月使用数量</th>
										<th>剩余数量</th>
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
	<div class="modal fade" id="addModal" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true" onclick="closeAddModal()">&times;</button>
					<h4 class="modal-title" id="modelTitle">新增包材信息</h4>
				</div>
				<div class="modal-body">
					<iframe id="addIFrame" width="100%" height="100%"></iframe>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="savePackageBtn">新增</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal"
						onclick="closeAddModal();">关闭</button>
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
					<h4 class="modal-title" id="modelTitle">更新包材信息</h4>
				</div>
				<div class="modal-body">
					<iframe id="updIFrame" width="100%" height="100%"></iframe>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="updPackageBtn">更新</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal"
						onclick="closeUpdModal()">关闭</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="editModal" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true" onclick="closeEditModal()">&times;</button>
					<h4 class="modal-title" id="modelTitle">维护包材数量</h4>
				</div>
				<div class="modal-body">
					<iframe id="editIFrame" width="100%" height="100%"></iframe>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="editPackageBtn">维护</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal"
						onclick="closeEditModal()">关闭</button>
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
			url : "${wmsUrl}/admin/basic/packageMaterial/dataList.shtml",
			numPerPage : "10",
			currentPage : "",
			index : "1",
			callback : rebuildTable
		}
		
		function closeAddModal(){
			$("#addModal").modal("hide");
		}
		
		function closeUpdModal(){
			$("#updModal").modal("hide");
		}
		
		function closeEditModal(){
			$("#editModal").modal("hide");
		}

		$(function() {
			$(".pagination-nav").pagination(options);

			//新增功能
			$("#savePackageBtn").click(
				function() {
					var packageId = $("#addIFrame").contents().find("#packageId").val();
					var packageName = $("#addIFrame").contents().find("#packageName").val();
					var packageSpec = $("#addIFrame").contents().find("#packageSpec").val();
					var status = $("#addIFrame").contents().find("#status").val();
					
					var packageLength = $("#addIFrame").contents().find("#packageLength").val();
					var packageWidth = $("#addIFrame").contents().find("#packageWidth").val();
					var packageHeight = $("#addIFrame").contents().find("#packageHeight").val();
					var packageWeight = $("#addIFrame").contents().find("#packageWeight").val();
					var remark = $("#addIFrame").contents().find("#remark").val();
					
					if (packageId == "") {
						$.zzComfirm.alertError("未输入包材编码");
						return;
					}
					if (packageName == "") {
						$.zzComfirm.alertError("未输入包材名称");
						return;
					}
					if (packageSpec == "") {
						$.zzComfirm.alertError("未输入包材规格");
						return;
					}
					
					if (packageLength == "") {
						$.zzComfirm.alertError("未输入包材长度");
						return;
					}
					if (packageWidth == "") {
						$.zzComfirm.alertError("未输入包材宽度");
						return;
					}
					if (packageHeight == "") {
						$.zzComfirm.alertError("未输入包材高度");
						return;
					}
					if (packageWeight == "") {
						$.zzComfirm.alertError("未输入包材重量");
						return;
					}
					
					$.ajax({
						type : "post",
						data : {
							'packageId' : packageId,
							'packageName' : packageName,
							'packageSpec' : packageSpec,
							'status' : status,
							'packageLength' : packageLength,
							'packageWidth' : packageWidth,
							'packageHeight' : packageHeight,
							'packageWeight' : packageWeight,
							'remark' : remark
						},
						dataType : 'json',
						url : '${wmsUrl}/admin/basic/packageMaterial/savePackage.shtml',
						success : function(data) {
							if (data.success) {
								$.zzComfirm.alertSuccess("操作成功！");
								$("#addModal").modal('hide');
								$("#querybtns").trigger("click");
							} else {
								$.zzComfirm.alertError(data.msg);
							}
						},
						error : function(data) {
							$.zzComfirm.alertError("操作失败，请联系管理员！");
						}
					});
					return false;
				});

			//更新功能
			$("#updPackageBtn").click(
				function() {
					var packageId = $("#updIFrame").contents().find("#packageId").val();
					var packageName = $("#updIFrame").contents().find("#packageName").val();
					var packageSpec = $("#updIFrame").contents().find("#packageSpec").val();
					var status = $("#updIFrame").contents().find("#status").val();
					
					var packageLength = $("#updIFrame").contents().find("#packageLength").val();
					var packageWidth = $("#updIFrame").contents().find("#packageWidth").val();
					var packageHeight = $("#updIFrame").contents().find("#packageHeight").val();
					var packageWeight = $("#updIFrame").contents().find("#packageWeight").val();
					var remark = $("#updIFrame").contents().find("#remark").val();
					
					if (packageName == "") {
						$.zzComfirm.alertError("未输入包材名称");
						return;
					}
					if (packageSpec == "") {
						$.zzComfirm.alertError("未输入包材规格");
						return;
					}
					
					if (packageLength == "") {
						$.zzComfirm.alertError("未输入包材长度");
						return;
					}
					if (packageWidth == "") {
						$.zzComfirm.alertError("未输入包材宽度");
						return;
					}
					if (packageHeight == "") {
						$.zzComfirm.alertError("未输入包材高度");
						return;
					}
					if (packageWeight == "") {
						$.zzComfirm.alertError("未输入包材重量");
						return;
					}
					
					$.ajax({
						type : "post",
						data : {
							'packageId' : packageId,
							'packageName' : packageName,
							'packageSpec' : packageSpec,
							'status' : status,
							'packageLength' : packageLength,
							'packageWidth' : packageWidth,
							'packageHeight' : packageHeight,
							'packageWeight' : packageWeight,
							'remark' : remark
						},
						dataType : 'json',
						url : '${wmsUrl}/admin/basic/packageMaterial/editPackage.shtml',
						success : function(data) {
							if (data.success) {
								$.zzComfirm.alertSuccess("操作成功！");
								$("#updModal").modal('hide');
								$("#querybtns").trigger("click");
							} else {
								$.zzComfirm.alertError(data.msg);
							}
						},
						error : function(data) {
							$.zzComfirm.alertError("操作失败，请联系管理员！");
						}
					});
					return false;
				});

			//维护功能
			$("#editPackageBtn").click(
				function() {
					var packageId = $("#editIFrame").contents().find("#packageId").val();
					var packageQty = $("#editIFrame").contents().find("#packageQty").val();
					
					if (packageQty == "") {
						$.zzComfirm.alertError("未输入包材数量");
						return;
					}
					
					$.ajax({
						type : "post",
						data : {
							'packageId' : packageId,
							'dymqty' : packageQty
						},
						dataType : 'json',
						url : '${wmsUrl}/admin/basic/packageMaterial/savePackageNum.shtml',
						success : function(data) {
							if (data.success) {
								$.zzComfirm.alertSuccess("操作成功！");
								$("#editModal").modal('hide');
								$("#querybtns").trigger("click");
							} else {
								$.zzComfirm.alertError(data.msg);
							}
						},
						error : function(data) {
							$.zzComfirm.alertError("操作失败，请联系管理员！");
						}
					});
					return false;
				});
		})

		/**
		 * 重构table
		 */
		function rebuildTable(data) {
			$("#packageTable tbody").html("");

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
				str += "</td><td align='left'>" + list[i].packageId;
				str += "</td><td align='left'>" + list[i].packageName;
				str += "</td><td align='left'>" + list[i].packageSpec;
				str += "</td><td align='left'>" + list[i].packageLength;
				str += "</td><td align='left'>" + list[i].packageWidth;
				str += "</td><td align='left'>" + list[i].packageHeight;
				str += "</td><td align='left'>" + list[i].packageVolume;
				str += "</td><td align='left'>" + list[i].packageWeight;
				switch (list[i].status) {
				case 0:
					strCom = "使用";
					break;
				case 1:
					strCom = "停用";
					break;
				}
				str += "</td><td align='left'>" + strCom;
				str += "</td><td align='left'>" + list[i].qty;
				str += "</td><td align='left'>" + list[i].dymqty;
				str += "</td><td align='left'>" + list[i].dyyqty;
				str += "</td><td align='left'>" + list[i].existqty;
				str += "</td><td align='left'>" + list[i].opt;
				str += "</td></tr>";
			}

			$("#packageTable tbody").htmlUpdate(str);
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
			var frameSrc = "${wmsUrl}/admin/basic/packageMaterial/addPackage.shtml";
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
				url : "${wmsUrl}/admin/basic/packageMaterial/delPackage.shtml",
				data : {
					packageId : _idx
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
			$("input[id^='check']").each(function() {
				if ($(this).is(':checked')) {
					_idx = $(this).parent().next().text();
				}
			});
			if (_idx == null) {
				alert("请选择要更新的记录");
				return;
			}
			var frameSrc = "${wmsUrl}/admin/basic/packageMaterial/updPackage.shtml?packageId=" + _idx;
			$("#updIFrame").attr("src", frameSrc);
			$('#updModal').modal({
				show : true,
				backdrop : 'static'
			});
		}

		function showEditModal() {
			var _idx = null;
			$("input[id^='check']").each(function() {
				if ($(this).is(':checked')) {
					_idx = $(this).parent().next().text();
				}
			});
			if (_idx == null) {
				alert("请选择要维护的记录");
				return;
			}
			var frameSrc = "${wmsUrl}/admin/basic/packageMaterial/editPackageNum.shtml?packageId=" + _idx;
			$("#editIFrame").attr("src", frameSrc);
			$('#editModal').modal({
				show : true,
				backdrop : 'static'
			});
		}

		function printRecord() {
			var _idx = null;
			var libno = null;
			$("input[id^='check']").each(
					function() {
						if ($(this).is(':checked')) {
							_idx = $(this).parent().next().text();
						}
					});
			if (_idx == null) {
				alert("请选择要打印的记录");
				return;
			}

			var left1 = (screen.width - 600) / 2;
			var top1 = (screen.height - 450) / 2;
			var barCode = _idx;
			barCode = encodeURI(encodeURI(barCode));

			window.open('${wmsUrl}/admin/basic/library/placeManage/pdfjsp.shtml?barCode='+ barCode, "","width=1400,height=700,resizable=yes,location=no,scrollbars=yes,left="+ left1.toString() + ",top=" + top1.toString());
		}
	</script>
</body>
</html>
