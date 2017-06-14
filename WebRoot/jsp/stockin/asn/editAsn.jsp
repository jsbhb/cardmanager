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
<title>明细维护</title>
<%@include file="../../resource.jsp" %>
</head>

<body>
	<div id="page-wrapper">
		<div class="container-fluid">
			<form role="form" id="asnForm" enctype="multipart/form-data">
				<table class="table table-bordered">
					<tr>
						<td><label>进货号:</label></td><td><input type='text' value="${asnStock.asnStockId}" readonly class="form-control" id="asnStockId" name="asnStockId" required></td>	 
						<td><label>是否转关:</label></td>
						<td>
							<select name="type" class="form-control span2"  id="type">
								<c:if test="${asnStock.type==0}">
								<option value="0" selected="selected">本地</option>
								<option value="1">转关</option>
								</c:if>
								<c:if test="${asnStock.type==1}">
								<option value="0">本地</option>
								<option value="1" selected="selected">转关</option>
								</c:if>
							</select>
						</td>
					</tr>
					<tr>
						<td><label>报检号:</label></td>
						<td>
							<c:choose>
								<c:when test="${asnStock.declStatus==1}">
									<input type='text' value="${asnStock.declNo}" readonly class="form-control" id="declNo" name="declNo" required>
								</c:when>
								<c:otherwise>
									<input type='text' value="${asnStock.declNo}" class="form-control" id="declNo" name="declNo" required>
								</c:otherwise>
							</c:choose>
							<c:if test="${asnStock.declStatus==1}">
									<label style='color:green' id="declAuditStatus">已审核</label>
								</c:if>
								<c:if test="${asnStock.declStatus==0}">
									<label style='color:black' id="declAuditStatus">未审核</label>
								</c:if>
								<c:if test="${asnStock.declStatus==2}">
									<label style='color:red' id="declAuditStatus">已打回</label>
							</c:if>
						</td>
						<td><label>报检单上传:</label></td>
						<td>
							<c:choose>
								<c:when test="${asnStock.declFile==null}">
									<input id="declFile" type="file" style="display:none"  name="declFile">
									<div class="input-append">
										<input id="declFileName" readonly class="form-control" type="text" onclick="$('input[id=declFile]').click();">
										<button type="button" class="btn btn-info"  onclick="uploadDeclFile()">上传 </button>
									</div>
								</c:when>
								<c:otherwise>
									<img src="${wmsUrl}/upload/asn/${asnStock.asnStockId}/${asnStock.declFile}" data-action="zoom" class="img-rounded" style="width:70px;height:100px">
									<button type="button" class="btn btn-info" data-dismiss="modal" onclick="showPicModal('${asnStock.declFile}')">查看图片 </button>
									<c:if test="${asnStock.declStatus!=1 && asnStock.declNo!=null&&privilege==3}">
										<div id="declFileId">
											<button type="button" class="btn btn-info" id="declAuditBtn"  onclick="auditPass(0)">复核通过</button>
											<button type="button" class="btn btn-info" id="declBackBtn"  onclick="auditBack(0)">打回</button>
										</div>
									</c:if>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<td><label>报关号:</label></td>
						<td>
							<c:choose>
								<c:when test="${asnStock.customStatus==1}">
									<input type='text' value="${asnStock.customsNo}" readonly class="form-control" id="customsNo" name="customsNo">
								</c:when>
								<c:otherwise>
									<input type='text' value="${asnStock.customsNo}" class="form-control" id="customsNo" name="customsNo">
								</c:otherwise>
							</c:choose>
							<c:if test="${asnStock.customStatus==1}">
									<label style='color:green' id="customAuditStatus">已审核</label>
							</c:if>
							<c:if test="${asnStock.customStatus==0}">
								<label style='color:black' id="customAuditStatus">未审核</label>
							</c:if>
							<c:if test="${asnStock.customStatus==2}">
								<label style='color:red' id="customAuditStatus">已打回</label>
							</c:if>
						</td>	 
						<td><label>报关单上传:</label></td>
						<td>
							<c:choose>
								<c:when test="${asnStock.customsFile==null}">
									<input id="customsFile" type="file" style="display:none" name="customsFile">
									<div class="input-append">
										<input id="customsFileName" readonly class="form-control" type="text" onclick="$('input[id=customsFile]').click();">
										<button type="button" class="btn btn-info"  onclick="uploadCustomsFile()">上传 </button>
									</div>
								</c:when>
								<c:otherwise>
									<img src="${wmsUrl}/upload/asn/${asnStock.asnStockId}/${asnStock.customsFile}" data-action="zoom" class="img-rounded" style="width:70px;height:100px">
									<button type="button" class="btn btn-info" data-dismiss="modal" onclick="showPicModal('${asnStock.customsFile}')">查看图片 </button>
									<c:if test="${asnStock.customStatus!=1 && asnStock.customsNo!=null&&privilege==3}">
										<div id="customsFileId">
											<button type="button" class="btn btn-info" id="customsAuditBtn"  onclick="auditPass(1)">复核通过</button>
											<button type="button" class="btn btn-info" id="customsBackBtn" onclick="auditBack(1)">打回</button>
										</div>
									</c:if>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<td><label>商家编码:</label></td>
						<td>
							<input type='text' class="form-control" id="supplierId" value="${asnStock.supplierId}" readonly name="supplierId">
						</td>	 
						<td><label>商家名称:</label></td>
						<td><input type='text' class="form-control" readonly id="supplierName" value="${asnStock.supplierName}" name="supplierName"></td>
					</tr>
					<tr>
						<td><label>送资料时间:</label></td>
						<td>
							<input size="16" type="text" id="startTime"  class="form-control dataPicker" value="${asnStock.sendTime}" readonly id="sendTime" name="sendTime">
						</td>
						<td><label>启运国:</label></td><td><input type='text' class="form-control" value="${asnStock.originCountry}" id="originCountry" name="originCountry"></td>
					</tr>
					<tr>
						<td><label>载货清单号:</label></td><td><input type='text' class="form-control" value="${asnStock.transportGoodsNo}" id="transportGoodsNo" name="transportGoodsNo"></td>
						<td><label>合同号:</label></td><td><input type='text' class="form-control" value="${asnStock.contractId}" id="contractId" name="contractId"></td>
					</tr>
					<tr>
						<td><label>提单号:</label></td><td><input type='text' class="form-control" value="${asnStock.bild}" id="bild" name="bild"></td>	 
						<td><label>柜号:</label></td><td><input type='text' class="form-control" value="${asnStock.cabinetNo}" id="cabinetNo" name="cabinetNo"></td>
					</tr>
					<tr>
						<td><label>进仓时间:</label></td>
						<td>
							<input size="16" type="text" id="actualFeedTime" value="${asnStock.actualFeedTime}"  class="form-control dataPicker" readonly name="actualFeedTime">
						</td>	 
						<td><label>到港时间:</label></td>
						<td>
							<input size="16" type="text" id="actualArrivalTime" value="${asnStock.actualArrivalTime}"  class="form-control dataPicker" readonly name="actualArrivalTime">
						</td>
					</tr>
					<tr>
						<td><label>状态:</label></td>
						<td>
							<c:if test="${asnStock.status==0}"><label style="color:red">初始化</label></c:if>
							<c:if test="${asnStock.status==1}"><label style="color:red">预进货</label></c:if>
							<c:if test="${asnStock.status==2}"><label style="color:red">到港</label></c:if>
							<c:if test="${asnStock.status==4}"><label style="color:red">精点</label></c:if>
							<c:if test="${asnStock.status==5}"><label style="color:red">报备失败</label></c:if>
							<c:if test="${asnStock.status==6}"><label style="color:red">报备成功</label></c:if>
							<c:if test="${asnStock.status==7}"><label style="color:red">上架</label></c:if>
							<c:if test="${asnStock.status==11}"><label style="color:red">精点差异</label></c:if>
							<c:if test="${asnStock.status==21}"><label style="color:red">采购单差异</label></c:if>
							<c:if test="${asnStock.status==31}"><label style="color:red">申报成功</label></c:if>
							<c:if test="${asnStock.status==32}"><label style="color:red">申报失败</label></c:if>
							<c:if test="${asnStock.status==41}"><label style="color:red">改单</label></c:if>
							<c:if test="${asnStock.status==99}"><label style="color:red">已粗点</label></c:if>
						</td>
						<td><label>计划信息:</label></td>
						<td><input type='text' class="form-control" value="${asnStock.planInfo}" id="planInfo" name="planInfo"></td>	 
					</tr>
					<tr>
						<td><label>备注:</label></td>
						<td colspan="3"><input type='text' class="form-control" value="${asnStock.remark}" id="remark" name="remark" style="width:600px"></td>	 
					</tr>
				</table>
			</form>
			<div class="row">
				<div class="col-lg-12">
					<button type="button" class="btn btn-primary" onclick="printGoosList()">打印商品清单</button>
					<c:if test="${asnStock.declStatus!=1}">
						<button type="button" class="btn btn-primary" onclick="showAddSupGoodsModal()">添加商品</button>
					</c:if>
					<c:if test="${asnStock.status==4||asnStock.status==32}">
						<button type="button" class="btn btn-primary" onclick="asnDeclare()">采购单申报</button>
					</c:if>
					<table id="asnTable" class="table table-hover">
						<thead>
							<tr>
								<th>操作</th>
								<th>货号</th>
								<th>商品编号</th>
								<th>商品编码</th>
								<th>商品名称</th>
								<th>单位</th>
								<th>数量</th>
								<th>粗点数量</th>
								<th>货值</th>
								<th>币制</th>
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
         	<iframe id="addSupGoodsIFrame" width="100%" height="100%" frameborder="0"></iframe>
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeAddModal()">取消 </button>
            <button type="button" class="btn btn-info" id="saveGoodsBtn">保存</button>
         </div>
      </div>
	</div>
</div>
<div class="modal fade" id="picModal" tabindex="-1" role="dialog" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
         	<h4 class="modal-title" id="modelTitle">商家商品库</h4>
         </div>
         <div class="modal-body">
         <img id="pic" src="" class="img-rounded">
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closePicModal()">取消 </button>
         </div>
      </div>
	</div>
</div>
<div class="modal fade" id="remarkModal" tabindex="-1" role="dialog" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
         	<h4 class="modal-title" id="modelTitle">打回备注</h4>
         </div>
         <div class="modal-body">
         	<label>备注:</label>
			<textarea class="form-control" id="backRemark" name="backRemark"></textarea>
			<input type='hidden' class="form-control" id="auditType" name="auditType">		
         </div>
         <div class="modal-footer">
         	<button type="button" class="btn btn-info" data-dismiss="modal" onclick="sureBack()">打回 </button>
            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="clearModel()">取消 </button>
         </div>
      </div>
	</div>
</div>
<script type="text/javascript" src="${wmsUrl}/js/ajaxfileupload.js"></script>
<script type="text/javascript">
$('input[id=customsFile]').change(function() {
	$('#customsFileName').val($(this).val());
});

$('input[id=declFile]').change(function() {
	$('#declFileName').val($(this).val());
});

var options = {
		queryForm : ".query",
		url :  "${wmsUrl}/admin/stockIn/asnMng/queryItemById.shtml?asnStockId=${asnStock.asnStockId}",
		numPerPage:"2000",
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

function auditPass(type){
	$.ajax({
		 url:"${wmsUrl}/admin/stockIn/asnMng/auditPass.shtml?type="+type+"&asnStockId=${asnStock.asnStockId}",
		 type:'post',
		 data:{},
		 dataType:'json',
		 success:function(data){
			 if(data.success){	
				 $.zzComfirm.alertSuccess("审核通过！");
				 window.location.reload();
			 }else{
				 $.zzComfirm.alertError(data.msg);
			 }
		 },
		 error:function(){
			 $.zzComfirm.alertError("系统出现问题啦，快叫技术人员处理");
		 }
	 });
	
	clearModal();
}

function auditBack(type){
	$("#auditType").val(type);
	$("#remarkModal").modal("show");
	
}

function sureBack(){
	
	var type = $("#auditType").val();
	
	$.ajax({
		 url:"${wmsUrl}/admin/stockIn/asnMng/auditBack.shtml?type="+type+"&asnStockId=${asnStock.asnStockId}",
		 type:'post',
		 data:{remark:$("#backRemark").val()},
		 dataType:'json',
		 success:function(data){
			 if(data.success){	
				 $.zzComfirm.alertSuccess("打回成功！");
				 window.location.reload();
			 }else{
				 $.zzComfirm.alertError(data.msg);
			 }
		 },
		 error:function(){
			 $.zzComfirm.alertError("系统出现问题啦，快叫技术人员处理");
		 }
	 });
	
	clearModal();
}

function clearModal(){
	$("backRemark").val("");
	$("auditType").val("");
}

function uploadDeclFile(){
	$.ajaxFileUpload({
		url:'${wmsUrl}/admin/stockIn/asnMng/uploadDeclFile.shtml?asnStockId=${asnStock.asnStockId}', //你处理上传文件的服务端
		secureuri:false,
		fileElementId:"declFile",
		dataType: 'json',
		success: function (data){
		   if(data.success){
			   	$.zzComfirm.alertSuccess("成功上传");
			   	window.location.reload();
		   }else{
			   	$.zzComfirm.alertError(data.msg);
		   }
		}
	})
}

function uploadCustomsFile(){
	
	$.ajaxFileUpload
    (
      {
           url:'${wmsUrl}/admin/stockIn/asnMng/uploadCustomsFile.shtml?asnStockId=${asnStock.asnStockId}', //你处理上传文件的服务端
           secureuri:false,
           fileElementId:"customsFile",
           dataType: 'json',
           success: function (data)
                 {
                   if(data.success){
                	   $.zzComfirm.alertSuccess("成功上传");
                	   window.location.reload();
                   }else{
                	   $.zzComfirm.alertError(data.msg);
                   }
                 }
              }
        )

      return false;
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
	
	var customStatus = ${asnStock.customStatus};
	var status = ${asnStock.status};
	var type = ${asnStock.type};

	var trHtml = "";
	for (var i = 0; i < list.length; i++) {
		
		if(customStatus==1&&status>1){
			trHtml +="<tr><td><button type='button' style='width:50px' onclick=\"editItem(this,'"+list[i].id+"')\" class=\"btn btn-info\">修改</button><input type='hidden' name=\"id\" id=\"id\" class=\"form-control\" readonly value='"+list[i].id+"' style=\"width:170px\"></td>";
		}else{
			trHtml +="<tr><td><button type='button' style='width:50px' onclick=\"deleteItem(this,'"+list[i].id+"')\" class=\"btn btn-info\">删除</button><button type='button' style='width:50px' onclick=\"editItem(this,'"+list[i].id+"')\" class=\"btn btn-info\">修改</button><input type='hidden' name=\"id\" id=\"id\" class=\"form-control\" readonly value='"+list[i].id+"' style=\"width:170px\"></td>";
		}
		
		trHtml +="<td><label>"+list[i].sku+"</label></td>";
		trHtml +="<td><label>"+list[i].itemId+"</label></td>";
		trHtml +="<td><label>"+list[i].itemCode+"</label></td>";
		trHtml +="<td><label>"+list[i].goodsName+"</label></td>";
		trHtml +="<td><label>"+list[i].unit+"</label></td>";
		
		if(status == 99&&type == 1&&list[i].quantity!=list[i].roughqty){
			trHtml +="<td><label>"+list[i].quantity+"<button type='button' style='width:50px' onclick=\"syncQuantity(this,'"+list[i].id+"')\" class=\"btn btn-info\">同步</button></label></td>";
		}else{
			trHtml +="<td><label>"+list[i].quantity+"</label></td>";
		}
		
		
		trHtml +="<td><label>"+list[i].roughqty+"</label></td>";
		trHtml +="<td><label>"+(list[i].currencyValue==null?"无":list[i].currencyValue)+"</label></td>";
		trHtml +="<td><label>"+(list[i].currency==null?"无":list[i].currency)+"</label></td>";
		trHtml +="<td><label>"+(list[i].remark==null?"无":list[i].remark)+"</label></td></tr>";
	}
	$("#asnTable tbody").htmlUpdate(trHtml);
}

function syncQuantity(obj,id){
	$.ajax({
		type:"post",
		url:'${wmsUrl}/admin/stockIn/asnMng/syncQuantity.shtml',
		data:{id:id},
		dataType:"json",
		success: function(data){
			if(data.success){
				$.zzComfirm.alertSuccess("同步成功!");
				 window.location.reload();
			}else{
				$.zzComfirm.alertError(data.errInfo);
			}
		},
		error:function(){
			$.zzComfirm.alertError("访问异常");
		}
	});
}


function editItem(obj,id){
	var supplierId = $("#supplierId").val();
	var supplierId = $("#asnStockId").val();
	if(supplierId==null||supplierId==""){
		$.zzComfirm.alertError("请先选择商家");
		return;
	}
	
    var frameSrc = "${wmsUrl}/admin/stockIn/asnMng/showAddSupGoods.shtml?asnStockId=${asnStock.asnStockId}&goodsId="+id+"&type=1";
    $("#addSupGoodsIFrame").attr("src", frameSrc);
    $('#addSupGoodsModal').modal({ show: true, backdrop: 'static' });
}

function deleteItem(obj,id){
	$.zzComfirm.alertConfirm("确定要删除吗？",function(){
		$.ajax({
			type:"post",
			url:'${wmsUrl}/admin/stockIn/asnMng/delete.shtml',
			data:{id:id},
			dataType:"json",
			success: function(data){
				if(data.success){
					$.zzComfirm.alertSuccess("删除成功!");
					$(obj).parent().parent().remove();
					return;
				}else{
					$.zzComfirm.alertError(data.errInfo);
				}
			},
			error:function(){
				$.zzComfirm.alertError("访问异常");
			}
		});
	});
}

function submitForm() {
	var goodsItemsTrs = $("#asnTable tbody tr");
	var trLength = goodsItemsTrs.length;
	if(trLength<1){
		$.zzComfirm.alertError("没有添加商品!");
		return;
	}		
	
	var type = $("#type").val();
	if(type==null || type==""){
		$.zzComfirm.alertError("请选择是否转关");
		return;
	}
	
	var transportGoodsNo = $("#transportGoodsNo").val();
	if(transportGoodsNo == null || transportGoodsNo == ''){
		$.zzComfirm.alertError("请输入载货清单号");
		return;
	}
	
	var supplierId = $("input[name=supplierId]").val();
	if(supplierId == null || supplierId == ""){
		$.zzComfirm.alertError("请输入商家信息");
		return false;
	}
	
	
	$.ajax({
		type : "post",
		data : sy.serializeObject($('#asnForm')),
		dataType : 'json',
		url : '${wmsUrl}/admin/stockIn/asnMng/updateAsn.shtml',
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

function reloadTable(){
	$.page.loadData(options);
}

function closeSupModal(){
	$('#supplierModal').modal('hide');
}

function showPicModal(path){
	 $("#pic").attr('src',"${wmsUrl}/upload/asn/${asnStock.asnStockId}/"+path); 
	 $('#picModal').modal({ show: true, backdrop: 'static' });
}

function closePicModal(path){
	$('#picModal').modal('hide');
}

function closeAddModal(){
	$('#addSupGoodsModal').modal('hide');
}

function checkQuantity(obj){
	var value =  $(obj).val();
	if(value==null||value==""){
		return;
	}	
	
	if(isNaN(value)){
		$.zzComfirm.alertError("非法数字！")
		$(obj).val("");
	}
}

function showAddSupGoodsModal(){
	var supplierId = $("#supplierId").val();
	var supplierId = $("#asnStockId").val();
	if(supplierId==null||supplierId==""){
		$.zzComfirm.alertError("请先选择商家");
		return;
	}
	
    var frameSrc = "${wmsUrl}/admin/stockIn/asnMng/showAddSupGoods.shtml?asnStockId=${asnStock.asnStockId}";
    $("#addSupGoodsIFrame").attr("src", frameSrc);
    $('#addSupGoodsModal').modal({ show: true, backdrop: 'static' });
}

function printGoosList(){
	$.post('${wmsUrl}/admin/stockIn/asnMng/declNoCheck.shtml', {asnStockId:"${asnStock.asnStockId}"},function(result){
		if (result.success) {
			var left1 = (screen.width-600)/2;
			var top1 = (screen.height-450)/2;
			if($("#type").val()==1){
				alert("该采购单为转关类型，填报时以粗点数量为准");
			}
			window.open('${wmsUrl}/admin/stockIn/asnMng/asnGoodsPrint.shtml?asnStockId=${asnStock.asnStockId}',"","width=1400,height=700,resizable=yes,location=no,scrollbars=yes,left=" + left1.toString() + ",top=" + top1.toString());
		}else{
			$.zzComfirm.alertError(result.msg);
		}
	},"json");
}

function asnDeclare(){
	$.ajax({
		type : "post",
		dataType : 'json',
		url : '${wmsUrl}/admin/stockIn/asnMng/asnReport.shtml?asnStockId=${asnStock.asnStockId}',
		dataType:'json',
		success : function(data) {
			if (data.success) {
				$.zzComfirm.alertSuccess("报备成功！");
				window.parent.reloadTable();
				window.parent.closeEditModal();
			} else {
				location.reload();
				$.zzComfirm.alertError(data.msg);
			}
		},
		error : function(data) {
			$.zzComfirm.alertError("操作失败，请联系管理员！");
		}
	});
}


</script>
</body>
</html>
