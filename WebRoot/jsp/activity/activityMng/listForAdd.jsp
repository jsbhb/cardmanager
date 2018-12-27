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
	<section class="content">
		<div id="image" style="width:100%;height:100%;display: none;background:rgba(0,0,0,0.5);margin-left:-25px;margin-top:-62px;">
			<img alt="loading..." src="${wmsUrl}/img/loader.gif" style="position:fixed;top:50%;left:50%;margin-left:-16px;margin-top:-16px;" />
		</div>
		<div class="moreSearchContent active">
			<div class="row form-horizontal query list-content">
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
           				<input type="hidden" class="form-control" name="hidTabId" value="first">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
	                  	<input type="text" class="form-control" name="itemCode" placeholder="请输入商家编码">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchBtns" style="margin-left:30px">
                         <button type="button" class="query" id="querybtns" name="signup">查询</button>
                         <button type="button" class="clear">清除选项</button>
                    </div>
                </div>
            </div>
		</div>
		<div class="list-content">
			<div class="col-md-12 container-right" style="padding:0;">
				<table id="baseTable" class="table table-hover myClass">
					<thead>
						<tr>
							<th width="6%">商品图片</th>
							<th width="14%">商品名称</th>
							<th width="6%">商品编号</th>
							<th width="7%">商家编码</th>
							<th width="7%">商品品牌</th>
							<th width="10%">商品分类</th>
							<th width="5%">供应商</th>
							<th width="5%">商品价格</th>
							<th width="5%">商品库存</th>
							<th width="5%">商品规格</th>
							<th width="5%">商品ID</th>
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
	</section>
	
<%@include file="../../resourceScript.jsp"%>
<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
<script type="text/javascript">
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
		str = "<tr style='text-align:center'><td colspan=10><h5>没有查到数据</h5></td></tr>";
		$("#baseTable tbody").html(str);
		return;
	}
	for (var i = 0; i < list.length; i++) {
		str += "<tr>";
		if (list[i].goodsEntity.files == null) {
			str += "<td><img style='width:50px;height:50px;' src=${wmsUrl}/img/default_img.jpg> ";
		} else {
			str += "<td><img style='width:50px;height:50px;' src="+list[i].goodsEntity.files[0].path+">";
		}
		str += "</td><td style='text-align:left;'><a target='_blank' href='${webUrl}"+list[i].webUrlParam+"'>" + list[i].goodsName + "</a>";
		if(list[i].tagList.length > 0){
			str += '<p style="margin: 5px 0 0 0;">';
			for(var j=0;j<list[i].tagList.length;j++){
				str += "<span class='table_icon'>"+list[i].tagList[j].tagName+"</span>"
			}
			str += '</p>';
		}
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
		str += "</td><td>" + (list[i].info == null ? "" : list[i].info);
		str += "</td><td>" + list[i].goodsId;
		str += "</td></tr>";
	}
	$("#baseTable tbody").html(str);
	trBind();
}
	
/**
 * 数据字典tr绑定选中事件
 */
function trBind() {
	$("#baseTable tr").dblclick(sureGoods);
};

function sureGoods(){
	var selectTr = $(this);
	if ($(selectTr).parent().is('thead')) {
		return;
	}
// 	var selectItemInfo={};
// 	selectItemInfo["itemId"] = selectTr.children("td").eq(2).text().trim();
// 	selectItemInfo["goodsName"] = selectTr.children("td").eq(1).text().trim();
// 	selectItemInfo["price"] = selectTr.children("td").eq(7).text().trim();
// 	selectItemInfo["stock"] = selectTr.children("td").eq(8).text().trim();
	var selectItenInfo=selectTr.children("td").eq(2).text().trim()+"|"+selectTr.children("td").eq(1).text().trim()+"|"+selectTr.children("td").eq(7).text().trim()+"|"+selectTr.children("td").eq(8).text().trim()+"|"+selectTr.children("td").eq(0).children("img").eq(0).attr('src')+"|"+selectTr.children("td").eq(10).text().trim();
	$('#selectItem', window.parent.document).val(selectItenInfo);
	parent.getSelectItemInfo();
}
</script>
</body>
</html>
