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
<%@include file="../../resource.jsp"%>

<link rel="stylesheet" href="${wmsUrl}/validator/css/bootstrapValidator.min.css">
<script src="${wmsUrl}/validator/js/bootstrapValidator.min.js"></script>
</head>

<body>
	<section class="content">
        <div class="main-content">
			<div class="row">
				<div class="col-xs-12" >
					<form class="form-horizontal" role="form" id="specsForm" >
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">模板名称</label>
							<div class="col-sm-5">
								<div class="input-group">
		                  			<button type="text" disabled class="btn btn-info">${entity.name}</button>
				                </div>
							</div>
						</div>
						<c:forEach var="spec" items="${entity.specs}">
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">${spec.name}</label>
							<div class="col-sm-4">
								<div class="input-group">
				                  	<c:forEach var="value" items="${spec.values}">
		                  				<button type="button" disabled class="btn btn-warning">${value.value}</button>
		                  			</c:forEach>
		                  			<button type="button" onclick="toAddValue(${spec.id})" class="btn btn-danger"><i class="fa fa-plus"></i></button>
				                </div>
							</div>
						</div>
						</c:forEach>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"></label>
							<div class="col-sm-5">
								<div class="input-group">
		                  			<button type="button" onclick="toAddSpec(${entity.id})" class="btn btn-danger"><i class="fa fa-plus"></i></button>
				                </div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
	<script type="text/javascript">
	
	function toAddValue(id){
		var index = layer.open({
			  title:"新增规格值",		
			  type: 2,
			  content: '${wmsUrl}/admin/goods/specsMng/toAddValue.shtml?specsId='+id,
			  maxmin: true
			});
			layer.full(index);
	}
	
	function toAddSpec(id){
		var index = layer.open({
			  title:"品牌查看",		
			  type: 2,
			  content: '${wmsUrl}/admin/goods/specsMng/toAddSpec.shtml?templateId='+id,
			  maxmin: true
			});
			layer.full(index);
	}
	
	
	
	</script>
</body>
</html>
