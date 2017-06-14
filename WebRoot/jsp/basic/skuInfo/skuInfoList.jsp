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
<title>商品管理</title>
<%@include file="../../resource.jsp"%>
</head>

<body>
	<div id="page-wrapper">

		<div class="container-fluid">
			<!-- Page Heading -->
			<div class="row">
				<div class="col-lg-12">
					<ol class="breadcrumb">
						<li><i class="fa fa-book fa-fw"></i>商品管理</li>
						<li class="active"><i class="fa fa-bookmark fa-fw"></i>商品信息</li>
					</ol>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="query">
						<div class="row">
							<div class="form-group">
								<label>货主编号</label> <input type="text" class="form-control"
									name="ownerUserId" id="ownerUserId">
							</div>
							<div class="form-group">
								<label>商品编号</label> <input type="text" class="form-control"
									name="itemId" id="itemId">
							</div>
							<div class="form-group">
								<label>商品编码</label> <input type="text" class="form-control"
									name="itemCode" id="itemCode">
							</div>
							<div class="form-group">
								<label>货号</label> <input type="text" class="form-control"
									name="sku" id="sku">
							</div>
						</div>
						<div class="row">
							<div class="form-group">
								<label>店铺编号</label> <input type="text" class="form-control"
									name="shopId" id="ownerUserId">
							</div>
							<div class="form-group">
								<label>店铺名称</label> <input type="text" class="form-control"
									name="shopName" id="itemId">
							</div>
							<div class="form-group">
								<label>商家编号</label> <input type="text" class="form-control"
									name="supplierId" id="supplierId">
							</div>
							<div class="form-group">
								<label>商家名称</label> <input type="text" class="form-control"
									name="supplierName" id="supplierName">
							</div>
							<div class="form-group">
								<button type="button" id="querybtns" class="btn btn-primary">查询</button>
							</div>
						</div>
						<div class="row">
							<div class="form-group">
								<label>商品名称</label> <input type="text" class="form-control"
									name="skuName" id="skuName">
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
								<i class="fa fa-bar-chart-o fa-fw"></i>商品信息列表
							</h3>
						</div>
						<div class="panel-body">
							<table id="skuInfoTable" class="table table-hover">
								<thead>
									<tr>
										<c:if test="${privilege>=2}">
											<th>处理方式</th>
										</c:if>
										<th>商家编号</th>
										<th>商家</th>
										<th>店铺编号</th>
										<th>店铺</th>
										<th>货主编号</th>
										<th>商品编号</th>
										<th>商品编码</th>
										<th>货号</th>
										<th>商品名称</th>
										<th>长</th>
										<th>宽</th>
										<th>高</th>
										<th>体积</th>
										<th>净重</th>
										<th>毛重</th>
										<th>外箱重量</th>
										<th>外箱长</th>
										<th>外箱宽</th>
										<th>外箱高</th>
										<th>外箱体积</th>
										<th>外箱箱规</th>
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
	<div class="modal fade" id="updModal" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true" onclick="closeUpdModal()">&times;</button>
					<h4 class="modal-title" id="modelTitle">更新商品信息</h4>
				</div>
				<div class="modal-body">
					<iframe id="updIFrame" width="100%" height="100%"></iframe>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="updSkuInfoBtn">更新</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal"
						onclick="closeUpdModal()">关闭</button>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var bar = 0;
		var step = "||";
		/**
		 * 初始化分页信息
		 */
		var options = {
			queryForm : ".query",
			url : "${wmsUrl}/admin/basic/skuInfo/dataList.shtml",
			numPerPage : "10",
			currentPage : "",
			index : "1",
			callback : rebuildTable
		}
		
		function closeUpdModal() {
			$('#updModal').modal('hide');
		}

		$(function() {
			$(".pagination-nav").pagination(options);

			//更新功能
			$("#updSkuInfoBtn")
					.click(
							function() {
								var skuInfoId = $("#updIFrame").contents()
										.find("#skuInfoId").val().trim();
								if (skuInfoId == "") {
									$.zzComfirm.alertError("网络异常，请退出页面后重试");
									return;
								}
								
								var ownerUserId = $("#updIFrame").contents().find(
										"#ownerUserId").val();
								if (ownerUserId == "") {
									$.zzComfirm.alertError("没有货主编号");
									return;
								}
								
								var itemId = $("#updIFrame").contents().find(
										"#itemId").val();
								if (itemId == "") {
									$.zzComfirm.alertError("没有商品编号");
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
								var netWeight = $("#updIFrame").contents()
										.find("#netWeight").val();
								if (netWeight == "") {
									$.zzComfirm.alertError("未输入净重");
									return;
								}
								var grossWeight = $("#updIFrame").contents()
										.find("#grossWeight").val();
								if (grossWeight == "") {
									$.zzComfirm.alertError("未输入毛重");
									return;
								}
								var opWeight = $("#updIFrame").contents()
										.find("#opWeight").val();
								if (opWeight == "") {
									$.zzComfirm.alertError("未输入外箱重量");
									return;
								}
								var opLength = $("#updIFrame").contents()
										.find("#opLength").val();
								if (opLength == "") {
									$.zzComfirm.alertError("未输入外箱长度");
									return;
								}
								var opWidth = $("#updIFrame").contents()
										.find("#opWidth").val();
								if (opWidth == "") {
									$.zzComfirm.alertError("未输入外箱宽度");
									return;
								}
								var opHeight = $("#updIFrame").contents()
										.find("#opHeight").val();
								if (opHeight == "") {
									$.zzComfirm.alertError("未输入高度");
									return;
								}
								var opPcs = $("#updIFrame").contents()
										.find("#opPcs").val();
								if (opPcs == "") {
									$.zzComfirm.alertError("未输入外箱箱规");
									return;
								}

								$
										.ajax({
											type : "post",
											data : {
												'ownerUserId':ownerUserId,
												'itemId':itemId,
												'skuInfoId' : skuInfoId,
												'length' : length,
												'width' : width,
												'height' : height,
												'netWeight' : netWeight,
												'grossWeight' : grossWeight,
												'opWeight' : opWeight,
												'opLength' : opLength,
												'opWidth' : opWidth,
												'opHeight' : opHeight,
												'opPcs' : opPcs
											},
											dataType : 'json',
											url : '${wmsUrl}/admin/basic/skuInfo/editSkuInfo.shtml',
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
			$("#skuInfoTable tbody").html("");

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
				str += "<tr>";
				if ("${privilege>=2}"=="true") {
					str += "<td align='left'>";
					str += "<button type='button' class='btn btn-info' onclick='showUpdModal(\""
							+ list[i].skuInfoId + "\")'>修改</button>";
					str += "</td>";
				}
				str += "<td align='left'>" + list[i].supplierId;
				str += "<td align='left'>" + list[i].supplierName;
				str += "<td align='left'>" + list[i].shopId;
				str += "<td align='left'>" + list[i].shopName;
				str += "<td align='left'>" + list[i].ownerUserId;
				str += "</td><td align='left'>" + list[i].itemId;
				str += "</td><td align='left'>" + list[i].itemCode;
				str += "</td><td align='left'>" + list[i].sku;
				str += "</td><td align='left'>" + list[i].skuName;
				str += "</td><td align='left'>" + list[i].length;
				str += "</td><td align='left'>" + list[i].width;
				str += "</td><td align='left'>" + list[i].height;
				str += "</td><td align='left'>" + list[i].volume;
				str += "</td><td align='left'>" + list[i].netWeight;
				str += "</td><td align='left'>" + list[i].grossWeight;
				str += "</td><td align='left'>" + list[i].opWeight;
				str += "</td><td align='left'>" + list[i].opLength;
				str += "</td><td align='left'>" + list[i].opWidth;
				str += "</td><td align='left'>" + list[i].opHeight;
				str += "</td><td align='left'>" + list[i].opVolume;
				str += "</td><td align='left'>" + list[i].opPcs;
				str += "</td></tr>";
			}

			$("#skuInfoTable tbody").htmlUpdate(str);
		}

		function showUpdModal(skuInfoId) {
			var frameSrc = "${wmsUrl}/admin/basic/skuInfo/updSkuInfo.shtml?skuInfoId="
					+ skuInfoId;
			$("#updIFrame").attr("src", frameSrc);
			$('#updModal').modal({
				show : true,
				backdrop : 'static'
			});
		}
	</script>
</body>
</html>
