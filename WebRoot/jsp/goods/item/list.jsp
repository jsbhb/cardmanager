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
<script src="${wmsUrl}/plugins/laydate/laydate.js"></script>
</head>
<body>
<section class="content-wrapper query">
	<section class="content-header">
	      <ol class="breadcrumb">
	        <li><a href="javascript:void(0);">首页</a></li>
	        <li>商品管理</li>
	        <li class="active">商品列表</li>
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
			            <select class="form-control" name="supplierId" id="supplierId">
		                	<option selected="selected" value="">--请选择供应商--</option>
			                <c:forEach var="supplier" items="${suppliers}">
			                <option value="${supplier.id}">${supplier.supplierName}</option>
			                </c:forEach>
			            </select>
					</div>
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
			            <select class="form-control" name="goodsType" id="goodsType">
		                	<option selected="selected" value="">商品类型</option>
		                	<option value="0">跨境商品</option>
		                	<option value="2">一般贸易商品</option>
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
           			<input type="hidden" class="form-control" name="hidTabId" id="hidTabId" value="first">
           			<input type="hidden" class="form-control" name="typeId" id="typeId" value="">
           			<input type="hidden" class="form-control" name="categoryId" id="categoryId" value="">
                	<input type="hidden" class="form-control" name="orderByParam" id="orderByParam"/>
                	<input type="hidden" class="form-control" name="orderByProperty" id="orderByProperty"/>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
	                  	<input type="text" class="form-control" name="itemCode" placeholder="请输入商家编码">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
	                  	<input type="text" class="form-control" name="encode" placeholder="请输入条形码">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
						<input type="text" class="chooseTime" id="searchTime" name="searchTime" placeholder="请选择查询时间" readonly>
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
		
	
		<div class="list-tabBar">
			<ul>
				<c:choose>
					<c:when test="${prilvl == 1}">
						<li data-id="first" class="active">上架商品</li>
						<li data-id="second">下架商品</li>
						<li data-id="third">分销商品</li>
						<li data-id="fourth">无库存商品</li>
					</c:when>
					<c:when test="${customType == 1}">
						<li data-id="first" class="active">上架商品</li>
					</c:when>
					<c:when test="${customType == 2}">
						<li data-id="third" class="active">分销商品</li>
					</c:when>
					<c:otherwise>
						<li data-id="first" class="active">上架商品</li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
	
		<div class="list-content">
			<div class="row">
				<div class="col-md-2 goods-classify">
					<span class="all-classfiy">所有分类</span>
					<i class="fa fa-list fa-fw active"></i>
				</div>
				<div class="col-md-10 list-btns">
                   	<button type="button" onclick="modelExport(3)">商品报价单导出</button>
					<button type="button" onclick = "modelExport(1)">商品信息导出</button>
					<c:if test="${prilvl == 1}">
<!-- 						<button type="button" onclick="jump(9)">新增商品</button> -->
						<button type="button" onclick = "puton('')">批量上架</button>
						<button type="button" onclick = "putoff('')">批量下架</button>
						<button type="button" onclick = "beFx('')">批量可分销</button>
						<button type="button" onclick = "noBeFx('')">批量不可分销</button>
						<button type="button" onclick = "bindTag()">批量打标签</button>
                       	<button type="button" onclick="modelExport(2)">商品信息导出(运营用)</button>
					</c:if>
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
					<table id="baseTable" class="table table-hover myClass">
						<thead>
							<tr>
								<!-- 这里增加了字段列，需要调整批量功能取值的列数11111 -->
								<th width="3%"><input type="checkbox" id="theadInp"></th>
								<th width="6%">商品图片</th>
								<th class="cursor-pointer" database-name="g.goods_name" width="14%">商品名称<i class="fa fa-arrows-v"></i></th>
								<th class="cursor-pointer" database-name="i.goods_id" width="6%">商品ID<i class="fa fa-arrows-v"></i></th>
								<th class="cursor-pointer" database-name="i.item_id" width="6%">商品编号<i class="fa fa-arrows-v"></i></th>
								<th class="cursor-pointer" database-name="i.item_code" width="7%">商家编码<i class="fa fa-arrows-v"></i></th>
								<th class="cursor-pointer" database-name="b.brand" width="7%">商品品牌<i class="fa fa-arrows-v"></i></th>
								<th width="10%">商品分类</th>
								<th class="cursor-pointer" database-name="g.supplier_name" width="6%">供应商<i class="fa fa-arrows-v"></i></th>
<!-- 								<th width="5%">商品标签</th> -->
<!-- 								<th width="5%">增值税率</th> -->
<!-- 								<th width="5%">消费税率</th> -->
								<th class="cursor-pointer" database-name="p.retail_price" width="5%">商品价格<i class="fa fa-arrows-v"></i></th>
								<th class="cursor-pointer" database-name="s.fxqty" width="5%">商品库存<i class="fa fa-arrows-v"></i></th>
								<th class="cursor-pointer" database-name="i.status" width="5%">商品状态<i class="fa fa-arrows-v"></i></th>
								<th class="cursor-pointer" database-name="i.info" width="5%">商品规格<i class="fa fa-arrows-v"></i></th>
								<th class="cursor-pointer" database-name="i.create_time" width="5%">创建时间<i class="fa fa-arrows-v"></i></th>
								<c:choose>
									<c:when test="${prilvl == 1}">
										<th width="10%">操作</th>
									</c:when>
									<c:otherwise>
										<th width="10%">返佣</th>
									</c:otherwise>
								</c:choose>
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

laydate.render({
    elem: '#searchTime', //指定元素
    type: 'datetime',
    range: '~',
    value: null
  });

/**
 * 初始化分页信息
 */
var options = {
	queryForm : ".query",
	url :  "${wmsUrl}/admin/goods/itemMng/dataList.shtml?gradeType=${gradeType}&type=1",
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
	
	$('.list-tabBar').find('li').each(function() {
		if ($(this).attr('data-id') == $("#hidTabId").val()) {
			$(this).addClass('active').siblings('.active').removeClass('active');
		}
    })
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
		str = "<tr style='text-align:center'><td colspan=14><h5>没有查到数据</h5></td></tr>";
		$("#baseTable tbody").html(str);
		return;
	}
	var tmpHidTabId = $("#hidTabId").val();

	for (var i = 0; i < list.length; i++) {
		str += "<tr>";
		str += "<td><input type='checkbox' name='check' value='" + list[i].itemId + "'/>"
		if (list[i].goodsEntity.files == null) {
			str += "</td><td><img style='width:50px;height:50px;' src=${wmsUrl}/img/default_img.jpg> ";
		} else {
			str += "</td><td><img style='width:50px;height:50px;' src="+list[i].goodsEntity.files[0].path+">";
		}
		str += "</td><td style='text-align:left;'><a target='_blank' href='${webUrl}"+list[i].webUrlParam+"'>" + list[i].goodsName + "</a>";
		if(list[i].tagList.length > 0){
			str += '<p style="margin: 5px 0 0 0;">';
			for(var j=0;j<list[i].tagList.length;j++){
				str += "<span class='table_icon'>"+list[i].tagList[j].tagName+"</span>"
			}
			str += '</p>';
		}
		str += "</td><td>" + list[i].goodsId;
		str += "</td><td>" + list[i].itemId;
		str += "</td><td>" + list[i].itemCode;
		if (list[i].baseEntity == null) {
			str += "</td><td>";
			str += "</td><td>";
		} else {
			str += "</td><td style='text-align:left;'>" + list[i].baseEntity.brand;
			str += "</td><td style='text-align:left;'>" + list[i].baseEntity.firstCatalogId+"-"+list[i].baseEntity.secondCatalogId+"-"+list[i].baseEntity.thirdCatalogId;
		}
		str += "</td><td style='text-align:left;'>" + list[i].supplierName;
		str += "</td><td>" + list[i].goodsPrice.retailPrice;
		if (list[i].stock != null) {
			str += "</td><td>" + list[i].stock.fxQty;
		} else {
			str += "</td><td>无";
		}
		var status = list[i].status;
		switch(status){
			case '0':str += "</td><td>下架";break;
			case '1':str += "</td><td>上架";break;
			default:str += "</td><td>状态错误："+status;
		}
		str += "</td><td>" + (list[i].info == null ? "" : list[i].info);
		str += "</td><td>" + (list[i].createTime == null ? "" : list[i].createTime);
		var prilvl = "${prilvl}";
		var gradeId = "${opt.gradeId}";
		var isFx = list[i].isFx;
		if(prilvl == 1){
			if (tmpHidTabId == "fourth") {
				if (status == 0) {
					str += "</td><td><a href='javascript:void(0);' class='table-btns' onclick='toEdit("+list[i].itemId+")'>编辑</a>";
					str += "<a href='javascript:void(0);' class='table-btns' onclick='puton("+list[i].itemId+")' >上架</a>";
				}else {
					str += "</td><td>";
					str += "<a href='javascript:void(0);' class='table-btns' onclick='toShow("+list[i].itemId+")'>查看信息</a>";
					str += "<a href='javascript:void(0);' class='table-btns' onclick='putoff("+list[i].itemId+")' >下架</a>";
				}
			} else {
				if (status == 0) {
					str += "</td><td><a href='javascript:void(0);' class='table-btns' onclick='toEdit("+list[i].itemId+")'>编辑</a>";
					str += "<a href='javascript:void(0);' class='table-btns' onclick='toCreateItem("+list[i].itemId+")'>添加规格</a>";
					str += "<a href='javascript:void(0);' class='table-btns' onclick='toEditRatio("+list[i].itemId+',"'+list[i].goodsName+'","'+list[i].info+"\")'>设置比价</a>";
					str += "<a href='javascript:void(0);' class='table-btns' onclick='puton("+list[i].itemId+")' >上架</a>";
					str += "<a href='javascript:void(0);' class='table-btns' onclick='setRebate("+list[i].itemId+","+prilvl+")' >返佣比例</a>";
				} else {
					str += "</td><td>";
					str += "<a href='javascript:void(0);' class='table-btns' onclick='toShow("+list[i].itemId+")'>查看信息</a>";
					str += "<a href='javascript:void(0);' class='table-btns' onclick='toEditRatio("+list[i].itemId+',"'+list[i].goodsName+'","'+list[i].info+"\")'>设置比价</a>";
					str += "<a href='javascript:void(0);' class='table-btns' onclick='putoff("+list[i].itemId+")' >下架</a>";
					if (isFx == 0) {
						str += "<a href='javascript:void(0);' class='table-btns' onclick='beFx("+list[i].itemId+")' >分销</a>";
					} else {
						str += "<a href='javascript:void(0);' class='table-btns' onclick='noBeFx("+list[i].itemId+")' >不可分销</a>";
					}
					str += "<a href='javascript:void(0);' class='table-btns' onclick='setRebate("+list[i].itemId+","+prilvl+")' >返佣比例</a>";
				}
				if(list[i].supplierName!="一般贸易仓"
					&&list[i].supplierName!="广州仓库"
					&&list[i].supplierName!="广州仓gzc"
					&&list[i].supplierName!="天天仓"
					&&list[i].supplierName!=null){
					str += "<a href='javascript:void(0);' class='table-btns' onclick='syncStock("+list[i].itemId+")' >同步库存</a>";
				}
			}
		} else {
			if (gradeId == 0 || gradeId == 2) {
				str += "</td><td><a href='javascript:void(0);' class='table-btns' onclick='setRebate("+list[i].itemId+","+prilvl+")' >返佣比例</a>";
			} else {
				str += "</td><td>" + list[i].rebate;
			}
		}		
		str += "</td></tr>";
	}
	$("#baseTable tbody").html(str);
}
	
function toEdit(id){
	var index = layer.open({
	  title:"编辑商品信息",		
	  type: 2,
	  content: '${wmsUrl}/admin/goods/goodsMng/toEditGoodsInfo.shtml?itemId='+id,
	  maxmin: true
	});
	layer.full(index);
}


function setRebate(id,prilvl){
	var index = layer.open({
	  title:"设置商品返佣比例",		
	  type: 2,
	  content: '${wmsUrl}/admin/goods/itemMng/toSetRebate.shtml?id='+id+"&prilvl="+prilvl,
	  maxmin: true
	});
	layer.full(index);
}

function beFx(id){
	if(id == ""){
		var valArr = new Array; 
		var itemIds;
	    $("[name='check']:checked").each(function(i){
	    	if ($(this).parent().siblings().eq(10).text() == "上架") {
	 	        valArr[i] = $(this).val(); 
	    	}
	    }); 
	    if(valArr.length==0){
	    	layer.alert("请选择上架状态的数据");
	    	return;
	    }
	    itemIds = valArr.join(',');//转换为逗号隔开的字符串 
	} else {
		itemIds = id;
	}
	$.ajax({
		 url:"${wmsUrl}/admin/goods/itemMng/beFx.shtml?itemId="+itemIds,
		 type:'post',
		 contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 success:function(data){
			 if(data.success){	
				 layer.alert("设置成功");
				 reloadTable();
				 $("#theadInp").prop("checked", false);
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
	    	if ($(this).parent().siblings().eq(10).text() == "上架") {
	 	        valArr[i] = $(this).val(); 
	    	}
	    }); 
	    if(valArr.length==0){
	    	layer.alert("请选择上架状态的数据");
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
				 $("#theadInp").prop("checked", false);
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

//点击分类
$('.container-left').on('click','span:not(.active)',function(){
	var categoryId = $(this).attr("data-id");
	var typeId = $(this).attr("data-type");
	var tabId = $('.list-tabBar li.active').attr('data-id');
	queryDataByLabelTouch(typeId,categoryId,tabId);
});

$('.container-left').on('click','span.active',function(){
	var tabId = $('.list-tabBar li.active').attr('data-id');
	queryDataByLabelTouch("","",tabId);
});
//点击所有分类
$('.goods-classify').on('click','.all-classfiy',function(){
	$('.container-left span.active').removeClass('active');
	var tabId = $('.list-tabBar li.active').attr('data-id');
	queryDataByLabelTouch("","",tabId);
});

//切换tabBar
$('.list-tabBar').on('click','ul li:not(.active)',function(){
	var tabId = $(this).attr("data-id");
	queryDataByLabelTouch($("#typeId").val(),$("#categoryId").val(),tabId);
});

//点击分类标签及tab标签时做数据查询动作
function queryDataByLabelTouch(typeId,categoryId,tabId){
	$("#typeId").val(typeId);
	$("#categoryId").val(categoryId);
	$("#hidTabId").val(tabId);
	
	reloadTable();
}

// function excelExport(type){
// 	var valArr = new Array; 
// 	var itemIds;
//     $("[name='check']:checked").each(function(i){
//     	valArr[i] = $(this).val();
//     }); 
//     itemIds = valArr.join(',');//转换为逗号隔开的字符串 
//     var supplierId = $("#supplierId").val();
//     window.open("${wmsUrl}/admin/goods/itemMng/downLoadExcel.shtml?type="+type+"&supplierId="+supplierId+"&itemIds="+itemIds);
//     $("#theadInp").prop("checked", false);
// }

function modelExport(type){
	var showTitle = "";
	if (type == 3) {
		showTitle = "商品报价单导出";
	} else {
		showTitle = "商品信息导出";
	}
	var index = layer.open({
  	  title: showTitle,		
  	  type: 2,
  	  area: ['70%','80%'],
  	  content: '${wmsUrl}/admin/goods/itemMng/toExport.shtml?type='+type,
  	  maxmin: false
  	});
}

function bindTag(){
	var valArr = new Array; 
	var itemIds;
    $("[name='check']:checked").each(function(i){
    	if ($(this).parent().siblings().eq(10).text() == "下架") {
 	        valArr[i] = $(this).val(); 
    	}
    }); 
    if(valArr.length==0){
    	layer.alert("请选择下架状态的数据");
    	return;
    }
    itemIds = valArr.join(',');//转换为逗号隔开的字符串 
    var index = layer.open({
  	  title:"标签绑定",		
  	  type: 2,
  	  area: ['55%','30%'],
  	  content: '${wmsUrl}/admin/label/goodsTagMng/listTag.shtml?itemIds='+itemIds,
  	  maxmin: false
  	});
}

function toCreateItem(id){
	var index = layer.open({
	  title:"添加商品规格信息",		
	  type: 2,
	  content: '${wmsUrl}/admin/goods/goodsMng/toCreateItemInfo.shtml?itemId='+id,
	  maxmin: true
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

function toShow(id){
	var index = layer.open({
	  title:"查看商品信息",		
	  type: 2,
	  content: '${wmsUrl}/admin/goods/goodsMng/toShowGoodsInfo.shtml?itemId='+id,
	  maxmin: true
	});
	layer.full(index);
}

function toEditRatio(id,name,info){
	var url = encodeURI(encodeURI('${wmsUrl}/admin/goods/goodsMng/toEditRatioGoodsInfo.shtml?itemId='+id+"&goodsName="+name+"&itemInfo="+info));
	var index = layer.open({
	  title:"设置商品比价信息",		
	  type: 2,
	  content: url,
	  maxmin: true
	});
	layer.full(index);
}
function puton(id){
	if(id == ""){
		var valArr = new Array; 
		var itemIds;
	    $("[name='check']:checked").each(function(i){
	    	if ($(this).parent().siblings().eq(10).text() == "下架") {
	 	        valArr[i] = $(this).val(); 
	    	}
	    }); 
	    if(valArr.length==0){
	    	layer.alert("请选择下架状态的数据");
	    	return;
	    } 
	    itemIds = valArr.join(',');//转换为逗号隔开的字符串 
	} else {
		itemIds = id;
	}
	$.ajax({
		 url:"${wmsUrl}/admin/mall/goodsMng/puton.shtml?itemId="+itemIds,
		 type:'post',
		 contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 success:function(data){
			 if(data.success){	
				 layer.alert("设置成功");
				 reloadTable();
				 $("#theadInp").prop("checked", false);
			 }else{
				 layer.alert(data.msg);
			 }
		 },
		 error:function(data){
			 console.log(data.msg);
			 layer.alert("提交失败，请联系客服处理");
		 }
	 });
}
function putoff(id){
	if(id == ""){
		var valArr = new Array; 
		var itemIds;
	    $("[name='check']:checked").each(function(i){
	    	if ($(this).parent().siblings().eq(10).text() == "上架") {
	 	        valArr[i] = $(this).val(); 
	    	}
	    }); 
	    if(valArr.length==0){
	    	layer.alert("请选择上架状态的数据");
	    	return;
	    } 
	    itemIds = valArr.join(',');//转换为逗号隔开的字符串 
	} else {
		itemIds = id;
	}
	$.ajax({
		 url:"${wmsUrl}/admin/mall/goodsMng/putoff.shtml?itemId="+itemIds,
		 type:'post',
		 contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 success:function(data){
			 if(data.success){	
				 layer.alert("设置成功");
				 reloadTable();
				 $("#theadInp").prop("checked", false);
			 }else{
				 layer.alert(data.msg);
			 }
		 },
		 error:function(data){
			 console.log(data.msg);
			 layer.alert("提交失败，请联系客服处理");
		 }
	 });
}

//绑定table排序事件
$("thead tr th").on("click",function(){
	var $icon = $(this).find("i");
	$(this).parent().find("i").not($icon).removeClass("fa-long-arrow-down fa-long-arrow-up").addClass("fa-arrows-v");
	if ($icon.length>0) {
		$("#orderByProperty").val($(this).attr("database-name"));
		if($icon.hasClass("fa-arrows-v")) {
			$icon.removeClass("fa-arrows-v");
			$icon.addClass("fa-long-arrow-up");
			$("#orderByParam").val("asc");
		}else if($icon.hasClass("fa-long-arrow-up")){
			$icon.removeClass("fa-long-arrow-up");
			$icon.addClass("fa-long-arrow-down");
			$("#orderByParam").val("desc");
		}else if($icon.hasClass("fa-long-arrow-down")){
			$icon.removeClass("fa-long-arrow-down");
			$icon.addClass("fa-long-arrow-up");
			$("#orderByParam").val("asc");
		}
		reloadTable();
	}
})
</script>
</body>
</html>
