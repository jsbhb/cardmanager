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
<title>存储类型</title>
<%@include file="../../resource.jsp"%>
</head>

<body>
	<div id="page-wrapper">

		<div class="container-fluid">
			<form role="form" id="libraryForm" class="queryTerm">
				<div class="row">
					<div class="col-lg-12">
						<ol class="breadcrumb">
							<li><i class="fa fa-book fa-fw"></i>存储类型</li>
							<li class="active"><i class="fa fa-bookmark fa-fw"></i>更新存储类型</li>
						</ol>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<label>类型编码</label><input type="text" class="form-control"
								name="code" id="code" value="${storageType.code}">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<label>类型名称</label><input type="text" class="form-control"
								name="storageName" id="storageName"
								value="${storageType.storageName}">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;长</label>
							<input type="text" class="form-control" name="length" id="length"
								value="${storageType.length}" onblur="checkQuantity(this)">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;宽</label>
							<input type="text" class="form-control" name="width" id="width"
								value="${storageType.width}" onblur="checkQuantity(this)">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;高</label>
							<input type="text" class="form-control" name="height" id="height"
								value="${storageType.height}" onblur="checkQuantity(this)">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;备注</label> <input
								type="text" class="form-control" name="remark" id="remark"
								value="${storageType.remark}">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<input type="hidden" class="form-control" name="id" id="id"
								value="${id}">
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<script type="text/javascript">

		$(function pageInit() {
			status = '${library.status}';
			type = '${library.type}';
			depart = '${library.depart}';
			qptype = '${library.qptype}';
			if (qptype == null || qptype == "0") {
				$("#qptype option[value='0']").attr("selected", "selected");
			} else {
				$("#qptype option[value=" + qptype + "]").attr("selected",
						"selected");
			}
			if (status == null || status == "") {
				$("#status option[value='1']").attr("selected", "selected");
			} else {
				$("#status option[value=" + status + "]").attr("selected",
						"selected");
			}
			if (type == null || type == "") {
				$("#type option[value='1']").attr("selected", "selected");
			} else {
				$("#type option[value=" + type + "]").attr("selected",
						"selected");
			}
			if (depart == null || type == "") {
				$("#depart option[value='东区']").attr("selected", "selected");
			} else {
				$("#depart option[value=" + depart + "]").attr("selected",
						"selected");
			}
			$("#direction").val('${library.direction}');
			$("#arrange").val('${library.arrange}');
			$("#storey").val('${library.storey}');
			$("#lump").val('${library.lump}');
			upFlg = '${upFlg}';
			if (upFlg) {
				$("#notice").hide();
				removeAttr();
			} else {
				$("#notice").show();
				judje();
			}
		})

		function removeAttr() {
			$("#status").removeAttr("disabled");
			$("#type").removeAttr("disabled");
			$("#depart").removeAttr("disabled");
			$("#direction").removeAttr("disabled");
			$("#arrange").removeAttr("disabled");
			$("#storey").removeAttr("disabled");
			$("#lump").removeAttr("disabled");
			$("#qptype").removeAttr("disabled");
		}

		function judje() {
			$("#status").attr("disabled", "disabled");
			$("#type").attr("disabled", "disabled");
			$("#depart").attr("disabled", "disabled");
			$("#direction").attr("disabled", "disabled");
			$("#arrange").attr("disabled", "disabled");
			$("#storey").attr("disabled", "disabled");
			$("#lump").attr("disabled", "disabled");
			$("#qptype").attr("disabled", "disabled");
		}

		function checkQuantity(obj){
			var value =  $(obj).val();
			if(isNaN(value)){
				alert("请输入数字");
				$(obj).val("");
			}
		}
	</script>
</body>
</html>
