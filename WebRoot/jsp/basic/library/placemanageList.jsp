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
<title>仓位管理</title>
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
						<li class="active"><i class="fa fa-bookmark fa-fw"></i>仓位管理</li>
					</ol>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="query">
						<div class="row">
							<div class="form-group">
								<label>仓库位置</label> <select class="form-control" name="depart">
									<option value="" selected="selected">全部</option>
									<option value="ZC1">出口区一楼</option>
									<option value="ZC2">出口区二楼</option>
								</select> <label>区域</label> <input type="text" class="form-control"
									name="direction"> <label>仓位状态</label> <select
									class="form-control" name="status">
									<option value="" selected="selected">全部</option>
									<option value="1">可用</option>
									<option value="2">不可用</option>
								</select> <label>类型</label> <select class="form-control" name="type"
									id="type">
									<option value="" selected="selected">全部</option>
									<option value="1">良品库</option>
									<option value="2">不良品库</option>
									<option value="3">待货区</option>
									<option value="4">撤单区</option>
									<option value="5">空包区</option>
									<option value="6">虚拟仓</option>
									<option value="7">差异区</option>
								</select>
							</div>
							<div class="form-group" id="switchQpType" style="display: none">
								<label>良品区类型</label> <select class="form-control" name="qptype">
									<option value="" selected="selected">全部</option>
									<option value="1">存储区</option>
									<option value="2">拣货区</option>
								</select>
							</div>
							<div class="form-group">
								<button type="button" id="querybtns" class="btn btn-primary">查询</button>
							</div>
						</div>
						<div class="row">
							<div class="form-group">
								<label>排</label> <input type="text" class="form-control"
									name="arrange">
								<label>&nbsp;&nbsp;&nbsp;层</label> <input type="text" class="form-control"
									name="storey">
								<label>&nbsp;&nbsp;&nbsp;列</label> <input type="text" class="form-control"
									name="lump">
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
							</c:if>
							<c:if test="${privilege==3}">
								<button type="button" class="btn btn-danger"
									onclick="delRecord()">删除</button>
							</c:if>
							</div>
						</div>
						<div class="panel-heading">
							<h3 class="panel-title">
								<i class="fa fa-bar-chart-o fa-fw"></i>仓位列表
							</h3>
						</div>
						<div class="panel-body">
							<table id="libraryTable" class="table table-hover">
								<thead>
									<tr>
										<th>选中</th>
										<th>仓位编号</th>
										<th>仓位状态</th>
										<th>类型</th>
										<th>良品库类型</th>
										<th>仓库位置</th>
										<th>区域</th>
										<th>排</th>
										<th>层</th>
										<th>列</th>
										<th>仓位名称</th>
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
					<h4 class="modal-title" id="modelTitle">新增仓位信息</h4>
				</div>
				<div class="modal-body">
					<iframe id="addIFrame" width="100%" height="100%"></iframe>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="saveLibraryBtn">新增</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal"
						onclick="closeAddModal();">关闭</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="updModal" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true" onclick="closeUpdModal()">&times;</button>
					<h4 class="modal-title" id="modelTitle">更新仓位信息</h4>
				</div>
				<div class="modal-body">
					<iframe id="updIFrame" width="100%" height="100%"></iframe>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="updLibraryBtn">更新</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal"
						onclick="closeUpdModal()">关闭</button>
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
			url : "${wmsUrl}/admin/basic/library/placeManage/dataList.shtml",
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

		$(function() {
			$(".pagination-nav").pagination(options);

			//新增功能
			$("#saveLibraryBtn")
					.click(
							function() {
								var status = $("#addIFrame").contents().find(
										"#status").val();
								var type = $("#addIFrame").contents().find(
										"#type").val();
								var qptype = $("#addIFrame").contents().find(
										"#qptype").val();
								var depart = $("#addIFrame").contents().find(
										"#depart").val();
								var lattice = $("#addIFrame").contents().find(
										"#lattice").val();

								var direction = $("#addIFrame").contents()
										.find("#direction").val();
								if (direction == "") {
									$.zzComfirm.alertError("未输入仓库区域");
									return;
								}

								var arrange = $("#addIFrame").contents().find(
										"#arrange").val();
								if (arrange == "") {
									$.zzComfirm.alertError("未输入排");
									return;
								}

								var storey = $("#addIFrame").contents().find(
										"#storey").val();
								if (storey == "") {
									$.zzComfirm.alertError("未输入层");
									return;
								}

								var lump = $("#addIFrame").contents().find(
										"#lump").val();
								if (lump == "") {
									$.zzComfirm.alertError("未输入列");
									return;
								}

								$
										.ajax({
											type : "post",
											data : {
												'status' : status,
												'type' : type,
												'qptype' : qptype,
												'depart' : depart,
												'lattice' : lattice,
												'direction' : direction,
												'arrange' : arrange,
												'storey' : storey,
												'lump' : lump
											},
											dataType : 'json',
											url : '${wmsUrl}/admin/basic/library/placeManage/saveLibrary.shtml',
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
			$("#updLibraryBtn")
					.click(
							function() {
								var libid = $("#updIFrame").contents().find(
										"#libid").val();
								var status = $("#updIFrame").contents().find(
										"#status").val();
								var type = $("#updIFrame").contents().find(
										"#type").val();
								var qptype = $("#updIFrame").contents().find(
										"#qptype").val();
								var depart = $("#updIFrame").contents().find(
										"#depart").val();
								var lattice = $("#updIFrame").contents().find(
										"#lattice").val();

								var direction = $("#updIFrame").contents()
										.find("#direction").val();
								if (direction == "") {
									$.zzComfirm.alertError("未输入仓库区域");
									return;
								}

								var arrange = $("#updIFrame").contents().find(
										"#arrange").val();
								if (arrange == "") {
									$.zzComfirm.alertError("未输入排");
									return;
								}

								var storey = $("#updIFrame").contents().find(
										"#storey").val();
								if (storey == "") {
									$.zzComfirm.alertError("未输入层");
									return;
								}

								var lump = $("#updIFrame").contents().find(
										"#lump").val();
								if (lump == "") {
									$.zzComfirm.alertError("未输入列");
									return;
								}

								$
										.ajax({
											type : "post",
											dataType : 'json',
											data : {
												'id' : libid,
												'status' : status,
												'type' : type,
												'qptype' : qptype,
												'depart' : depart,
												'lattice' : lattice,
												'direction' : direction,
												'arrange' : arrange,
												'storey' : storey,
												'lump' : lump
											},
											dataType : 'json',
											url : '${wmsUrl}/admin/basic/library/placeManage/editLibrary.shtml',
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
			$("#libraryTable tbody").html("");

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
				switch (list[i].status) {
				case "1":
					strCom = "可用";
					break;
				case "2":
					strCom = "不可用";
					break;
				}
				str += "</td><td align='left'>" + strCom;
				switch (list[i].type) {
				case "1":
					strCom = "良品库";
					break;
				case "2":
					strCom = "不良品库";
					break;
				case "3":
					strCom = "待货区";
					break;
				case "4":
					strCom = "撤单区";
					break;
				case "5":
					strCom = "空包区";
					break;
				case "6":
					strCom = "虚拟仓";
					break;
				case "7":
					strCom = "差异区";
					break;
				}
				str += "</td><td align='left'>" + strCom;
				switch (list[i].qptype) {
				case "1":
					strCom = "存储区";
					break;
				case "2":
					strCom = "拣货区";
					break;
				}
				str += "</td><td align='left'>" + strCom;
				switch (list[i].depart) {
				case "ZC1":
					strCom = "出口区一楼";
					break;
				case "ZC2":
					strCom = "出口区二楼";
					break;
				}
				str += "</td><td align='left'>" + strCom;
				str += "</td><td align='left'>" + list[i].direction;
				str += "</td><td align='left'>" + list[i].arrange;
				str += "</td><td align='left'>" + list[i].storey;
				str += "</td><td align='left'>" + list[i].lump;
				str += "</td><td align='left'>" + list[i].libno;
				str += "</td></tr>";
			}

			$("#libraryTable tbody").htmlUpdate(str);
		}

		function switchCheck(e) {
			if (!$(e).is(':checked')) {
				return;
			}
			$("[name='check']").removeAttr("checked");
			$(e).prop("checked", true);
			return;
		}

		$("#type").on('change', function() {
			var select = $("#type option:selected").val();
			if (select == '1') {
				$("#switchQpType").show();
				return;
			} else {
				$("#switchQpType").hide();
				return;
			}
		});

		function showAddModal() {
			var frameSrc = "${wmsUrl}/admin/basic/library/placeManage/addLibrary.shtml";
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
			$
					.ajax({
						type : 'POST',
						url : "${wmsUrl}/admin/basic/library/placeManage/delLibrary.shtml",
						data : {
							libid : _idx
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
			var frameSrc = "${wmsUrl}/admin/basic/library/placeManage/updLibrary.shtml?libid="
					+ _idx;
			$("#updIFrame").attr("src", frameSrc);
			$('#updModal').modal({
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
							libno = $(this).parent().next().next().next()
									.next().next().next().next().next().next()
									.next().text();
						}
					});
			if (_idx == null) {
				alert("请选择要打印的记录");
				return;
			}

			var left1 = (screen.width - 600) / 2;
			var top1 = (screen.height - 450) / 2;
			var barCode = libno;
			barCode = encodeURI(encodeURI(barCode));

			window.open(
					'${wmsUrl}/admin/basic/library/placeManage/pdfjsp.shtml?barCode='
							+ barCode, "",
					"width=1400,height=700,resizable=yes,location=no,scrollbars=yes,left="
							+ left1.toString() + ",top=" + top1.toString());
		}
	</script>
</body>
</html>
