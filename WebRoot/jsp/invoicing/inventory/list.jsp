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
	        <li>进销存管理</li>
	        <li class="active">库存维护</li>
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
		                	<option value="5">广州仓</option>
		                	<option selected="selected" value="6">一般贸易仓</option>
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
		                	<option value="0">跨境商品</option>
		                	<option selected="selected" value="2">一般贸易商品</option>
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
				<div class="col-md-10 list-btns">
					<button style="float:left;" type="button" onclick = "excelExport()">导出批量维护模板</button>
					<a href="javascript:void(0);" class="file">批量维护虚拟库存
					    <input type="file" id="import" name="import" accept=".xlsx"/>
					</a>
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
								<th width="3%"><input type="checkbox" id="theadInp"></th>
								<th width="10%">商品图片</th>
								<th width="12%">商品名称</th>
								<th width="5%">商品编号</th>
								<th width="5%">商家编码</th>
								<th width="5%">商品品牌</th>
								<th width="10%">商品分类</th>
								<th width="5%">单位</th>
								<th width="5%">规格</th>
								<th width="5%">箱规</th>
								<th width="5%">保质期</th>
								<th width="5%">产地</th>
								<th width="5%">条形码</th>
								<th width="5%">供应商</th>
								<th width="5%">商品标签</th>
								<th width="5%">商品价格</th>
								<th width="5%">现有库存</th>
								<th width="5%">虚拟库存</th>
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
<script type="text/javascript" src="${wmsUrl}/js/ajaxfileupload.js"></script>
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
	url :  "${wmsUrl}/admin/invoicing/inventoryMng/dataList.shtml?gradeType=${gradeType}&type=1",
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
		str = "<tr style='text-align:center'><td colspan=14><h5>没有查到数据</h5></td></tr>";
		$("#baseTable tbody").html(str);
		return;
	}

	for (var i = 0; i < list.length; i++) {
		str += "<tr>";
		str += "<td><input type='checkbox' name='check' value='" + list[i].itemId + "'/>"
		if (list[i].goodsEntity.files == null) {
			str += "</td><td><img src=${wmsUrl}/img/logo_1.png>";
		} else {
			str += "</td><td><img src="+list[i].goodsEntity.files[0].path+">";
		}
		str += "</td><td>" + list[i].goodsName;
		str += "</td><td><a target='_blank' href='http://www.cncoopbuy.com/goodsDetail.html?goodsId="+list[i].goodsId+"'>" + list[i].itemId + "</a>";
		str += "</td><td>" + list[i].itemCode;
		if (list[i].baseEntity == null) {
			str += "</td><td>";
			str += "</td><td>";
			str += "</td><td>";
		} else {
			str += "</td><td>" + list[i].baseEntity.brand;
			str += "</td><td>" + list[i].baseEntity.firstCatalogId+"-"+list[i].baseEntity.secondCatalogId+"-"+list[i].baseEntity.thirdCatalogId;
			str += "</td><td>" + list[i].baseEntity.unit;
		}
		str += "</td><td>" + list[i].info;
		str += "</td><td>" + list[i].carTon;
		str += "</td><td>" + list[i].shelfLife;
		str += "</td><td>" + list[i].goodsEntity.origin;
		str += "</td><td>" + list[i].encode;
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
		str += "</td><td><input type='text' class='form-control' onkeyup=\"this.value=this.value.replace(/[^-?\\d]/g,'')\" onafterpaste=\"this.value=this.value.replace(/[^-?\\d]/g,'')\" value='1'>";
		str += "</td><td><a href='javascript:void(0);' class='table-btns' data-id='"+list[i].itemId+"'>维护虚拟库存</a>";
		str += "</td></tr>";
	}

	$("#baseTable tbody").html(str);
}
	
$('#baseTable').on('click','.table-btns',function(){
	var itemId = $(this).attr('data-id');
	var qty = $(this).parent().prev().find('input').val();
	$.ajax({
		 url:"${wmsUrl}/admin/invoicing/inventoryMng/maintain.shtml?itemId="+itemId+"&qty="+qty,
		 type:'post',
		 contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 success:function(data){
			 if(data.success){	
				 layer.alert("维护成功");
				 reloadTable();
			 }else{
				 layer.alert(data.msg);
			 }
		 },
		 error:function(){
			 layer.alert("维护失败，请联系客服处理");
		 }
	 });
});

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

//点击分类标签及tab标签时做数据查询动作
function queryDataByLabelTouch(typeId,categoryId){
	$("#typeId").val(typeId);
	$("#categoryId").val(categoryId);
	
	reloadTable();
}

function excelExport(){
	var valArr = new Array; 
	var itemIds;
    $("[name='check']:checked").each(function(i){
    	valArr[i] = $(this).val();
    }); 
    itemIds = valArr.join(',');//转换为逗号隔开的字符串 
    var supplierId = $("#supplierId").val();
    window.open("${wmsUrl}/admin/invoicing/inventoryMng/downLoadExcel.shtml?supplierId="+supplierId+"&itemIds="+itemIds);
// 	location.href="${wmsUrl}/admin/invoicing/inventoryMng/downLoadExcel.shtml?supplierId="+supplierId+"&itemIds="+itemIds;
	$("#theadInp").prop("checked", false);
}

//点击上传文件
$('.list-content').on('change','.list-btns input[type=file]',function(){
	$.ajaxFileUpload({
		url : '${wmsUrl}/admin/uploadExcelFile.shtml', //你处理上传文件的服务端
		secureuri : false,
		fileElementId : "import",
		dataType : 'json',
		beforeSend : function() {
			$("#image").css({
				display : "block",
				position : "fixed",
				zIndex : 99,
			});
		},
		success : function(data) {
			//文件上传成功，进行读取操作
			var filePath = data.msg;
			readExcelForMaintain(filePath);
		},
		complete : function(data) {
			$("#image").hide();
		}
	})
});

function readExcelForMaintain(filePath){
	$.ajax({
		 url:"${wmsUrl}/admin/invoicing/inventoryMng/readExcelForMaintain.shtml?filePath="+filePath,
		 type:'post',
		 contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 success:function(data){
			 if(data.success){
				 $("#import").val();
				 reloadTable();
			 }else{
				 layer.alert(data.msg);
			 }
		 },
		 error:function(){
			 layer.alert("处理失败，请联系客服处理");
		 }
	 });
}
</script>
</body>
</html>
