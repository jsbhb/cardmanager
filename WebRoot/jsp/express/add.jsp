<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@include file="../resourceLink.jsp"%>
<link rel="stylesheet" type="text/css"
	href="${wmsUrl}/css/jquery.pickerModal.css">
</head>

<body>
	<section class="content-header">
		<ol class="breadcrumb">
			<li><a href="javascript:void(0);">首页</a></li>
			<li>物流管理</li>
			<li class="active">模板编辑</li>
		</ol>
	</section>
	<section class="content-iframe content">
		<form class="form-horizontal" role="form" id="itemForm">
			<div class="title">
				<h1>模板信息</h1>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">供应商</div>
				<div class="col-sm-9 item-right">
					<c:if test="${empty template}">
						<select class="form-control" name="supplierId" id="supplierId">
							<option selected="selected" value="">---请选择---</option>
							<c:forEach var="supplier" items="${supplier}">
								<option value="${supplier.id}">${supplier.supplierName}</option>
							</c:forEach>
						</select>
						<input type="hidden" class="form-control" name="id" id="id"
							value="" />
					</c:if>
					<c:if test="${not empty template}">
						<select class="form-control" name="supplierId" id="supplierId"
							disabled>
							<option selected="selected" value="${template.supplierId}">${template.supplierName}</option>
						</select>
						<input type="hidden" class="form-control" name="id" id="id"
							value="${template.id}" />
					</c:if>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">模板名称</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="templateName"
						id="templateName" value="${template.templateName}">
					<div class="item-content">（天天仓运费模板）</div>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">是否包税</div>
				<div class="col-sm-9 item-right" id="tax">
					<ul class="label-content-express" id="freeTax">
						<li data-id="0" class="active">不包税</li>
						<li data-id="1">包税</li>
					</ul>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">是否包邮</div>
				<div class="col-sm-9 item-right" id="post">
					<ul class="label-content-express" id="freePost">
						<li data-id="0" class="active">不包邮</li>
						<li data-id="1">包邮</li>
						<li data-id="2">邮费到付</li>
					</ul>
				</div>
			</div>
			<div class="submit-btn">
				<button type="button" id="saveAndEnable"
					onclick="saveInfo('enable')">保存并启用</button>
				<button type="button" id="saveInfoBtn" onclick="saveInfo('disable')">保存信息</button>
			</div>
		</form>
	</section>
	<%@include file="../resourceScript.jsp"%>
	<script src="${wmsUrl}/js/jquery.pickerModal.js"></script>
	<script type="text/javascript">
	$(function(){
		var freePost = '${template.freePost}';
		var freeTax = '${template.freeTax}';
		$("#freePost li").each(function(){
			if($(this).attr("data-id") == freePost){
				$("#freePost").find(">*").attr("class", "");
				$(this).addClass("active");
				return;
			}
		});
		$("#freeTax li").each(function(){
			if($(this).attr("data-id") == freeTax){
				$("#freeTax").find(">*").attr("class", "");
				$(this).addClass("active");
				return;
			}
		});
		var jsonStr = '${template.expressList}';
		var list
		if(isJSON(jsonStr)){
			list = $.parseJSON(jsonStr);
		}
		if($("#post .active").attr("data-id") == '0'){
			initTable(list);
		}
	});
		function saveInfo(param) {
			$('#itemForm').data("bootstrapValidator").validate();
			
			if(!valid()){
				return;
			}
			if ($('#itemForm').data("bootstrapValidator").isValid()) {

				var url = "${wmsUrl}/admin/expressMng/save.shtml";
				var formData = {};
				packExpressList(formData,param);
				$.ajax({
					url : url,
					type : 'post',
					data : JSON.stringify(formData),
					contentType: "application/json; charset=utf-8",
					dataType : 'json',
					success : function(data) {
						if (data.success) {
							parent.layer.closeAll();
							parent.location.reload();
						} else {
							layer.alert(data.msg);
						}
					},
					error : function() {
						layer.alert("提交失败，请联系客服处理");
					}
				});
			} else {
				layer.alert("信息填写有误");
			}
		}
		
		function packExpressList(formData,param){
			if("enable" == param){
				formData["enable"] = 1;
			}
			if("disable" == param){
				formData["enable"] = 0;
			}
			
			formData["freeTax"] = $('#freeTax li.active').attr('data-id');
			formData["freePost"] = $('#freePost li.active').attr('data-id');
			formData["id"] = $("#id").val();
			formData["supplierId"] = $("#supplierId option:selected").val();
			formData["templateName"] = $("#templateName").val();
			
			var array = new Array();
			$("[id=province]").each(function(){
				var express = {};
				express["includeProvince"] = $(this).text().trim();
				express["id"] = $(this).next().val();
				express["fee"] = $(this).parent().next().find("#fee").val();
				express["weight"] = $(this).parent().next().next().find("#weight").val();
				express["heavyFee"] = $(this).parent().next().next().next().find("#heavyFee").val();
				array.push(express);
			})
			formData["expressList"] = array;
		}

		function valid() {
			var flag = true;
			$('[id=province]').each(function() {
				temp = $(this).text().trim();
				if (temp == null || temp == '' || temp == 'undefined') {
					layer.alert("请选择省份");
					flag = false
					return flag;
				}
			});
			if(!flag){
				return;
			}
			$('[id=fee]').each(function() {
				temp = $(this).val();
				if (temp == null || temp === '' || temp == 'undefined') {
					layer.alert("请填写首费");
					flag = false
					return flag;
				}
				if (isNaN(temp)) {
					layer.alert("首费请填写数字");
					flag = false
					return flag;
				}
			});
			if(!flag){
				return;
			}
			$('[id=weight]').each(function() {
				temp = $(this).val();
				if (temp == null || temp === '' || temp == 'undefined') {
					layer.alert("请填写首重");
					flag = false
					return flag;
				}
				if (isNaN(temp)) {
					layer.alert("首重请填写数字");
					flag = false
					return flag;
				}
			});
			if(!flag){
				return;
			}
			$('[id=heavyFee]').each(function() {
				temp = $(this).val();
				if (temp == null || temp === '' || temp == 'undefined') {
					layer.alert("请填写续费");
					flag = false
					return flag;
				}
				if (isNaN(temp)) {
					layer.alert("续费请填写数字");
					flag = false
					return flag;
				}
			});
			if(!flag){
				return;
			}
			return flag;
		}

		$('#itemForm').bootstrapValidator({
			live : 'enabled',
			message : 'This value is not valid',
			feedbackIcons : {
				valid : 'glyphicon glyphicon-ok',
				invalid : 'glyphicon glyphicon-remove',
				validating : 'glyphicon glyphicon-refresh'
			},
			fields : {
				templateName : {
					trigger : "change",
					message : '模板名称不正确',
					validators : {
						notEmpty : {
							message : '模板名称不能为空！'
						}
					}
				},
				supplierId : {
					trigger : "change",
					message : '供应商不正确',
					validators : {
						notEmpty : {
							message : '请选择供应商！'
						}
					}
				}
			}
		});

		//点击标签选中
		$('#tax').on('click', '.label-content-express li', function() {
			if (!$(this).hasClass("active")) {
				$("#freeTax").find(">*").attr("class", "");
				$(this).addClass("active");
			}
		});

		//点击标签选中
		$('#post')
				.on(
						'click',
						'.label-content-express li',
						function() {
							if ($(this).attr("data-id") == "0"
									&& !$(this).hasClass("active")) {
								initTable(null);
							}
							if ($(this).attr("data-id") == "1" || $(this).attr("data-id") == "2") {
								$("#itemTable").remove();
								$("#addPost").remove();
							}
							if (!$(this).hasClass("active")) {
								$("#freePost").find(">*").attr("class", "");
								$(this).addClass("active");
							}
						});
		
		function initTable(list){
			var str = "<table id=\"itemTable\" class=\"table table-hover myClass\">";
			str += "<thead><tr>";
			str += "<th width=\"40%\">运送至</th>";
			str += "<th width=\"15%\">首费(元)</th>";
			str += "<th width=\"15%\">首重(克)</th>";
			str += "<th width=\"15%\">续费(元)</th>";
			str += "<th width=\"15%\">操作</th>";
			str += "</tr></thead><tbody>";
			if(list == null || list.length == 0){
				str += "<tr><td><span id = \"province\" name = \"province\"></span>&nbsp;&nbsp;<a href='javascript:void(0);' onclick='edit(this)'>编辑</a></td>"
				str += "<td><input id=\"fee\" name=\"fee\" type = \"text\" /></td>";
				str += "<td><input id=\"weight\" name=\"weight\" type = \"text\" value = \"1000\"/></td>";
				str += "<td><input id=\"heavyFee\" name = \"heavyFee\"type = \"text\"/></td>";
				str += "<td><a href='javascript:void(0);' onclick='del(this)'>删除</a></td></tr>";
			} else {
				for (var i = 0; i < list.length; i++){
					str += "<tr><td><span id = \"province\" name = \"province\">"+list[i].includeProvince+"</span>&nbsp;&nbsp;<input type = \"hidden\" value = \""+list[i].id+"\"/><a href='javascript:void(0);' onclick='edit(this)'>编辑</a></td>"
					str += "<td><input id=\"fee\" name=\"fee\" type = \"text\" value = \""+list[i].fee+"\"/></td>";
					str += "<td><input id=\"weight\" name=\"weight\" type = \"text\" value = \""+list[i].weight+"\"/></td>";
					str += "<td><input id=\"heavyFee\" name = \"heavyFee\"type = \"text\" value = \""+list[i].heavyFee+"\"/></td>";
					str += "<td><a href='javascript:void(0);' onclick='del(this)'>删除</a></td></tr>";
				}
			}
			str += "</tbody></table>";
			str += "<div id =\"addPost\"><a class=\"addBtn\" href=\"javascript:void(0);\" onclick=\"addPost()\">为指定区域设置运费</a></div>";

			$(".list-item:last").after(str);
		}

		function edit(e) {
			var exclude = '';
			var choose = '';
			var temp;
			$('[id=province]').not($(e).parent().find("[id='province']")).each(
					function() {
						temp = $(this).text().trim();
						exclude += temp
						exclude += ",";
					});
			choose = $(e).parent().find("[id='province']").text().trim();
			exclude = (exclude.substring(exclude.length - 1) == ',') ? exclude
					.substring(0, exclude.length - 1) : exclude;
			$.pickerModal({
				exclude : exclude,
				choose : choose
			}, function(opt) {
				console.log(opt)
				$(e).parent().find("[id='province']").text(opt.choose);
			});
		}

		function addPost() {
			var str = '';
			str += "<tr><td><span id = \"province\"></span> &nbsp;&nbsp;<a href='javascript:void(0);' onclick='edit(this)'>编辑</a></td>"
			str += "<td><input id=\"fee\" type = \"text\" /></td>";
			str += "<td><input id=\"weight\" type = \"text\" value = \"1000\"/></td>";
			str += "<td><input id=\"heavyFee\" type = \"text\"/></td>";
			str += "<td><a href='javascript:void(0);' onclick='del(this)'>删除</a></td>";
			$("#itemTable tr:last").after(str);
		}

		function del(temp) {
			if ($("#itemTable tr").length == 2) {
				layer.alert("请至少设置一条数据");
				return;
			}
			$(temp).parent().parent().remove();
		}
		
		function isJSON(str) {
		    if (typeof str == 'string') {
		        try {
		            var obj=JSON.parse(str);
		            if(typeof obj == 'object' && obj ){
		                return true;
		            }else{
		                return false;
		            }

		        } catch(e) {
		            return false;
		        }
		    }
		    return false;
		}
	</script>
</body>
</html>
