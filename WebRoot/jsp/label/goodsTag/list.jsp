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
<section class="content-wrapper query">
	<section class="content-header">
	      <ol class="breadcrumb">
	        <li><a href="javascript:void(0);">首页</a></li>
	        <li>标签管理</li>
	        <li class="active">商品标签</li>
	      </ol>
    </section>	
	<section class="content">
		<div class="list-content">
			<div class="row">
				<div class="col-md-12 list-btns">
					<button type="button" onclick="toAdd()">新增标签</button>
				</div>
			</div>
			<div class="row content-container">
				<div class="col-md-12 container-right active">
					<table id="itemTable" class="table table-hover myClass">
						<thead>
							<tr>
								<th width="50%">标签名称</th>
								<th width="50%">操作</th>
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
	var str = "";
	
	if (list == null || list.length == 0) {
		str = "<tr style='text-align:center'><td colspan=2><h5>没有查到数据</h5></td></tr>";
		$("#itemTable tbody").html(str);
		return;
	}

	for (var i = 0; i < list.length; i++) {
		str += "<tr>";
		str += "</td><td>" + list[i].tagName;
		str += "</td><td>";
		str += "<a href='javascript:void(0);' class='table-btns' onclick='toEdit(\""+list[i].id+"\")' >修改</a>";
		str += "<a href='javascript:void(0);' class='table-btns' onclick='toDelete(\""+list[i].id+"\")' >删除</a>";
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
		  maxmin: false
		});
}
function toEdit(id){
	var index = layer.open({
		  title:"修改标签",	
		  area: ['70%', '40%'],	
		  type: 2,
		  content: '${wmsUrl}/admin/label/goodsTagMng/toEditTag.shtml?tagId='+id,
		  maxmin: false
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
					 location.reload();
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
