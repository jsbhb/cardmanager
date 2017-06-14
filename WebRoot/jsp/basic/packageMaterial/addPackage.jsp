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
<title>包材管理</title>
<%@include file="../../resource.jsp"%>
</head>

<body>
	<div id="page-wrapper">

		<div class="container-fluid">
			<form role="form" id="libraryForm" class="queryTerm">
				<div class="row">
					<div class="col-lg-12">
						<ol class="breadcrumb">
							<li><i class="fa fa-book fa-fw"></i>包材管理</li>
							<li class="active"><i class="fa fa-bookmark fa-fw"></i>新增包材信息</li>
						</ol>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<label>包材编码</label>
							<input type="text" class="form-control" name="packageId" id="packageId">
						</div>
						<div class="form-group">
							<label>包材名称</label>
							<input type="text" class="form-control" name="packageName" id="packageName">
						</div>
						<div class="form-group">
							<label>包材规格</label>
							<input type="text" class="form-control" name="packageSpec" id="packageSpec">
						</div>
						<div class="form-group">
							<label>包材状态</label>
							<select class="form-control" name="status" id="status">
								<option value=0 selected="selected">使用</option>
								<option value=1>停用</option>
							</select>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;长</label>
							<input type="text" class="form-control" name="packageLength" id="packageLength" onkeyup="return ValidateNumber($(this),value)">
						</div>
						<div class="form-group">
							<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;宽</label>
							<input type="text" class="form-control" name="packageWidth" id="packageWidth" onkeyup="return ValidateNumber($(this),value)">
						</div>
						<div class="form-group">
							<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;高</label>
							<input type="text" class="form-control" name="packageHeight" id="packageHeight" onkeyup="return ValidateNumber($(this),value)">
						</div>
						<div class="form-group">
							<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;重量</label>
							<input type="text" class="form-control" name="packageWeight" id="packageWeight" onkeyup="return ValidateNumber($(this),value)">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;备注</label>
							<input type="text" class="form-control" name="remark" id="remark" >
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<script type="text/javascript">
		
		function ValidateNumber(e, pnumber) {
			if (!/^\d+$/.test(pnumber)) {
				$(e).val(/^\d+/.exec($(e).val()));
			}
		}
	</script>
</body>
</html>
