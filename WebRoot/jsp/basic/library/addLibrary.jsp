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
<title>仓位管理</title>
<%@include file="../../resource.jsp"%>
</head>

<body>
	<div id="page-wrapper">

		<div class="container-fluid">
			<form role="form" id="libraryForm" class="queryTerm">
				<div class="row">
					<div class="col-lg-12">
						<ol class="breadcrumb">
							<li><i class="fa fa-book fa-fw"></i>仓位管理</li>
							<li class="active"><i class="fa fa-bookmark fa-fw"></i>新增仓位信息</li>
						</ol>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<label>仓位状态</label> <select class="form-control" name="status"
								id="status">
								<option value="1" selected="selected">可用</option>
								<option value="2">不可用</option>
							</select>
						</div>
						<div class="form-group">
							<label>仓位类型</label> <select class="form-control" name="type"
								id="type">
								<option value="1" selected="selected">良品库</option>
								<option value="2">不良品库</option>
								<option value="3">待货区</option>
								<option value="4">撤单区</option>
								<option value="5">空包区</option>
								<option value="6">虚拟仓</option>
								<option value="7">差异区</option>
							</select>
						</div>
						<div class="form-group">
							<label>区域类型</label> <select class="form-control" name="qptype"
								id="qptype">
								<option value="1" selected="selected">存储区</option>
								<option value="2">拣货区</option>
							</select>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<label>仓位位置</label> <select class="form-control" name="depart"
								id="depart">
								<option value="ZC1" selected="selected">出口区一楼</option>
								<option value="ZC2">出口区二楼</option>
							</select>
						</div>
						<div class="form-group">
							<label>仓库区域</label> <input type="text" class="form-control"
								name="direction" id="direction">
						</div>
						<div class="form-group">
							<label>存储类型</label> <select class="form-control" name="lattice"
								id="lattice">
							</select>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<label>排</label> <input type="text" class="form-control"
								name="arrange" id="arrange">
						</div>
						<div class="form-group">
							<label>层</label> <input type="text" class="form-control"
								name="storey" id="storey">
						</div>
						<div class="form-group">
							<label>列</label> <input type="text" class="form-control"
								name="lump" id="lump">
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<script type="text/javascript">

		$(function pageInit() {
			$("#lattice").html("");
			$.ajax({
				url : "${wmsUrl}/admin/basic/stor/getValue.shtml",
				type : "post",
				dataType : "json",
				success : function(result) {
					for (var i = 0; i < result.length; i++) {
						$("select[name='lattice']").each(
								function() {
									$(this).append(
											"<option value="+result[i].code+">"
													+ result[i].storageName
													+ "</option>");
								});
					}
				},
				error : function() {
					alert("系统崩溃啦，请联系技术");
				}
			});
		})
		
	</script>
</body>
</html>
