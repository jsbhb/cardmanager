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
	<div id="page-wrapper">

		<div class="container-fluid">
			<!-- Page Heading -->
			<div class="row">
				<div class="col-lg-12">
					<ol class="breadcrumb">
						<li><i class="fa fa-fighter-jet fa-fw"></i>出库业务</li>
						<li class="active"><i class="fa fa-user-md fa-fw"></i>手动回传</li>
					</ol>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="query">
						<div class="row"  >
							<div class="form-group">
								<label>订单编号</label> <input type="text" class="form-control"
									name="externalNo2">
							</div>
							<div class="form-group">
								<label>&nbsp;状态&nbsp;</label> 
								<select id="state" name="state" class="form-control span2">
									<option value="">全部</option>
									<option value="1">拒单</option>
									<option value="2">接单</option>
									<option value="3">打包</option>
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
								<i class="fa fa-bar-chart-o fa-fw"></i>回传列表
							</h3>
						</div>
						<div class="panel-body">
							<table id="handReturn" class="table table-hover">
								<thead>
									<tr>
										<th>操作</th>
										<th>订单编号</th>
										<th>仓储编号</th>
										<th>状态</th>
										<th>重量(克)</th>
										<th>内容</th>
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
	<div class="modal fade" id="updModal" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog"  >
			<div class="modal-content"  >
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true" onclick="window.history.go(-1);">&times;</button>
					<h4 class="modal-title" id="modelTitle">更新重量</h4>
				</div>
				<div class="modal-body"  >
					<iframe id="updIFrame" ></iframe>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="updWeightBtn">更新并回传</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal"
						onclick="closeModal()">关闭</button>
				</div>
			</div>
		</div>
	</div>
	<div id="sending"
		style="filter:alpha(opacity=80); position:absolute; top:40%; left:40%; z-index:10; visibility:hidden; width: 225px; height: 81px;">
		<TABLE WIDTH="80%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
			<TR>
				<td width="30%"></td>
				<TD bgcolor="#ccc">
					<TABLE WIDTH="100%" height="50" BORDER="0" CELLSPACING="2"
						CELLPADDING="0">
						<tr>
							<td height="30"><img src="${wmsUrl}/img/30.gif"
								border="0" /></td>
						</tr>
						<tr>
							<td align="center" style="font-size:12px">正在回传，请稍后...</td>
						</tr>
					</table>
				</td>
				<td width="30%"></td>
			</tr>
		</table>
	</div>
	<script type="text/javascript">
		/**
		 * 初始化分页信息
		 */
		var options = {
			queryForm : ".query",
			url : "${wmsUrl}/admin/stockOut/handReturn/dataList.shtml",
			numPerPage : "10",
			currentPage : "",
			index : "1",
			callback : rebuildTable
		}

		$(function() {
			$(".pagination-nav").pagination(options);

			//更新功能
			$("#updWeightBtn")
					.click(
							function() {
								var weight = $("#updIFrame").contents()
										.find("#weight").val().trim();
								var id = $("#updIFrame").contents()
								.find("#id").val().trim();
								if (weight == "" || weight==0) {
									$.zzComfirm.alertError("请输入重量");
									return;
								}
								if(isNaN(weight)){
									$.zzComfirm.alertError("请输入数字");
									return;
								}
								var reg = /^([1-9]\d*|[0]{1,1})$/;
								if(!reg.test(weight)){
									$.zzComfirm.alertError("请输入正整数！！");
									return;
								}
								if(weight <10){
									$.zzComfirm.alertError("请输入大于10的数字");
									return;
								}
								if(weight >50000){
									$.zzComfirm.alertError("请输入小于50000的数字");
									return;
								}
								$.ajax({
											type : "post",
											data : {
												'weight' : weight,
												'id' : id
											},
											dataType : 'json',
											url : '${wmsUrl}/admin/stockOut/handReturn/editAndReport.shtml',
											success : function(data) {
												if (data.success) {
													$.zzComfirm
															.alertSuccess("操作成功！");
													$("#updModal")
															.modal('hide');
													$.page.loadData(options);
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
			$("#handReturn tbody").html("");

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
				if ("${privilege>=2}") {
					if("WMS_REJECT" == list[i].status){
						str += "<td align='left'>";
						str += "<button type='button' class='btn btn-warning' onclick='confirmReturn(\""
								+ list[i].id + "\")'>确认不足</button>&nbsp;&nbsp;<button type='button' class='btn btn-info' onclick='handle(\""
								+ list[i].id + "\")'>库存已处理</button>";
						str += "</td>";
					}else{
						str += "<td align='left'>";
						str += "<button type='button' class='btn btn-info' onclick='showUpdModal(\""
								+ list[i].id + "\")'>修改并回传</button>";
						str += "</td>";
					}
				} else {
					str += "<td></td>";
				}
				str += "<td>" + list[i].externalNo2 + "</td>" ;
				str += "<td>"+ list[i].orderCode +"</td>";
				str += "<td>"+ list[i].status +"</td>";
				str += "<td>"+ list[i].weight +"</td>";
				str += "<td>"+ list[i].content +"</td>";
				str += "<td>"+ list[i].features +"</td>";
				str += "</tr>";
			}

			$("#handReturn tbody").htmlUpdate(str);
		}
			


		function closeModal() {
			$('#updModal').modal('hide');
		}

		function showUpdModal(id) {
			var frameSrc = "${wmsUrl}/admin/stockOut/handReturn/show.shtml?id="
					+ id;
			$("#updIFrame").attr("src", frameSrc);
			$('#updModal').modal({
				show : true,
				backdrop : 'static'
			});
		}
		
		function confirmReturn(id){
			sending.style.visibility="visible"; 
			$.ajax({
				type : "post",
				data : {'id' : id},
				dataType : 'json',
				url : '${wmsUrl}/admin/stockOut/handReturn/Report.shtml',
				success : function(result){
					if(result.success){
						sending.style.visibility="hidden";
						$.zzComfirm.alertSuccess("操作成功！");
						$.page.loadData(options);
					}else{
						sending.style.visibility="hidden";
						$.zzComfirm.alertError(result.msg);
					}
				},
				error : function(){
					sending.style.visibility="hidden";
					$.zzComfirm.alertError("操作失败，请联系管理员！");
				}
			});
		}
		
		function handle(id){
			sending.style.visibility="visible"; 
			$.ajax({
				type : "post",
				data : {'id' : id},
				dataType : 'json',
				url : '${wmsUrl}/admin/stockOut/handReturn/handle.shtml',
				success : function(result){
					if(result.success){
						sending.style.visibility="hidden";
						$.zzComfirm.alertSuccess("操作成功！");
						$.page.loadData(options);
					}else{
						sending.style.visibility="hidden";
						$.zzComfirm.alertError(result.msg);
					}
				},
				error : function(){
					sending.style.visibility="hidden";
					$.zzComfirm.alertError("操作失败，请联系管理员！");
				}
			});
		}
	</script>
</body>
</html>
