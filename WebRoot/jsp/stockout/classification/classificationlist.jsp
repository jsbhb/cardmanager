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
<title>分类分拣</title>
<%@include file="../../resource.jsp"%>
</head>

<body>
	<div id="page-wrapper">

		<div class="container-fluid">
			<!-- Page Heading -->
			<div class="row">
				<div class="col-lg-12">
					<ol class="breadcrumb">
						<li><i class="fa fa-fighter-jet fa-fw"></i>出库业务</li>
						<li class="active"><i class="fa fa-user-md fa-fw"></i> 分类分拣</li>
					</ol>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="query">
						<div class="row" >
							<div class="form-group">
								<label>快递公司:</label> 
								<select name="carrier" id="carrier"  class="form-control span2">
									<option value="">不限</option>
										<c:forEach items="${carrierList}" var="item">
											<option value="${item.carrier }">${item.company }</option>
										</c:forEach>
								</select>
							</div>
							<div class="form-group">
								<label>明细数&nbsp;:</label> 
								<select	name="asingle" id="asingle"   class="form-control span2">
										<option value="">全部</option>
										<option value="0">=1</option>
										<option value="1">>1</option>
										<option value="2">>2</option>
										<option value="3">>3</option>
								</select>
							</div>
							<div class="form-group">
								<label>订单来源:</label> 
								<select name="orderTab"  id="orderTab" class="form-control span2">
									<option value="">全部</option>
									<option value="0">菜鸟订单</option>
								</select>
							</div>
							<div class="form-group">
								<label>&nbsp;省份&nbsp;:</label>
								<select id="receiverProvince" name="receiverProvince"  class="form-control span2">
									<option value="">全部</option>
									<option value="浙江省">浙江省</option>               
									<option value="北京">北京</option>                    
									<option value="上海">上海</option>                    
									<option value="云南省">云南省 </option>                
									<option value="内蒙古自治区">内蒙古自治区 </option>       
									<option value="吉林省">吉林省</option>                 
									<option value="四川省">四川省</option>                 
									<option value="天津">天津</option>                    
									<option value="宁夏回族自治区">宁夏回族自治区</option>     
									<option value="安徽省">安徽省</option>                 
									<option value="山东省">山东省</option>                 
									<option value="山西省">山西省</option>                 
									<option value="广东省">广东省</option>                 
									<option value="广西壮族自治区">广西壮族自治区</option>     
									<option value="新疆维吾尔自治区">新疆维吾尔自治区</option>  
									<option value="江苏省">江苏省</option>                 
									<option value="江西省">江西省</option>                 
									<option value="河北省">河北省</option>                 
									<option value="河南省">河南省</option>                 
									<option value="海南省">海南省</option>                 
									<option value="湖北省">湖北省</option>                 
									<option value="湖南省">湖南省</option>                 
									<option value="甘肃省">甘肃省</option>                 
									<option value="福建省">福建省</option>                 
									<option value="西藏自治区">西藏自治区</option>           
									<option value="贵州省">贵州省</option>                 
									<option value="辽宁省">辽宁省</option>                 
									<option value="重庆">重庆</option>                    
									<option value="陕西省">陕西省 </option>                
									<option value="青海省">青海省 </option>                
									<option value="香港特别行政区">香港特别行政区</option>     
									<option value="黑龙江省">黑龙江省</option> 
								</select>
							</div>
						</div>
						<div class="row" >
							<div class="form-group">
								<label>选择店铺:</label>
								<input name="shopId" id="shopId" type="text"  class="form-control">
								<button type="button" class="btn btn-primary" btnId="shopQuery" onclick="showShops()">店铺查询</button>
							</div>
							<div class="form-group">
								<label>店铺名称:</label> 
								<input size="16" type="text" id="shopName" forBtn="shopQuery" class="form-control" name="shopName" readonly="readonly">
							</div>
							<div class="form-group">
								<label>&nbsp;货号&nbsp;:</label> 
								<input size="16" type="text" id="sku"  class="form-control" name="sku">
							</div>
						</div>
						<div class="row" >
							<div class="form-group">
								<label>单证时间:</label> 
								<input size="18" type="text" id="startTime"  class="form-control dataPicker" name="startTime" readonly="readonly">
								<span class="add-on"><i class="icon-th"></i></span>
								<label>&nbsp;至&nbsp;</label> 
								<input size="18" type="text" id="endTime"  class="form-control dataPicker" name="endTime" readonly="readonly">
								<span class="add-on"><i class="icon-th"></i></span>
							</div>
							<div class="form-group">
								<label>商户名&nbsp;:</label> 
								<select name="sellerInfoId" id="sellerInfoId" class="form-control span2">
						   			<option value="" selected="selected" >全部</option>
						   			<c:forEach items="${sellerInfoList}" var="seller">
						  	 			<option value="${seller.sellerInfoId}">${seller.sellerName}</option>
						   			</c:forEach>
								</select>
							</div>
						</div>
						<button type="button" id="querybtns" class="btn btn-primary">查询</button>
						<button type="button" id="reset" class="btn btn-primary" onclick="reset()">重置</button>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">
								<i class="fa fa-bar-chart-o fa-fw"></i>分类分拣列表
							</h3>
						</div>
						<div class="panel-body">
							<c:if test="${privilege>=2}">
								<button type="button" class="btn btn-primary" onclick="print()">打印分拣单</button>
								<button type="button" class="btn btn-primary" onclick="printBatch()">打印批量单</button>
							</c:if>
							<table id="classificationTable" class="table table-hover">
								<thead>
									<tr>
										<th><input type="checkbox" id = selectAll onclick="selectAll(this);"></th>
										<th>商品</th>
										<th>所属商户</th>
										<th>订单量(笔)</th>
										<th>每单SKU数</th>
										<th>每单商品总数</th>
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
	<div class="modal fade" id="shopModal" tabindex="-1" role="dialog" aria-hidden="true">
	    <div class="modal-dialog"  >
	      <div class="modal-content" >
	         <div class="modal-header">
	            <button type="button" class="close"  aria-hidden="true" data-dismiss="modal" onclick="closeShopModal()">&times;</button>
	         	<h4 class="modal-title" id="modelTitle">店铺选择</h4>
	         </div>
	         <div class="modal-body" >
	         	<iframe id="shopIFrame" width="100%" height="80%" frameborder="0"></iframe>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeShopModal()">取消 </button>
	         </div>
	      </div>
		</div>
	</div>
	
	<div id="sending"
		style="filter:alpha(opacity=80); position:absolute; top:40%; left:40%; z-index:10; visibility:hidden; width: 225px; height: 81px;">
		<TABLE WIDTH="80%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
			<TR>
				<td width="30%"></td>
				<TD bgcolor="#ccc">
					<TABLE WIDTH="100%" height="50" BORDER="0" CELLSPACING="2"
						CELLPADDING="0">
						<tr>
							<td height="30"><img src="${wmsUrl}/img/30.gif"
								border="0" /></td>
						</tr>
						<tr>
							<td align="center" style="font-size:12px">正在计算库位，请稍后...</td>
						</tr>
					</table>
				</td>
				<td width="30%"></td>
			</tr>
		</table>
	</div>
<script type="text/javascript">

	/**
	 * 初始化分页信息
	 */
	var options = {
				queryForm : ".query",
				url :  "${wmsUrl}/admin/stockOut/classification/dataList.shtml",
				numPerPage:"10",
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
		$("#classificationTable tbody").html("");
	
	
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
			str += "<tr>";
			if(i != 0){
				str += "<td><input type='checkbox' name='check' value='" + list[i].orderId + "' /></td>";
			}else{
				str += "<td></td>";
			}
			str += "<td>" + list[i].orderDetail +"</td>";
			str += "<td>" + list[i].ownerUserName +"</td>";
			str += "<td>" + list[i].sumNum +"</td>";
			str += "<td>" + list[i].skuNum +"</td>";
			str += "<td>" + list[i].eachOne +"</td>";
			str += "</tr>";
		}
		
		
		$("#classificationTable tbody").htmlUpdate(str);
	}
	
	function showShops(){
	    var frameSrc = "${wmsUrl}/admin/basic/shopInfo/showDetail.shtml";
	    $("#shopIFrame").attr("src", frameSrc);
	    $('#shopModal').modal({ show: true, backdrop: 'static' });
	}
	
	function closeShopModal(){
		$('#shopModal').modal('hide');
	}
	
	function reset(){
      	$("#carrier").val("");
      	$("#asingle").val("");
      	$("#dsplatform").val("");
      	$("#orderTab").val("");
      	$("#startTime").val("");
      	$("#endTime").val("");
      	$("#sku").val("");
      	$("#shopId").val("");
      	$("#shopName").val("");
      	$("#sellerInfoId").val("");
      	$("#receiverProvince").val("");
      }
	
	   
	function selectAll(obj){
		$("[name='check']").each(function(){
	        this.checked = !this.checked;
	    });
	}
	
	function print(){
	    var valArr = new Array; 
	    $("[name='check']:checked").each(function(i){ 
	        valArr[i] = $(this).val(); 
	    }); 
	    if(valArr.length==0){
	    	$.zzComfirm.alertConfirm("请选择数据");
	    	return;
	    }
	    var orderIds = valArr.join(',');//转换为逗号隔开的字符串 
		// 计算库位
		$.post('${wmsUrl}/admin/stockOut/classification/check.shtml',{"orderIds":orderIds},function(result){
			if(result.success){
				$.post('${wmsUrl}/admin/stockOut/classification/CalculationLib.shtml',{"orderIds":orderIds,"flag":"0"}, 
				 function(result) {
					if (result.success) {
						if(result.msg != null && result.msg!=""){
							$.zzComfirm.alertConfirm(result.msg);
						}else{
							$.page.loadData(options);
						}	
						var left1 = (screen.width-600)/2;
						var top1 = (screen.height-450)/2;
						window.open('${wmsUrl}/admin/stockOut/classification/pdfjsp2.shtml?carrier='+$('#carrier').val()+'&instructions='+result.instructions+'&dsplatform='+$('#dsplatform').val(), "", "width=1400,height=700,resizable=yes,location=no,scrollbars=yes,left=" + left1.toString() + ",top=" + top1.toString());
					} else {
						if(result.upFloor){
							$.zzComfirm.alertConfirm(result.msg,function(){
								sending.style.visibility="visible"; 
								$.post('${wmsUrl}/admin/stockOut/classification/CalculationLib.shtml',{"orderIds":orderIds,"flag":"1"}, 
										 function(result) {
											if (result.success) {
												sending.style.visibility="hidden";
												if(result.msg != null && result.msg!=""){
													$.zzComfirm.alertConfirm(result.msg);
												}else{
													$.page.loadData(options);
												}	
												var left1 = (screen.width-600)/2;
												var top1 = (screen.height-450)/2;
												window.open('${wmsUrl}/admin/stockOut/classification/pdfjsp2.shtml?carrier='+$('#carrier').val()+'&instructions='+result.instructions+'&dsplatform='+$('#dsplatform').val(), "", "width=1400,height=700,resizable=yes,location=no,scrollbars=yes,left=" + left1.toString() + ",top=" + top1.toString());
											}else{
												sending.style.visibility="hidden";
												$.zzComfirm.alertError(result.msg);
											}
								}, 'json');
							})
						}else{
							sending.style.visibility="hidden";
							$.zzComfirm.alertError(result.msg);
						}
					}
				}, 'json');
			}else{
				$.zzComfirm.alertError(result.msg);
			}
		},'json');
		
	}
	
	
	function printBatch(){
	    var valArr = new Array; 
	    var sumNumArr = new Array;
	    $("[name='check']:checked").each(function(i){ 
	        valArr[i] = $(this).val(); 
	        sumNumArr[i] = $(this).parent().next().next().next().html();
	    }); 
	    if(valArr.length>1){
	    	$.zzComfirm.alertConfirm("只能选择单挑数据");
	    	return;
	    }
	    var orderIds = valArr.join(',');//转换为逗号隔开的字符串 
	    var sumNum = sumNumArr.join(',');
		// 计算库位
		$.post('${wmsUrl}/admin/stockOut/classification/checkIsBatch.shtml',{"orderIds":orderIds,"sumNum":sumNum},function(result){
			if(result.success){
				$.post('${wmsUrl}/admin/stockOut/classification/CalculationLib.shtml',{"orderIds":orderIds,"isBatch":"1","flag":"0"}, 
				 function(result) {
					if (result.success) {
						if(result.msg != null && result.msg!=""){
							$.zzComfirm.alertConfirm(result.msg);
						}else{
							$.page.loadData(options);
						}	
						var left1 = (screen.width-600)/2;
						var top1 = (screen.height-450)/2;
						window.open('${wmsUrl}/admin/stockOut/classification/pdfjsp2.shtml?carrier='+$('#carrier').val()+'&instructions='+result.instructions+'&dsplatform='+$('#dsplatform').val()+'&isBatch=1', "", "width=1400,height=700,resizable=yes,location=no,scrollbars=yes,left=" + left1.toString() + ",top=" + top1.toString());
					} else {
						if(result.upFloor){
							$.zzComfirm.alertConfirm(result.msg,function(){
								sending.style.visibility="visible"; 
								$.post('${wmsUrl}/admin/stockOut/classification/CalculationLib.shtml',{"orderIds":orderIds,"isBatch":"1","flag":"1"}, 
										 function(result) {
											if (result.success) {
												sending.style.visibility="hidden";
												if(result.msg != null && result.msg!=""){
													$.zzComfirm.alertConfirm(result.msg);
												}else{
													$.page.loadData(options);
												}	
												var left1 = (screen.width-600)/2;
												var top1 = (screen.height-450)/2;
												window.open('${wmsUrl}/admin/stockOut/classification/pdfjsp2.shtml?carrier='+$('#carrier').val()+'&instructions='+result.instructions+'&dsplatform='+$('#dsplatform').val(), "", "width=1400,height=700,resizable=yes,location=no,scrollbars=yes,left=" + left1.toString() + ",top=" + top1.toString());
											}else{
												sending.style.visibility="hidden";
												$.zzComfirm.alertError(result.msg);
											}
								}, 'json');
							})
						}else{
							sending.style.visibility="hidden";
							$.zzComfirm.alertError(result.msg);
						}
					}
				}, 'json');
			}else{
				$.zzComfirm.alertError(result.msg);
			}
		},'json');
		
	}
	</script>
</body>
</html>
