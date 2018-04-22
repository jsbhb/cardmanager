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
			           <input type="text" class="form-control" name="hidGoodsName" placeholder="请输入商品名称">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
	                  	<input type="text" class="form-control" name="itemId" placeholder="请输入商品编号">
					</div>
           			<input type="hidden" class="form-control" name="hidTabId" id="hidTabId" value="first">
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
		
	
		<div class="list-tabBar">
			<ul>
				<li data-id="first" class="active">在售中</li>
				<li data-id="second">已售罄</li>
				<li data-id="third">未分销</li>
			</ul>
		</div>
	
		<div class="list-content">
			<div class="row">
				<div class="col-md-2 goods-classify">
					<span class="all-classfiy">所有分类</span>
					<i class="fa fa-list fa-fw active"></i>
				</div>
				<c:if test="${opt.gradeId == 0}">
					<div class="col-md-10 list-btns">
						<button type="button" onclick="jump(9)">新增商品</button>
						<button type="button" onclick = "beUse('')">批量可用</button>
						<button type="button" onclick = "beFx('')">批量可分销</button>
						<button type="button" onclick = "noBeFx('')">批量不可分销</button>
					</div>
				</c:if>
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
								<th width="3%"><input type="checkbox" id="theadInp"></th>
								<th width="15%">商品名称</th>
								<th width="5%">商品编号</th>
								<th width="10%">商家编码</th>
								<th width="8%">商品品牌</th>
								<th width="12%">商品分类</th>
								<th width="5%">供应商</th>
								<th width="5%">商品标签</th>
								<th width="5%">增值税率</th>
								<th width="5%">消费税率</th>
								<th width="5%">商品价格</th>
								<th width="5%">商品库存</th>
								<th width="5%">商品状态</th>
								<c:choose>
									<c:when test="${opt.gradeId == 0 || opt.gradeId == 2}">
										<th width="12%">操作</th>
									</c:when>
									<c:otherwise>
										<th width="12%">返佣</th>
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
//点击搜索按钮
$('.searchBtn').on('click',function(){
	$("#querybtns").click();
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
		str += "<td><input type='checkbox' name='check' value='" + list[i].itemId + "'/>"
		str += "</td><td>" + list[i].goodsName;
		str += "</td><td>" + list[i].itemId;
		str += "</td><td>" + list[i].itemCode;
		if (list[i].baseEntity == null) {
			str += "</td><td>";
			str += "</td><td>";
		} else {
			str += "</td><td>" + list[i].baseEntity.brand;
			str += "</td><td>" + list[i].baseEntity.firstCatalogId+"-"+list[i].baseEntity.secondCatalogId+"-"+list[i].baseEntity.thirdCatalogId;
		}
		str += "</td><td>" + list[i].supplierName;
		if (list[i].tagBindEntity != null) {
			var tmpTagId = list[i].tagBindEntity.tagId;
			var tmpTagName = "普通";
			var tagSelect = document.getElementById("tagId");
			var options = tagSelect.options;
			for(var j=0;j<options.length;j++){
				if (tmpTagId==options[j].value) {
					tmpTagName = options[j].text;
					break;
				}
			}
			str += "</td><td>" + tmpTagName;
		} else {
			str += "</td><td>普通";
		}
		if (list[i].baseEntity == null) {
			str += "</td><td>";
		} else {
			str += "</td><td>" + list[i].baseEntity.incrementTax;
		}
		str += "</td><td>" + list[i].exciseTax;
		str += "</td><td>" + list[i].goodsPrice.retailPrice;
		if (list[i].stock != null) {
			str += "</td><td>" + list[i].stock.fxQty;
		} else {
			str += "</td><td>无";
		}
		var status = list[i].status;
		switch(status){
			case '0':str += "</td><td>初始化";break;
			case '1':str += "</td><td>可用";break;
			case '2':str += "</td><td>可分销";break;
			default:str += "</td><td>状态错误："+status;
		}
		var gradeId = "${opt.gradeId}";
		if(gradeId == 0 ||gradeId == 2){
			if (status != 2) {
				str += "</td><td><a href='javascript:void(0);' class='table-btns' onclick='toEdit("+list[i].itemId+")'>编辑</a>";
			} else {
				str += "</td><td>";
			}
			if(status == 0){
				str += "<a href='javascript:void(0);' class='table-btns' onclick='beUse("+list[i].itemId+")' >可用</a>";
				str += "<a href='javascript:void(0);' class='table-btns' onclick='setRebate("+list[i].itemId+")' >返佣比例</a>";
			}else if(status == 1){
				str += "<a href='javascript:void(0);' class='table-btns' onclick='beFx("+list[i].itemId+")' >可分销</a>";
				str += "<a href='javascript:void(0);' class='table-btns' onclick='setRebate("+list[i].itemId+")' >返佣比例</a>";
			}else if(status == 2){
				str += "<a  href='javascript:void(0);' class='table-btns' onclick='noBeFx("+list[i].itemId+")' >不可分销</a>";
				str += "<a href='javascript:void(0);' class='table-btns' onclick='setRebate("+list[i].itemId+")' >返佣比例</a>";
			}
			if(status==1||status==2){
				if(list[i].supplierName!="天天仓"&&list[i].supplierName!=null){
					str += "<a href='javascript:void(0);' class='table-btns' onclick='syncStock("+list[i].itemId+")' >同步库存</a>";
				}
			}
		} else {
			str += "</td><td>" + list[i].rebate;
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


function setRebate(id){
	var index = layer.open({
		  title:"设置商品返佣比例",		
		  type: 2,
		  content: '${wmsUrl}/admin/goods/itemMng/toSetRebate.shtml?id='+id,
		  maxmin: true
		});
		layer.full(index);
}

function beUse(id){
	if(id == ""){
		var valArr = new Array; 
		var itemIds;
	    $("[name='check']:checked").each(function(i){
	    	if ($(this).parent().siblings().eq(10).text() == "初始化") {
	 	        valArr[i] = $(this).val(); 
	    	}
	    }); 
	    if(valArr.length==0){
	    	layer.alert("请选择初始化状态的数据");
	    	return;
	    }
	    itemIds = valArr.join(',');//转换为逗号隔开的字符串 
	} else {
		itemIds = id;
	}
	$.ajax({
		 url:"${wmsUrl}/admin/goods/itemMng/beUse.shtml?itemId="+itemIds,
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
	if(id == ""){
		var valArr = new Array; 
		var itemIds;
	    $("[name='check']:checked").each(function(i){
	    	if ($(this).parent().siblings().eq(10).text() == "可用") {
	 	        valArr[i] = $(this).val(); 
	    	}
	    }); 
	    if(valArr.length==0){
	    	layer.alert("请选择可用状态的数据");
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
	    	if ($(this).parent().siblings().eq(10).text() == "可分销") {
	 	        valArr[i] = $(this).val(); 
	    	}
	    }); 
	    if(valArr.length==0){
	    	layer.alert("请选择可分销状态的数据");
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


</script>
</body>
</html>
