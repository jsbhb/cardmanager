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
<title>预进货管理</title>
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
								<label>&nbsp;&nbsp;&nbsp;进货号:</label> <input type="text" class="form-control"  name="asnStockId">
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
								<label>&nbsp;&nbsp;&nbsp;报检号:</label> <input type="text" class="form-control" name="declNo">
							</div>
							<div class="form-group">
								<label>&nbsp;&nbsp;&nbsp;报关号:</label> <input type="text" class="form-control" name="customsNo">
							</div>
							<div class="form-group">
								<label>单据状态:</label>
								<select name="status" class="form-control span2"  id="status">
									<option value="0">全部</option>
									<option value="1">预进货</option>
									<option value="2">到港</option>
									<option value="99">粗点</option>
									<option value="4">精点</option>
									<option value="5">报备失败</option>
									<option value="6">报备成功</option>
									<option value="7">上架</option>
									<option value="21">采购单差异</option>
									<option value="31">申报成功</option>
									<option value="32">申报失败</option>
									
								</select>
							</div>
						</div>
						<div class="row">
							<div class="form-group">
								<label>报关单审核:</label>
								<select name="customStatus" class="form-control span2"  id="customStatus">
									<option value="-1">全部</option>
									<option value="0">未审核</option>
									<option value="1">已审核</option>
									<option value="2">打回</option>
								</select>
							</div>
							<div class="form-group">
								<label>报检单审核:</label>
								<select name="declStatus" class="form-control span2"  id="declStatus">
									<option value="-1">全部</option>
									<option value="0">未审核</option>
									<option value="1">已审核</option>
									<option value="2">打回</option>
								</select>
							</div>
							<div class="form-group">
								<label>更新时间:</label> 
								<input size="16" type="text" id="startTime"  class="form-control dataPicker" name="startTime">
								<span class="add-on"><i class="icon-th"></i></span>
								<label>&nbsp;至&nbsp;</label> 
								<input size="16" type="text" id="endTime"  class="form-control dataPicker" name="endTime">
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
								<i class="fa fa-bar-chart-o fa-fw"></i>预进货列表
							</h3>
						</div>
						<div class="panel-body">
							<c:if test="${privilege>=2}">
								<button type="button" class="btn btn-primary" onclick="showAddModal()">新增</button>
								<button type="button" class="btn btn-primary" onclick="bindAddModal()">绑定入库单新增</button>
							</c:if>
							<table id="asnTable" class="table table-hover">
								<thead>
									<tr>
										<th>操作</th>
										<th>进货号</th>
										<th>状态</th>
										<th>申报单号</th>
										<th>类型</th>
										<th>供应商编号</th>
										<th>供应商名称</th>
										<th>报检号</th>
										<th>报关号</th>
										<th>载货清单号</th>
										<th>启运国</th>
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
	         	<h4 class="modal-title" id="modelTitle">预进货新增</h4>
	         </div>
	         <div class="modal-body">
	         	<iframe id="addIFrame" frameborder="0"></iframe>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeAddModal()">取消 </button>
	            <button type="button" class="btn btn-info" id="saveAsnBtn">新增 </button>
	         </div>
	      </div>
		</div>
	</div>
	<div class="modal fade" id="bindModal" tabindex="-1" role="dialog" aria-hidden="true">
	   <div class="modal-dialog">
	      <div class="modal-content">
	         <div class="modal-header">
	            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="closeBindModal()">&times;</button>
	         	<h4 class="modal-title" id="modelTitle">绑定入库单新增</h4>
	         </div>
	         <div class="modal-body">
	         	<iframe id="bindIFrame" frameborder="0"></iframe>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeBindModal()">取消 </button>
	            <button type="button" class="btn btn-info" id="bindAndSaveBtn">新增预进货 </button>
	         </div>
	      </div>
		</div>
	</div>
	<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-hidden="true">
	   <div class="modal-dialog">
	      <div class="modal-content">
	         <div class="modal-header">
	            <button type="button" class="close"  aria-hidden="true" data-dismiss="modal" onclick="closeEditModal()">&times;</button>
	         	<h4 class="modal-title" id="modelTitle">预进货维护</h4>
	         </div>
	         <div class="modal-body">
	         	<iframe id="editIFrame" frameborder="0"></iframe>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeEditModal()">取消 </button>
	         	<button type="button" class="btn btn-info" id="updateAsnBtn">修改 </button>
	         </div>
	      </div>
		</div>
	</div>
	<div class="modal fade" id="detailModal" tabindex="-1" role="dialog" aria-hidden="true">
	   <div class="modal-dialog">
	      <div class="modal-content">
	         <div class="modal-header">
	            <button type="button" class="close"  aria-hidden="true" data-dismiss="modal" onclick="closeDetailModal()">&times;</button>
	         	<h4 class="modal-title" id="modelTitle">预进货详情</h4>
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
			url :  "${wmsUrl}/admin/stockIn/asnMng/dataList.shtml",
			numPerPage:"10",
			currentPage:"",
			index:"1",
			callback:rebuildTable
}

$(function(){
	 $(".pagination-nav").pagination(options);
	 
	 $("#saveAsnBtn").click(function(){
		 $("#addIFrame")[0].contentWindow.submitForm();
	 });
	 
	 $("#updateAsnBtn").click(function(){
		 $("#editIFrame")[0].contentWindow.submitForm();
	 });
	 
	 $("#bindAndSaveBtn").click(function(){
		 $("#bindIFrame")[0].contentWindow.submitForm();
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
	$("#editModal").modal("hide");
}

function closeDetailModal(){
	$("#detailModal").modal("hide");
}

function closeBindModal(){
	$.ajax({
		 url:"${wmsUrl}/admin/stockIn/asnMng/cancleBind.shtml",
		 type:'post',
		 dataType:'json',
		 success:function(data){
			 if(data.success){	
				 $("#bindModal").modal("hide");
				 reloadTable();
			 }else{
				 $.zzComfirm.alertError(data.msg);
			 }
		 },
		 error:function(){
			 $.zzComfirm.alertError("系统出现问题啦，快叫技术人员处理");
		 }
	 });
}

/**
 * 重构table
 */
function rebuildTable(data){
	$.zzComfirm.endMask();
	$("#asnTable tbody").htmlUpdate("");


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
			
			if(list[i].status<=2&&list[i].declStatus!='1'&&list[i].customStatus!='1'){
				str += "<tr><td><button type='button' class='btn btn-info' onclick='showEditModal("+list[i].asnStockId+")'>修改</button><button type='button' class='btn btn-info' onclick='deleteAsnStock("+list[i].asnStockId+")'>删除</button></td><td><a href='javascript:void(0)' onclick='viewDetail("+ list[i].asnStockId+")' style='color:black;text-decoration:none;'>"+list[i].asnStockId+"</a>" ;
			}else{
				str += "<tr><td><button type='button' class='btn btn-info' onclick='showEditModal("+list[i].asnStockId+")'>修改</button></td><td><a href='javascript:void(0)' onclick='viewDetail("+ list[i].asnStockId+")' style='color:black;text-decoration:none;'>"+list[i].asnStockId+"</a>" ;
			}
		}else{
			str += "<tr><td></td><td><a href='javascript:void(0)' onclick='viewDetail("+ list[i].asnStockId+")' style='color:black;text-decoration:none;'>"+list[i].asnStockId+"</a></td>";
		}
		switch(list[i].status){
			case 1: str += "</td><td>预进货";break;
     			case 2:	str += "</td><td>到港";break;
     			case 3:	str += "</td><td>报关";break;
     			case 4:	str += "</td><td>精点";break;
     			case 5:	str += "</td><td>报备失败";break;
     			case 6:	str += "</td><td>报备成功";break;
     			case 7:	str += "</td><td>上架";break;
     			case 11:str += "</td><td>撤单";break;
     			case 21:str += "</td><td>采购单差异";break;
     			case 31:str += "</td><td>申报成功";break;
     			case 32:str += "</td><td>申报失败";break;
     			case 41:str += "</td><td>改单";break;
     			case 99:str += "</td><td>粗点";break;
     			default: str += "</td><td>无";
		}
		
		str += "</td><td>" + (list[i].externalNo==null?"无":list[i].externalNo);
	
		switch(list[i].type){
			case 0: str += "</td><td>本地";break;
			case 1:	str += "</td><td>转关";break;
			default: str += "</td><td>无";
		}
		
		switch(list[i].declStatus){
			case '0': declStatusStr = "<lable style='color:black'>(未审核)</label>";break;
			case '1': declStatusStr = "<lable style='color:green'>(已审核)</label>";break;
			case '2': declStatusStr = "<lable style='color:red'>(已打回)</label>";break;
		}
		
		switch(list[i].customStatus){
		case '0': customStatusStr = "<lable style='color:black'>(未审核)</label>";break;
		case '1': customStatusStr = "<lable style='color:green'>(已审核)</label>";break;
		case '2': customStatusStr = "<lable style='color:red'>(已打回)</label>";break;
		}
		
		str += "</td><td>" + (list[i].supplierId==null?"无":list[i].supplierId);
		str += "</td><td>" + (list[i].supplierName==null?"无":list[i].supplierName);
		str += "</td><td>" + (list[i].declNo==null?"无":(list[i].declNo+declStatusStr));
		str += "</td><td>" + (list[i].customsNo==null?"无":(list[i].customsNo+customStatusStr));
		str += "</td><td>" + (list[i].transportGoodsNo==null?"无":list[i].transportGoodsNo);
		str += "</td><td>" + (list[i].originCountry==null?"无":list[i].originCountry);
		str += "</td><td>" + (list[i].createTime==null?"无":list[i].createTime);
		str += "</td><td>" + (list[i].updateTime==null?"无":list[i].updateTime);
		str += "</td><td>" + (list[i].opt==null?"无":list[i].opt);
		str += "</td></tr>";
	}
	
	
	$("#asnTable tbody").htmlUpdate(str);
}

function viewDetail(value){
	var frameSrc = '${wmsUrl}/admin/stockIn/asnMng/viewDetail.shtml?asnStockId='+value;
       $("#detailIFrame").attr("src", frameSrc);
       $('#detailModal').modal({ show: true, backdrop: 'static' });
}

function showAddModal(){
       var frameSrc = "${wmsUrl}/admin/stockIn/asnMng/addAsn.shtml";
       $("#addIFrame").attr("src", frameSrc);
       $('#addModal').modal({ show: true, backdrop: 'static' });
}

/**
 * 绑定入库单
 */
function bindAddModal(){
    var frameSrc = "${wmsUrl}/admin/stockIn/asnMng/bind.shtml";
    $("#bindIFrame").attr("src", frameSrc);
    $('#bindModal').modal({ show: true, backdrop: 'static' });
}

function showEditModal(asnStockId){
       var frameSrc = "${wmsUrl}/admin/stockIn/asnMng/editAsn.shtml?asnStockId="+asnStockId;
       $("#editIFrame").attr("src", frameSrc);
       $('#editModal').modal({ show: true, backdrop: 'static' });
}

function deleteAsnStock(asnStockId){
	
	$.zzComfirm.alertConfirm("确定要删除吗？",function(){
		$.ajax({
			 url:"${wmsUrl}/admin/stockIn/asnMng/deleteAsn.shtml?asnStockId="+asnStockId,
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
