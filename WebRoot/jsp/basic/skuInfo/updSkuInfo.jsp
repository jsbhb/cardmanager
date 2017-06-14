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
<title>商品信息</title>
<%@include file="../../resource.jsp"%>
</head>

<body>
	<div id="page-wrapper">

		<div class="container-fluid">
			<form role="form" id="libraryForm">
				<div class="row">
					<div class="col-lg-12">
						<ol class="breadcrumb">
							<li><i class="fa fa-book fa-fw"></i>商品管理</li>
							<li class="active"><i class="fa fa-bookmark fa-fw"></i>更新商品信息</li>
						</ol>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<label>货主编号</label><input type="text" class="form-control"
								name="ownerUserId" id="ownerUserId"
								value="${skuInfo.ownerUserId}" disabled="disabled">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<label>商品编号</label><input type="text" class="form-control"
								name="itemId" id="itemId" value="${skuInfo.itemId}"
								disabled="disabled">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<label>商品编码</label><input type="text" class="form-control"
								name="itemCode" id="itemCode" value="${skuInfo.itemCode}"
								disabled="disabled">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;货号</label><input
								type="text" class="form-control" name="sku" id="sku"
								value="${skuInfo.sku}" disabled="disabled">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;长</label>
							<input type="text" class="form-control" name="length" id="length"
								value="${skuInfo.length}" onblur="checkQuantity(this)">mm
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;宽</label>
							<input type="text" class="form-control" name="width" id="width"
								value="${skuInfo.width}" onblur="checkQuantity(this)">mm
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;高</label>
							<input type="text" class="form-control" name="height" id="height"
								value="${skuInfo.height}" onblur="checkQuantity(this)">mm
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;净重</label> <input
								type="text" class="form-control" name="netWeight" id="netWeight"
								value="${skuInfo.netWeight}" onblur="checkQuantity(this)">g
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;毛重</label> <input
								type="text" class="form-control" name="grossWeight"
								id="grossWeight" value="${skuInfo.grossWeight}" onblur="checkQuantity(this)">g
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;外箱重量</label> <input
								type="text" class="form-control" name="opWeight"
								id="opWeight" value="${skuInfo.opWeight}" onblur="checkQuantity(this)">g
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;外箱长</label> <input
								type="text" class="form-control" name="opLength"
								id="opLength" value="${skuInfo.opLength}" onblur="checkQuantity(this)">mm
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;外箱宽</label> <input
								type="text" class="form-control" name="opWidth"
								id="opWidth" value="${skuInfo.opWidth}" onblur="checkQuantity(this)">mm
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;外箱高</label> <input
								type="text" class="form-control" name="opHeight"
								id="opHeight" value="${skuInfo.opHeight}" onblur="checkQuantity(this)">mm
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;外箱箱规</label> <input
								type="text" class="form-control" name="opPcs"
								id="opPcs" value="${skuInfo.opPcs}" onblur="checkQuantity(this)">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<input type="hidden" class="form-control" name="skuInfoId"
								id="skuInfoId" value="${skuInfo.skuInfoId}">
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<script type="text/javascript">

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
