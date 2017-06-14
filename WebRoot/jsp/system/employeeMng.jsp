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
<title>员工管理</title>
<link rel="stylesheet" href="${wmsUrl}/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${wmsUrl}/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="${wmsUrl}/css/core.css">
</head>

<body>
	<div id="page-wrapper">

		<div class="container-fluid">

			<!-- Page Heading -->
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">员工管理</h1>
					<ol class="breadcrumb">
						<li><i class="fa fa-desktop"></i>系统管理</li>
						<li class="active"><i class="fa fa-user-md"></i> 员工管理</li>
					</ol>
				</div>
			</div>
			<!-- /.row -->

			<div class="row">
				<div class="col-lg-12">
					<form role="form" class="query">
						<div class="form-group">
							<label>员工号:</label> <input class="form-control" name="badge">
						</div>

						<div class="form-group">
							<label>员工名称:</label> <input class="form-control" name="userName">
						</div>
						<button type="submit" class="btn btn-default">查询</button>
					</form>
				</div>
			</div>

			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">
								<i class="fa fa-bar-chart-o fa-fw"></i>员工列表
							</h3>
						</div>
						<div class="panel-body">
							<c:if test="${privilege==1}">
								<button type="submit" class="btn btn-default">新增</button>
								<button type="submit" class="btn btn-default">修改</button>
							</c:if>
							<table id="clubTable" class="table table-hover">
								<thead>
									<tr>
										<th><input id="checkall" name="checkall" type="checkbox" /></th>
										<th>编号</th>
										<th>员工号</th>
										<th>名称</th>
										<th>职位</th>
										<th>部门</th>
										<th>公司</th>
										<th>性别</th>
										<th>生日</th>
										<th>电话</th>
										<th>邮箱</th>
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
<script type="text/javascript" src="${wmsUrl}/js/jquery.min.js"></script>
<script type="text/javascript" src="${wmsUrl}/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${wmsUrl}/js/pagination.js"></script>
<script type="text/javascript">
/**
 * 初始化分页信息
 */
var options = {
			queryForm : ".query",
			url :  "${wmsUrl}/system/employee/dataList.shtml",
			numPerPage:"10",
			currentPage:"",
			index:"1",
			callback:rebuildTable
}

$(function(){
	 $(".pagination-nav").pagination(options);
	 
	 $("#checkall").bind("click", function() {
			if ($("#checkall").get(0).checked) {
				$("#checkall").prop("checked", "checked");
				$("input[name='check']").prop("checked", "checked");
				$("tr").addClass("table_selected");
			} else {
				$("#checkall").removeAttr("checked");
				$("input[name='check']").removeAttr("checked");
				$("tr").removeClass("table_selected");
			}
		});
})

/**
 * 重构table
 */
function rebuildTable(data){
	$("#clubTable tbody").html("");


	if (data == null || data.length == 0) {
		return;
	}
	
	var list = data.obj;
	
	if (list == null || list.length == 0) {
		$.pldComfirm.alertError("没有查到数据");
		return;
	}

	var str = "";
	for (var i = 0; i < list.length; i++) {
		str += "<tr><td><input name='check' type='checkbox'/></td><td>" + list[i].id;
		str += "</td><td>" + list[i].badge;
		str += "</td><td>" + list[i].jobName;
		str += "</td><td>" + list[i].deptName;
		str += "</td><td>" + list[i].comName;
		str += "</td><td>" + list[i].name;
		str += "</td><td>" + list[i].gender;
		str += "</td><td>" + list[i].birthday;
		str += "</td><td>" + list[i].tel;
		str += "</td><td>" + list[i].email;
		str += "</td><td>" + list[i].createTime;
		str += "</td><td>" + list[i].settingRelationship;
		str += "</td></tr>";
	}
	$("#clubTable tbody").htmlUpdate(str);
	
	trBind();
}

</script>

</body>
</html>
