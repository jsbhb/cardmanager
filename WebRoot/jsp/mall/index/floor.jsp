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
<%@include file="../../resource.jsp"%>
<script src="${wmsUrl}/js/pagination.js"></script>



</head>
<body>
<section class="content-wrapper">
	<section class="content">
	
		<div class="box box-warning">
			<div class="box-body">
				<div class="row">
					<div class="col-md-12">
							<button type="button" class="btn btn-primary" onclick="toAdd()">新增楼层</button>
						</div>
					<div class="col-md-12">
						<div class="panel panel-default">
							<table id="floorTable" class="table table-hover">
								<thead>
									<tr>
										<th>布局编号</th>
										<th>分类中文名</th>
										<th>分类英文名</th>
										<th>页面类型</th>
										<th>页面类型</th>
										<th>是否显示</th>
										<th>创建时间</th>
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
			</div>
		</div>	
	</section>
	</section>
	
	<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
<script type="text/javascript">


/**
 * 初始化分页信息
 */
var options = {
			queryForm : ".query",
			url :  "${wmsUrl}/admin/mall/indexMng/dataList.shtml?code=module_00024",
			numPerPage:"20",
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
		//if ("${privilege>=2}") {
			
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
		
		str += "</td><td>" + list[i].createTime;
		if (true) {
			str += "<td align='left'>";
			str += "<button type='button' class='btn btn-warning' onclick='toEdit("+list[i].id+")'>编辑</button>";
			str += "<button type='button' class='btn btn-warning' onclick='delete("+list[i].id+")'>删除</button>";
			str += "</td>";
		}
		str += "</td></tr>";
	}
		

	$("#floorTable tbody").html(str);
}
	
function toEdit(id){
	var index = layer.open({
		  title:"基础商品编辑",		
		  type: 2,
		  content: '${wmsUrl}/admin/mall/indexMng/toEditFloor.shtml?id='+id,
		  maxmin: true
		});
		layer.full(index);
}

function toAdd(id){
	var index = layer.open({
		  title:"查看商品",		
		  type: 2,
		  content: '${wmsUrl}/admin/mall/indexMng/toAddFloor.shtml',
		  maxmin: true
		});
		layer.full(index);
}

</script>
</body>
</html>
