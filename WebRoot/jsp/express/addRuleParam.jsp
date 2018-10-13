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
		<input type="hidden" id = "id" value = "${id}"/>
		<div class="submit-btn">
           	<button type="button" onclick="add()">确定</button>
       	</div>
	</section>
	<%@include file="../resourceScript.jsp"%>
	<script type="text/javascript">
		$(function(){
			var param = '${paramKey}';
			var paramMap = JSON.parse(param);
			var str = "";
			for(var key in paramMap){
				str += '<div class="list-item">';
				str += '<div class="col-xs-3 item-left">'+key+'</div>';
				str += '<div class="col-xs-9 item-right">';
				str +='<input type="text" class="form-control" id = "'+paramMap[key]+'" placeholder="请输入参数">';
				str += '</div></div>';
			}
			$(".submit-btn:last").before(str);
		})	
		
		function add(){
			var parameter = "{";
			$(".content-iframe input[type='text']").each(function(){
				if($(this).val() != '' && $(this).val() != 'undefined'){
					var id = $(this).attr("id");
					var val = $(this).val();
					parameter += '"'+id+'":"'+val+'",';
				}
			})
			parameter = parameter.substring(0,parameter.length - 1) + '}';
			var ruleId = $("#id").val();
			var ruleParameter = {};
			ruleParameter["ruleId"] = ruleId;
			ruleParameter["param"] = parameter;
			$.ajax({
				url : '${wmsUrl}/admin/expressMng/addRuleParam.shtml',
				type : 'post',
				data : JSON.stringify(ruleParameter),
				contentType: "application/json; charset=utf-8",
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						parent.layer.closeAll();
						window.parent.listRuleParam();
					} else {
						layer.alert(data.msg);
					}
				},
				error : function() {
					layer.alert("提交失败，请联系客服处理");
				}
			});
		}
	</script>
</body>
</html>