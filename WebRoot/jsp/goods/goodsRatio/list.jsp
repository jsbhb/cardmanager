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
	        <li>比价管理</li>
	        <li class="active">商品比价平台</li>
	      </ol>
	      <div class="search">
	      	<input type="text" name="name" placeholder="请输入比价平台名称">
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
	                  	<input type="text" class="form-control" name="hidName" placeholder="请输入比价平台名称">
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
					<button type="button" onclick="toAdd()">新增比价平台</button>
				</div>
			</div>
			<div class="row content-container">
				<div class="col-md-12 container-right">
					<table id="brandTable" class="table table-hover myClass">
						<thead>
							<tr>
								<th width="25%">比价平台编码</th>
								<th width="25%">比价平台名称</th>
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
		url :  "${wmsUrl}/admin/goods/goodsPriceRatioMng/dataList.shtml",
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
		str += "<td>" + list[i].id;
		str += "</td><td>" + list[i].ratioPlatformName;
		str += "</td><td>" + list[i].createTime;
		str += "</td><td>";
		str += "<a href='javascript:void(0);' class='table-btns' onclick='toEdit("+list[i].id+")'>编辑</a>";
		str += "</td></tr>";
	}
	$("#brandTable tbody").html(str);
}

function toEdit(id){
	var index = layer.open({
	  title:"编辑比价平台",	
	  area: ['80%', '40%'],		
	  type: 2,
	  content: '${wmsUrl}/admin/goods/goodsPriceRatioMng/toEdit.shtml?id='+id,
	  maxmin: false
	});
}


function toAdd(){
	var index = layer.open({
	  title:"新增比价平台",	
	  area: ['80%', '40%'],		
	  type: 2,
	  content: '${wmsUrl}/admin/goods/goodsPriceRatioMng/toAdd.shtml',
	  maxmin: false
	});
}

</script>
</body>
</html>
