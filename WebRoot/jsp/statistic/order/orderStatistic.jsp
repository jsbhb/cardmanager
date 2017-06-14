<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="refresh" content="10">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>订单统计</title>
<%@include file="../../resource.jsp"%>
</head>

<body>
	<div id="page-wrapper">
		<div id="mask"></div>
		<div class="row">
			<div class="col-lg-10">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="fa fa-bar-chart-o fa-fw"></i>历史订单处理统计
						</h3>
					</div>
					<div class="panel-body">
						<table id="ruleTable" class="table table-hover nofilter">
							<thead>
								<tr>
									<th>菜鸟初始订单</th>
									<th>初始订单</th>
									<th>单证放行订单</th>
									<th>分类分拣</th>
									<th>快递单打印</th>
									<th>出货订单</th>
									<th>退单</th>
									<th>拒单</th>
									<th>异常订单</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>${allOrder.state_11_quantity}</td>
									<td>${allOrder.state_0_quantity}</td>
									<td>${allOrder.state_2_quantity}</td>
									<td>${allOrder.state_3_quantity}</td>
									<td>${allOrder.state_4_quantity}</td>
									<td>${allOrder.state_5_quantity}</td>
									<td>${allOrder.state_6_quantity}</td>
									<td>${allOrder.state_12_quantity}</td>
									<td>${allOrder.state_exception_quantity}</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-lg-10">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="fa fa-bar-chart-o fa-fw"></i>今日订单处理统计
						</h3>
					</div>
					<div class="panel-body">
						<table id="ruleTable" class="table table-hover  nofilter">
							<thead>
								<tr>
									<th>菜鸟初始订单</th>
									<th>初始订单</th>
									<th>单证放行订单</th>
									<th>分类分拣</th>
									<th>快递单打印</th>
									<th>出货订单</th>
									<th>退单</th>
									<th>拒单</th>
									<th>异常订单</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>${allOrderByContition.state_11_quantity}</td>
									<td>${allOrderByContition.state_0_quantity}</td>
									<td>${allOrderByContition.state_2_quantity}</td>
									<td>${allOrderByContition.state_3_quantity}</td>
									<td>${allOrderByContition.state_4_quantity}</td>
									<td>${allOrderByContition.state_5_quantity}</td>
									<td>${allOrderByContition.state_6_quantity}</td>
									<td>${allOrderByContition.state_12_quantity}</td>
									<td>${allOrderByContition.state_exception_quantity}</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
			
		<div class="row">
			<div class="col-lg-5">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="fa fa-bar-chart-o fa-fw"></i>接单规则统计
						</h3>
					</div>
					<div class="panel-body">
						<c:forEach var="item" items="${acceptOrderByCondition}" varStatus="status">
						
						<table id="ruleTable" class="table table-hover nofilter">
							<thead>	
                                 <tr class="caption">
						           <th colspan="2"><label style="color:red">${item.key}</label></th>
							    <tr>
								<tr>
									<th>菜鸟初始订单</th>
									<th>初始订单</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>${item.value.state_11_quantity}</td>
									<td>${item.value.state_0_quantity}</td>
								</tr>
							</tbody>
						</table>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-lg-5">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="fa fa-bar-chart-o fa-fw"></i>历史订单打包统计
						</h3>
					</div>
					<div class="panel-body">
						<table id="ruleTable" class="table table-hover nofilter">
							<thead>
								<tr>
									<th>待处理</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>${packageOrderAll.quantity}</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-5">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="fa fa-bar-chart-o fa-fw"></i>打包规则统计
						</h3>
					</div>
					<div class="panel-body">
						<c:forEach var="item" items="${packageOrderByCondition}" varStatus="status">
						<table id="ruleTable" class="table table-hover nofilter">
							<thead>
							     <tr class="caption">
						           <th><label style="color:red">${item.key}</label></th>
							    <tr>
								<tr>
									<th>待处理</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>${item.value.quantity}</td>
								</tr>
							</tbody>
						</table>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-5">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="fa fa-bar-chart-o fa-fw"></i>历史订单出库统计
						</h3>
					</div>
					<div class="panel-body">
						<table id="ruleTable" class="table table-hover nofilter">
							<thead>
								<tr>
									<th>未分拣</th>
									<th>未复核</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>${stockOutOrderAll.state_3_quantity}</td>
									<td>${stockOutOrderAll.state_4_quantity}</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-5">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="fa fa-bar-chart-o fa-fw"></i>出库规则统计
						</h3>
					</div>
					<div class="panel-body">
						<c:forEach var="item" items="${stockOutOrderByCondition}" varStatus="status">
						
						<table id="ruleTable" class="table table-hover nofilter">
							<thead>
							
							     <tr class="caption">
						           <th colspan="2"><label style="color:red">${item.key}</label></th>
							    <tr>
								<tr>
									<th>未分拣</th>
									<th>未复核</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>${item.value.state_3_quantity}</td>
									<td>${item.value.state_4_quantity}</td>
								</tr>
							</tbody>
						</table>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
	</script>
</body>
</html>
