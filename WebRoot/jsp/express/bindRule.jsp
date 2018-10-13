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
<%@include file="../resourceLink.jsp"%>
<script src="${wmsUrl}/plugins/laydate/laydate.js"></script>
</head>

<body>
	<section class="content-iframe" style="margin-top:20px;">
		<div class="list-item">
			<div class="col-xs-3 item-left">规则选择</div>
			<div class="col-xs-9 item-right">
				<select class="form-control" name="rule" id="rule" onchange = listRuleParam()>
                  	  <option selected="selected" value="-1">--请选择--</option>
                  	  <c:forEach var="rule" items="${ruleList}">
                  	  	<option value='${rule.id};${rule.param}'>${rule.description}</option>
                  	  </c:forEach>
                </select>
			</div>
		</div>
		<div class="submit-btn">
			<button type="button" onclick="addRuleParam()">添加规则参数</button>
           	<button type="button" onclick="bind()">确定</button>
       	</div>
	</section>
	<%@include file="../resourceScript.jsp"%>
	<script type="text/javascript">
	function listRuleParam(){
		var value = $("#rule").val();
		var id = value.split(";")[0];
		var param = value.split(";")[1];
		if(id == -1){
			$("#ruleParamChose").remove();
			return;
		}
		$.ajax({
			 url:"${wmsUrl}/admin/expressMng/listRuleParam.shtml?id="+id+"&param="+encodeURIComponent(param),
			 type:'post',
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){
					$("#ruleParamChose").remove();
					var list = data.obj;
					var str = "";
					str = '<div class="list-item" id="ruleParamChose">';
					str += '<div class="col-xs-3 item-left">规则参数</div>';
					str += '<div class="col-xs-9 item-right">';
					if (list == null || list.length == 0) {
						str += '<input type="text" class="form-control" disabled style="background:#fff;" value = "暂无规则参数，请先添加">';
					} else {
						str += '<select class="form-control" name="ruleParam" id="ruleParam">';
						for (var i = 0; i < list.length; i++) {
							str += '<option value="'+list[i].id+'">'+list[i].param+'</option>';
						}
						str += '</select>';
					}
					str += '</div></div>';
					$(".list-item:last").after(str);
				 }else{
					 layer.alert(data.msg);
				 }
			 },
			 error:function(){
				 layer.alert("获取参数失败，请联系客服处理");
			 }
		 });
	}
	
	function addRuleParam(){
		var value = $("#rule").val();
		if("-1" == value){
			 layer.alert("请先选择规则");
			 return;
		}
		var id = value.split(";")[0];
		var param = value.split(";")[1];
		var index = layer.open({
			  title:"新增规则参数",		
			  type: 2,
			  area: ['100%','100%'],
			  content: '${wmsUrl}/admin/expressMng/toAddRuleParam.shtml?id='+id+"&param="+encodeURIComponent(param),
			  maxmin: false
			});
	}
	
	function bind(){
		var value = $("#rule").val();
		var id = value.split(";")[0];
		var param = value.split(";")[1];
		var paramId = $("#ruleParam").val();
		if(id == -1){
			layer.alert("请先选择规则");
			return;
		}
		if(paramId == undefined || paramId == ''){
			layer.alert("请先选择规则参数");
			return;
		}
		var ruleBind = {};
		ruleBind["description"] = $("#rule").find("option:selected").text();
		ruleBind["ruleId"] = id;
		ruleBind["param"] = $("#ruleParam").find("option:selected").text();
		ruleBind["paramId"] = paramId;
		parent.layer.closeAll();
		window.parent.addRule(ruleBind);
	}
		
	</script>
</body>
</html>