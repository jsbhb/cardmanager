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
<title>预包管理</title>
<%@include file="../resource.jsp" %>
</head>

<body>
	<div id="page-wrapper">
		<div id="mask"></div>
		<div class="container-fluid">
			<!-- Page Heading -->
			<div class="row">
				<div class="col-lg-12">
					<ol class="breadcrumb">
						<li><i class="fa fa-fighter-jet fa-fw"></i>预包业务</li>
						<li class="active"><i class="fa fa-user-md fa-fw"></i>预包设置</li>
					</ol>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="query">
						<div class="row">
							<div class="form-group">
								<label>预包编码:</label> <input type="text" class="form-control"  name="pid">
							</div>
							<div class="form-group">
								<label>自定名称:</label> <input type="text" class="form-control"  name="preName">
							</div>
						</div>
						<div class="row">
							<div class="form-group">
								<label>商家编号:</label> <input type="text" class="form-control" name="supplierId">
							</div>
							<div class="form-group">
								<label>商家名称:</label> <input type="text" class="form-control" name="supplierName">
							</div>
							<div class="form-group"><button type="button" id="querybtns" class="btn btn-primary">查询</button></div>
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default" >
						<div class="panel-heading" >
							<h3 class="panel-title">
								<i class="fa fa-bar-chart-o fa-fw"></i>预包列表
							</h3>
						</div>
						<div class="panel-body">
							<c:if test="${privilege>=2}">
								<button type="button" class="btn btn-primary" onclick="showAddModal()">新增</button>
							</c:if>
							<table id="preTable" class="table table-hover" >
								<thead>
									<tr>
										<th>操作</th>
										<th>预包编码</th>
										<th>自定名称</th>
										<th>商家ID</th>
										<th>商家名称</th>
										<th>包材规格</th>
										<th>备注</th>
										<th>创建时间</th>
										<th>更新时间</th>
										<th>最后操作人</th>
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
	   <div class="modal-dialog" >
	      <div class="modal-content" >
	         <div class="modal-header">
	            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="closeAddModal()">&times;</button>
	         	<h4 class="modal-title" id="modelTitle">预包新增</h4>
	         </div>
	         <div class="modal-body" >
	         	<iframe id="addIFrame" width="100%" height="100%" frameborder="0"></iframe>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeAddModal()">取消 </button>
	            <button type="button" class="btn btn-info" id="savePreBtn">新增 </button>
	         </div>
	      </div>
		</div>
	</div>
	<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-hidden="true">
	   <div class="modal-dialog" >
	      <div class="modal-content"  >
	         <div class="modal-header">
	            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="closeEditModal()">&times;</button>
	         	<h4 class="modal-title" id="modelTitle">预包维护</h4>
	         </div>
	         <div class="modal-body"  >
	         	<iframe id="editIFrame" width="100%" height="100%" frameborder="0"></iframe>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeEditModal()">取消 </button>
	            <button type="button" class="btn btn-info" id="upPreBtn">更新 </button>
	         </div>
	      </div>
		</div>
	</div>
	<div class="modal fade" id="bindModal" tabindex="-1" role="dialog" aria-hidden="true">
	   <div class="modal-dialog"  >
	      <div class="modal-content"  >
	         <div class="modal-header">
	            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="closeBindModal()">&times;</button>
	         	<h4 class="modal-title" id="modelTitle">绑定预包库位</h4>
	         </div>
	         <div class="modal-body"  >
	         	<iframe id="bindIFrame" width="100%" height="100%" frameborder="0"></iframe>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeBindModal()">返回 </button>
	         </div>
	      </div>
		</div>
	</div>
	<div class="modal fade" id="detailModal" tabindex="-1" role="dialog" aria-hidden="true">
	   <div class="modal-dialog" >
	      <div class="modal-content"  >
	         <div class="modal-header">
	            <button type="button" class="close"  aria-hidden="true" data-dismiss="modal" onclick="closeDetailModal()">&times;</button>
	         	<h4 class="modal-title" id="modelTitle">预包详情</h4>
	         </div>
	         <div class="modal-body"  >
	         	<iframe id="detailIFrame" width="100%" height="100%" frameborder="0"></iframe>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeDetailModal()">取消 </button>
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
			url :  "${wmsUrl}/admin/prePackage/prePacMng/dataList.shtml",
			numPerPage:"10",
			currentPage:"",
			index:"1",
			callback:rebuildTable
}

$(function(){
	 $(".pagination-nav").pagination(options);
	 
	 $("#savePreBtn").click(function(){
		 $("#addIFrame")[0].contentWindow.submitForm();
	 });
	 
	 $("#upPreBtn").click(function(){
		 $("#editIFrame")[0].contentWindow.submitForm();
	 });
})


function reloadTable(){
	$.page.loadData(options);
}

function closeAddModal(){
	$("#addModal").modal("hide");
}

function closeBindModal(){
	$("#bindModal").modal("hide");
}

/**
 * 重构table
 */
function rebuildTable(data){
	$.zzComfirm.endMask();
	$("#preTable tbody").html("");


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
		if("${privilege>=2}"=="true"){
			str += "<tr><td><button type='button' class='btn btn-info' onclick='showDealModal("+list[i].pid+")'>处理</button>&nbsp;&nbsp;<button type='button' class='btn btn-warning' onclick='showEditModal("+list[i].pid+")'>更新</button>&nbsp;&nbsp;<button type='button' class='btn btn-primary' onclick='print("+list[i].pid+")'>条码打印</button></td><td><a href='javascript:void(0)' onclick='viewDetail("+ list[i].pid+")' >"+list[i].pid+"</a>" ;
		}else{
			str += "<tr><td><button type='button' class='btn btn-primary' onclick='print("+list[i].pid+")'>条码打印</button></td><td><a href='javascript:void(0)' onclick='viewDetail("+ list[i].pid+")' >"+list[i].pid+"</a>";
		}
		
		str += "</td><td>" + list[i].preName;
		
		str += "</td><td>" + list[i].supplierId;
		
		str += "</td><td>" + list[i].supplierName;
		
		str += "</td><td>" + list[i].pacSpec;
		
		str += "</td><td>" + list[i].remark;
		
		str += "</td><td>" + list[i].ctime;
		
		str += "</td><td>" + (list[i].updateTime==null?"":list[i].updateTime);
		
		str += "</td><td>" + list[i].opt;
	
		str += "</td></tr>";
	}
	
	
	$("#preTable tbody").htmlUpdate(str);
}


function viewDetail(value){
	var frameSrc = '${wmsUrl}/admin/prePackage/prePacMng/viewDetail.shtml?pid='+value;
       $("#detailIFrame").attr("src", frameSrc);
       $('#detailModal').modal({ show: true, backdrop: 'static' });
}

function showAddModal(){
    var frameSrc = "${wmsUrl}/admin/prePackage/prePacMng/toAdd.shtml";
    $("#addIFrame").attr("src", frameSrc);
    $('#addModal').modal({ show: true, backdrop: 'static' });
}

function showEditModal(value){
	$.ajax({
		type : "post",
		url : '${wmsUrl}/admin/prePackage/prePacMng/check.shtml?pid='+value,
		dataType:'json',
		success : function(data) {
			if (data.success) {
				var frameSrc = '${wmsUrl}/admin/prePackage/prePacMng/toEdit.shtml?type=0&pid='+value;
			    $("#editIFrame").attr("src", frameSrc);
			    $('#editModal').modal({ show: true, backdrop: 'static' });
			} else {
				var frameSrc = '${wmsUrl}/admin/prePackage/prePacMng/toEdit.shtml?type=1&pid='+value;
			    $("#editIFrame").attr("src", frameSrc);
			    $('#editModal').modal({ show: true, backdrop: 'static' });
			}
		},
		error : function(data) {
			$.zzComfirm.alertError("操作失败，请联系管理员！");
		}
	});
    
}

function showDealModal(value){
	var frameSrc = '${wmsUrl}/admin/prePackage/prePacMng/toDeal.shtml?pid='+value;
    $("#bindIFrame").attr("src", frameSrc);
    $('#bindModal').modal({ show: true, backdrop: 'static' });
}

function closeDetailModal(){
	$("#detailModal").modal("hide");
}

function closeAddModal(){
	$("#addModal").modal("hide");
}

function closeEditModal(){
	$("#editModal").modal("hide");
}

function closeBindModal(){
	$("#bindModal").modal("hide");
}

function print(value) {
	var left1 = (screen.width - 600) / 2;
	var top1 = (screen.height - 450) / 2;
	
	window.open('${wmsUrl}/admin/prePackage/prePacMng/pdfjsp.shtml?pid='+value,"","width=1400,height=700,resizable=yes,location=no,scrollbars=yes,left=" + left1.toString() + ",top=" + top1.toString());
}

</script>
</body>
</html>
