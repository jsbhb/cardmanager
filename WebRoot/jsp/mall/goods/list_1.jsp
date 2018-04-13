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
	        <li>商城管理</li>
	        <li class="active">商城商品</li>
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
			           <input type="text" class="form-control" name="hidGoodsName" placeholder="请输入商品名称">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
	                  	<input type="text" class="form-control" name="itemId" placeholder="请输入明细编码">
               			<input type="hidden" class="form-control" name="hidTabId" id="hidTabId" value="first">
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
				<li data-id="first" class="active">已上架</li>
				<li data-id="second">未上架</li>
			</ul>
		</div>
	
		<div class="list-content">
			<div class="row">
				<div class="col-md-12 list-btns">
					<button type="button" onclick = "puton('')">批量上架</button>
					<button type="button" onclick = "putoff('')">批量下架</button>
				</div>
			</div>
			<div class="row content-container">
				<div class="col-md-12 container-right active">
					<table id="baseTable" class="table table-hover myClass">
						<thead>
							<tr>
								<th width="3%"><input type="checkbox" id="theadInp"></th>
								<th width="27%">商品名称</th>
								<th width="10%">商家编码</th>
								<th width="10%">供应商</th>
								<th width="5%">商品标签</th>
								<th width="10%">商品价格</th>
								<th width="10%">商品库存</th>
								<th width="5%">商品状态</th>
								<th width="10%">明细编码</th>
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
	url :  "${wmsUrl}/admin/mall/goodsMng/dataList.shtml",
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
		str += "</td><td>" + list[i].itemCode;
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
		str += "</td><td>" + list[i].goodsPrice.retailPrice;
		if (list[i].stock != null) {
			str += "</td><td>" + list[i].stock.fxQty;
		} else {
			str += "</td><td>无";
		}
		var status = list[i].centerStatus;
		switch(status){
			case 0:str += "</td><td>未上架";break;
			case 1:str += "</td><td>已上架";break;
			default:str += "</td><td>状态错误："+status;
		}
		str += "</td><td>" + list[i].itemId;
		str += "</td><td>";
		if(status == 0){
			str += "<a href='javascript:void(0);' class='table-btns' onclick='puton("+list[i].itemId+")'>上架</a>";
		}else if(status == 1){
			str += "<a href='javascript:void(0);' class='table-btns' onclick='putoff("+list[i].itemId+")'>下架</a>";
		}
		str += "</td></tr>";
	}

	$("#baseTable tbody").html(str);
}


function puton(id){
	if(id == ""){
		var valArr = new Array; 
		var itemIds;
	    $("[name='check']:checked").each(function(i){
	    	if ($(this).parent().siblings().eq(6).text() == "未上架") {
	 	        valArr[i] = $(this).val(); 
	    	}
	    }); 
	    if(valArr.length==0){
	    	layer.alert("请选择未上架状态的数据");
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
			 }else{
				 layer.alert(data.msg);
			 }
		 },
		 error:function(){
			 layer.alert("提交失败，请联系客服处理");
		 }
	 });
}
function putoff(id){
	if(id == ""){
		var valArr = new Array; 
		var itemIds;
	    $("[name='check']:checked").each(function(i){
	    	if ($(this).parent().siblings().eq(6).text() == "已上架") {
	 	        valArr[i] = $(this).val(); 
	    	}
	    }); 
	    if(valArr.length==0){
	    	layer.alert("请选择已上架状态的数据");
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
			 }else{
				 layer.alert(data.msg);
			 }
		 },
		 error:function(){
			 layer.alert("提交失败，请联系客服处理");
		 }
	 });
}

//切换tabBar
$('.list-tabBar').on('click','ul li:not(.active)',function(){
	var tabId = $(this).attr("data-id");
	$("#hidTabId").val(tabId);
	queryDataByLabelTouch("","",tabId);
});

//点击分类标签及tab标签时做数据查询动作
function queryDataByLabelTouch(typeId,categoryId,tabId){
	var url = "${wmsUrl}/admin/mall/goodsMng/dataListByLabel.shtml";	 
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
			 var pagination = data.pagination;
			 $.page.currentPage = pagination.currentPage + "";
		 	 $.page.setLine(pagination.totalPages, options,pagination.totalRows);
		 },
		 error:function(){
			 layer.alert("提交失败，请联系客服处理");
		 }
	});
}

</script>
</body>
</html>
