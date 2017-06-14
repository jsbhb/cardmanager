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
<title>机构管理</title>
<%@include file="../resource.jsp" %>
</head>

<body>
	<div id="page-wrapper">

		<div class="container-fluid">
			<!-- Page Heading -->
			<div class="row">
				<div class="col-lg-12">
					<ol class="breadcrumb">
						<li><i class="fa fa-desktop"></i>系统管理</li>
						<li class="active"><i class="fa fa-user-md"></i> 机构管理</li>
					</ol>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="query">
						<div class="form-group">
							<label>机构号:</label> <input type="text" class="form-control" name="compId">
						</div>

						<div class="form-group">
							<label>机构名称:</label> <input type="text" class="form-control" name="compName">
						</div>
						<button type="button" id="querybtns" class="btn btn-primary">查询</button>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">
								<i class="fa fa-bar-chart-o fa-fw"></i>机构列表
							</h3>
						</div>
						<div class="panel-body">
							<c:if test="${privilege==1}">
								<button type="button" class="btn btn-primary" onclick="showAddModal()">新增</button>
							</c:if>
							<table id="compTable" class="table table-hover">
								<thead>
									<tr>
										<th>编辑</th>
										<th>编号</th>
										<th>名称</th>
										<th>上级机构</th>
										<th>地址</th>
										<th>机构管理人</th>
										<th>分管领导</th>
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
	<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-hidden="true">
	   <div class="modal-dialog"  >
	      <div class="modal-content" >
	         <div class="modal-header">
	            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="closeAddModal()">&times;</button>
	         	<h4 class="modal-title" id="modelTitle">机构新增</h4>
	         </div>
	         <div class="modal-body">
	         	<iframe id="addIFrame" width="100%" height="100%" frameborder="0"></iframe>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-default" data-dismiss="modal" onclick="closeAddModal()">取消 </button>
	            <button type="button" class="btn btn-primary" id="saveCompBtn">新增 </button>
	         </div>
	      </div>
		</div>
	</div>
	<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-hidden="true">
	   <div class="modal-dialog">
	      <div class="modal-content">
	         <div class="modal-header">
	            <button type="button" class="close"  aria-hidden="true" onclick="closeEditModal()">&times;</button>
	         	<h4 class="modal-title" id="modelTitle">机构维护</h4>
	         </div>
	         <div class="modal-body" >
	         	<iframe id="editIFrame" width="100%" height="100%" frameborder="0"></iframe>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-default" data-dismiss="modal" onclick="closeEditModal()">取消 </button>
	         	<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="updateComp()">修改 </button>
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
				url :  "${wmsUrl}/admin/system/compMng/dataList.shtml",
				numPerPage:"10",
				currentPage:"",
				index:"1",
				callback:rebuildTable
	}
	
	function closeEditModal(){
		$("editModal").modal("hide");
	}
	
	function closeAddModal(){
		$("addModal").modal("hide");
	}
	
	$(function(){
		 $(".pagination-nav").pagination(options);
		 
		 $("#saveCompBtn").click(function(){
				var compName = $("#addIFrame").contents().find("#compName").val();
				if(compName==""){
					$.zzComfirm.alertError("未输入机构名称");
					return;
				}
				
				var location = $("#addIFrame").contents().find("#location").val();
				if(location==""){
					$.zzComfirm.alertError("未输入机构地址");
					return;
				}
				
				$.ajax({ 
					type:"post",
					data: {'compName':compName,'location':location}, 
					url: '${wmsUrl}/admin/system/compMng/saveComp.shtml',
					dataType : 'json',
		            success: function (data) {
		            	if(data.success){
		            		$.zzComfirm.alertSuccess("操作成功！");
		            		$("#addModal").modal('hide');
		            		$.page.loadData(options);
		            	}else{
		            		$.zzComfirm.alertError(data.msg);
		            	}
		            },
		            error: function (data) {
		            	$.zzComfirm.alertError("操作失败，请联系管理员！");
		            } 
		        });
				return false;
			});
	})
	
	/**
	 * 重构table
	 */
	function rebuildTable(data){
		$("#compTable tbody").html("");
	
	
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
			str += "<tr><td><button type='button' class='btn btn-primary' onclick='showEditModal("+list[i].compId+")'>edit</button></td><td>" + list[i].compId;
			str += "</td><td>" + list[i].compName;
			str += "</td><td>" + list[i].chiefName;
			str += "</td><td>" + list[i].location;
			str += "</td><td>" + list[i].compCharge;
			str += "</td><td>" + list[i].director;
			str += "</td><td>" + list[i].createTime;
			str += "</td></tr>";
		}
		$("#compTable tbody").htmlUpdate(str);
	}
	
	function showAddModal(){
        var frameSrc = "${wmsUrl}/admin/system/compMng/addComp.shtml";
        $("#addIFrame").attr("src", frameSrc);
        $('#addModal').modal({ show: true, backdrop: 'static' });
	}
	
	function savecomp(){
		$("#addIFrame").contents().find("#compForm").submit();
	}
	
	function showEditModal(compId){
        var frameSrc = "${wmsUrl}/admin/system/compMng/editComp.shtml?compId="+compId;
        $("#editIFrame").attr("src", frameSrc);
        $('#editModal').modal({ show: true, backdrop: 'static' });
	}
	
	function updateComp(){
		$("#editIFrame").contents().find("#compForm").submit();
	}

	</script>
</body>
</html>
