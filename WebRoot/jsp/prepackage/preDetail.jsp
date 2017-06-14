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
<title>预包详情</title>
<%@include file="../resource.jsp" %>
</head>

<body>
	<div id="page-wrapper">
		<div class="container-fluid">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">
						<i class="fa fa-bar-chart-o fa-fw"></i>预包信息
					</h3>
				</div>
				<div class="panel-body">
					<table class="table table-bordered">
						<tr>
							<td><label>预包编码:</label></td>
							<td><label style="color:red">${PrePacInfo.pid}</label>	 
							<td><label>预包名称:</label></td>
							<td><label style="color:red">${PrePacInfo.preName}</label></td>
							<td><label>预包总数:</label></td>
							<td><label style="color:red">${PrePacInfo.qty==null?0:PrePacInfo.qty}</label>
							<td><label>预包现存:</label></td>
							<td><label style="color:red">${PrePacInfo.existqty==null?0:PrePacInfo.existqty}</label>	 
						</tr>
					</table>
				</div>
			</div>
		
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">
						<i class="fa fa-bar-chart-o fa-fw"></i>模板明细
					</h3>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<table class="table table-bordered">
							<thead>
								<tr>
									<th>货号</th>
									<th>名称</th>
									<th>数量</th>
									<th>详情</th>
									<th>备注</th>
									<th>创建时间</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${goodsList}" var = "item">
								<tr>
									<td>${item.sku}</td>	 
									<td>${item.skuName}</td>
									<td>${item.quantity==null?0:item.quantity}</td>
									<td>${item.orderDetail}</td>
									<td>${item.remark}</td>
									<td>${item.ctime}</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
					</div>
			</div>
		</div>
		
		<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">
						<i class="fa fa-bar-chart-o fa-fw"></i>预包明细
					</h3>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<table id="preTable" class="table table-hover">
							<thead>
								<tr>
									<th>操作</th>
									<th>库位</th>
									<th>总数</th>
									<th>库存数量</th>
									<th>冻结数量</th>
									<th>创建时间</th>
									<th>更新时间</th>
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
</div>

<div class="modal fade" id="detailModal" tabindex="-1" role="dialog" aria-hidden="true">
	   <div class="modal-dialog"  >
	      <div class="modal-content"  >
	         <div class="modal-header">
	            <button type="button" class="close"  aria-hidden="true" data-dismiss="modal" onclick="closeDetailModal()">&times;</button>
	         	<h4 class="modal-title" id="modelTitle">预包库位详情</h4>
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

var options = {
		queryForm : ".query",
		url :  "${wmsUrl}/admin/prePackage/prePacMng/itemList.shtml?pid=${PrePacInfo.pid}",
		numPerPage:"100",
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
		str += "<tr><td><button type='button' class='btn btn-info' onclick='viewDetailModal("+list[i].id+")'>查看</button></td>" ;
		str += "<td>"+list[i].libno ;
		str += "</td><td>" + list[i].qty;
		str += "</td><td>" + list[i].existqty;
		str += "</td><td>" + list[i].frozenqty;
		str += "</td><td>" + list[i].ctime;
		str += "</td><td>" + (list[i].updateTime==null?"":list[i].updateTime);
		str += "</td><td>" + list[i].opt;
		str += "</td></tr>";
	}
	
	
	$("#preTable tbody").htmlUpdate(str);
}


function viewDetailModal(value){
	var frameSrc = '${wmsUrl}/admin/prePackage/prePacMng/viewPreLibDetail.shtml?plid='+value;
       $("#detailIFrame").attr("src", frameSrc);
       $('#detailModal').modal({ show: true, backdrop: 'static' });
}

function closeDetailModal(){
	$("#detailModal").modal("hide");
}

</script>
</body>
</html>
