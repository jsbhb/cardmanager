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
<%@include file="../../resource.jsp"%>
<script src="${wmsUrl}/js/pagination.js"></script>



</head>
<body>
<section class="content-wrapper">
	<section class="content-header">
	      <h1><i class="fa fa-street-view"></i>功能管理</h1>
	      <ol class="breadcrumb">
	        <li><a href="#"><i class="fa fa-dashboard"></i> 首页</a></li>
	        <li class="active">功能管理</li>
	      </ol>
    </section>	
	<section class="content">
		<div class="box box-warning">
			<div class="box-header">
				<div class="row form-horizontal"><!--
				<div class="col-xs-4">
						<div class="form-group">
							<label class="col-sm-4 control-label no-padding-right" for="form-field-1">分级编号<font style="color:red">*</font> </label>
							<div class="col-sm-8">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-user-o"></i>
				                  </div>
		                  			<input type="text" class="form-control" name="id">
				                </div>
							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label class="col-sm-4 control-label no-padding-right" for="form-field-1">分级名称<font style="color:red">*</font> </label>
							<div class="col-sm-8">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-user-o"></i>
				                  </div>
		                  			<input type="text" class="form-control" name="gradeName">
				                </div>
							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label class="col-sm-4 control-label no-padding-right" for="form-field-1">公司名称<font style="color:red">*</font> </label>
							<div class="col-sm-8">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-address-book"></i>
				                  </div>
				                  <input type="text" class="form-control" name="company">
				                </div>
							</div>
						</div>
					</div>
					<div class="col-md-offset-10 col-md-12">
						<div class="form-group">
                                <button type="button" class="btn btn-primary" id="submitBtn" name="signup">提交</button>
                                <button type="button" class="btn btn-info" id="resetBtn">重置</button>
                        </div>
                     </div>-->
				</div> 
			</div>
			<div class="box-body">
				<div class="row">
					<div class="col-md-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">
								<button type="button" onclick="toAdd()" class="btn btn-primary">新增分级</button>
								</h3>
							</div>
							<table id="gradeTable" class="table table-hover">
								<thead>
									<tr>
										<th>操作</th>
										<th>等级编号</th>
										<th>名称</th>
										<th>上级机构</th>
										<th>类型</th>
										<th>公司</th>
										<th>负责人</th>
										<th>电话</th>
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
	</section>
	</section>
	
	<%@ include file="../../footer.jsp"%>
	
	<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
<script type="text/javascript">


/**
 * 初始化分页信息
 */
var options = {
			queryForm : ".query",
			url :  "${wmsUrl}/admin/system/gradeMng/dataList.shtml",
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
	$("#gradeTable tbody").html("");

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
		//if ("${privilege>=2}") {
		if (true) {
			str += "<td align='left'>";
			str += "<a href='#' onclick='toEdit("+list[i].id+")'><i class='fa fa-pencil' style='font-size:20px'></i></a>";
			str += "</td>";
		}
		str += "<td>" + list[i].id;
		str += "</td><td>" + (list[i].gradeName == null ? "" : list[i].gradeName);
		
		var pgName = list[i].parentGradeName;
		
		if(pgName != null && pgName !="null" && pgName != ""){
			str += "<td>" + list[i].parentGradeName;
		}else{
			str += "<td>";
		}
		
		
		var type = list[i].gradeType;
		
		if(type == "0"){
			str += "</td><td>大贸" ;
		}else if(type == "1"){
			str += "</td><td>跨境";
		}else if(type == "100"){
			str += "</td><td>总公司";
		}else{
			str += "</td><td>无";
		}
		str += "</td><td>" + (list[i].company == null ? "" : list[i].company);
		str += "</td><td>" + (list[i].personInCharge == null ? "" : list[i].personInCharge);
		str += "</td><td>" + (list[i].phone == null ? "" : list[i].phone);
		str += "</td><td>" + (list[i].createTime == null ? "" : list[i].createTime);
		
		str += "</td></tr>";
	}

	$("#gradeTable tbody").html(str);
}
	
function toEdit(id){
	var index = layer.open({
		 title:"分级编辑",		 
		  type: 2,
		  content: '${wmsUrl}/admin/system/gradeMng/toEdit.shtml?gradeId='+id,
		  maxmin: true
		});
		layer.full(index);
}


function toAdd(){
	var index = layer.open({
		  title:"新增分级",
		  type: 2,
		  content: '${wmsUrl}/admin/system/gradeMng/toAdd.shtml',
		  maxmin: true
		});
		layer.full(index);
}

</script>
</body>
</html>
