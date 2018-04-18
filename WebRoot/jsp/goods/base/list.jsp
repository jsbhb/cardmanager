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
</head>
<body>
<section class="content-wrapper query">
	<section class="content-header">
	      <ol class="breadcrumb">
	        <li><a href="javascript:void(0);">首页</a></li>
	        <li>商品管理</li>
	        <li class="active">基础商品</li>
	      </ol>
	      <div class="search">
	      	<input type="text" name="goodsName" placeholder="请输入商品名称">
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
			            <select class="form-control" name="brandId" id="brandId">
		                	<option selected="selected" value="">--请选择商品品牌--</option>
			                <c:forEach var="brand" items="${brands}">
			                <option value="${brand.brandId}">${brand.brand}</option>
			                </c:forEach>
			            </select>
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
			           <input type="text" class="form-control" name="hidGoodsName" placeholder="请输入商品名称">
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
					<button type="button" onclick="toAdd()">新增基础商品</button>
				</div>
			</div>
			<div class="row content-container">
				<div class="col-md-12 container-right">
					<table id="baseTable" class="table table-hover myClass">
						<thead>
							<tr>
								<th width="5%">基础编码</th>
								<th width="14%">品牌名称</th>
								<th width="20%">商品分类</th>
								<th width="25%">商品名称</th>
								<th width="5%">计量单位</th>
								<th width="10%">海关代码</th>
								<th width="8%">增值税率</th>
								<th width="8%">海关税率</th>
								<th width="10%">操作</th>
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
	
<%@include file="../../resource.jsp"%>
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
	url :  "${wmsUrl}/admin/goods/baseMng/dataList.shtml",
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
	$("#baseTable tbody").html("");

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
		str += "<td>" + list[i].id;
		str += "</td><td>" + list[i].brand;
		str += "</td><td>" + list[i].firstCatalogId+"-"+list[i].secondCatalogId+"-"+list[i].thirdCatalogId;
		str += "</td><td>" + list[i].goodsName;
		str += "</td><td>" + (list[i].unit == null ? "" : list[i].unit);
		str += "</td><td>" + (list[i].hscode == null ? "" : list[i].hscode);
		str += "</td><td>" + list[i].incrementTax;
		str += "</td><td>" + list[i].tariff;
		str += "</td><td>"
		str += "<a href='javascript:void(0);' class='table-btns' onclick='toEdit("+list[i].id+")'>编辑</a>";
		str += "</td></tr>";
	}
	$("#baseTable tbody").html(str);
}
	
function toEdit(id){
	var index = layer.open({
		  title:"基础商品编辑",		
		  type: 2,
		  content: '${wmsUrl}/admin/goods/baseMng/toEdit.shtml?baseId='+id,
		  maxmin: false
		});
		layer.full(index);
}


function toAdd(){
	var index = layer.open({
		  title:"新增基础商品",		
		  type: 2,
		  content: '${wmsUrl}/admin/goods/baseMng/toAdd.shtml',
		  maxmin: false
		});
		layer.full(index);
}

</script>
</body>
</html>
