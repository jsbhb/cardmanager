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
<title>新增规则</title>
<%@include file="../../resource.jsp" %>
</head>

<body>
	<div id="page-wrapper">
		<div class="container-fluid">
			<form role="form" id="ruleForm">
			<table class="table table-bordered">
				<tr>
					<td><label>规则类型:</label></td>
					<td>
						<select name="type" class="form-control span2" id="type">
							<option value="0" selected>订单规则</option>
						</select>
					</td>	 
					<td><label>规则节点:</label></td>
					<td>
						<select name="node" class="form-control span2" id="node">
							<c:if test="${rule.node=='1'}">
							<option value="1" selected>接单规则</option>
							<option value="2">打包规则</option>
							<option value="3" >出货规则</option>
							</c:if>
							<c:if test="${rule.node=='2'}">
							<option value="1" >接单规则</option>
							<option value="2" selected>打包规则</option>
							<option value="3" >出货规则</option>
							</c:if>
							<c:if test="${rule.node=='3'}">
							<option value="1">接单规则</option>
							<option value="2">打包规则</option>
							<option value="3" selected>出货规则</option>
							</c:if>
						</select>
					</td>	 
				</tr>
				<tr>
					<td><label>规则名称:</label></td><td><input type='text' class="form-control" id="name" name="name" value="${rule.name}"></td>	 
					<td><label>规则(例：2..或者HH:MM:SS(16:30:00)):</label></td><td><input type='text' class="form-control" id="rule" name="rule" value="${rule.rule}"></td>	 
					<input type='hidden' class="form-control" id="id" name="id" value="${rule.id}">
				</tr>
			</table>
		</form>
	</div>
</div>

<script type="text/javascript">
$(".dataPicker").datetimepicker({format: 'yyyy-mm-dd'});

function submitForm() {
	
	var type = $("#type").val();
	if(type==null || type==""){
		$.zzComfirm.alertError("请选择规则类型");
		return;
	}
	
	var node = $("#node").val();
	if(node == null || node == ''){
		$.zzComfirm.alertError("请选择节点类型");
		return;
	}
	
	var rule = $("#rule").val();
	
	if(!checkTime(rule)){
		$.zzComfirm.alertError("规则不正确");
		return;
	}
	if(rule == null || rule == ''){
		$.zzComfirm.alertError("规则不能为空");
		return;
	}
	
	var name = $("#name").val();
	if(name == null || name == ''){
		$.zzComfirm.alertError("规则名称不能为空");
		return;
	}
	
	$.ajax({
		 url:"${wmsUrl}/admin/statistic/rule/updateRule.shtml",
		 type:'post',
		 data:sy.serializeObject($('#ruleForm')),
		 dataType:'json',
		 success:function(data){
			 if(data.success){	
				 $.zzComfirm.alertSuccess("修改成功");
				 window.parent.reloadTable();
				 window.parent.closeEditModal();
			 }else{
				 $.zzComfirm.alertError(data.errInfo);
			 }
		 },
		 error:function(){
			 $.zzComfirm.alertError("系统出现问题啦，快叫技术人员处理");
		 }
	 });
};

function checkTime(rule){
    var regTime = /^([0-2][0-9]):([0-5][0-9]):([0-5][0-9])$/;
    var regNum = /^d+(.d+)?$/;
    if (regTime.test(rule)) {
        if ((parseInt(RegExp.$1) < 24) && (parseInt(RegExp.$2) < 60) && (parseInt(RegExp.$3) < 60)) {
        	return true;
        }
    }
    
    if (!isNaN(rule)) {
   	  return  true;
    }
    
    return false;
}
</script>
</body>
</html>
