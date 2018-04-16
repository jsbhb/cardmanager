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
			<div class="row form-horizontal query">
				<div class="col-xs-4">
						<div class="form-group">
							<label class="col-sm-4 control-label no-padding-right" for="form-field-1">商品编号<font style="color:red">*</font> </label>
							<div class="col-sm-8">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-user-o"></i>
				                  </div>
		                  			<input type="text" class="form-control" name="goodsId">
				                </div>
							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label class="col-sm-4 control-label no-padding-right" for="form-field-1">商品名称<font style="color:red">*</font> </label>
							<div class="col-sm-8">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-user-o"></i>
				                  </div>
		                  			<input type="text" class="form-control" name="goodsName">
				                </div>
							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label class="col-sm-4 control-label no-padding-right" for="form-field-1">供应商</label>
							<div class="col-sm-8">
								<div class="input-group">
				                  <select class="form-control" name="supplierId" id="supplierId" style="width: 100%;">
			                   	  <option selected="selected" value="-1">未选择</option>
			                   	  <c:forEach var="supplier" items="${suppliers}">
			                   	  	<option value="${supplier.id}">${supplier.supplierName}</option>
			                   	  </c:forEach>
				                </select>
				                </div>
							</div>
						</div>
					</div>
					<div class="col-md-offset-10 col-md-12">
						<div class="form-group">
                                <button type="button" class="btn btn-primary" id="querybtns" name="signup">提交</button>
                                <button type="button" class="btn btn-info" id="resetBtn">重置</button>
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
							<table id="goodsTable" class="table table-hover">
								<thead>
									<tr>
										<th>操作</th>
										<th>基础商品</th>
										<th>商品编号</th>
										<th>商品名称</th>
										<th>供应商</th>
										<th>产地</th>
										<th>创建时间</th>
										<th>编辑</th>
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
	
	
	<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
<script type="text/javascript">


/**
 * 初始化分页信息
 */
var options = {
			queryForm : ".query",
			url :  "${wmsUrl}/admin/goods/goodsMng/dataList.shtml",
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
	$("#goodsTable tbody").html("");

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
			str += "<a href='#' onclick='toShow("+list[i].id+")'><i class='fa fa-eye'></i></a>";
			str += "</td>";
		}
		str += "</td><td>" + list[i].baseId;
		str += "</td><td>" + list[i].goodsId;
		str += "</td><td>" + list[i].goodsName;
		str += "</td><td>" + list[i].supplierName;
		str += "</td><td>" + list[i].origin;
		str += "</td><td>" + list[i].createTime;
		if (true) {
			str += "<td align='left'>";
			var detailPath = (list[i].detailPath=="null"?"":list[i].detailPath);
			str += "<button type='button' class='btn btn-info' onclick='toEditDetail("+list[i].goodsId+",\""+detailPath+"\")' id='resetBtn'>编辑商详</button>";
			str += "</td>";
		}
		str += "</td></tr>";
	}
		

	$("#goodsTable tbody").html(str);
}
	
function toEdit(id){
	var index = layer.open({
		  title:"基础商品编辑",		
		  type: 2,
		  content: '${wmsUrl}/admin/goods/goodsMng/toEdit.shtml?id='+id,
		  maxmin: true
		});
		layer.full(index);
}

function toEditDetail(id,path){
	var index = layer.open({
		  title:"查看商品",		
		  type: 2,
		  content: '${wmsUrl}/admin/goods/goodsMng/ueditor.shtml?goodsId='+id+"&html="+path,
		  maxmin: true
		});
		layer.full(index);
}


function toShow(id){
	var index = layer.open({
		  title:"查看商品",		
		  type: 2,
		  content: '${wmsUrl}/admin/goods/goodsMng/toShow.shtml?id='+id,
		  maxmin: true
		});
		layer.full(index);
}

</script>
</body>
</html>
