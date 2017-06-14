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
<title>预包新增</title>
<%@include file="../resource.jsp" %>
</head>

<body>
	<div id="page-wrapper">
		<div class="container-fluid">
			<form role="form" id="preForm">
			<table class="table table-bordered">
				<tr>
					<td><label>预包编号:</label></td><td><label style="color:red"><input type='text' class="form-control" id="pid" name="pid" value="${prePacInfo.pid}" readonly="readonly"></label></td>	 
					<td><label>预包名称:</label></td><td><input type='text' class="form-control" id="preName" name="preName" value="${prePacInfo.preName}"></td>
				</tr>
				<tr>
					<td><label>商家编码:</label></td>
					<td>
						<input type='text' class="form-control" id="supplierId" readonly name="supplierId" value="${prePacInfo.supplierId}">
					</td>	 
					<td><label>商家名称:</label></td>
					<td><input type='text' class="form-control" readonly id="supplierName" name="supplierName" value="${prePacInfo.supplierName}"></td>
				</tr>
				<tr>
					<td><label>包材编码:</label></td>
					<td>
						<input type='text' class="form-control" id="pacId" readonly name="pacId" value="${prePacInfo.pacId}">
						<button type="button" class="btn btn-warning" onclick="showPackage()">查看</button>
					</td>	 
					<td><label>包材规格:</label></td>
					<td><input type='text' class="form-control" readonly id="pacSpec" name="pacSpec" value="${prePacInfo.pacSpec}"></td>
				</tr>
				<tr>
					<td><label>备注:</label></td>
					<td colspan="3"><input type='text' class="form-control" id="remark" name="remark" value="${prePacInfo.remark}"  ></td>	 
				</tr>
				</table>
			
				<div class="row">
					<div class="col-lg-12">
						<div class="panel panel-default" >
							<button type="button" class="btn btn-primary" onclick="showAddSupGoodsModal()">新增商品</button>
							<table id="preTable" class="table table-hover">
								<thead>
									<tr>
										<th>操作</th>
										<th>货号</th>
										<th>商品名称</th>
										<th>数量</th>
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
			</form>
		</div>
	</div>

	<div class="modal fade" id="packageModal" tabindex="-1" role="dialog" aria-hidden="true">
	   <div class="modal-dialog"  >
	      <div class="modal-content"  >
	         <div class="modal-header">
	            <button type="button" class="close"  aria-hidden="true" data-dismiss="modal" onclick="closePacModal()">&times;</button>
	         	<h4 class="modal-title" id="modelTitle">包材选择</h4>
	         </div>
	         <div class="modal-body"  >
	         	<iframe id="packageIFrame" width="100%" height="100%" frameborder="0"></iframe>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closePacModal()">取消 </button>
	         </div>
	      </div>
		</div>
	</div>
	
	<div class="modal fade" id="addSupGoodsModal" tabindex="-1" role="dialog" aria-hidden="true">
	   <div class="modal-dialog"  >
	      <div class="modal-content"  >
	         <div class="modal-header">
	         	<h4 class="modal-title" id="modelTitle">新增商品</h4>
	         </div>
	         <div class="modal-body"  >
	         	<iframe id="addSupGoodsIFrame" width="100%" height="100%" frameborder="0"></iframe>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeAddModal()">取消 </button>
	            <button type="button" class="btn btn-info" id="saveGoodsBtn">保存</button>
	         </div>
	      </div>
		</div>
	</div>

<script type="text/javascript">
$(".dataPicker").datetimepicker({format: 'yyyy-mm-dd'});
/**
 * 初始化分页信息
 */
var options = {
			queryForm : ".query",
			url :  "${wmsUrl}/admin/prePackage/prePacMng/editList.shtml?pid=${prePacInfo.pid}",
			numPerPage:"10",
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
			if("${type==0}"=="true"){
				str += "<tr><td><button type='button' class='btn btn-danger' onclick='deleteItem(this,"+list[i].id+")'>删除</button>&nbsp;&nbsp;<button type='button' class='btn btn-info' onclick='editItem("+list[i].id+")'>修改</button>" ;
			}else{
				str += "<tr><td>";
			}
		}else{
			str += "<tr><td>";
		}
		
		str += "</td><td>" + list[i].sku;
		
		str += "</td><td>" + list[i].skuName;
		
		str += "</td><td>" + list[i].quantity;
		
		str += "</td><td>" + list[i].remark;
		
		str += "</td></tr>";
	}
	
	
	$("#preTable tbody").html(str);
}


function submitForm() {
	
	var pacId = $("input[name=pacId]").val();
	if(pacId == null || pacId == ""){
		$.zzComfirm.alertError("请输入包材信息");
		return false;
	}
	
	var preName = $("input[name=preName]").val();
	if(preName == null || preName == ""){
		$.zzComfirm.alertError("请输入预包名称");
		return false;
	}
	$.ajax({
		type : "post",
		data : sy.serializeObject($('#preForm')),
		dataType : 'json',
		url : '${wmsUrl}/admin/prePackage/prePacMng/updatePre.shtml',
		dataType:'json',
		success : function(data) {
			if (data.success) {
				$.zzComfirm.alertSuccess("修改成功！");
				window.parent.reloadTable();
				window.parent.closeEditModal();
			} else {
				$.zzComfirm.alertError(data.errInfo);
			}
		},
		error : function(data) {
			$.zzComfirm.alertError("操作失败，请联系管理员！");
		}
	});
};

function showPackage(){
	var frameSrc = "${wmsUrl}/admin/basic/packageMaterial/showDetail.shtml";
    $("#packageIFrame").attr("src", frameSrc);
    $('#packageModal').modal({ show: true, backdrop: 'static' });
}

function closePacModal(){
	$('#packageModal').modal('hide');
}

function closeAddModal(){
	$('#addSupGoodsModal').modal('hide');
}

function reloadTable(){
	$.page.loadData(options);
}

function showAddSupGoodsModal(){
	
    var frameSrc = "${wmsUrl}/admin/prePackage/prePacMng/showAddSupGoods.shtml?pid=${prePacInfo.pid}";
    $("#addSupGoodsIFrame").attr("src", frameSrc);
    $('#addSupGoodsModal').modal({ show: true, backdrop: 'static' });
}

function editItem(id){
	
    var frameSrc = "${wmsUrl}/admin/prePackage/prePacMng/showAddSupGoods.shtml?pid=${prePacInfo.pid}&goodsId="+id+"&type=1";
    $("#addSupGoodsIFrame").attr("src", frameSrc);
    $('#addSupGoodsModal').modal({ show: true, backdrop: 'static' });
}

function deleteItem(obj,value){
	$.zzComfirm.alertConfirm("确定要删除吗？",function(){
		$.ajax({
			 url:"${wmsUrl}/admin/prePackage/prePacMng/deleteItem.shtml?id="+value,
			 type:'post',
			 dataType:'json',
			 success:function(data){
				 if(data.success){	
					$.zzComfirm.alertSuccess("删除成功!");
					$(obj).parent().parent().remove();
					return;
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
