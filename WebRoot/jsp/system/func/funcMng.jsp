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
<title>功能管理</title>
<script type="text/javascript" src="${wmsUrl}/js/pagination.js"></script>
<link rel="stylesheet" href="${wmsUrl}/AdminLTE/AdminLTE.min.css">
</head>

<body>
	<div id="content-wrapper">
		<section class="content-header">
			<!-- Page Heading -->
			<h1>系统管理
		    <small>功能管理</small>
		    </h1>
			<!-- /.row -->

			<ol class="breadcrumb">
		        <li><a href="#"><i class="fa fa-dashboard"></i>首页</a></li>
		        <li><a href="#">系统管理</a></li>
		        <li class="active">功能管理</li>
		     </ol>
		</section>
		<section class="content">
		<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">
								<i class="fa fa-bar-chart-o fa-fw"></i>功能列表
							</h3>
						</div>
						<div class="panel-body">
							<c:if test="${priviledge>1}">
								<button type="submit" class="btn btn-default">新增</button>
							</c:if>
							<table id="funcTable" class="table table-hover">
								<thead>
									<tr>
										<th>操作</th>
										<th>名称</th>
										<th>tag</th>
										<th>创建日期</th>
										<th>更新日期</th>
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
		</section>
	</div>
	
	<div class="modal fade" id="detailModal" tabindex="-1" role="dialog" aria-hidden="true">
	   <div class="modal-dialog" >
	      <div class="modal-content">
	         <div class="modal-header">
	            <button type="button" class="close"  aria-hidden="true" data-dismiss="modal" onclick="closeDetailModal()">&times;</button>
	         	<h4 class="modal-title" id="modelTitle">子功能模块</h4>
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
			url :  "${wmsUrl}/admin/system/funcMng/dataList.shtml",
			numPerPage:"10",
			currentPage:"",
			index:"1",
			callback:rebuildTable
}

$(function(){
	 $(".pagination-nav").pagination(options);
})

/**
 * 重构table
 */
function rebuildTable(data){
	$("#funcTable tbody").html("");


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
		str += "<tr><td><button type='button' class='btn btn-primary' onclick='viewDetail("+list[i].id+")'>查看</button>";
		
		if("${priviledge==2}"=="true"){
			str += "&nbsp;&nbsp;<button type='button' class='btn btn-info' onclick='showEditModal("+list[i].id+")'>修改</button>" ;
		}
		if("${priviledge==3}"=="true"){
			str += "&nbsp;&nbsp;<button type='button' class='btn btn-info' onclick='showEditModal("+list[i].id+")'>修改</button>&nbsp;&nbsp;<button type='button' class='btn btn-warning' onclick='Delete("+list[i].id+")'>删除</button>" ;
		}
		str += "</td><td>" + list[i].name;
		str += "</td><td>" + list[i].tag;
		str += "</td><td>" + list[i].createTime;
		str += "</td><td>" + list[i].updateTime;
		str += "</td><td>" + list[i].opt;
		str += "</td></tr>";
	}
	$("#funcTable tbody").htmlUpdate(str);
	
}

function viewDetail(value){
	var frameSrc = '${wmsUrl}/admin/system/funcMng/viewDetail.shtml?id='+value;
       $("#detailIFrame").attr("src", frameSrc);
       $('#detailModal').modal({ show: true, backdrop: 'static' });
}

function closeDetailModal(){
	$("#detailModal").modal("hide");
}

</script>
</body>
</html>
