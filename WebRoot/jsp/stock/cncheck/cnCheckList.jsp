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
<title>盘点管理</title>
<%@include file="../../resource.jsp" %>
</head>

<body>
	<div id="page-wrapper">
		<div id="mask"></div>
		<div class="container-fluid">
			<!-- Page Heading -->
			<div class="row">
				<div class="col-lg-12">
					<div class="query">
						<div class="row">
							<div class="form-group">
								<label>盘点号:</label> <input type="text" class="form-control"  name="id">
							</div>
							<div class="form-group">
								<label>商家编号:</label> <input type="text" class="form-control" name="supplierId">
							</div>
							<div class="form-group">
								<label>商家名称:</label> <input type="text" class="form-control" name="supplierName">
							</div>
						</div>
						<div class="row">
							<div class="form-group">
								<label>仓储编号:</label> <input type="text" class="form-control" name="orderCode">
							</div>
							<div class="form-group">
								<label>盘点类型:</label>
								<select name="orderType" class="form-control span2"  id="orderType">
									<option value="">全部</option>
									<option value="1">错发</option>
									<option value="2">漏发</option>
									<option value="3">进货</option>
									<option value="4">盘点</option>
									<option value="5">其他</option>
								</select>
							</div>
							<div class="form-group">
								<label>盘点状态:</label>
								<select name="status" class="form-control span2"  id="status">
									<option value="">全部</option>
									<option value="1">待盘点</option>
									<option value="2">已盘点</option>
									<option value="3">取消</option>
									<option value="4">盘点失败</option>
								</select>
							</div>
						</div>
						<div class="row">
							<div class="form-group">
								<label>创建时间:</label> 
								<input size="16" type="text" id="sCreateTime"  class="form-control dataPicker" name="sCreateTime">
								<span class="add-on"><i class="icon-th"></i></span>
								<label>&nbsp;至&nbsp;</label> 
								<input size="16" type="text" id="eCreateTime"  class="form-control dataPicker" name="eCreateTime">
								<span class="add-on"><i class="icon-th"></i></span>
							</div>
							<div class="form-group">
								<label>更新时间:</label> 
								<input size="16" type="text" id="sUpdateTime"  class="form-control dataPicker" name="sUpdateTime">
								<span class="add-on"><i class="icon-th"></i></span>
								<label>&nbsp;至&nbsp;</label> 
								<input size="16" type="text" id="eUpdateTime"  class="form-control dataPicker" name="eUpdateTime">
								<span class="add-on"><i class="icon-th"></i></span>
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
								<i class="fa fa-bar-chart-o fa-fw"></i>盘点列表
							</h3>
						</div>
						<div class="panel-body">
							<c:if test="${privilege>=2}">
								<button type="button" class="btn btn-primary" onclick="showAddModal()">新增</button>
							</c:if>
							<table id="checkTable" class="table table-hover">
								<thead>
									<tr>
										<th>操作</th>
										<th>盘点编号</th>
										<th>状态</th>
										<th>类型</th>
										<th>供应商编号</th>
										<th>供应商名称</th>
										<th>单据编号</th>
										<th>仓储编号</th>
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
	   <div class="modal-dialog">
	      <div class="modal-content">
	         <div class="modal-header">
	            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="closeAddModal()">&times;</button>
	         	<h4 class="modal-title" id="modelTitle">盘点新增</h4>
	         </div>
	         <div class="modal-body">
	         	<iframe id="addIFrame" frameborder="0"></iframe>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeAddModal()">取消 </button>
	            <button type="button" class="btn btn-info" id="saveCheckBtn">新增 </button>
	         </div>
	      </div>
		</div>
	</div>
	<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-hidden="true">
	   <div class="modal-dialog">
	      <div class="modal-content">
	         <div class="modal-header">
	            <button type="button" class="close"  aria-hidden="true" data-dismiss="modal" onclick="closeEditModal()">&times;</button>
	         	<h4 class="modal-title" id="modelTitle">盘点维护</h4>
	         </div>
	         <div class="modal-body">
	         	<iframe id="editIFrame" frameborder="0"></iframe>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-info" id="checkBtn">盘点 </button>
	            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeEditModal()">取消 </button>
	         </div>
	      </div>
		</div>
	</div>
	<div class="modal fade" id="detailModal" tabindex="-1" role="dialog" aria-hidden="true">
	   <div class="modal-dialog">
	      <div class="modal-content">
	         <div class="modal-header">
	            <button type="button" class="close"  aria-hidden="true" data-dismiss="modal" onclick="closeDetailModal()">&times;</button>
	         	<h4 class="modal-title" id="modelTitle">盘点详情</h4>
	         </div>
	         <div class="modal-body">
	         	<iframe id="detailIFrame" frameborder="0"></iframe>
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
			url :  "${wmsUrl}/admin/stock/cnCheck/dataList.shtml",
			numPerPage:"10",
			currentPage:"",
			index:"1",
			callback:rebuildTable
}

$(function(){
	 $(".pagination-nav").pagination(options);
	 
	 $("#saveCheckBtn").click(function(){
		 $("#addIFrame")[0].contentWindow.submitForm();
	 });
	 
	 $("#checkBtn").click(function(){
		 $("#editIFrame")[0].contentWindow.check();
	 });
	 
})

/**
  * 在页面中任何嵌套层次的窗口中获取顶层窗口
  * @return 当前页面的顶层窗口对象
  */
 function getTopWindow(){
     var p = window;
    while(p != p.parent){
        p = p.parent;
     }
     return p;
 }

function reloadTable(){
	$.page.loadData(options);
}

function closeAddModal(){
	$("#addModal").modal("hide");
}

function closeEditModal(){
	reloadTable();
	$("#editModal").modal("hide");
}

function check(){
	reloadTable();
	$("#editModal").modal("hide");
}

function closeDetailModal(){
	$("#detailModal").modal("hide");
}

/**
 * 重构table
 */
function rebuildTable(data){
	$.zzComfirm.endMask();
	$("#checkTable tbody").html("");


	if (data == null || data.length == 0) {
		return;
	}
	
	var list = data.obj;
	
	if (list == null || list.length == 0) {
		$.zzComfirm.alertError("没有查到数据");
		return;
	}

	var str = "";
	var declStatusStr = "";
	var customStatusStr = "";
	for (var i = 0; i < list.length; i++) {
		if("${privilege>=2}"=="true"){
			str += "<tr><td>";
			if(list[i].status!=2){
				str += "<button type='button' class='btn btn-info' onclick='showEditModal("+list[i].id+")'>修改</button><button type='button' class='btn btn-info' onclick='deleteCheckStock("+list[i].id+")'>删除</button></td><td><a href='javascript:void(0)' onclick='viewDetail("+ list[i].id+")' style='color:black;text-decoration:none;'>"+list[i].id+"</a>" ;
			}else{
				str += "</td><td><a href='javascript:void(0)' onclick='viewDetail("+ list[i].id+")' style='color:black;text-decoration:none;'>"+list[i].id+"</a>" ;
			}
		}else{
			str += "<tr><td></td><td><a href='javascript:void(0)' onclick='viewDetail("+ list[i].id+")' style='color:black;text-decoration:none;'>"+list[i].id+"</a></td>";
		}
		switch(list[i].status){
			case '1': str += "</td><td>待盘点";break;
   			case '2':	str += "</td><td>已盘点";break;
   			case '3':	str += "</td><td>取消";break;
   			case '4':	str += "</td><td>盘点失败";break;
   			default: str += "</td><td>无";
		}
		
		switch(list[i].orderType){
			case '1': str += "</td><td>错发";break;
			case '2':	str += "</td><td>漏发";break;
			case '3':	str += "</td><td>进货";break;
			case '4':	str += "</td><td>盘点";break;
			case '5':	str += "</td><td>其他";break;
			default: str += "</td><td>无";
		}
		
		str += "</td><td>" + (list[i].supplierId==null?"无":list[i].supplierId);
		str += "</td><td>" + (list[i].supplierName==null?"无":list[i].supplierName);
		str += "</td><td>" + (list[i].orderNo==null?"无":(list[i].orderNo));
		str += "</td><td>" + (list[i].orderCode==null?"无":(list[i].orderCode));
		str += "</td><td>" + (list[i].createTime==null?"无":list[i].createTime);
		str += "</td><td>" + (list[i].updateTime==null?"无":list[i].updateTime);
		str += "</td><td>" + (list[i].opt==null?"无":list[i].opt);
		str += "</td></tr>";
	}
	
	
	$("#checkTable tbody").htmlUpdate(str);
}

function viewDetail(id){
	var frameSrc = '${wmsUrl}/admin/stock/cnCheck/viewDetail.shtml?id='+id;
       $("#detailIFrame").attr("src", frameSrc);
       $('#detailModal').modal({ show: true, backdrop: 'static' });
}

function showAddModal(){
       var frameSrc = "${wmsUrl}/admin/stock/cnCheck/addCheck.shtml";
       $("#addIFrame").attr("src", frameSrc);
       $('#addModal').modal({ show: true, backdrop: 'static' });
}

function showEditModal(id){
       var frameSrc = "${wmsUrl}/admin/stock/cnCheck/editCheck.shtml?id="+id;
       $("#editIFrame").attr("src", frameSrc);
       $('#editModal').modal({ show: true, backdrop: 'static' });
}

function deleteCheckStock(id){
	$.zzComfirm.alertConfirm("确定要删除吗？",function(){
		$.ajax({
			 url:"${wmsUrl}/admin/stock/cnCheck/deleteCheck.shtml?id="+id,
			 type:'post',
			 dataType:'json',
			 success:function(data){
				 if(data.success){	
					 $.zzComfirm.alertSuccess("删除成功！");
					 reloadTable();
				 }else{
					 $.zzComfirm.alertError(data.msg);
				 }
			 },
			 error:function(){
				 $.zzComfirm.alertError("系统出现问题啦，快叫技术人员处理");
			 }
		 });
	});
}

</script>
</body>
</html>
