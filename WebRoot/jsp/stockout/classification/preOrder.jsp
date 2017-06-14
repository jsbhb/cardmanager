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
<title>拣货车分拣</title>
<%@include file="../../resource.jsp"%>
</head>

<body>
	<div id="page-wrapper">
		<div id="mask"></div>
		<div class="container-fluid">
			<!-- Page Heading -->
			<div class="row">
				<div class="col-lg-12">
					<ol class="breadcrumb">
						<li><i class="fa fa-fighter-jet fa-fw"></i>出库业务</li>
						<li class="active"><i class="fa fa-user-md fa-fw"></i>${sellerName}: 预包列表</li>
					</ol>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="query">
						<div class="row" style="padding-left:15px">
							<div class="form-group">
								<label>快递公司:</label> 
								<select name="carrier" id="carrier"  class="form-control span2">
										<c:forEach items="${carrierList}" var="item">
											<option value="${item.carrier}">${item.company }</option>
										</c:forEach>
								</select>
							</div>
							<div class="form-group">
								<label>单证时间:</label> 
								<input size="18" type="text" id="startTime"  class="form-control dataPicker" name="startTime" readonly="readonly">
								<span class="add-on"><i class="icon-th"></i></span>
								<label>&nbsp;至&nbsp;</label> 
								<input size="18" type="text" id="endTime"  class="form-control dataPicker" name="endTime" readonly="readonly">
								<span class="add-on"><i class="icon-th"></i></span>
							</div>
						</div>
						<button type="button" id="querybtns" class="btn btn-primary">查询</button>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">
								<i class="fa fa-bar-chart-o fa-fw"></i>预包订单
							</h3>
						</div>
						<div class="panel-body">
							<c:if test="${privilege>=2}">
								<button type="button" class="btn btn-primary" onclick="print()">打印分拣单</button>
							</c:if>
							<table id="classificationTable" class="table table-hover">
								<thead>
									<tr>
										<th><input type="checkbox" id = selectAll onclick="selectAll(this);"></th>
										<th>预包编号</th>
										<th>预包名称</th>
										<th>所属商户</th>
										<th>订单量(笔)</th>
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

	$(".dataPicker").datetimepicker({
		format : 'yyyy-mm-dd hh:ii:ss'
	});
	/**
	 * 初始化分页信息
	 */
	var options = {
				queryForm : ".query",
				url :  "${wmsUrl}/admin/stockOut/makeOrder/preOrderList.shtml?sellerInfoId=${sellerInfoId}",
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
		$.zzComfirm.endMask();
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
			str += "<td><input type='checkbox' name='check' value='" + list[i].orderId + "' /></td>";
			str += "<td>" + list[i].orderId +"</td>";
			str += "<td>" + list[i].orderDetail +"</td>";
			str += "<td>" + list[i].ownerUserName +"</td>";
			str += "<td>" + list[i].sumNum +"</td>";
			str += "</tr>";
		}
		
		
		$("#classificationTable tbody").html(str);
	}
	
	function closeShopModal(){
		$('#shopModal').modal('hide');
	}
	
	function selectAll(obj){
		$("[name='check']").each(function(){
	        this.checked = !this.checked;
	    });
	}
	
	function print(){
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
	    var pid = valArr.join('--');//转换为逗号隔开的字符串 
		// 计算库位
	    sending.style.visibility="visible"; 
		$.post('${wmsUrl}/admin/stockOut/makeOrder/preCalLib.shtml?sellerInfoId=${sellerInfoId}&carrier='+$('#carrier').val(),{"pid":pid}, 
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
				window.open('${wmsUrl}/admin/stockOut/makeOrder/preOrderPdf.shtml?carrier='+$('#carrier').val()+'&instructions='+result.instructions+'&dsplatform='+$('#dsplatform').val(), "", "width=1400,height=700,resizable=yes,location=no,scrollbars=yes,left=" + left1.toString() + ",top=" + top1.toString());
			} else {
				sending.style.visibility="hidden";
				$.zzComfirm.alertError(result.msg);
			}
		}, 'json');
		
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
				sending.style.visibility="visible"; 
				$.post('${wmsUrl}/admin/stockOut/classification/CalculationLib.shtml',{"orderIds":orderIds,"isBatch":"1"}, 
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
						window.open('${wmsUrl}/admin/stockOut/classification/pdfjsp2.shtml?carrier='+$('#carrier').val()+'&instructions='+result.instructions+'&dsplatform='+$('#dsplatform').val()+'&isBatch=1', "", "width=1400,height=700,resizable=yes,location=no,scrollbars=yes,left=" + left1.toString() + ",top=" + top1.toString());
					} else {
						sending.style.visibility="hidden";
						$.zzComfirm.alertError(result.msg);
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
