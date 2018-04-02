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
<!-- 		<div class="box box-info"> -->
<!-- 			<div class="box-header with-border"> -->
<!-- 				<div class="box-header with-border"> -->
<!-- 	            	<h5 class="box-title">搜索</h5> -->
<!-- 	            	<div class="box-tools pull-right"> -->
<!-- 	                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button> -->
<!-- 	              	</div> -->
<!-- 	            </div> -->
<!-- 			</div> -->
<!-- 		    <div class="box-body"> -->
<!-- 				<div class="row form-horizontal query"> -->
<!-- 					<div class="col-xs-4"> -->
<!-- 						<div class="form-group"> -->
<!-- 							<label class="col-sm-4 control-label no-padding-right" for="form-field-1">商品编码</label> -->
<!-- 							<div class="col-sm-8"> -->
<!-- 								<div class="input-group"> -->
<!-- 		                  			<input type="text" class="form-control" name="goodsId"> -->
<!-- 				                </div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="col-xs-4"> -->
<!-- 						<div class="form-group"> -->
<!-- 							<label class="col-sm-4 control-label no-padding-right" for="form-field-1">商品名称</label> -->
<!-- 							<div class="col-sm-8"> -->
<!-- 								<div class="input-group"> -->
<!-- 				                  <input type="text" class="form-control" name="goodsName"> -->
<!-- 				                </div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="col-md-offset-10 col-md-12"> -->
<!-- 						<div class="form-group"> -->
<!-- 	                         <button type="button" class="btn btn-primary" id="querybtns" name="signup">提交</button> -->
<!-- 	                    </div> -->
<!-- 	                </div> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
	
		<div class="box box-warning">
			<div class="box-body">
				<div class="row">
					<div class="col-md-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">
								<button type="button" onclick="toAdd()" class="btn btn-primary">新增标签</button>
								</h3>
							</div>
							<table id="itemTable" class="table table-hover">
								<thead>
									<tr>
										<th>标签名称</th>
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
			url :  "${wmsUrl}/admin/label/goodsTagMng/dataList.shtml",
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
		str += "</td><td>" + list[i].tagName;
		str += "</td><td>";
		str += "<button type='button' class='btn btn-danger' onclick='toEdit(\""+list[i].id+"\")' >修改</button>";
		str += "<button type='button' class='btn btn-danger' onclick='toDelete(\""+list[i].id+"\")' >删除</button>";
		str += "</td></tr>";
	}
	$("#itemTable tbody").html(str);
}
function toAdd(){
	var index = layer.open({
		  title:"新增标签",	
		  area: ['70%', '40%'],	
		  type: 2,
		  content: '${wmsUrl}/admin/goods/goodsMng/toTag.shtml',
		  maxmin: true
		});
}
function toEdit(id){
	var index = layer.open({
		  title:"修改标签",	
		  area: ['70%', '40%'],	
		  type: 2,
		  content: '${wmsUrl}/admin/label/goodsTagMng/toEditTag.shtml?tagId='+id,
		  maxmin: true
		});
}
function toDelete(id){
	layer.confirm('确定要删除当前标签吗？', {
		  btn: ['取消','确定']
	}, function(){
		layer.closeAll();
	}, function(){
		$.ajax({
			 url:"${wmsUrl}/admin/label/goodsTagMng/toDeleteTag.shtml?tagId="+id,
			 type:'post',
//			 data:JSON.stringify(sy.serializeObject($('#goodsForm'))),
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){	
					 layer.alert("删除商品标签成功");
					 parent.layer.closeAll();
					 parent.location.reload();
				 }else{
					 layer.alert(data.msg);
				 }
			 },
			 error:function(){
				 layer.alert("删除商品标签失败，请联系客服处理");
			 }
		 });
	});
}
</script>
</body>
</html>
