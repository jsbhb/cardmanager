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
<title>仓位库存</title>
<%@include file="../resource.jsp"%>
</head>

<body>
	<div id="page-wrapper">
		<div class="container-fluid">
			<!-- Page Heading -->
			<div class="row">
				<div class="col-lg-12">
					<ol class="breadcrumb">
						<li><i class="fa fa-book fa-fw"></i>在库业务</li>
						<li class="active"><i class="fa fa-bookmark fa-fw"></i>仓位库存</li>
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
								</select>
							</div>
							<div class="form-group">
								<label>类型</label> <select class="form-control" name="type">
									<option value="">全部</option>
									<option value="1" selected="selected">良品库</option>
									<option value="2">不良品库</option>
									<option value="3">待货区</option>
									<option value="4">撤单区</option>
									<option value="5">空包区</option>
									<option value="6">虚拟仓</option>
									<option value="7">差异区</option>
								</select>
							</div>
							<div class="form-group">
								<label>区域</label> <input type="text" class="form-control"
									name="direction">
							</div>
						</div>
						<div class="row">
							<div class="form-group">
								<label>排</label> <input type="text" class="form-control"
									name="arrange">
							</div>
							<div class="form-group">
								<label>层</label> <input type="text" class="form-control"
									name="storey">
							</div>
							<div class="form-group">
								<label>列</label> <input type="text" class="form-control"
									name="lump">
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
								<i class="fa fa-bar-chart-o fa-fw"></i>库存列表
							</h3>
						</div>
						<div class="panel-body">
							<table id="warehouseTable" class="table table-hover">
								<thead>
									<tr>
										<th>详情</th>
										<th>仓库位置</th>
										<th>仓库类型</th>
										<th>仓库区域</th>
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
	<div class="modal fade" id="libDetailModal" tabindex="-1"
		role="dialog" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true" onclick="closeLibDetailModal() ">&times;</button>
					<h4 class="modal-title" id="modelTitle">库存明细</h4>
				</div>
				<div class="modal-body">
					<iframe id="libDetailIFrame"></iframe>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal"
						onclick="closeLibDetailModal() ">关闭</button>
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

		$(function() {
			$(".pagination-nav").pagination(options);
		})
		
		function closeLibDetailModal() {
			$('#libDetailModal').modal('hide');
		}
		
		function closeLibDetailModal() {
			$('#libDetailModal').modal('hide');
		}

		/**
		 * 重构table
		 */
		function rebuildTable(data) {
			$("#warehouseTable tbody").html("");

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
				str += "<tr><td align='left' style='line-height: 30px;'><button type='button' class='btn btn-info' onclick='showDetail(\"";
				str += list[i].id;
				str += "\")'>明细</button></td><td align='left'>"
				switch (list[i].depart) {
				case "ZC1":
					strCom = "出口区一楼";
					break;
				case "ZC2":
					strCom = "出口区二楼";
					break;
				}
				str += strCom;
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
				str += "</td><td align='left'>" + list[i].direction;
				str += "</td><td align='left'>" + list[i].arrange;
				str += "</td><td align='left'>" + list[i].storey;
				str += "</td><td align='left'>" + list[i].lump;
				str += "</td><td align='left'>" + list[i].libno;
				str += "</td></tr>";
			}

			$("#warehouseTable tbody").html(str);
		}

		function showDetail(libId) {
			var frameSrc = "${wmsUrl}/admin/stock/queryLibWarehouse/libDetail.shtml?libId="
					+ libId
			$("#libDetailIFrame").attr("src", frameSrc);
			$('#libDetailModal').modal({
				show : true,
				backdrop : 'static'
			});
		}
	</script>
</body>
</html>
