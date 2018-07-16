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
	                	<input type="text" class="form-control" id="brand" placeholder="选择品牌"/>
	                	<input type="hidden" class="form-control" name="brandId" id="brandId"/>
					</div>
				</div>
				<div class="list-item" style="display:none">
					<div class="col-sm-3 item-left">商品品牌</div>
					<div class="col-sm-9 item-right">
				   		<select class="form-control" id="hidBrand">
			                <c:forEach var="brand" items="${brands}">
			                <option value="${brand.brandId}">${brand.brand}</option>
			                </c:forEach>
			            </select>
					</div>
				</div>
				<div class="select-content">
					<input type="text" placeholder="请输入品牌名称" id="searchBrand"/>
		            <ul class="first-ul" style="margin-left:5px;">
		           		<c:forEach var="brand" items="${brands}">
		           			<c:set var="brand" value="${brand}" scope="request" />
							<li><span data-id="${brand.brandId}" data-name="${brand.brand}" class="no-child">${brand.brand}</span></li>
						</c:forEach>
		           	</ul>
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
	
<%@include file="../../resourceScript.jsp"%>
<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
<script type="text/javascript">
var cpLock = false;
$('#searchBrand').on('compositionstart', function () {
    cpLock = true;
});
$('#searchBrand').on('compositionend', function () {
    cpLock = false;
});
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
	var str = "";
	
	if (list == null || list.length == 0) {
		str = "<tr style='text-align:center'><td colspan=9><h5>没有查到数据</h5></td></tr>";
		$("#baseTable tbody").html(str);
		return;
	}

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

//点击展开下拉列表
$('#brand').click(function(){
	$('.select-content').css('width',$(this).outerWidth());
	$('.select-content').css('left',$(this).offset().left);
	$('.select-content').css('top',$(this).offset().top + $(this).height());
	$('.select-content').stop();
	$('.select-content').slideDown(300);
});

//点击空白隐藏下拉列表
$('html').click(function(event){
	var el = event.target || event.srcelement;
	if(!$(el).parents('.select-content').length > 0 && $(el).attr('id') != "brand"){
		$('.select-content').stop();
		$('.select-content').slideUp(300);
	}
});
//点击选择分类
$('.select-content').on('click','span',function(event){
	var el = event.target || event.srcelement;
	if(el.nodeName != 'I'){
		var id = $(this).attr('data-id');
		var name = $(this).attr('data-name');
		$('#brandId').val(id);
		$('#brand').val(name);
		$('#searchBrand').val("");
		reSetDefaultInfo();
		$('.select-content').stop();
		$('.select-content').slideUp(300);
	}
});

$('#searchBrand').on("input",function(){
	if (!cpLock) {
		var tmpSearchKey = $(this).val();
		if (tmpSearchKey !='') {
			var searched = "";
			$('.first-ul li').each(function(li_obj){
				var tmpLiId = $(this).find("span").attr('data-id');
				var tmpLiText = $(this).find("span").attr('data-name');
				var flag = tmpLiText.indexOf(tmpSearchKey);
				if(flag >=0) {
					searched = searched + "<li><span data-id=\""+tmpLiId+"\" data-name=\""+tmpLiText+"\" class=\"no-child\">"+tmpLiText+"</span></li>";
				}
			});
			$('.first-ul').html(searched);
		} else {
			reSetDefaultInfo();
		}
  }
});

function reSetDefaultInfo() {
	var tmpBrands = "";
	var hidBrandSelect = document.getElementById("hidBrand");
	var options = hidBrandSelect.options;
	for(var j=0;j<options.length;j++){
		tmpBrands = tmpBrands + "<li><span data-id=\""+options[j].value+"\" data-name=\""+options[j].text+"\" class=\"no-child\">"+options[j].text+"</span></li>";
	}
	$('.first-ul').html(tmpBrands);
}

</script>
</body>
</html>
