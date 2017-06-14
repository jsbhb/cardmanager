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
<title>商家订单</title>
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
						<li class="active"><i class="fa fa-user-md fa-fw"></i>商家订单</li>
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
										<c:forEach items="${carrierList}" var="item">
											<option value="${item.carrier }">${item.company }</option>
										</c:forEach>
								</select>
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
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">
								<i class="fa fa-bar-chart-o fa-fw"></i>商家订单列表
							</h3>
						</div>
						<div class="panel-body">
							<table id="makeOrderTable" class="table table-hover">
								<thead>
									<tr>
										<th>操作</th>
										<th>所属商户</th>
										<th>商户编号</th>
										<th>类型</th>
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
<script type="text/javascript">

	/**
	 * 初始化分页信息
	 */
	var options = {
				queryForm : ".query",
				url :  "${wmsUrl}/admin/stockOut/makeOrder/supDataList.shtml",
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
		$("#makeOrderTable tbody").html("");
	
	
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
			str += "<td><a target='_blank' rel='nofollow' href='${wmsUrl}/admin/stockOut/makeOrder/makeOrderMng.shtml?sellerInfoId="+list[i].sellerInfoId+"'>制单</a></td>";
			str += "<td>" + list[i].ownerUserName +"</td>";
			str += "<td>" + list[i].sellerInfoId +"</td>";
			str += "<td>放行订单</td>";
			str += "<td><label style='color:red'>" + list[i].sumNum +"</label></td>";
			str += "</tr>";
		}
		
		$("#makeOrderTable tbody").htmlUpdate(str);
	}
	
	</script>
</body>
</html>
