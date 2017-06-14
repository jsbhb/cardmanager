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
<title>机构管理</title>
<%@include file="../resource.jsp" %>
</head>

<body>
	<div id="page-wrapper">

		<div class="container-fluid">
				<form role="form" id="compForm">
					<div class="row">
						<div class="form-group col-lg-6">
							<label>机构名称:</label> <input class="form-control" id="compName" name="compName"  >
						</div>
					</div>
					<div class="row">
						<div class="form-group col-lg-6">
							<label>机构地址:</label> <input class="form-control" id="location" name="location" >
						</div>
					</div>
					<div class="row">
						<div class="form-group col-lg-6">
							<label>是否失效:</label> 
							<select name="status" class="form-control" id="isDisabled" name="isDisabled">
								<option value="0">生效</option>
								<option value="1">失效</option>
							</select>
						</div>
					</div>
					<div class="row">
						<div class="form-group col-lg-6">
							<label>生效时间:</label> 
							<input size="16" type="text" id="effectDate" readonly class="form-control dataPicker" name="effectDate">
						</div>
						<div class="form-group col-lg-6">
							<label>失效时间:</label>
							<input size="16" type="text" id="disabledDate" readonly class="form-control dataPicker" name="disabledDate">
						</div>
					</div>
				</form>
			</div>
		</div>
	

<script type="text/javascript">
$(function(){
	$(".dataPicker").datetimepicker({format: 'yyyy-mm-dd'});
})
</script>
</body>
</html>
