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
<link rel="stylesheet" href="${wmsUrl}/css/component/mall_item_show.css">
<link rel="stylesheet" href="${wmsUrl}/css/component/alert-cover.css">
</head>
<body>
<section class="content-wrapper query">
	<section class="content-header">
	      <ol class="breadcrumb">
	        <li>进销存管理</li>
	        <li class="active">采购商品库</li>
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
			<div class="row form-horizontal list-content">
				<div class="col-xs-3">
					<div class="searchItem">
	                	<input type="text" class="form-control" id="brand" readonly style="background:#fff;" placeholder="选择品牌"/>
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
			            <select class="form-control" name="tagId" id="tagId">
		                	<option selected="selected" value="">--请选择商品标签--</option>
		                	<option value="">普通</option>
			                <c:forEach var="tag" items="${tags}">
	                   	  	<option value="${tag.id}">${tag.tagName}</option>
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
					<div class="searchItem">
			           <input type="text" class="form-control" name="goodsId" placeholder="请输入商品ID">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
	                  	<input type="text" class="form-control" name="itemId" placeholder="请输入商品编号">
					</div>
           			<input type="hidden" class="form-control" name="typeId" id="typeId" value="">
           			<input type="hidden" class="form-control" name="categoryId" id="categoryId" value="">
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
	                  	<input type="text" class="form-control" name="itemCode" placeholder="请输入商家编码">
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
				<div class="col-md-2 goods-classify">
					<span class="all-classfiy">所有分类</span>
					<i class="fa fa-list fa-fw active"></i>
				</div>
				<div class="shopCart-content">
					<img src="${wmsUrl}/img/customer/icon_shopCart.png" onclick="jump(74)" alt="中国供销海外购">
					<span>${countShoppingCart}</span>
				</div>
			</div>
			<div class="row content-container">
				<div class="col-md-2 container-left hideList" style="display:none;">
					<ul class="first-classfiy">
						<c:forEach var="first" items="${firsts}">
						<li>
							<span data-id="${first.firstId}" data-type="first">${first.name}</span>
							<i class="fa fa-angle-right fa-fw"></i>
							<ul class="second-classfiy">
								<c:forEach var="second" items="${first.seconds}">
								<li>
									<span data-id="${second.secondId}" data-type="second">${second.name}</span>
									<i class="fa fa-angle-right fa-fw"></i>
									<ul class="third-classfiy">
										<c:forEach var="third" items="${second.thirds}">
										<li><span data-id="${third.thirdId}" data-type="third">${third.name}</span></li>
										</c:forEach>
									</ul>
								</li>
								</c:forEach>
							</ul>
						</li>
						</c:forEach>
					</ul>
				</div>
				<div class="col-md-12 container-right active">
					<div class="searchClassify-content-list"></div>
					<div class="pagination-nav">
						<ul id="pagination" class="pagination"></ul>
					</div>
				</div>
			</div>
		</div>	
	</section>
</section>
<section class="alert-cover">
	<div id="includeHtml" class="alert-cover-content"></div>
</section>
	
<%@include file="../../resourceScript.jsp"%>
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
	url :  "${wmsUrl}/admin/customer/purchaseMng/dataList.shtml?gradeType=${gradeType}",
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
	if (data == null || data.length == 0) {
		return;
	}
	
	var list = data.obj;
	var str = "";
	
	if (list == null || list.length == 0) {
		str = "<div class='empty_search'>没找到相关商品，请更改搜索条件！</div>";
		$(".searchClassify-content-list").html(str);
		return;
	}

	for (var i = 0; i < list.length; i++) {
		str += "<div class='img_shrink' data-path="+(list[i].goodsEntity.detailPath==null?"${wmsUrl}/test.html":list[i].goodsEntity.detailPath)+"><a href='javascript:void(0)' class='imgBox'>";
		if (list[i].goodsEntity.files == null) {
			str += "<img class='goodsImg' style='width:206px;height:206px;' src=${wmsUrl}/img/default_img.jpg alt='中国供销海外购'>";
		} else {
			str += "<img class='goodsImg' style='width:206px;height:206px;' src="+list[i].goodsEntity.files[0].path+" alt='中国供销海外购'>";
		}
		str += "</a><a href='javascript:void(0)' class='infoBox'><div class='img_shrink_msg'>" + list[i].goodsName + "</div>";
		str += "<div class='img_shrink_specs'>" + list[i].info + "</div></a>";
		str += '<div class="img_shrink_msg"><p style="margin: 5px 0 0 0;">';
		if(list[i].tagList.length > 0){
			for(var j=0;j<list[i].tagList.length;j++){
				str += "<span class='table_icon'>"+list[i].tagList[j].tagName+"</span>"
			}
		}
		str += '</p></div>';
		str += "<div class='img_shrink_group'><div class='img_shrink_price'><strong><b><span>￥</span>"+eval(list[i].goodsPrice.retailPrice-list[i].rebate).toFixed(2)+"</b><s><span>￥</span>"+list[i].goodsPrice.retailPrice+"</s></strong></div>";
		str += "<div class='img_shrink_btnBox'><img class='search_addShopCart' src='${wmsUrl}/img/customer/icon_shoppingCart.png' alt='中国供销海外购' data-item="+list[i].itemId+" data-supplierId="+list[i].supplierId+" data-supplierName="+encodeURI(list[i].supplierName)+" data-goodsName="+encodeURI(list[i].goodsName)+"></div>";
		str += "</div></div>";
	}
	$(".searchClassify-content-list").html(str);
}

//点击分类
$('.container-left').on('click','span:not(.active)',function(){
	var categoryId = $(this).attr("data-id");
	var typeId = $(this).attr("data-type");
	queryDataByLabelTouch(typeId,categoryId);
});

$('.container-left').on('click','span.active',function(){
	queryDataByLabelTouch("","");
});
//点击所有分类
$('.goods-classify').on('click','.all-classfiy',function(){
	$('.container-left span.active').removeClass('active');
	queryDataByLabelTouch("","");
});

//切换tabBar
$('.list-tabBar').on('click','ul li:not(.active)',function(){
	queryDataByLabelTouch($("#typeId").val(),$("#categoryId").val());
});

//点击分类标签及tab标签时做数据查询动作
function queryDataByLabelTouch(typeId,categoryId){
	$("#typeId").val(typeId);
	$("#categoryId").val(categoryId);
	reloadTable();
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

$('.searchClassify-content-list').on('click','.img_shrink',function(){
	$('.alert-cover').addClass('show');
	setTimeout(function(){$('.alert-cover-content').addClass('show');},200);
	$('html').css('overflow','hidden');
	var loadPath = $(this).attr("data-path");
// 	$('.alert-cover-content').load(loadPath);
	clientSideInclude("includeHtml", loadPath);
});

$('.alert-cover').on('click',function(){
	$('.alert-cover-content').removeClass('show');
	setTimeout(function(){$('.alert-cover').removeClass('show');},400);
	$('html').css('overflow','auto');
	$('.alert-cover-content').html("");
});

$('.alert-cover').on('click','.alert-cover-content',function(e){
	e.stopPropagation();
})

$('.searchClassify-content-list').on('click','.search_addShopCart ',function(e){
	e.stopPropagation();
	var itemId = $(this).attr("data-item");
	var supplierId = $(this).attr("data-supplierId");
	var supplierName = decodeURI($(this).attr("data-supplierName"));
	var goodsName = decodeURI($(this).attr("data-goodsName"));
	
	var cart = $('body').find('.list-content .shopCart-content');
	var top = cart.offset().top + 10;
	var left = cart.offset().left + 10;
	var imgtodrag = $(this).parent().parent().parent().find(".goodsImg");
	var imgclone = imgtodrag.clone();
	if (imgclone.length) {
	   imgclone.offset({
	      top: imgtodrag.offset().top,
	      left: imgtodrag.offset().left
	   }).css({
	      'opacity': '0.5',
	      'position': 'absolute',
	      'height': '150px',
	      'width': '150px',
	      'z-index': '99999999'
	   }).appendTo($('body')).animate({
	      'top': top,
	      'left': left,
	      'width': 50,
	      'height': 50
	   }, 1000, 'linear');
	   imgclone.animate({
	      'width': 0,
	      'height': 0
	   }, function () {
	      $(this).detach();
	   });
	}
	
	$.ajax({
		 url:encodeURI(encodeURI("${wmsUrl}/admin/customer/purchaseMng/addItemToShoppingCart.shtml?itemId="+itemId+"&supplierId="+supplierId+"&supplierName="+supplierName+"&goodsName="+goodsName)),
		 type:'post',
		 contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 success:function(data){
			 if(data.success){
				var str = "";
				str += "<img src='${wmsUrl}/img/customer/icon_shopCart.png' onclick='jump(74)' alt='中国供销海外购'>";
				str += "<span>"+data.msg+"</span>";
				$('.shopCart-content').html(str);
			 }else{
				layer.alert(data.msg);
				return;
			 }
		 },
		 error:function(){
			 layer.alert("添加购物车失败，请重新添加！");
			 return;
		 }
	});
});

function clientSideInclude(id, url) {
  var req = false;
  // Safari, Firefox, 及其他非微软浏览器
  if (window.XMLHttpRequest) {
    try {
      req = new XMLHttpRequest();
    } catch (e) {
      req = false;
    }
  } else if (window.ActiveXObject) {
    // For Internet Explorer on Windows
    try {
      req = new ActiveXObject("Msxml2.XMLHTTP");
    } catch (e) {
      try {
        req = new ActiveXObject("Microsoft.XMLHTTP");
      } catch (e) {
        req = false;
      }
    }
  }
  var element = document.getElementById(id);
  if (!element) {
    alert("函数clientSideInclude无法找到id " + id + "。" +
      "你的网页中必须有一个含有这个id的div 或 span 标签。");
    return;
  }
  if (req) {
    // 同步请求，等待收到全部内容
    req.open('GET', url, false);
    req.send(null);
    if (req.status == 404) {
      clientSideInclude(id, 'test.html')
    } else {
      element.innerHTML = req.responseText;
    }
  } else {
    element.innerHTML =
      "对不起，你的浏览器不支持" +
      "XMLHTTPRequest 对象。这个网页的显示要求" +
      "Internet Explorer 5 以上版本, " +
      "或 Firefox 或 Safari 浏览器，也可能会有其他可兼容的浏览器存在。";
  }
}
</script>
</body>
</html>
