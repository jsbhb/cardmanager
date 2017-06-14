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
<title>仓位条码打印</title>
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
						<li class="active"><i class="fa fa-bookmark fa-fw"></i>仓位条码打印</li>
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
									name="lump" >
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
								<i class="fa fa-bar-chart-o fa-fw"></i>仓位列表
							</h3>
						</div>
						<div class="panel-body">
							<c:if test="${privilege>=2}">
								<button type="button" class="btn btn-primary"
									onclick="selectAll()">全选中</button>
								<button type="button" class="btn btn-danger"
									onclick="selectNull()">全取消</button>
								<button type="button" class="btn btn-info"
									onclick="printBarcode()">打印条码</button>
							</c:if>
							<table id="warehouseTable" class="table table-hover">
								<thead>
									<tr>
										<th>选中</th>
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
	<script type="text/javascript">
		/**
		 * 初始化分页信息
		 */
		var options = {
			queryForm : ".query",
			url : "${wmsUrl}/admin/basic/library/placeManage/dataList.shtml",
			numPerPage : "100",
			currentPage : "",
			index : "1",
			callback : rebuildTable
		}

		$(function() {
			$(".pagination-nav").pagination(options);
		})

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
				str += "<tr>";
				str += "<td><input type='checkbox' name='check' value='" + list[i].libno + "' /></td>";
				str += "<td align='left'>";
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
				str += "</td><td>" + strCom;
				str += "</td><td>" + list[i].direction;
				str += "</td><td>" + list[i].arrange;
				str += "</td><td>" + list[i].storey;
				str += "</td><td>" + list[i].lump;
				str += "</td><td>" + list[i].libno;
				str += "</td></tr>";
			}

			$("#warehouseTable tbody").htmlUpdate(str);
		}

		function selectAll() {
			$("[name='check']").each(function() {
				this.checked = true;
			});
		}

		function selectNull() {
			$("[name='check']").each(function() {
				this.checked = false;
			});
		}

		function printBarcode() {
			var libno = "";
			$("[name='check']:checked").each(function() {
				if ($(this).is(':checked')) {
					libno += $(this).val() + ",";
				}
			});
			if (libno == null||libno == "") {
				alert("请选择要打印的记录");
				return;
			}
			var left1 = (screen.width - 600) / 2;
			var top1 = (screen.height - 450) / 2;
			var barCode = encodeURI(encodeURI(libno));
			window.open('${wmsUrl}/admin/basic/library/placeManage/pdfjsp.shtml?barCode='
					+ barCode, "",
					"width=1400,height=700,resizable=yes,location=no,scrollbars=yes,left="
							+ left1.toString() + ",top=" + top1.toString());
		}
	</script>
</body>
</html>
