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
<title>店铺管理</title>
<%@include file="../../resource.jsp" %>
</head>

<body>
	<div id="page-wrapper">
		<div class="container-fluid">
			<div class="query">
				<table class="table table-bordered">
					<tr>
						<td><label>店铺编码:</label></td>
						<td><input type="text" class="form-control" id="shopId" name="shopId"></td>
						<td><label>店铺名称:</label></td>
						<td><input type="text" class="form-control" id="shopName" name="shopName"></td>	 
					</tr>
					<tr>
						<td colspan="4"><button type="button" class="btn btn-primary" id="querybtns">查询</button></td>
					</tr>
				</table>
			</div>
			<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-body">
						<table id="shopInfoTable" class="table table-hover">
							<thead>
								<tr>
									<th>店铺编码</th>
									<th>店铺名称</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
						<div class="pagination-nav">
							<ul id="pagination" class="pagination">
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">

	/**
	 * 初始化分页信息
	 */
	var options = {
				queryForm : ".query",
				url :  "${wmsUrl}/admin/basic/shopInfo/dataList.shtml",
				numPerPage:"10",
				currentPage:"",
				index:"1",
				callback:rebuildTable
	}
	
	$(function(){
		 $(".pagination-nav").pagination(options);
		 
	})
	
	/**
	 * 重构table
	 */
	function rebuildTable(data){
		$("#shopInfoTable tbody").html("");
	
	
		if (data == null || data.length == 0) {
			return;
		}
		
		var list = data.obj;
		
		if (list == null || list.length == 0) {
			$.zzComfirm.alertError("没有查到数据");
			return;
		}
	
		var str = "";
		for (var i = 0; i < list.length; i++) {
			str += "<tr><td>" + list[i].shopId;
			str += "</td><td>" + list[i].shopName;
			str += "</td></tr>";
		}
		
		
		$("#shopInfoTable tbody").htmlUpdate(str);
		
		trBind()
	}
	
	/**
	 * 数据字典tr绑定选中事件
	 */
	function trBind() {
		$("#shopInfoTable tr").dblclick(sureSup);
	};
	
	function sureSup(){
			var selectTr = $(this);

			if ($(selectTr).parent().is('thead')) {
				return;
			}
		
			$("tr[name='shopInfoId']").removeClass("table_selected");
			
			if (!selectTr.hasClass("table_selected")) {
				selectTr.addClass("table_selected");
			} 

			$('#shopId', window.parent.document).val(selectTr.children("td").eq(0).text());
			$('#shopName', window.parent.document).val(selectTr.children("td").eq(1).text());
			
			window.parent.closeShopModal();
	}

	</script>
</body>
</html>