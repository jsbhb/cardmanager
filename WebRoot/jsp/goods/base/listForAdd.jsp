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
			           <input type="text" class="form-control" name="goodsName" placeholder="请输入商品名称">
					</div>
				</div>
				<div class="col-xs-5">
					<div class="searchBtns">
                         <button type="button" class="query" id="querybtns" name="signup">查询</button>
                         <button type="button" class="clear">清除选项</button>
						 <button type="button" class="add" onclick="toAdd()">新增基础商品</button>
                    </div>
                </div>
            </div>
		</div>
		<div class="list-content">
			<div class="col-md-12 container-right" style="padding:0;">
				<table id="baseTable" class="table table-hover myClass">
					<thead>
						<tr>
							<th width="7%">基础编码</th>
							<th width="20%">品牌名称</th>
							<th width="25%">商品分类</th>
							<th width="20%">商品名称</th>
							<th width="7%">计量单位</th>
							<th width="7%">海关代码</th>
							<th width="7%">增值税率</th>
							<th width="7%">海关税率</th>
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
			url :  "${wmsUrl}/admin/goods/baseMng/dataList.shtml",
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
		str = "<tr style='text-align:center'><td colspan=8><h5>没有查到数据</h5></td></tr>";
		$("#baseTable tbody").html(str);
		return;
	}

	for (var i = 0; i < list.length; i++) {
		str += "<tr>";
		str += "<td align='left'>" + list[i].id + "</td>";
		str += "</td><td>" + list[i].brand;
		str += "</td><td>" + list[i].firstCatalogId+"-"+list[i].secondCatalogId+"-"+list[i].thirdCatalogId;
		str += "</td><td>" + list[i].goodsName;
		str += "</td><td>" + (list[i].unit == null ? "" : list[i].unit);
		str += "</td><td>" + (list[i].hscode == null ? "" : list[i].hscode);
		str += "</td><td>" + list[i].incrementTax;
		str += "</td><td>" + list[i].tariff;		
		str += "</td></tr>";
	}
		

	$("#baseTable tbody").html(str);
	trBind();
}
	
/**
 * 数据字典tr绑定选中事件
 */
function trBind() {
	$("#baseTable tr").dblclick(sureSup);
};

function sureSup(){
		var selectTr = $(this);

		if ($(selectTr).parent().is('thead')) {
			return;
		}
	
		$('#baseId', window.parent.document).val(selectTr.children("td").eq(0).text());
		$('#brand', window.parent.document).val(selectTr.children("td").eq(1).text());
		$('#catalog', window.parent.document).val(selectTr.children("td").eq(2).text());
		$('#goodsName', window.parent.document).val(selectTr.children("td").eq(3).text().trim());
		$('#unit', window.parent.document).val(selectTr.children("td").eq(4).text());
		$('#hscode', window.parent.document).val(selectTr.children("td").eq(5).text().trim());
		$('#incrementTax', window.parent.document).val(selectTr.children("td").eq(6).text());
		$('#tariff', window.parent.document).val(selectTr.children("td").eq(7).text());

		 parent.choiseModel();
		
// 		$('#baseInfo', window.parent.document).show();
		
		
		parent.layer.closeAll();
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
