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
<title>规则列表</title>
<%@include file="../../resource.jsp"%>
</head>

<body>
	<div id="page-wrapper">
		<div id="mask"></div>
		<div class="container-fluid">
			<!-- Page Heading -->
			<div class="row">
				<div class="col-lg-12">
					<ol class="breadcrumb">
						<li><i class="fa fa-truck fa-fw"></i>统计管理</li>
						<li class="active"><i class="fa fa-user-md fa-fw"></i>规则制定</li>
					</ol>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="query">
						<div class="row">
							<div class="form-group">
								<label>规则类型</label> <select class="form-control" name="type">
									<option value="0" selected="selected">订单规则</option>
								</select>
							</div>
							<div class="form-group">
								<label>规则节点</label> <select class="form-control" name="node">
									<option value="1" selected="selected">接单规则</option>
									<option value="2">打包规则</option>
									<option value="3">出货规则</option>
								</select>
							</div>
							<div class="form-group">
								<label>名称</label> <input type="text" class="form-control"
									name="name">
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
								<i class="fa fa-bar-chart-o fa-fw"></i>规则列表
							</h3>
						</div>
						<div class="panel-body">
							<c:if test="${privilege>=2}">
								<button type="button" class="btn btn-primary" onclick="showAddModal()">新增</button>
							</c:if>
							<table id="ruleTable" class="table table-hover">
								<thead>
									<tr>
										<th>操作</th>
										<th>规则类型</th>
										<th>规则节点</th>
										<th>规则名称</th>
										<th>规则</th>
										<th>创建时间</th>
										<th>修改时间</th>
										<th>修改人</th>
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
	
	<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-hidden="true">
	   <div class="modal-dialog">
	      <div class="modal-content">
	         <div class="modal-header">
	            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="closeAddModal()">&times;</button>
	         	<h4 class="modal-title" id="modelTitle">新增规则</h4>
	         </div>
	         <div class="modal-body">
	         	<iframe id="addIFrame" frameborder="0"></iframe>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeAddModal()">取消 </button>
	            <button type="button" class="btn btn-info" id="saveBtn">新增 </button>
	         </div>
	      </div>
		</div>
	</div>
	<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-hidden="true">
	   <div class="modal-dialog">
	      <div class="modal-content">
	         <div class="modal-header">
	            <button type="button" class="close"  aria-hidden="true" data-dismiss="modal" onclick="closeEditModal()">&times;</button>
	         	<h4 class="modal-title" id="modelTitle">修改规则</h4>
	         </div>
	         <div class="modal-body">
	         	<iframe id="editIFrame" frameborder="0"></iframe>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeEditModal()">取消 </button>
	         	<button type="button" class="btn btn-info" id="updateBtn">修改 </button>
	         </div>
	      </div>
		</div>
	</div>
	<script type="text/javascript">
		$(".dataPicker").datetimepicker({
			format : 'yyyy-mm-dd'
		});
		/**
		 * 初始化分页信息
		 */
		var options = {
			queryForm : ".query",
			url : "${wmsUrl}/admin/statistic/rule/dataList.shtml",
			numPerPage : "100",
			currentPage : "",
			index : "1",
			callback : rebuildTable
		}

		$(function() {
			$(".pagination-nav").pagination(options);
			
			 $("#saveBtn").click(function(){
				 $("#addIFrame")[0].contentWindow.submitForm();
			 });
			 
			 $("#updateBtn").click(function(){
				 $("#editIFrame")[0].contentWindow.submitForm();
			 });
		})

		/**
		 * 重构table
		 */
		function rebuildTable(data) {
			$.zzComfirm.endMask();
			$("#ruleTable tbody").html("");

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
				
				if("${privilege>=2}"=="true"){
					str += "<tr><td><button type='button' class='btn btn-info' onclick='showEditModal("+list[i].id+")'>修改</button></td>" ;
				}else{
					str += "<tr><td></td>";
				}
				str += "<td align='left'>";
				switch (list[i].type) {
				case "0":
					str += "订单规则";
					break;
				case "1":
					str += "进货规则";
					break;
				}
				switch (list[i].node) {
				case "1":
					str += "</td><td>接单规则";
					break;
				case "2":
					str += "</td><td>放行规则";
					break;
				case "3":
					str += "</td><td>出货规则";
					break;
				}
				str += "</td><td>" + list[i].name;
				str += "</td><td>" + list[i].rule;
				str += "</td><td>" + list[i].createTime;
				str += "</td><td>" + list[i].updateTime;
				str += "</td><td>" + list[i].opt;
				str += "</td></tr>";
			}

			$("#ruleTable tbody").htmlUpdate(str);
		}
		
		function showAddModal(){
		       var frameSrc = "${wmsUrl}/admin/statistic/rule/addRule.shtml";
		       $("#addIFrame").attr("src", frameSrc);
		       $('#addModal').modal({ show: true, backdrop: 'static' });
		}


		function showEditModal(id){
		       var frameSrc = "${wmsUrl}/admin/statistic/rule/editRule.shtml?id="+id;
		       $("#editIFrame").attr("src", frameSrc);
		       $('#editModal').modal({ show: true, backdrop: 'static' });
		}
		
		function reloadTable(){
			$.page.loadData(options);
		}

		function closeAddModal(){
			$("#addModal").modal("hide");
		}

		function closeEditModal(){
			$("#editModal").modal("hide");
		}
	</script>
</body>
</html>
