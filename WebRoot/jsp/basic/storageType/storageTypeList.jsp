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
<title>存储类型</title>
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
						<li class="active"><i class="fa fa-bookmark fa-fw"></i>存储类型</li>
					</ol>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="query">
						<div class="row" >
							<div class="form-group">
								<label>类型编码</label> <input type="text" class="form-control"
									name="code" id="code">
							</div>
							<div class="form-group">
								<label>类型名称</label> <input type="text" class="form-control"
									name="storageName" id="storageName">
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
						<div class="row" >
							<div class="form-group">
							<c:if test="${privilege>=2}">
								<button type="button" class="btn btn-primary" onclick="showAddModal()">新增</button>
								<button type="button" class="btn btn-warning" onclick="showUpdModal()">更新</button>
							</c:if>
							<c:if test="${privilege==3}">
								<button type="button" class="btn btn-danger" onclick="delRecord()">删除</button>
							</c:if>
							</div>
						</div>
						<div class="panel-heading">
							<h3 class="panel-title">
								<i class="fa fa-bar-chart-o fa-fw"></i>存储类型列表
							</h3>
						</div>
						<div class="panel-body">
							<table id="storageTypeTable" class="table table-hover">
								<thead>
									<tr>
										<th>选中</th>
										<th>编号</th>
										<th>类型编码</th>
										<th>类型名称</th>
										<th>长</th>
										<th>宽</th>
										<th>高</th>
										<th>操作人</th>
										<th>创建时间</th>
										<th>修改时间</th>
										<th>备注</th>
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
		<div class="modal-dialog" >
			<div class="modal-content" >
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true" onclick="closeAddModal()">&times;</button>
					<h4 class="modal-title" id="modelTitle">新增存储类型</h4>
				</div>
				<div class="modal-body" >
					<iframe id="addIFrame" width="100%" height="100%"></iframe>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="saveStorageBtn">新增</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal"
						onclick="closeAddModal()">关闭</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="updModal" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog" >
			<div class="modal-content" >
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true" onclick="closeUpdModal()">&times;</button>
					<h4 class="modal-title" id="modelTitle">更新存储类型</h4>
				</div>
				<div class="modal-body" >
					<iframe id="updIFrame" width="100%" height="100%"></iframe>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="updStorageBtn">更新</button>
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
			url : "${wmsUrl}/admin/basic/stor/dataList.shtml",
			numPerPage : "10",
			currentPage : "",
			index : "1",
			callback : rebuildTable
		}
		
		function closeAddModal(){
			$('#addModal').modal('hide');
		}
		
		function closeUpdModal(){
			$('#updModal').modal('hide');
		}

		$(function() {
			$(".pagination-nav").pagination(options);

			//新增功能
			$("#saveStorageBtn")
					.click(
							function() {
								var code = $("#addIFrame").contents().find(
										"#code").val().trim();
								if (code == "") {
									$.zzComfirm.alertError("未输入类型编码");
									return;
								}
								var storageName = $("#addIFrame").contents()
										.find("#storageName").val().trim();
								if (storageName == "") {
									$.zzComfirm.alertError("未输入类型名称");
									return;
								}
								var length = $("#addIFrame").contents().find(
										"#length").val();
								if (length == "") {
									$.zzComfirm.alertError("未输入长度");
									return;
								}
								var width = $("#addIFrame").contents().find(
										"#width").val();
								if (width == "") {
									$.zzComfirm.alertError("未输入宽度");
									return;
								}
								var height = $("#addIFrame").contents().find(
										"#height").val();
								if (height == "") {
									$.zzComfirm.alertError("未输入高度");
									return;
								}
								var remark = $("#addIFrame").contents().find(
										"#remark").val();

								$
										.ajax({
											type : "post",
											data : {
												'code' : code,
												'storageName' : storageName,
												'length' : length,
												'width' : width,
												'height' : height,
												'remark' : remark
											},
											dataType : 'json',
											url : '${wmsUrl}/admin/basic/stor/saveStorageType.shtml',
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
			$("#updStorageBtn")
					.click(
							function() {
								var id = $("#updIFrame").contents().find("#id")
										.val().trim();
								if (id == "") {
									$.zzComfirm.alertError("网络异常，请退出页面后重试");
									return;
								}
								var code = $("#updIFrame").contents().find(
										"#code").val().trim();
								if (code == "") {
									$.zzComfirm.alertError("未输入类型编码");
									return;
								}
								var storageName = $("#updIFrame").contents()
										.find("#storageName").val().trim();
								if (storageName == "") {
									$.zzComfirm.alertError("未输入类型名称");
									return;
								}
								var length = $("#updIFrame").contents().find(
										"#length").val();
								if (length == "") {
									$.zzComfirm.alertError("未输入长度");
									return;
								}
								var width = $("#updIFrame").contents().find(
										"#width").val();
								if (width == "") {
									$.zzComfirm.alertError("未输入宽度");
									return;
								}
								var height = $("#updIFrame").contents().find(
										"#height").val();

								if (height == "") {
									$.zzComfirm.alertError("未输入高度");
									return;
								}
								var remark = $("#updIFrame").contents().find(
										"#remark").val();

								$
										.ajax({
											type : "post",
											data : {
												'id' : id,
												'code' : code,
												'storageName' : storageName,
												'length' : length,
												'width' : width,
												'height' : height,
												'remark' : remark
											},
											dataType : 'json',
											url : '${wmsUrl}/admin/basic/stor/editStorageType.shtml',
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
			$("#storageTypeTable tbody").html("");

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
				str += "<tr><td align='left'><input type='checkbox' id='check' name='check' onclick='switchCheck($(this))'";
				str += "</td><td align='left'>" + list[i].id;
				str += "</td><td align='left'>" + list[i].code;
				str += "</td><td align='left'>" + list[i].storageName;
				str += "</td><td align='left'>" + list[i].length;
				str += "</td><td align='left'>" + list[i].width;
				str += "</td><td align='left'>" + list[i].height;
				str += "</td><td align='left'>" + list[i].opt;
				str += "</td><td align='left'>" + list[i].createTime;
				str += "</td><td align='left'>" + list[i].updateTime;
				str += "</td><td align='left'>" + list[i].remark;
				str += "</td></tr>";
			}

			$("#storageTypeTable tbody").htmlUpdate(str);
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
			var frameSrc = "${wmsUrl}/admin/basic/stor/addStorage.shtml";
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
				url : "${wmsUrl}/admin/basic/stor/delStorageType.shtml",
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
			$("input[id^='check']").each(function() {
				if ($(this).is(':checked')) {
					_idx = $(this).parent().next().text();
				}
			});
			if (_idx == null) {
				alert("请选择要更新的记录");
				return;
			}
			var frameSrc = "${wmsUrl}/admin/basic/stor/updStorage.shtml?id="
					+ _idx;
			$("#updIFrame").attr("src", frameSrc);
			$('#updModal').modal({
				show : true,
				backdrop : 'static'
			});
		}
	</script>
</body>
</html>
