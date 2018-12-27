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
<section class="content-wrapper">
	<section class="content">
		<div class="list-content">
			<div class="row content-container">
				<div class="col-md-12 container-right active">
					<table id="floorTable" class="table table-hover myClass">
						<thead>
							<tr>
								<th>页面类型</th>
								<th>模块名称</th>
								<th>模块顺序</th>
								<th>操作</th>
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
<script type="text/javascript">

/**
 * 初始化分页信息
 */
var options = {
	queryForm : ".query",
	url :  "${wmsUrl}/admin/mall/indexMng/componentDataList.shtml?pageId=${pageId}",
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
	$("#floorTable tbody").html("");

	if (data == null || data.length == 0) {
		return;
	}
	var list = data.obj;
	var str = "";
	if (list == null || list.length == 0) {
		str = "<tr style='text-align:center'><td colspan=8><h5>没有查到数据</h5></td></tr>";
		$("#floorTable tbody").html(str);
		return;
	}
	for (var i = 0; i < list.length; i++) {
		str += "<tr>";
		var pageId = list[i].pageId;
		if(pageId==1){
			str += "</td><td>PC";
		}else if(pageId==4){
			str += "</td><td>手机";			
		}else if(pageId==7){
			str += "</td><td>小程序";			
		}else{
			str += "</td><td>其他类型";
		}
		str += "</td><td>" + (list[i].name == null ? "" : list[i].name);
		str += "</td><td>" + (list[i].sort == null ? "0" : list[i].sort);
		str += "</td><td>";
		if (list[i].key == "activity-1" || list[i].key == "activity-2") {
			str += "<a href='javascript:void(0);' class='table-btns' onclick='toEdit(\""+list[i].id+"\",\""+list[i].key+"\")'>编辑</a>";
		}
		str += "</td></tr>";
	}
	$("#floorTable tbody").html(str);
}

function toEdit(id,modelKey){
	var index = layer.open({
	  title:"编辑模块内容",		
	  type: 2,
	  content: '${wmsUrl}/admin/mall/indexMng/toEditModel.shtml?pageId='+id+"&modelKey="+modelKey,
	  maxmin: false
	});
	layer.full(index);
}

</script>
</body>
</html>
