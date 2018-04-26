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
	        <li>商品管理</li>
	        <li class="active">品牌管理</li>
	      </ol>
	      <div class="search">
	      	<input type="text" name="brand" placeholder="请输入品牌名称">
	      	<div class="searchBtn"><i class="fa fa-search fa-fw"></i></div>
	      	<div class="moreSearchBtn">高级搜索</div>
		  </div>
    </section>
    <section class="content">
		<div id="image" style="width:100%;height:100%;display: none;background:rgba(0,0,0,0.5);margin-left:-25px;margin-top:-62px;">
			<img alt="loading..." src="${wmsUrl}/img/loader.gif" style="position:fixed;top:50%;left:50%;margin-left:-16px;margin-top:-16px;" />
		</div>
		<div class="moreSearchContent">
			<div class="row form-horizontal query list-content">
				<div class="col-xs-3">
					<div class="searchItem">
	                  	<input type="text" class="form-control" name="hidBrand" placeholder="请输入品牌名称">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchBtns">
						 <div class="lessSearchBtn">简易搜索</div>
                         <button type="button" class="query" id="querybtns" name="signup">提交</button>
                         <button type="button" class="clear">清除选项</button>
                    </div>
                </div>
            </div>
		</div>
	
		<div class="list-content">
			<div class="row">
				<div class="col-md-10 list-btns">
					<button type="button" onclick="toAdd()">新增品牌</button>
				</div>
			</div>
			<div class="row content-container">
				<div class="col-md-12 container-right">
					<table id="brandTable" class="table table-hover myClass">
						<thead>
							<tr>
								<th width="25%">品牌编码</th>
								<th width="25%">品牌名称</th>
								<th width="25%">创建时间</th>
								<th width="25%">操作</th>
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

//点击搜索按钮
$('.searchBtn').on('click',function(){
	$("#querybtns").click();
});

/**
 * 初始化分页信息
 */
var options = {
		queryForm : ".query",
		url :  "${wmsUrl}/admin/goods/brandMng/dataList.shtml",
		numPerPage:"10",
		currentPage:"",
		index:"1",
		callback:rebuildTable
}

$(function(){
	 $(".pagination-nav").pagination(options);
	 var top = getTopWindow();
	$('.breadcrumb').on('click','a',function(){
		top.location.reload();
	});
})


function reloadTable(){
	$.page.loadData(options);
}


/**
 * 重构table
 */
function rebuildTable(data){
	$("#brandTable tbody").html("");

	if (data == null || data.length == 0) {
		return;
	}
	
	var list = data.obj;
	var str = "";
	
	if (list == null || list.length == 0) {
		str = "<tr style='text-align:center'><td colspan=4><h5>没有查到数据</h5></td></tr>";
		$("#brandTable tbody").html(str);
		return;
	}

	for (var i = 0; i < list.length; i++) {
		str += "<tr>";
		str += "<td>" + list[i].brandId;
		str += "</td><td>" + list[i].brand;
		str += "</td><td>" + list[i].createTime;
		str += "</td><td>";
		str += "<a href='javascript:void(0);' class='table-btns' onclick='toEdit("+list[i].id+")'>编辑</a>";
		str += "<a href='javascript:void(0);' class='table-btns' onclick='del(\""+list[i].brandId+"\")'>删除</a>";
		str += "</td></tr>";
	}
	$("#brandTable tbody").html(str);
}
	
function del(id){
	layer.confirm('确定要删除该功能吗？', {
		  btn: ['确认删除','取消'] //按钮
		}, function(){
			$.ajax({
				 url:"${wmsUrl}/admin/goods/brandMng/delete.shtml?brandId="+id,
				 type:'post',
				 dataType:'json',
				 success:function(data){
					 if(data.success){	
						 layer.alert("删除成功");
						 location.reload();
					 }else{
						 layer.alert(data.msg);
					 }
				 },
				 error:function(){
					 layer.alert("系统出现问题啦，快叫技术人员处理");
				 }
			 });
		}, function(){
		  layer.close();
		});
}
	
function toEdit(id){
	var index = layer.open({
	  title:"编辑品牌",	
	  area: ['70%', '30%'],		
	  type: 2,
	  content: '${wmsUrl}/admin/goods/brandMng/toEdit.shtml?brandId='+id,
	  maxmin: false
	});
}


function toAdd(){
	var index = layer.open({
	  title:"新增品牌",	
	  area: ['70%', '30%'],		
	  type: 2,
	  content: '${wmsUrl}/admin/goods/brandMng/toAdd.shtml',
	  maxmin: false
	});
}

</script>
</body>
</html>
