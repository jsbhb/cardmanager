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
							<label class="col-sm-4 control-label no-padding-right">商家</label>
							<div class="col-sm-8">
								<div class="input-group">
									 <select class="form-control" name="supplierId" id="supplierId" style="width: 100%;">
				                   	  <option selected="selected" value="-1">未选择</option>
				                   	  <c:forEach var="supplier" items="${suppliers}">
				                   	  	<option value="${supplier.id}">${supplier.supplierId}</option>
				                   	  </c:forEach>
					                </select>
				                </div>
			                </div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label class="col-sm-4 control-label no-padding-right">状态</label>
							<div class="col-sm-8">
								<div class="input-group">
									 <select class="form-control" name="status" id="status" style="width: 100%;">
					                   	  <option selected="selected" value="-1">未选择</option>
					                   	  <option value="0">待处理</option>
					                   	  <option value="1">已处理</option>
					                </select>
				                </div>
			                </div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label class="col-sm-4 control-label no-padding-right" for="form-field-1">itemCode</label>
							<div class="col-sm-8">
								<div class="input-group">
		                  			<input type="text" class="form-control" name="itemCode">
				                </div>
			                </div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label class="col-sm-4 control-label no-padding-right" for="form-field-1">sku</label>
							<div class="col-sm-8">
								<div class="input-group">
		                  			<input type="text" class="form-control" name="sku">
				                </div>
			                </div>
						</div>
					</div>
					<div class="col-md-offset-10 col-md-12">
						<div class="form-group">
	                          <button type="button" class="btn btn-primary" id="querybtns" name="signup">提交</button>
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
							<table id="syncTable" class="table table-hover">
								<thead>
									<tr>
										<th>供应商</th>
										<th>商品名称</th>
										<th>状态</th>
										<th>sku</th>
										<th>itemcode</th>
										<th>品牌</th>
										<th>重量</th>
										<th>国家</th>
										<th>更新时间</th>
										<th>操作</th>
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

$("#supplierId").change(function(){
	$("#supplierName").val($("#supplierId").find("option:selected").text());
});

/**
 * 初始化分页信息
 */
var options = {
			queryForm : ".query",
			url :  "${wmsUrl}/admin/goods/goodsMng/syncDataList.shtml",
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
	$("#syncTable tbody").html("");

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
		var status = list[i].status;
		
		str += "</td><td>" + list[i].supplierName;
		str += "</td><td>" + list[i].goodsName;
		
		switch(status){
			case 0:str += "</td><td>待处理";break;
			case 1:str += "</td><td>已处理";break;
			default:str += "</td><td>未知状态";
		}
		
		str += "</td><td>" + list[i].sku;
		str += "</td><td>" + list[i].itemCode;
		str += "</td><td>" + list[i].brand;
		str += "</td><td>" + list[i].weight;
		str += "</td><td>" + list[i].origin;
		str += "</td><td>" + list[i].updateTime;
		if (true) {
			str += "<td align='left'>";
			
			if(status ==1 ){
				str += "<button type='button' disable class='btn btn-error'>新建商品</button>";
				str += "<button type='button' disable class='btn btn-error'>绑定商品</button>";
			}else{
				str += "<button type='button' class='btn btn-warning' onclick='bindBaseGoods("+list[i].id+")' >新建商品</button>";
			
			str += "</td>";
		}
		str += "</td></tr>";
		}
	}

	$("#syncTable tbody").html(str);
}
	
function bindBaseGoods(id){
	var index = layer.open({
		  title:"基础商品编辑",		
		  type: 2,
		  content: '${wmsUrl}/admin/goods/goodsMng/toAdd.shtml?type=sync&id='+id,
		  maxmin: true
		});
		layer.full(index);
}

function bindGoods(id){
	var index = layer.open({
		  title:"查看商品",		
		  type: 2,
		  content: '${wmsUrl}/admin/goods/goodsMng/toAdd.shtml?id='+id,
		  maxmin: true
		});
		layer.full(index);
}

</script>
</body>
</html>
