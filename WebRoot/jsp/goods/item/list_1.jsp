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
	        <li class="active">商品列表</li>
	      </ol>
	      <div class="search">
	      	<input type="text" name="id" placeholder="请输入商品名称">
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
	                  	<input type="text" class="form-control" name="itemCode" placeholder="请输入商家编码">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
			           <input type="text" class="form-control" name="goodsName" placeholder="请输入商品名称">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
	                  	<input type="text" class="form-control" name="itemId" placeholder="请输入明细编码">
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
					<span>商品分类</span>
					<i class="fa fa-list fa-fw"></i>
				</div>
				<div class="col-md-10 list-btns">
					<button type="button" onclick="jump(40)">新增商品</button>
					<button type="button" onclick = "beUse('')">批量可用</button>
					<button type="button" onclick = "beFx('')">批量可分销</button>
					<button type="button" onclick = "noBeFx('')">批量不可分销</button>
				</div>
			</div>
			<div class="row content-container">
				<div class="col-md-2 container-left">
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
				<div class="col-md-10 container-right">
					<table id="baseTable" class="table table-hover myClass">
						<thead>
							<tr>
								<th width="3%"><input type="checkbox" id="theadInp"></th>
								<th width="15%">商品名称</th>
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
								<th width="5%">明细编码</th>
								<th width="12%">操作</th>
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
$('.SearchBtn').on('click',function(){
	
});

/**
 * 初始化分页信息
 */
var options = {
			queryForm : ".query",
			url :  "${wmsUrl}/admin/goods/itemMng/dataList.shtml",
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
		str += "<td><input type='checkbox'/>"
		str += "</td><td>" + list[i].goodsName;
		str += "</td><td>" + list[i].itemCode;
		str += "</td><td>" + list[i].baseEntity.brand;
		str += "</td><td>" + list[i].baseEntity.firstCatalogId+"-"+list[i].baseEntity.secondCatalogId+"-"+list[i].baseEntity.thirdCatalogId;
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
		str += "</td><td>" + list[i].baseEntity.incrementTax;
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
		str += "</td><td>" + list[i].itemId;
		str += "</td><td><a href='javascript:void(0);' class='table-btns' onclick='toEdit("+list[i].itemId+")'>编辑</a><a href='javascript:void(0);' class='table-btns'  onclick='toEdit("+list[i].itemId+")' >设价</a>";
		if(status == 0){
			str += "<a href='javascript:void(0);' class='table-btns' onclick='beUse("+list[i].itemId+")' >可用</a>";
		}else if(status == 1){
			str += "<a href='javascript:void(0);' class='table-btns' onclick='beFx("+list[i].itemId+")' >可分销</a>";
		}else if(status == 2){
			str += "<a  href='javascript:void(0);' class='table-btns' onclick='noBeFx("+list[i].itemId+")' >不可分销</a>";
		}
		if(status==1||status==2){
			if(list[i].supplierName!="天天仓"&&list[i].supplierName!=null){
				str += "<a href='javascript:void(0);' class='table-btns' onclick='syncStock("+list[i].itemId+")' >同步库存</a>";
			}
		}
		str += "</td></tr>";
	}

	$("#baseTable tbody").html(str);
}
	
function toEdit(id){
	var index = layer.open({
		  title:"基础商品编辑",		
		  type: 2,
		  content: '${wmsUrl}/admin/goods/baseMng/toEdit.shtml?baseId='+id,
		  maxmin: true
		});
		layer.full(index);
}

function beUse(id){
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

//搜索类型切换
$('.moreSearchBtn').click(function(){
	$('.moreSearchContent').slideDown(300);
	$('.search').hide();
});
$('.lessSearchBtn').click(function(){
	$('.moreSearchContent').slideUp(300);
	setTimeout(function(){
		$('.search').show();
	},300);
});

//清除筛选内容
$('.searchBtns').on('click','.clear',function(){
	$('.searchItem input').val('');
	document.getElementById("brandId").options[0].selected="selected";
	document.getElementById("supplierId").options[0].selected="selected";
	document.getElementById("tagId").options[0].selected="selected";
});

//点击收缩所有分类
$('.goods-classify').on('click','i:not(.active)',function(){
	$(this).addClass('active');
	$('.container-left').stop();
	$('.container-left').slideUp(300);
	setTimeout(function(){
		$('.container-right').removeClass('col-md-10').addClass('col-md-12').addClass('active');
		$('.container-left').addClass('hideList');
	},300);
});

//点击展开所有分类
$('.goods-classify').on('click','i.active',function(){
	$('.container-left').removeClass('hideList');
	$('.container-left').hide();
	$(this).removeClass('active');
	$('.container-left').stop();
	$('.container-right').removeClass('col-md-12').removeClass('active').addClass('col-md-10');
	$('.container-left').slideDown(300);
});

//点击展开分类列表
$('.container-left').on('click','i.fa-angle-right',function(){
	$(this).next().stop();
	$(this).next().slideDown(300);
	$(this).removeClass('fa-angle-right').addClass('fa-angle-down');
});

//点击收缩分类列表
$('.container-left').on('click','i.fa-angle-down',function(){
	$(this).next().stop();
	$(this).next().slideUp(300);
	$(this).removeClass('fa-angle-down').addClass('fa-angle-right');
	$('.container-left span.active').removeClass('active');
});

//点击分类
$('.container-left').on('click','span:not(.active)',function(){
	var categoryId = $(this).attr("data-id");
	var typeId = $(this).attr("data-type");
	queryDataByLabelTouch(typeId,categoryId,"");
});

$('.container-left').on('click','span.active',function(){
	queryDataByLabelTouch("","","");
});

//切换tabBar
$('.list-tabBar').on('click','ul li:not(.active)',function(){
	var tabId = $(this).attr("data-id");
	queryDataByLabelTouch("","",tabId);
});

//点击分类标签及tab标签时做数据查询动作
function queryDataByLabelTouch(typeId,categoryId,tabId){
	var url = "${wmsUrl}/admin/goods/itemMng/dataListByLabel.shtml";	 
	var formData = {};
	formData["typeId"] = typeId;
	formData["categoryId"] = categoryId;
	formData["tabId"] = tabId;
	
	$.ajax({
		 url:url,
		 type:'post',
		 data:JSON.stringify(formData),
		 contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 success:function(data){
			 if(data.success){
				 rebuildTable(data);
			 }else{
				 layer.alert(data.msg);
			 }
		 },
		 error:function(){
			 layer.alert("提交失败，请联系客服处理");
		 }
	});
}

var timer = null;


//鼠标事件
$('.goods-classify').on('mouseenter',function(){
	if($(this).find('i').hasClass('active')){
		$('.container-left').stop();
		$('.container-left').slideDown(300);
	}
})

$('.goods-classify').on('mouseleave',function(){
	if($(this).find('i').hasClass('active')){
		timer = setTimeout(function(){
	  		$('.container-left').stop();
	  		$('.container-left').slideUp(300);
	  	},100);
	}
})

$('.container-left').on('mouseenter',function(){
	if($(this).hasClass('hideList')){
		clearTimeout(timer);
	}
})

$('.container-left').on('mouseleave',function(){
	if($(this).hasClass('hideList')){
		$('.container-left').stop();
	  	$('.container-left').slideUp(300);
	}
})

//实现全选反选
$("#theadInp").on('click', function() {
    $("tbody input:checkbox").prop("checked", $(this).prop('checked'));
})
$("tbody input:checkbox").on('click', function() {
    //当选中的长度等于checkbox的长度的时候,就让控制全选反选的checkbox设置为选中,否则就为未选中
    if($("tbody input:checkbox").length === $("tbody input:checked").length) {
        $("#theadInp").prop("checked", true);
    } else {
        $("#theadInp").prop("checked", false);
    }
})

</script>
</body>
</html>
