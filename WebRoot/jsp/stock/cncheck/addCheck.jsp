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
<title>新增盘点</title>
<%@include file="../../resource.jsp" %>
</head>

<body>
	<div id="page-wrapper">
		<div class="container-fluid">
			<form role="form" id="checkForm">
				<table class="table table-bordered">
					<tr>
						<td><label>类型:</label></td>
						<td>
							<select name="orderType" class="form-control span2" id="orderType">
								<option value="1">错发</option>
								<option value="2">漏发</option>
								<option value="3">进货</option>
								<option value="4" selected>盘点</option>
								<option value="5">其他</option>
							</select>
						</td>
						<td><label>单据:</label></td><td><input type='text' class="form-control" id="orderNo" name="orderNo" required></td>
					</tr>
					<tr>
						<td><label>商家编码:</label></td>
						<td>
							<input type='text' class="form-control" id="supplierId" readonly name="supplierId">
							<button type="button" class="btn btn-warning" onclick="showSuppiler()">查看</button>
						</td>	 
						<td><label>商家名称:</label></td>
						<td><input type='text' class="form-control" readonly id="supplierName" name="supplierName"></td>
					</tr>
					<tr>
						<td><label>备注:</label></td>
						<td colspan="3"><input type='text' class="form-control" id="remark" name="remark"></td>	 
					</tr>
					</table>
				<div class="row">
					<div class="col-lg-12">
						<button type="button" class="btn btn-primary" onclick="showSuppilerGoods()">添加盘点商品</button>
						<table id="checkGoodsTable" class="table table-hover">
							<thead>
								<tr>
									<th>操作</th>
									<th>类型</th>
									<th>数量</th>
									<th>店铺编码</th>
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
			</form>
		</div>
	</div>
	<div class="modal fade" id="supplierModal" tabindex="-1" role="dialog" aria-hidden="true">
	   <div class="modal-dialog">
	      <div class="modal-content">
	         <div class="modal-header">
	            <button type="button" class="close"  aria-hidden="true" data-dismiss="modal" onclick="closeSupModal()">&times;</button>
	         	<h4 class="modal-title" id="modelTitle">商家选择</h4>
	         </div>
	         <div class="modal-body">
	         	<iframe id="supplierIFrame" frameborder="0"></iframe>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeSupModal()">取消 </button>
	         </div>
	      </div>
		</div>
	</div>
	
	<div class="modal fade" id="supplierGoodsModal" tabindex="-1" role="dialog" aria-hidden="true">
	   <div class="modal-dialog">
	      <div class="modal-content">
	         <div class="modal-header">
	         	<h4 class="modal-title" id="modelTitle">商家商品库</h4>
	         </div>
	         <div class="modal-body">
	         	<iframe id="supplierGoodsIFrame" frameborder="0"></iframe>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeSupplierGoodsModal()">取消 </button>
	         </div>
	      </div>
		</div>
	</div>

<script type="text/javascript">
function submitForm() {
	var goodsItemsTrs = $("#checkGoodsTable tbody tr");
	var trLength = goodsItemsTrs.length;
	if(trLength<1){
		$.zzComfirm.alertError("没有添加商品!");
		return;
	}		
	
	var isCorrected = true;
	$("#checkGoodsTable tbody tr").each(function(){
		var name = $(this).find("input[name=goodsName]").val();
		var quantity = $(this).find("input[name=quantity]").val();
		if(name==null||name == ""){
			$.zzComfirm.alertError("未输入商品名称");
			isCorrected = false;
			return false;
		}
		
		if(isNaN(quantity)){
			$.zzComfirm.alertError("商品数量有误请重新输入！！");
			isCorrected = false;
			return false;
		}
		
		if(quantity==0||quantity==""){
			$.zzComfirm.alertError("未输入商品数量！！");
			isCorrected = false;
			return false;
		}
		
	});	
	
	if(!isCorrected){
		return;
	}
	
	var supplierId = $("input[name=supplierId]").val();
	if(supplierId == null || supplierId == ""){
		$.zzComfirm.alertError("请输入商家信息");
		return false;
	}
	
	$("input[id^='sku']").each(function() {
		if($(this).val()==null ||$(this).val()==''){
			$(this).val("*");
		}
	});
	$("textarea[id^='remark']").each(function() {
		if($(this).val()==null ||$(this).val()==''){
			$(this).val("*");
		}
	});
	$("input[id^='itemId']").each(function() {
		if($(this).val()==null ||$(this).val()==''){
			$(this).val("*");
		}
	});
	$("input[id^='itemCode']").each(function() {
		if($(this).val()==null ||$(this).val()==''){
			$(this).val("*");
		}
	});
	
	$.ajax({
		 url:"${wmsUrl}/admin/stock/cnCheck/saveCheck.shtml",
		 type:'post',
		 data:sy.serializeObject($('#checkForm')),
		 dataType:'json',
		 success:function(data){
			 if(data.success){	
				 $.zzComfirm.alertSuccess("插入成功");
				 window.parent.reloadTable();
				 window.parent.closeAddModal();
			 }else{
				 $.zzComfirm.alertError(data.errInfo);
			 }
		 },
		 error:function(){
			 $.zzComfirm.alertError("系统出现问题啦，快叫技术人员处理");
		 }
	 });
};

function showSuppiler(){
    var frameSrc = "${wmsUrl}/admin/basic/sellerInfo/showDetail.shtml";
    $("#supplierIFrame").attr("src", frameSrc);
    $('#supplierModal').modal({ show: true, backdrop: 'static' });
}

function closeSupModal(){
	$('#supplierModal').modal('hide');
}


function closeSupplierGoodsModal(){
	$("#supplierModal").modal("hide");
}

function showSuppilerGoods(){
	var supplierId = $("#supplierId").val();
	if(supplierId==null||supplierId==""){
		$.zzComfirm.alertError("请先选择商家");
		return;
	}
	
    var frameSrc = "${wmsUrl}/admin/basic/sellerInfo/showSupplierGoods.shtml?supplierId="+supplierId;
    $("#supplierGoodsIFrame").attr("src", frameSrc);
    $('#supplierGoodsModal').modal({ show: true, backdrop: 'static' });
}

function closeSupGoodsModal(){
	$('#supplierGoodsModal').modal('hide');
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

function deleteItem(obj){
	$(obj).parent().parent().remove();
}


function addSupGoods(selectTr){
	var itemId = selectTr.children("td").eq(0).text();
	var itemCode = selectTr.children("td").eq(1).text();
	
	$.ajax({
		 url:"${wmsUrl}/admin/basic/sellerInfo/supplierGoods.shtml?itemId="+itemId+"&itemCode="+itemCode,
		 type:'post',
		 data:{},
		 dataType:'json',
		 success:function(data){
			 if(data.success){
				 var result = data.obj;
				 for(var i=0;i<result.length;i++){
					var trHtml ="<td><button type='button' style='width:50px' onclick=\"deleteItem(this)\" class=\"btn btn-info\">删除</button></td>";
					trHtml +="<td>";
					trHtml +="<select name='type' class='form-control span2' id='type'>";
					trHtml += "<option value='1'>盘盈</option>";
					trHtml += "<option value='2'>盘亏</option>";
					trHtml += "<option value='3'>盘次品</option>";
					trHtml += "</select>";
					trHtml += "</td>";
					trHtml +="<td><input type='text' name=\"quantity\" id=\"quantity\" onblur=checkQuantity(this) class=\"form-control\" style=\"width:80px\"></td>";
					trHtml +="<td><input type='text' name=\"ownerUserId\" id=\"ownerUserId\" class=\"form-control\" readonly value='"+result[i].ownerUserId+"' required=\"required:true\" style=\"width:120px\"></td>";
					trHtml +="<td><input type='text' name=\"itemId\" id=\"itemId\" class=\"form-control\" readonly value='"+result[i].itemId+"' required=\"required:true\" style=\"width:120px\"></td>";
					trHtml +="<td><input type='text' name=\"itemCode\" id=\"itemCode\" class=\"form-control\" readonly value='"+result[i].itemCode+"' required=\"required:true\" style=\"width:170px\"></td>";
					trHtml +="<td><input type='text' name=\"sku\" id=\"sku\" class=\"form-control\" readonly value='"+result[i].sku+"' onblur=check(this) style=\"width:170px\"></td>";
					trHtml +="<td><input type='text' name=\"goodsName\" id=\"goodsName\" class=\"form-control\" readonly value='"+result[i].skuName+"' required=\"required:true\" style=\"width:300px\"></td>";
					trHtml +="<td><input type='text' name=\"remark\" id=\"remark\" class=\"form-control\"></input></td>";
					var tr = $("<tr></tr>").append(trHtml);
					var itemId = result[i].itemId;
					var flag = true;
					$("input[id^='itemId']").each(function(){   
					    if(itemId==$(this).val()&&itemId != ''){
					    	$.zzComfirm.alertError("已经存在该商品");
					    	flag = false;
					    }
					});
					if(flag){
				    	$("#checkGoodsTable tbody").append(tr);
				    }
				}
				 closeSupGoodsModal();
			 }else{
				 $.zzComfirm.alertError(result.msg);
			 }
		 },
		 error:function(){
			 $.zzComfirm.alertError("系统出现问题啦，快叫技术人员处理");
		 }
	 });
}

</script>
</body>
</html>
