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
<title>理货管理</title>
<%@include file="../../resource.jsp" %>
</head>

<body>
	<div id="page-wrapper">

		<div class="container-fluid">
			<!-- Page Heading -->
			<div class="row">
				<div class="col-lg-12">
					<ol class="breadcrumb">
						<li><i class="fa fa-truck fa-fw"></i>进货管理</li>
						<li class="active"><i class="fa fa-user-md fa-fw"></i>理货管理</li>
					</ol>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="query">
						<div class="row">
							<div class="form-group">
								<label>进货号:</label> <input type="text" class="form-control"  name="asnStockId">
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
								<label>报检号:</label> <input type="text" class="form-control" name="declNo">
							</div>
							<div class="form-group">
								<label>报关号:</label> <input type="text" class="form-control" name="customsNo">
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
									<option value="11">撤单</option>
									<option value="21">采购单差异</option>
									<option value="41">改单</option>
								</select>
							</div>
						</div>
						<div class="row">
							<div class="form-group">
								<label>创建时间:</label> 
								<input size="16" type="text" id="startTime"  class="form-control dataPicker" name="startTime">
								<span class="add-on"><i class="icon-th"></i></span>
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
								<i class="fa fa-bar-chart-o fa-fw"></i>进货列表
							</h3>
						</div>
						<div class="panel-body">
							<table id="asnTable" class="table table-hover table-bordered">
								<thead>
									<tr>
										<th>操作</th>
										<th>进货号</th>
										<th>状态</th>
										<th>类型</th>
										<th>载货清单号</th>
										<th>供应商编号</th>
										<th>供应商名称</th>
										<th>报检号</th>
										<th>报关号</th>
										<th>启运国</th>
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
	</div>
	<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-hidden="true">
	   <div class="modal-dialog">
	      <div class="modal-content">
	         <div class="modal-header">
	            <button type="button" class="close"  aria-hidden="true" data-dismiss="modal" onclick="closeEditModel();">&times;</button>
	         	<h4 class="modal-title" id="modelTitle">理货信息</h4>
	         </div>
	         <div class="modal-body">
	         	<iframe id="editIFrame" frameborder="0"></iframe>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeEditModel();">取消 </button>
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
	})
	
	function reloadTable(){
		$.page.loadData(options);
	}
	
	function closeEditModel(){
		$("#editModal").modal("hide");
	}
	
	/**
	 * 重构table
	 */
	function rebuildTable(data){
		$("#asnTable tbody").html("");
	
	
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
			str += "<tr><td><button type='button' class='btn btn-info' onclick='showEditModal("+list[i].asnStockId+")'>查看</button></td><td>"+list[i].asnStockId ;
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
      			case 41:str += "</td><td>改单";break;
      			case 99:str += "</td><td>已粗点";break;
      			default: str += "</td><td>无";
			}
		
			
			switch(list[i].type){
				case 0: str += "</td><td>本地";break;
				case 1:	str += "</td><td>转关";break;
				default: str += "</td><td>无";
			}
			str += "</td><td>" + (list[i].transportGoodsNo==null?"无":list[i].transportGoodsNo);
			str += "</td><td>" + (list[i].supplierId==null?"无":list[i].supplierId);
			str += "</td><td>" + (list[i].supplierName==null?"无":list[i].supplierName);
			str += "</td><td>" + (list[i].declNo==null?"无":(list[i].declNo));
			str += "</td><td>" + (list[i].customsNo==null?"无":(list[i].customsNo));
			str += "</td><td>" + (list[i].originCountry==null?"无":list[i].originCountry);
			str += "</td><td>" + (list[i].createTime==null?"无":list[i].createTime);
			str += "</td><td>" + (list[i].updateTime==null?"无":list[i].updateTime);
			str += "</td><td>" + (list[i].opt==null?"无":list[i].opt);
			str += "</td></tr>";
		}
		
		
		$("#asnTable tbody").htmlUpdate(str);
	}
	
	
	function showEditModal(asnStockId){
        var frameSrc = "${wmsUrl}/admin/stockIn/tally/showTally.shtml?asnStockId="+asnStockId;
        $("#editIFrame").attr("src", frameSrc);
        $('#editModal').modal({ show: true, backdrop: 'static' });
	}
	
	</script>
</body>
</html>
