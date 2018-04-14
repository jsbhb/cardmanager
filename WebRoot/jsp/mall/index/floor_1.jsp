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
<section class="content-wrapper">
	<section class="content">
		<div class="list-content">
			<div class="row">
				<div class="col-md-12 list-btns">
					<button type="button" onclick="toAdd()">新增楼层</button>
				</div>
			</div>
			<div class="row content-container">
				<div class="col-md-12 container-right active">
					<table id="floorTable" class="table table-hover myClass">
						<thead>
							<tr>
								<th width="10%">布局编号</th>
								<th width="15%">分类中文名</th>
								<th width="15%">分类英文名</th>
								<th width="15%">页面类型</th>
								<th width="15%">页面类型</th>
								<th width="15%">是否显示</th>
								<th width="15%">操作</th>
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
	<script src="${wmsUrl}/js/pagination.js"></script>
	<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
<script type="text/javascript">
/**
 * 初始化分页信息
 */
var options = {
	queryForm : ".query",
	url :  "${wmsUrl}/admin/mall/indexMng/dataList.shtml?code=module_00024",
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
	if (list == null || list.length == 0) {
		layer.alert("没有查到数据");
		return;
	}
	var str = "";
	for (var i = 0; i < list.length; i++) {
		str += "<tr>";
		str += "</td><td>" + list[i].id;
		str += "</td><td>" + list[i].name;
		str += "</td><td>" + list[i].enname;
		
		var type = list[i].type;
		switch(type){
			case 0:str += "</td><td>新品";break;
			case 1:str += "</td><td>特推";break;
			case 2:str += "</td><td>渠道";break;
			case 3:str += "</td><td>精选";break;
			case 4:str += "</td><td>普通分类";break;
			default:str += "</td><td>无";
		}
		var pageType = list[i].layout.pageType;
		if(pageType==0){
			str += "</td><td>PC";
		}else if(pageType==1){
			str += "</td><td>手机";			
		}else{
			str += "</td><td>无";
		}
		
		var isShow = list[i].layout.show;
		if(isShow==0){
			str += "</td><td>PC";
		}else if(isShow==0){
			str += "</td><td>不显示";			
		}else{
			str += "</td><td>显示";
		}
		
		str += "</td><td>";
		str += "<a href='javascript:void(0);' class='table-btns' onclick='toEdit("+list[i].id+")'>编辑</a>";
		str += "</td></tr>";
	}
	$("#floorTable tbody").html(str);
}
	
function toEdit(id){
	var index = layer.open({
		  title:"楼层编辑",		
		  type: 2,
		  content: '${wmsUrl}/admin/mall/indexMng/toEditFloor.shtml?id='+id,
		  maxmin: false
		});
		layer.full(index);
}

function toAdd(id){
	var index = layer.open({
		  title:"新增楼层",		
		  type: 2,
		  content: '${wmsUrl}/admin/mall/indexMng/toAddFloor.shtml',
		  maxmin: false
		});
		layer.full(index);
}

</script>
</body>
</html>
