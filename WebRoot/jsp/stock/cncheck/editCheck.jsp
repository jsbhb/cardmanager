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
<title>盘点更新</title>
<%@include file="../../resource.jsp" %>
</head>

<body>
	<div id="page-wrapper">
		<div class="container-fluid">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">
						<i class="fa fa-bar-chart-o fa-fw"></i>商家信息
					</h3>
				</div>
				<div class="panel-body">
					<table class="table table-bordered">
						<tr>
							<td><label>商家编码:</label></td>
							<td><label>${check.supplierId}</label>	 
							<td><label>商家名称:</label></td>
							<td><label>${check.supplierName}</label></td>
						</tr>
					</table>
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">
						<i class="fa fa-bar-chart-o fa-fw"></i>盘点信息
					</h3>
				</div>
				<div class="panel-body">
					<table class="table table-bordered">
						<tr>
							<td><label>盘点编号:</label></td><td>${check.id}</td>
								
							<td><label>盘点单据:</label></td><td><label>${check.orderno}</label></td>
						</tr>
						<tr>
							<td><label>最后操作人:</label></td>
							<td><label>${check.opt}</label></td>		
							<td><label>盘点状态:</label></td>
							<td>
								<c:if test="${check.status==1}">
									<label style='color:green' id="status">待盘点</label>
								</c:if>
								<c:if test="${check.status==2}">
									<label style='color:black' id="status">已盘点</label>
								</c:if>
								<c:if test="${check.status==3}">
									<label style='color:red' id="orderType">取消</label>
								</c:if>
								<c:if test="${check.status==4}">
									<label style='color:red' id="status">盘点失败</label>
								</c:if>
							</td>
						</tr>
						<tr>
							<td><label>创建时间:</label></td>
							<td><label>${check.createTime}</label></td>	 
							<td><label>更新时间:</label></td>
							<td><label>${check.updateTime}</label></td>
						</tr>
						<tr>
							<td><label>备注:</label></td>
							<td colspan="3">${check.remark}</td>	 
						</tr>
					</table>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<c:if test="${check.status!=2}">
						<button type="button" class="btn btn-primary" onclick="showAddSupGoodsModal()">添加商品</button>
					</c:if>
					<table id="checkTable" class="table table-hover">
						<thead>
							<tr>
								<th>操作</th>
								<th>类型</th>
								<th>数量</th>
								<th>店铺编码</th>
								<th>店铺名称</th>
								<th>商品编号</th>
								<th>商品编码</th>
								<th>商品货号</th>
								<th>商品名称</th>
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
	<div class="modal fade" id="addSupGoodsModal" tabindex="-1" role="dialog" aria-hidden="true">
	   <div class="modal-dialog">
	      <div class="modal-content">
	         <div class="modal-header">
	         	<h4 class="modal-title" id="modelTitle">新增商品</h4>
	         </div>
	         <div class="modal-body">
	         	<iframe id="addSupGoodsIFrame" height="100%" frameborder="0"></iframe>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeAddModal()">取消 </button>
	            <button type="button" class="btn btn-info" id="saveGoodsBtn">保存</button>
	         </div>
	      </div>
		</div>
	</div>

<script type="text/javascript">

var options = {
		queryForm : ".query",
		url :  "${wmsUrl}/admin/stock/cnCheck/queryItemByCheckId.shtml?checkId=${check.id}",
		numPerPage:"1000",
		currentPage:"",
		index:"1",
		callback:rebuildTable
}

$(function(){
	 $(".pagination-nav").pagination(options);
	 
	 $("#saveGoodsBtn").click(function(){
		 $("#addSupGoodsIFrame")[0].contentWindow.submitForm();
	 });
})

/**
* 重构table
*/
function rebuildTable(data){
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
	for (var i = 0; i < list.length; i++) {
		str += "<tr><td><button type='button' style='width:50px' onclick=\"editItem(this,'"+list[i].id+"')\" class=\"btn btn-info\">修改</button><button type='button' style='width:50px' onclick=\"deleteItem(this,'"+list[i].id+"')\" class=\"btn btn-info\">删除</button>";
		
		var type = list[i].type;
		
		switch(type){
			case '1':str +="</td><td>盘盈";break;
			case '2':str +="</td><td>盘亏";break;
			case '3':str +="</td><td>盘次品";break;
			default:str +="</td><td>无";
		}
		
		str += "</td><td>" + list[i].quantity;
		str += "</td><td>" + (list[i].ownerUserId==null?"无":list[i].ownerUserId);
		str += "</td><td>" + (list[i].shopName==null?"无":list[i].shopName);
		str += "</td><td>" + (list[i].itemId==null?"无":list[i].itemId);
		str += "</td><td>" + (list[i].itemCode==null?"无":list[i].itemCode);
		str += "</td><td>" + (list[i].sku==null?"无":list[i].sku);
		str += "</td><td>" + (list[i].skuName==null?"无":list[i].skuName);
		str += "</td><td>" + (list[i].remark==null?"无":list[i].remark);
		str += "</td></tr>";
	}
	
	
	$("#checkTable tbody").htmlUpdate(str);
	
}
function deleteItem(obj,checkItemId){
	$.zzComfirm.alertConfirm("确定要删除吗？",function(){
		$.ajax({
			type:"post",
			url:'${wmsUrl}/admin/stock/cnCheck/deleteItemById.shtml?checkItemId='+checkItemId,
			dataType:"json",
			success: function(data){
				if(data.success){
					$.zzComfirm.alertSuccess("删除成功!");
					$(obj).parent().parent().remove();
					return;
				}else{
					$.zzComfirm.alertError(data.msg);
				}
			},
			error:function(){
				$.zzComfirm.alertError("访问异常");
			}
		});
	});
}

function check(){
	$.zzComfirm.alertConfirm("确定开始盘点吗？",function(){
		$.ajax({
			type:"post",
			url:"${wmsUrl}/admin/stock/cnCheck/check.shtml?checkId=${check.id}",
			dataType:"json",
			success: function(data){
				if(data.success){
					$.zzComfirm.alertSuccess("盘点成功!");
					window.parent.reloadTable();
					window.parent.closeEditModal();
					return;
				}else{
					$.zzComfirm.alertError(data.msg);
				}
			},
			error:function(){
				$.zzComfirm.alertError("访问异常");
			}
		});
	});
}

function closeAddModal(){
	$('#addSupGoodsModal').modal('hide');
}

function reloadTable(){
	$.page.loadData(options);
}

function showAddSupGoodsModal(){
	 var frameSrc = "${wmsUrl}/admin/stock/cnCheck/showAddSupGoods.shtml?checkId="+${check.id};
	    $("#addSupGoodsIFrame").attr("src", frameSrc);
	    $('#addSupGoodsModal').modal({ show: true, backdrop: 'static' });
}
	
function editItem(obj,checkItemId){
    var frameSrc = "${wmsUrl}/admin/stock/cnCheck/showAddSupGoods.shtml?checkItemId="+checkItemId+"&checkId="+${check.id}+"&type=1";
    $("#addSupGoodsIFrame").attr("src", frameSrc);
    $('#addSupGoodsModal').modal({ show: true, backdrop: 'static' });
}

</script>
</body>
</html>
