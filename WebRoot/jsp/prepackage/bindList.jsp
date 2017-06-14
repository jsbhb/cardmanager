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
<title>预包绑定</title>
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
							<td><label style="color:red">${PrePacInfo.pid}</label></td>	 
							<td><label>预包名称:</label></td>
							<td><label style="color:red">${PrePacInfo.preName}</label></td>
						</tr>
						<c:forEach items="${goodsList}" var = "item">
							<tr>
								<td><label>货号:</label></td>
								<td><label style="color:red">${item.sku}</label></td>	 
								<td><label>名称:</label></td>
								<td><label style="color:red">${item.skuName}</label></td>
								<td><label>数量:</label></td>
								<td><label style="color:red">${item.quantity==null?0:item.quantity}</label></td>
							</tr>
						</c:forEach>
						
					</table>
				</div>
			</div>
			
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default"  >
						<div class="panel-heading"  >
							<h3 class="panel-title">
								<i class="fa fa-bar-chart-o fa-fw"></i>库位列表
							</h3>
						</div>
						<div class="panel-body">
							<table id="preTable" class="table table-hover"  >
								<thead>
									<tr>
										<th>操作</th>
										<th>库位编码</th>
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

	<div class="modal fade" id="bindModal" tabindex="-1" role="dialog" aria-hidden="true">
	   <div class="modal-dialog"  >
	      <div class="modal-content"  >
	         <div class="modal-header">
	            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="closeBindModal()">&times;</button>
	         	<h4 class="modal-title" id="modelTitle">绑定</h4>
	         </div>
	         <div class="modal-body"  >
	         	<iframe id="bindIFrame" width="100%" height="100%" frameborder="0"></iframe>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeBindModal()">取消 </button>
	            <button type="button" class="btn btn-info" id="savePreBtn">绑定 </button>
	         </div>
	      </div>
		</div>
	</div>

<script type="text/javascript">

var options = {
		queryForm : ".query",
		url :  "${wmsUrl}/admin/prePackage/prePacMng/libList.shtml?pid=${PrePacInfo.pid}",
		numPerPage:"100",
		currentPage:"",
		index:"1",
		callback:rebuildTable
}

$(function(){
	 $(".pagination-nav").pagination(options);
	 
	 $("#savePreBtn").click(function(){
		 $("#bindIFrame")[0].contentWindow.submitForm();
	 });
})

function reloadTable(){
	$.page.loadData(options);
}

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
		str += "<tr><td><button type='button' class='btn btn-info' onclick='Bunding(this)' value='"+list[i].libinfo_Id+"'>绑定</button><input type='hidden' value='"+list[i].libid+"'/></td>" ;
		str += "<td>" + list[i].libno;
		str +="</td></tr>";
	}
	
	
	$("#preTable tbody").htmlUpdate(str);
}

function Bunding(obj){
	var value = $(obj).val();
	var length = '${length}';
	$.ajax({
		url:'${wmsUrl}/admin/prePackage/prePacMng/checkLibinfo.shtml?libinfoId='+value+'&length='+length,
		dataType:'json',
		type:'post',
		success:function(result){
			if(result.success){
				var libid = $(obj).next().val();
				var frameSrc = '${wmsUrl}/admin/prePackage/prePacMng/toBindDetail.shtml?libinfoId='+value+'&pid=${PrePacInfo.pid}'+'&libid='+libid;
			    $("#bindIFrame").attr("src", frameSrc);
			    $('#bindModal').modal({ show: true, backdrop: 'static' });
			}else{
				$.zzComfirm.alertError(result.msg);
			}
		},
		error:function(){
			$.zzComfirm.alertError("系统出问题了，快联系技术小王");
		}
	});
}

function closeBindModal(){
	$("#bindModal").modal("hide");
}

</script>
</body>
</html>
