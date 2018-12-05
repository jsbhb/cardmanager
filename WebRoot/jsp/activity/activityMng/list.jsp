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
<%-- <script src="${wmsUrl}/plugins/laydate/laydate.js"></script> --%>
</head>
<body>
<section class="content-wrapper query">
	<section class="content-header">
	      <ol class="breadcrumb">
	        <li><a href="javascript:void(0);">首页</a></li>
	        <li>活动管理</li>
	        <li class="active">活动列表</li>
	      </ol>
	      <div class="search">
	      	<input type="text" name="activityName" placeholder="请输入活动名称" >
	      	<div class="searchBtn"><i class="fa fa-search fa-fw"></i></div>
	      	<div class="moreSearchBtn">高级搜索</div>
		  </div>
    </section>
	<section class="content content-iframe">
		<div id="image" style="width:100%;height:100%;display: none;background:rgba(0,0,0,0.5);margin-left:-25px;margin-top:-62px;">
			<img alt="loading..." src="${wmsUrl}/img/loader.gif" style="position:fixed;top:50%;left:50%;margin-left:-16px;margin-top:-16px;" />
		</div>
		<div class="moreSearchContent">
			<div class="row form-horizontal list-content">
				<div class="col-xs-3">
					<div class="searchItem">
			            <select class="form-control" name="activityType" id="activityType">
	                   	  <option selected="selected" value="">活动类型</option>
	                   	  <option value="1">砍价活动</option>
		                </select>
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
			            <select class="form-control" name="activityStatus" id="activityStatus">
	                   	  <option selected="selected" value="">活动状态</option>
	                   	  <option value="0">未开始</option>
	                   	  <option value="1">开始</option>
		                </select>
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
						<input type="text" class="form-control" name="activityName" placeholder="请输入活动名称">
					</div>
				</div>
<!-- 				<div class="col-xs-3"> -->
<!-- 					<div class="searchItem"> -->
<!-- 						<input type="text" class="chooseTime" id="searchTime" name="searchTime" placeholder="请选择活动时间" readonly> -->
<!-- 					</div> -->
<!-- 				</div> -->
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
				<div class="col-md-12 list-btns">
					<c:if test="${prilvl == 1}">
						<button style="float:left;" type="button" onclick = "toAddActivity()">创建新活动</button>
					</c:if>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 container-right">
					<table id="baseTable" class="table table-hover myClass">
						<thead>
							<tr>
								<th>活动编号</th>
								<th>活动类型</th>
								<th>活动名称</th>
								<th>活动描述</th>
								<th>活动商品数</th>
								<th>活动状态</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
			</div>
		</div>	
		<div class="pagination-nav">
			<ul id="pagination" class="pagination">
			</ul>
		</div>
	</section>
	</section>
	
<%@include file="../../resourceScript.jsp"%>
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
	url :  "${wmsUrl}/admin/activity/activityMng/dataList.shtml",
	numPerPage:"10",
	currentPage:"",
	index:"1",
	callback:rebuildTable
}


$(function(){
	$(".pagination-nav").pagination(options);
})

// laydate.render({
// 	elem: '#searchTime', //指定元素
// 	type: 'datetime',
// 	range: '~',
// 	value: null
// });

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
		str = "<tr style='text-align:center'><td colspan=11><h5>没有查到数据</h5></td></tr>";
		$("#baseTable tbody").html(str);
		return;
	}

	for (var i = 0; i < list.length; i++) {
		str += "<tr>";
		str += "<td>" + list[i].id;
		var type = list[i].type;
		switch(type){
			case 1:str += "</td><td>砍价活动";break;
			default:str += "</td><td>未知活动类型";
		}
		str += "</td><td>" + (list[i].name == null ? "" : list[i].name);
		str += "</td><td>" + (list[i].description == null ? "" : list[i].description);
		str += "</td><td>" + (list[i].goodsCount == null ? "0" : list[i].goodsCount);
		var status = list[i].status;
		switch(status){
			case 0:str += "</td><td>未开始";break;
			case 1:str += "</td><td>开始";break;
			default:str += "</td><td>未知状态";
		}
		str += "</td><td><a href='javascript:void(0);' class='table-btns' onclick='toShow("+type+","+list[i].id+")'>查看活动信息</a>";
		str += "</td></tr>";
	}
	$("#baseTable tbody").html(str);
}
	

function toShow(type,id){
	var tmpStr = "";
	if (type == "1") {
		tmpStr = "bargainMng";
	}
	var url = "${wmsUrl}/admin/activity/"+tmpStr+"/toShowAcitvityInfo.shtml?id="+id;
	var index = layer.open({
	  title:"查看活动信息",		
	  type: 2,
	  content: url,
	  maxmin: true
	});
	layer.full(index);
}

function toAddActivity(){
	var index = layer.open({
	  title:"创建新活动",		
	  type: 2,
	  content: '${wmsUrl}/admin/activity/activityMng/toAddActivity.shtml',
	  maxmin: true
	});
	layer.full(index);
}
</script>
</body>
</html>
