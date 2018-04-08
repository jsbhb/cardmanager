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
						<label class="col-sm-4 control-label no-padding-right" for="form-field-1">供应商</label>
						<div class="col-sm-8">
							<div class="input-group">
			                  <select class="form-control" name="supplierId" id="supplierId" style="width: 160px;">
		                   	  <option selected="selected" value="">未选择</option>
		                   	  <c:forEach var="supplier" items="${suppliers}">
		                   	  	<option value="${supplier.id}">${supplier.supplierName}</option>
		                   	  </c:forEach>
			                </select>
			                </div>
						</div>
					</div>
				</div>
				<div class="col-xs-4">
					<div class="form-group">
						<label class="col-sm-4 control-label no-padding-right" for="form-field-1">商品编码</label>
						<div class="col-sm-8">
							<div class="input-group">
	                  			<input type="text" class="form-control" name="goodsId">
			                </div>
						</div>
					</div>
				</div>
				<div class="col-xs-4">
					<div class="form-group">
						<label class="col-sm-4 control-label no-padding-right" for="form-field-1">明细编码</label>
						<div class="col-sm-8">
							<div class="input-group">
			                  <input type="text" class="form-control" name="itemId">
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
				<div class="col-xs-4">
					<div class="form-group">
						<label class="col-sm-4 control-label no-padding-right" for="form-field-1">商品名称</label>
						<div class="col-sm-8">
							<div class="input-group">
			                  <input type="text" class="form-control" name="goodsName">
			                </div>
						</div>
					</div>
				</div>
				<div class="col-xs-4">
					<div class="form-group">
						<label class="col-sm-4 control-label no-padding-right" for="form-field-1">状态</label>
						<div class="col-sm-8">
							<div class="input-group">
			                 <select class="form-control" name="status" id="status" style="width: 160px;">
			                   	  <option selected="selected" value="">未选择</option>
			                   	  <option value="0">初始化</option>
			                   	  <option value="1">可用</option>
			                   	  <option value="2">可分销</option>
				                </select>
			                </div>
						</div>
					</div>
				</div>
				<div class="col-xs-4">
					<div class="form-group">
						<label class="col-sm-4 control-label no-padding-right">商品标签</label>
						<div class="col-sm-8">
							<div class="input-group">
								<select class="form-control" name="tagId" id="tagId" style="width: 160px;">
			                   	  <option selected="selected" value="">普通</option>
			                   	  <c:forEach var="tag" items="${tags}">
			                   	  	<option value="${tag.id}">${tag.tagName}</option>
			                   	  </c:forEach>
				                </select>
			                </div>
						</div>
					</div>
				</div>
				<div class="col-md-offset-10 col-md-12">
					<div class="form-group">
                         <button type="button" class="btn btn-primary" id="querybtns" name="signup">提交</button>
                         <button type="button" class="btn btn-warning" onclick = "noBeFx('')">批量不可分销</button>
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
							<table id="itemTable" class="table table-hover">
								<thead>
									<tr>
										<th>全选<input type="checkbox" id = selectAll onclick="selectAll(this);"></th>
										<th>编辑</th>
										<th>商品名称</th>
										<th>sku</th>
										<th>itemCode</th>
										<th>商品编号</th>
										<th>明细编号</th>
										<th>供应商</th>
										<th>分销价</th>
										<th>零售价</th>
<!-- 										<th>库存</th> -->
										<th>分销库存</th>
										<th>状态</th>
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


/**
 * 初始化分页信息
 */
var options = {
			queryForm : ".query",
			url :  "${wmsUrl}/admin/goods/itemMng/dataList.shtml",
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
		str += "<td><input type='checkbox' name='check' value='" + list[i].itemId + "' /></td>";
		if (true) {
			str += "<td align='left'>";
			str += "<a href='#' onclick='toShow("+list[i].id+")'><i class='fa fa-pencil'></i></a>";
			str += "</td>";
		}
		str += "</td><td>" + list[i].goodsName;
		str += "</td><td>" + list[i].sku;
		str += "</td><td>" + list[i].itemCode;
		str += "</td><td>" + list[i].goodsId;
		str += "</td><td>" + list[i].itemId;
		str += "</td><td>" + list[i].supplierName;
		str += "</td><td>" + list[i].goodsPrice.fxPrice;
		str += "</td><td>" + list[i].goodsPrice.retailPrice;
		if(list[i].stock!=null){
// 			str += "</td><td>" + list[i].stock.qpQty;
			str += "</td><td>" + list[i].stock.fxQty;
		}else{
// 		str += "</td><td>无";
		str += "</td><td>无";
		}
		var status = list[i].status;
		
		switch(status){
			case '0':str += "</td><td>初始化";break;
			case '1':str += "</td><td>可用";break;
			case '2':str += "</td><td>可分销";break;
			default:str += "</td><td>状态错误："+status;
		}
		str += "</td><td>" + list[i].updateTime;
		if (true) {
			str += "<td align='left'>";
			if(status == 0){
				str += "<button type='button' class='btn btn-warning' onclick='beUse("+list[i].itemId+")' >可用</button>";
			}else if(status == 1){
				str += "<button type='button' class='btn btn-warning' onclick='beFx("+list[i].itemId+")' >可分销</button>";
			}else if(status == 2){
				str += "<button type='button' class='btn btn-warning' onclick='noBeFx("+list[i].itemId+")' >不可分销</button>";
			}
			if(status==1||status==2){
				if(list[i].supplierName!="天天仓"&&list[i].supplierName!=null){
					str += "<button type='button' class='btn btn-info' onclick='syncStock("+list[i].itemId+")' >同步库存</button>";
				}
			}
			
			str += "</td>";
		}
		
		
		str += "</td></tr>";
	}
		

	$("#itemTable tbody").html(str);
}

function toShow(id){
	var index = layer.open({
		  title:"查看明细",		
		  type: 2,
		  content: '${wmsUrl}/admin/goods/itemMng/toShow.shtml?id='+id,
		  maxmin: true
		});
		layer.full(index);
}
	
function beUse(id){
	$.ajax({
		 url:"${wmsUrl}/admin/goods/itemMng/beUse.shtml?itemId="+id,
		 type:'post',
		 contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 success:function(data){
			 if(data.success){	
				 layer.alert("设置成功");
				 reloadTable();
			 }else{
				 layer.alert(data.msg);
			 }
		 },
		 error:function(){
			 layer.alert("提交失败，请联系客服处理");
		 }
	 });
}
function beFx(id){
	$.ajax({
		 url:"${wmsUrl}/admin/goods/itemMng/beFx.shtml?itemId="+id,
		 type:'post',
		 contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 success:function(data){
			 if(data.success){	
				 layer.alert("设置成功");
				 reloadTable();
			 }else{
				 layer.alert(data.msg);
			 }
		 },
		 error:function(){
			 layer.alert("提交失败，请联系客服处理");
		 }
	 });
}


function noBeFx(id){
	if(id == ""){
		var valArr = new Array; 
		var itemIds;
	    $("[name='check']:checked").each(function(i){ 
	        valArr[i] = $(this).val(); 
	    }); 
	    if(valArr.length==0){
	    	layer.alert("请选择数据");
	    	return;
	    }
	    itemIds = valArr.join(',');//转换为逗号隔开的字符串 
	} else {
		itemIds = id;
	}
	$.ajax({
		 url:"${wmsUrl}/admin/goods/itemMng/noBeFx.shtml?itemId="+itemIds,
		 type:'post',
		 contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 success:function(data){
			 if(data.success){	
				 layer.alert("设置成功");
				 reloadTable();
			 }else{
				 layer.alert(data.msg);
			 }
		 },
		 error:function(){
			 layer.alert("提交失败，请联系客服处理");
		 }
	 });
}
function fx(id){
	$.ajax({
		 url:"${wmsUrl}/admin/goods/itemMng/fx.shtml?itemId="+id,
		 type:'post',
		 contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 success:function(data){
			 if(data.success){	
				 layer.alert("设置成功");
				 reloadTable();
			 }else{
				 layer.alert(data.msg);
			 }
		 },
		 error:function(){
			 layer.alert("提交失败，请联系客服处理");
		 }
	 });
}
function syncStock(id){
	$.ajax({
		 url:"${wmsUrl}/admin/goods/itemMng/syncStock.shtml?itemId="+id,
		 type:'post',
		 contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 success:function(data){
			 if(data.success){	
				 layer.alert("开始同步。。稍后刷新查看");
				 reloadTable();
			 }else{
				 layer.alert(data.msg);
			 }
		 },
		 error:function(){
			 layer.alert("提交失败，请联系客服处理");
		 }
	 });
}

function selectAll(obj){
	if($("#selectAll").prop("checked")){
		 $("input[type='checkbox'][name='check']").prop("checked",true);//全选
	} else {
		 $("input[type='checkbox'][name='check']").prop("checked",false);//
	}
}

</script>
</body>
</html>
