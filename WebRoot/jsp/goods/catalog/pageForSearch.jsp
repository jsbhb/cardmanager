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
			           <input type="text" class="form-control" name="name" placeholder="请输入属性名称">
			           <input type="hidden" class="form-control" name="propertyType" value="${propertyType}" readonly>
					</div>
				</div>
				<div class="col-xs-5">
					<div class="searchBtns">
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
							<th width="10%">属性ID</th>
							<th width="20%">属性名称</th>
							<th width="20%">属性类型</th>
							<th width="20%">创建时间</th>
							<th width="20%">更新时间</th>
							<th width="10%">操作人</th>
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
<script type="text/javascript">

/**
 * 初始化分页信息
 */
var options = {
	queryForm : ".query",
	url :  "${wmsUrl}/admin/goods/catalogMng/queryAllPropertyList.shtml",
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
	
	var tmpType = "${propertyType}" ;

	for (var i = 0; i < list.length; i++) {
		str += "<tr>";
		str += "<td align='left'>" + list[i].id;
		str += "</td><td>" + list[i].name;
		if (tmpType == 1) {
			str += "</td><td>系列属性";
		} else {
			str += "</td><td>导购属性";
		}
		str += "</td><td>" + (list[i].createTime == null ? "" : list[i].createTime);
		str += "</td><td>" + (list[i].updateTime == null ? "" : list[i].updateTime);
		str += "</td><td>" + (list[i].opt == null ? "" : list[i].opt);
		str += "</td></tr>";
	}
	$("#baseTable tbody").html(str);
	trBind();
}
	
/**
 * 数据字典tr绑定选中事件
 */
function trBind() {
	$("#baseTable tr").dblclick(sureProperty);
};

function sureProperty(){
	var selectTr = $(this);
	if ($(selectTr).parent().is('thead')) {
		return;
	}
	$('#propertyId', window.parent.document).val(selectTr.children("td").eq(0).text());
	parent.selectAndJoinProperty();
}
</script>
</body>
</html>
