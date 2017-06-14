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
<title>拆分</title>
<%@include file="../../resource.jsp" %>
</head>

<body>
	<div id="page-wrapper">
		<div class="container-fluid">
			<form role="form" id="splForm">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="fa fa-bar-chart-o fa-fw"></i>商品信息
						</h3>
					</div>
					<div class="panel-body">
						<table class="table table-bordered">
							<tr>
								<td><label>商家ID:</label></td>
								<td><label><input type='text' class="form-control" id="supplierId" name="supplierId" value="${supplierId}" readonly="readonly"></label>
								<td><label>商家名称:</label></td>
								<td><label style="color:red">${supName}</label>	 
							</tr>
							<tr>
								<td><label>货号:</label></td>
								<td><label><input type='text' class="form-control" id="oldSku" name="oldSku" value="${sku}" readonly="readonly"></label>	 
								<td><label>商品名称:</label></td>
								<td><label style="color:red">${skuName}</label></td>
							</tr>
							<tr>
								<td><label>现有数量:</label></td>
								<td><label><input type='text' class="form-control" id="qty" name="qty" value="${qty}" readonly="readonly"></label>	 
							</tr>
						</table>
					</div>
				</div>
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="fa fa-bar-chart-o fa-fw"></i>拆分货号
						</h3>
					</div>
					<div class="row">
						<div class="col-lg-12">
						<button type="button" class="btn btn-primary" onclick="add()">新增</button>
							<table class="table table-bordered" id="spliTable">
								<thead>
									<tr>
										<th>货号</th>
										<th>名称</th>
										<th>数量</th>
										<th>报检号</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>

<script type="text/javascript">
function add(){
	var $str = "<tr><td>";
	$str += "<input type='text' name=\"sku\" id=\"sku\" class=\"form-control\"  value='' onblur=query(this) >";
	$str += "</td>"
	$str += "<td>";
	$str += "<input type='text' name=\"skuName\" id=\"skuName\" class=\"form-control\" readonly='readonly' value=''>";
	$str += "</td><td>"
	$str += "<input type='text' name=\"quantity\" id=\"quantity\" onblur=checkQuantity(this) class=\"form-control\">";
	$str += "</td><td>"
	$str += "<input type='text' name=\"declNo\" id=\"declNo\"  value='' class=\"form-control\">";
	$str += "</td><td>"
	$str += "<button type='button' style='width:50px' onclick=\"deleteItem(this)\" class=\"btn btn-info\">删除</button>";
	$str += "</td></tr>"
	$("#spliTable tbody").append($str);
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

function query(obj){
	var sku = $(obj).val();
	$.ajax({
		type:'post',
		url:'${wmsUrl}/admin/stock/stockSplit/querySku.shtml?sku='+sku,
		dataType:'json',
		success:function(result){
			if(result.success){
				$(obj).parent().next().find("#skuName").val(result.msg);
			}else{
				$.zzComfirm.alertError(result.msg);
			}
		},
		error:function(){
			$.zzComfirm.alertError("系统出现问题啦，快找技术小王");
		}
	});
}

function submitForm() {
	
	var goodsItemsTrs = $("#spliTable tbody tr");
	var trLength = goodsItemsTrs.length;
	if(trLength<1){
		$.zzComfirm.alertError("没有进行拆分!");
		return;
	}		
	
	var isCorrected = true;
	var reg = /^([1-9]\d*|[0]{1,1})$/;
	var total = 0;
	var num = $("#qty").val();
	$("#spliTable tbody tr").each(function(){
		var quantity = $(this).find("input[name=quantity]").val();
		
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
		
		if(!reg.test(quantity)){
			$.zzComfirm.alertError("请输入正整数！！");
			isCorrected = false;
			return false;
		}
		total = Number(total) + Number(quantity);
	});	
	if(total>num){
		$.zzComfirm.alertError("超过总数！！");
		return;
	}
	
	$("input[id^='sku']").each(function() {
		if($(this).val()==null ||$(this).val()==''){
			$.zzComfirm.alertError("请输入货号！！");
			isCorrected = false;
			return false;
		}
	});
	
	$("input[id^='declNo']").each(function() {
		if($(this).val()==null ||$(this).val()==''){
			$.zzComfirm.alertError("请输入报检号！！");
			isCorrected = false;
			return false;
		}
	});
	
	if(!isCorrected){
		return;
	}
	
	$.ajax({
		 url:"${wmsUrl}/admin/stock/stockSplit/doSplit.shtml",
		 type:'post',
		 data:sy.serializeObject($('#splForm')),
		 dataType:'json',
		 success:function(data){
			 if(data.success){	
				 $.zzComfirm.alertSuccess("操作成功");
				 window.parent.reloadTable();
				 window.parent.closeSplitModel();
			 }else{
				 $.zzComfirm.alertError(data.errInfo);
			 }
		 },
		 error:function(){
			 $.zzComfirm.alertError("系统出现问题啦，快叫技术人员处理");
		 }
	 });
};

function deleteItem(obj){
	$(obj).parent().parent().remove();
}
</script>
</body>
</html>
