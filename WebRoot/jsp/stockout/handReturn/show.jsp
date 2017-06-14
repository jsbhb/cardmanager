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
<title>更新重量</title>
<%@include file="../../resource.jsp"%>
</head>

<body>
	<div id="page-wrapper">

		<div class="container-fluid">
			<form role="form" id="libraryForm">
				<div class="row">
					<div class="col-lg-12">
						<ol class="breadcrumb">
							<li><i class="fa fa-book fa-fw"></i>出库业务</li>
							<li class="active"><i class="fa fa-bookmark fa-fw"></i>更新重量</li>
						</ol>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<label>订单编号</label><input type="text" class="form-control"
								name="externalNo2" id="externalNo2"
								value="${osu.externalNo2}" disabled="disabled">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<label>仓储编号</label><input type="text" class="form-control"
								name="orderCode" id="orderCode" value="${osu.orderCode}"
								disabled="disabled">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<label>重量 &nbsp;&nbsp;</label><input type="text" class="form-control"
								name="weight" id="weight" value="${osu.weight}" onblur="checkQuantity(this)">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<input type="hidden" class="form-control" name="id"
								id="id" value="${osu.id}">
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<script type="text/javascript">
		$(function() {
			$(".dataPicker").datetimepicker({
				format : 'yyyy-mm-dd'
			});
		})

		function checkQuantity(obj){
			var value =  $(obj).val();
			if(isNaN(value)){
				$.zzComfirm.alertError("请输入数字");
				$(obj).val("");
			}
			var reg = /^([1-9]\d*|[0]{1,1})$/;
			if(!reg.test(value)){
				$.zzComfirm.alertError("请输入正整数！！");
				$(obj).val("");
			}
			if(value <10){
				$.zzComfirm.alertError("请输入大于10的数字");
				$(obj).val("");
			}
			if(value >50000){
				$.zzComfirm.alertError("请输入小于50000的数字");
				$(obj).val("");
			}
		}
	</script>
</body>
</html>
