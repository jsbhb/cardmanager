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
<%@include file="../../resource.jsp" %>
</head>

<body>
	<div id="page-wrapper">
		<div class="container-fluid">
			<div class="query">
				<table class="table table-bordered">
					<tr>
						<td><label>报检号:</label></td>
						<td><input type="text" class="form-control" id="declNo" name="declNo"></td>
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
							<table id="asnTable" class="table table-hover table-border">
								<thead>
									<tr>
										<th>预进货</th>
										<th>商家编号</th>
										<th>商家名称</th>
										<th>报检号</th>
										<th>状态</th>
										<th>操作人</th>
										<th>创建时间</th>
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
				url :  "${wmsUrl}/admin/stockIn/asnMng/supAsnList.shtml?supplierId=${supplierId}",
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
		$("#asnTable tbody").html("");
	
	
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
			str += "<tr><td>" + list[i].asnStockId;
			str += "</td><td>" + list[i].supplierId;
			str += "</td><td>" + list[i].supplierName;
			str += "</td><td>" + list[i].declNo;
			
			switch(list[i].status){
				case "1": str += "</td><td>预进货";break;
	  			case "2": str += "</td><td>到港";break;
	  			case "3": str += "</td><td>报关";break;
	  			case "4": str += "</td><td>精点";break;
	  			case "5": str += "</td><td>报备失败";break;
	  			case "6": str += "</td><td>报备成功";break;
	  			case "7": str += "</td><td>上架";break;
	  			case "11": str += "</td><td>撤单";break;
	  			case "21": str += "</td><td>采购单差异";break;
	  			case "41": str += "</td><td>改单";break;
	  			default: str += "</td><td>无";
			}
			str += "</td><td>" + list[i].opt;
			str += "</td><td>" + list[i].createTime;
			
			str += "</td></tr>";
		}
		
		
		$("#asnTable tbody").htmlUpdate(str);
		
		trBind()
	}
	
	/**
	 * 数据字典tr绑定选中事件
	 */
	function trBind() {
		$("#asnTable tr").dblclick(sureDeclNo);
	};
	
	function sureDeclNo(){
		var selectTr = $(this);

		if ($(selectTr).parent().is('thead')) {
			return;
		}
		
		var declNo = selectTr.children("td").eq(3).text();
		var asnStockId = selectTr.children("td").eq(0).text();
		
		$.ajax({
			 url:"${wmsUrl}/admin/stockIn/cnAsnMng/bind.shtml?orderId=${orderId}",
			 type:'post',
			 data:{"declNo":declNo,"asnStockId":asnStockId},
			 dataType:'json',
			 success:function(data){
				 if(data.success){	
					 $.zzComfirm.alertSuccess("绑定成功！");
					 window.parent.closeAsnModal();
				 }else{
					 $.zzComfirm.alertError(data.msg);
				 }
			 },
			 error:function(){
				 $.zzComfirm.alertError("系统出现问题啦，快叫技术人员处理");
			 }
		 });
			
	}

	</script>
</body>
</html>