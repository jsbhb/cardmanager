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
<%@include file="../../resourceLink.jsp"%>
</head>
<body>
<section class="content-wrapper">
	<section class="content">
		<div class="box box-info">
			<div class="box-header with-border">
				<div class="box-header with-border">
	            	<h5 class="box-title">搜索</h5>
	            	<div class="box-tools pull-right">
	                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
	              	</div>
	            </div>
			</div>
		    <div class="box-body">
			<div class="row form-horizontal">
				<div class="col-xs-6">
						<div class="form-group">
							<label class="col-sm-4 control-label no-padding-right" for="form-field-1">模板编号<font style="color:red">*</font> </label>
							<div class="col-sm-8">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-book"></i>
				                  </div>
		                  			<input type="text" class="form-control" name="id">
				                </div>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<label class="col-sm-4 control-label no-padding-right" for="form-field-1">模板名称<font style="color:red">*</font> </label>
							<div class="col-sm-8">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-book"></i>
				                  </div>
		                  			<input type="text" class="form-control" name="brandName">
				                </div>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="form-group">
							<div class="col-sm-8">
								<button type="button" class="btn btn-primary" id="submitBtn" name="signup">提交</button>
                                <button type="button" class="btn btn-info" id="resetBtn">重置</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
	
		<div class="box box-warning">
			<div class="box-body">
				<div class="row">
					<div class="col-md-12">
						<div class="panel panel-default">
							<table id="specsTable" class="table table-hover">
								<thead>
									<tr>
										<th>模板编号</th>
										<th>模板名称</th>
										<th>创建时间</th>
										<th>创建人</th>
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
	</section>
	</section>
	
	<%@include file="../../resourceScript.jsp"%>
	<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
<script type="text/javascript">


/**
 * 初始化分页信息
 */
var options = {
			queryForm : ".query",
			url :  "${wmsUrl}/admin/goods/specsMng/dataList.shtml",
			numPerPage:"20",
			currentPage:"",
			index:"1",
			callback:rebuildTable
}


$(function(){
	 $(".pagination-nav").pagination(options);
})


function reloadTable(){
	$.page.loadData(options);
}


/**
 * 重构table
 */
function rebuildTable(data){
	$("#specsTable tbody").html("");

	if (data == null || data.length == 0) {
		return;
	}
	
	var list = data.obj;
	
	if (list == null || list.length == 0) {
		layer.alert("没有查到数据");
		return;
	}

	var str = "";
	for (var i = 0; i < list.length; i++) {
		str += "<tr>";
		str += "</td><td>" + list[i].id;
		str += "</td><td>" + list[i].name;
		str += "</td><td>" + list[i].createTime;
		str += "</td><td>" + list[i].opt;
		
		str += "</td></tr>";
	}
		

	$("#specsTable tbody").html(str);
	trBind();
}
	
/**
 * 数据字典tr绑定选中事件
 */
function trBind() {
	$("#specsTable tr").dblclick(sureSpecs);
};

function sureSpecs(){
		var selectTr = $(this);

		if ($(selectTr).parent().is('thead')) {
			return;
		}
		var id =  selectTr.children("td").eq(0).text()
		
		parent.createSpecs(id);
		
		
		parent.layer.closeAll();
}


</script>
</body>
</html>
