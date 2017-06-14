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
<title>分类分拣</title>
<%@include file="../../resource.jsp" %>
</head>

<body>
	<div id="page-wrapper">

		<div class="container-fluid">
			<!-- Page Heading -->
			<div class="row">
				<div class="col-lg-12">
					<ol class="breadcrumb">
						<li><i class="fa fa-fighter-jet fa-fw"></i>出库业务</li>
						<li class="active"><i class="fa fa-user-md fa-fw"></i> 一次分拣</li>
					</ol>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="query">
						<div class="row" >
							<div class="form-group">
								<label>指示号&nbsp;:</label> 
								<input size="16" type="text" id="instructions"  class="form-control" name="instructions">
							</div>
							<div class="form-group">
								<label>指示状态:</label> 
								<select name="state"  id="state" class="form-control span2">
									<option value="">全部</option>
									<option value="3">已打印</option>
									<option value="2">未打印</option>
								</select>
							</div>
						</div>
						<button type="button" id="querybtns" class="btn btn-primary">查询</button>
						<button type="button" id="reset" class="btn btn-primary" onclick="reset()">重置</button>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">
								<i class="fa fa-bar-chart-o fa-fw"></i>分类分拣列表
							</h3>
						</div>
						<div class="panel-body">
							<c:if test="${privilege>=2}">
								<button type="button" class="btn btn-primary" onclick="print()">重打分拣单</button>
							</c:if>
							<table id="classificationTable" class="table table-hover">
								<thead>
									<tr>
										<th><input type="checkbox" id = selectAll onclick="selectAll(this);"></th>
										<th>指示号</th>
										<th>货号</th>
										<th>商品名称</th>
										<th>数量</th>
										<th>状态</th>
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
				url :  "${wmsUrl}/admin/stockOut/classification/logList.shtml",
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
		$("#classificationTable tbody").html("");
	
	
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
			str += "<tr>";
			str += "<td><input type='checkbox' name='check' value='" + list[i].instructions + "' /></td>";
			str += "<td>" + list[i].instructions +"</td>";
			str += "<td>" + list[i].sku +"</td>";
			str += "<td>" + list[i].skuName +"</td>";
			str += "<td>" + list[i].sumNum +"</td>";
			switch(list[i].state){
				case 2:str += "<td>未打印</td>" ;break;
				case 3:str += "<td>已打印</td>" ;break;
				case 4:str += "<td>已拣货</td>" ;break;
				case 5:str += "<td>已复核</td>" ;break;
				case 6:str += "<td>已出库</td>" ;break;
			}
			str += "</tr>";
		}
		
		
		$("#classificationTable tbody").htmlUpdate(str);
	}
	
	
	   
	function selectAll(obj){
		$("[name='check']").each(function(){
	        this.checked = !this.checked;
	    });
	}
	
	function print(){
	    var valArr = new Array; 
	    $("[name='check']:checked").each(function(i){ 
	        valArr[i] = $(this).val(); 
	    }); 
	    for(var i=1;i<valArr.length;i++){
	    	if(valArr[0] != valArr[i]){
	    		$.zzComfirm.alertError("请选择相同的指示号");
		    	return;
	    	}
	    }
	    var instructions = valArr[0];//转换为逗号隔开的字符串 
		var left1 = (screen.width-600)/2;
		var top1 = (screen.height-450)/2;
		window.open('${wmsUrl}/admin/stockOut/classification/pdfjsp2.shtml?carrier='+$('#carrier').val()+'&instructions='+instructions+'&dsplatform='+$('#dsplatform').val(), "", "width=1400,height=700,resizable=yes,location=no,scrollbars=yes,left=" + left1.toString() + ",top=" + top1.toString());
		
	}
	</script>
</body>
</html>
