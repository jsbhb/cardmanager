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

<link rel="stylesheet" href="${wmsUrl}/validator/css/bootstrapValidator.min.css">
<script src="${wmsUrl}/validator/js/bootstrapValidator.min.js"></script>
<script src="${wmsUrl}/js/pagination.js"></script>

</head>

<body>
	<section class="content-wrapper">
        <div class="content">
        	<div class="box box-info">
			<div class="box-header with-border">
				<div class="box-header with-border">
	            	<h5 class="box-title">商品信息</h5>
	            	<div class="box-tools pull-right">
							<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
	              	</div>
	            </div>
			</div>
		    <div class="box-body">
				<div class="row form-horizontal">
					<div class="form-group">
						<label class="col-sm-2 control-label no-padding-right">商品编号</label>
						<div class="col-sm-4">
							<div class="input-group">
			                  <div class="input-group-addon">
			                    <i class="fa fa-pencil"></i>
			                  </div>
	                  			<input type="text" class="form-control" readonly  value="${goods.id}">
			                </div>
						</div>
						<label class="col-sm-1 control-label no-padding-right">商品编码</label>
						<div class="col-sm-4">
							<div class="input-group">
			                  <div class="input-group-addon">
			                    <i class="fa fa-pencil"></i>
			                  </div>
	                  			<input type="text" class="form-control" readonly  value="${goods.goodsId}">
			                </div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label no-padding-right">供应商</label>
						<div class="col-sm-4">
							<div class="input-group">
			                  <div class="input-group-addon">
			                    <i class="fa fa-pencil"></i>
			                  </div>
	                  			<input type="text" class="form-control" readonly  value="${goods.supplierName}">
			                </div>
						</div>
						<label class="col-sm-1 control-label no-padding-right">国家</label>
						<div class="col-sm-4">
							<div class="input-group">
			                  <div class="input-group-addon">
			                    <i class="fa fa-pencil"></i>
			                  </div>
	                  			<input type="text" class="form-control" readonly  value="${goods.origin}">
			                </div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label no-padding-right">基础商品编码</label>
						<div class="col-sm-4">
							<div class="input-group">
			                  <div class="input-group-addon">
			                    <i class="fa fa-pencil"></i>
			                  </div>
			                  <input type="text" class="form-control"  readonly value="${goods.baseId}">
			                </div>
						</div>
						<label class="col-sm-1 control-label no-padding-right">商品名称</label>
						<div class="col-sm-4">
							<div class="input-group">
		                    	<div class="input-group-addon">
			                    	<i class="fa fa-pencil"></i>
			                	</div>
			                  	<input type="text" class="form-control" name="area" readonly value="${goods.goodsName}">
			                </div>
						</div>
					</div>
				</div>
			</div>
		</div>
			<div class="box box-warning">
				<div class="box-header with-border">
					<div class="box-header with-border">
		            	<h5 class="box-title">明细信息</h5>
		            	<div class="box-tools pull-right">
							<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
						</div>
		            </div>
				</div>
				<div class="box-body">
					<div class="row">
						<div class="col-md-12">
							<c:if test="${goods.templateId > 0}">
								<button type="button" class="btn btn-primary" onclick="addItem()">新增明细</button>
							</c:if>
						</div>
						<div class="col-md-12">
							<div class="panel panel-default">
								<table id="itemTable" class="table table-hover">
									<thead>
										<tr>
											<th>明细编号</th>
											<th>itemCode</th>
											<th>sku</th>
											<th>重量</th>
											<th>消费税</th>
											<th>状态</th>
											<th>规格</th>
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
	</section>
	<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
	<script type="text/javascript">
	
	/**
	 * 初始化分页信息
	 */
	var options = {
				queryForm : ".query",
				url :  "${wmsUrl}/admin/goods/itemMng/dataListForGoods.shtml?goodsId="+"${goods.goodsId}",
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
	
	function addItem(){
		var index = layer.open({
			  title:"新增商品明细",		
			  type: 2,
			  content: '${wmsUrl}/admin/goods/itemMng/toAdd.shtml?templateId=${goods.templateId}&goodsId=${goods.goodsId}',
			  maxmin: true
			});
			layer.full(index);
	}
	
	/**
	 * 重构table
	 */
	function rebuildTable(data){
		$("#itemTable tbody").html("");

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
			str += "</td><td>" + list[i].itemId;
			str += "</td><td>" + list[i].itemCode;
			str += "</td><td>" + list[i].sku;
			str += "</td><td>" + list[i].weight;
			str += "</td><td>" + list[i].exciseTax;
			
			var status = list[i].status;
			
			switch(status){
				case 0:str += "</td><td>初始化";break;
				case 1:str += "</td><td>可用";break;
				case 2:str += "</td><td>可分销";break;
				default:str += "</td><td>状态错误："+status;
			}
			
			str += "</td><td>" + list[i].simpleInfo;
			str += "</td></tr>";
		}

		$("#itemTable tbody").html(str);
	}
	</script>
</body>
</html>