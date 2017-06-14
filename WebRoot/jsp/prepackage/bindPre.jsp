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
<title>预包绑定</title>
<%@include file="../resource.jsp" %>
</head>

<body>
	<div id="page-wrapper">
		<div class="container-fluid">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">
						<i class="fa fa-bar-chart-o fa-fw"></i>预包信息
					</h3>
				</div>
				<div class="panel-body">
					<table class="table table-bordered">
						<thead>
							<tr>
								<th>货号</th>
								<th>名称</th>
								<th>数量</th>
								<th>效期</th>
								<th>报检号</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${list}" var = "item">
							<tr>
								<td><label>${item.sku}</label></td>	 
								<td><label>${item.skuName}</label></td>
								<td><label>${item.quantity==null?0:item.quantity}</label></td>
								<td><label>${item.deadline}</label></td>
								<td><label>${item.declNo}</label></td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<form role="form" id="preForm" class="queryTerm">
				<div class="row"  >
					<div class="col-lg-12">
						<div class="form-group">
							<label>还可打包:</label> 
							<input type="text" class="form-control" id="totalNum" name="totalNum" value="${totalNum}" readonly="readonly">
							<input type="hidden" class="form-control" id="libinfoid" name="libinfoid" value="${libinfoid}">
							<input type="hidden" class="form-control" id="pid" name="pid" value="${pid}">
						</div>
						<div class="form-group">
							<label>已打包:</label> <input type="text" class="form-control" id="pacNum" name="pacNum" value="${pacNum}" readonly="readonly">
						</div>
						<div class="form-group">
							<label>打包数量:</label> <input type="text" class="form-control"  name="num" id="num">
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
<script type="text/javascript">

function submitForm() {
	var reg = /^([1-9]\d*|[0]{1,1})$/;
	var num = $("#num").val();
	if(isNaN(num)){
		$.zzComfirm.alertError("数量有误请重新输入！！");
		return false;
	}
	
	if(num==""){
		$.zzComfirm.alertError("未输入数量！！");
		return false;
	}
	
	if(!reg.test(num)){
		$.zzComfirm.alertError("请输入正整数！！");
		return false;
	}
	var totalNum = $("#totalNum").val();
	var pacNum = $("#pacNum").val();
	if(num>(Number(totalNum)+Number(pacNum))){
		$.zzComfirm.alertError("可打包数量超过该库位可打包数量！！");
		return false;
	}
	var o = sy.serializeObject($('#preForm'));
	$.ajax({
		 url:"${wmsUrl}/admin/prePackage/prePacMng/saveBind.shtml",
		 type:'post',
		 data:sy.serializeObject($('#preForm')),
		 dataType:'json',
		 success:function(data){
			 if(data.success){	
				 $.zzComfirm.alertSuccess("操作成功");
				 window.parent.reloadTable();
				 window.parent.closeBindModal();
			 }else{
				 $.zzComfirm.alertError(data.msg);
			 }
		 },
		 error:function(){
			 $.zzComfirm.alertError("系统出现问题啦，快叫技术人员处理");
		 }
	 });
};



</script>
</body>
</html>
