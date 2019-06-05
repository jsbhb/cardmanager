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
		        <li><a href="javascript:void(0);">店铺管理</a></li>
		        <li class="active">店铺审核</li>
		      </ol>
		      <div class="search">
		      	<input type="text"  name="statusName" id="statusName" readonly style="background:#fff;width:200px;" placeholder="选择状态" value = "未审核">
				<input type="hidden" class="form-control" name="status" id="status" value = "0">
		      	<div class="searchBtn" ><i class="fa fa-search fa-fw" id="querybtns"></i></div>
			  </div>
	    </section>
	<section class="content">
		<div id="image" style="width:100%;height:100%;display: none;background:rgba(0,0,0,0.5);margin-left:-25px;margin-top:-62px;">
			<img alt="loading..." src="${wmsUrl}/img/loader.gif" style="position:fixed;top:50%;left:50%;margin-left:-16px;margin-top:-16px;" />
		</div>
		<div class="select-content" style="width: 420px;top: 219px;">
	           		<ul class="first-ul" style="margin-left:10px;">
	           			<li><span data-id="0" data-name = "未审核" class="no-child">未审核</span><li>
	           			<li><span data-id="1" data-name = "未通过" class="no-child">未通过</span><li>
	           			<li><span data-id="2" data-name = "通过" class="no-child">通过</span><li>
	           		</ul>
	           	</div>
		<div class="list-content">
			<div class="col-md-12 ">
				<table id="baseTable" class="table table-hover myClass">
					<thead>
						<tr>
							<th>等级编号</th>
							<th>名称</th>
							<th>上级机构</th>
							<th>分级类型</th>
							<th>负责人</th>
							<th>电话号码</th>
							<th>申请时间</th>
							<th>状态</th>
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
	</section>
</section>
<%@include file="../../resourceScript.jsp"%>
<script src="${wmsUrl}/js/pagination.js"></script>
<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
<script type="text/javascript">


/**
 * 初始化分页信息
 */
var options = {
			queryForm : ".query",
			url :  "${wmsUrl}/admin/system/gradeMng/dataList.shtml",
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
		str = "<tr style='text-align:center'><td colspan=9><h5>没有查到数据</h5></td></tr>";
		$("#baseTable tbody").html(str);
		return;
	}

	for (var i = 0; i < list.length; i++) {
		str += "<tr>";
		str += "<td>" + (list[i].id+3000);
		str += "</td><td>" + (list[i].gradeName == null ? "" : list[i].gradeName);
		var pgName = list[i].parentGradeName;
		
		if(pgName != null && pgName !="null" && pgName != ""){
			str += "</td><td>" + list[i].parentGradeName;
		}else{
			str += "</td><td>";
		}
		
		str += "</td><td>" + (list[i].gradeTypeName == null ? "" : list[i].gradeTypeName);
		str += "</td><td>" + (list[i].personInCharge == null ? "" : list[i].personInCharge);
		str += "</td><td>" + (list[i].phone == null ? "" : list[i].phone);
		str += "</td><td>" + (list[i].createTime == null ? "" : list[i].createTime);
		var status = list[i].status;
		if(status == 0){
			str += "</td><td>未审核"
		} else if(status == 1){
			str += "</td><td>未通过"
		} else if(status == 2){
			str += "</td><td>通过"
		} else {
			str += "</td><td>异常"
		}
		str += "<td align='left'>";
		str += "<a href='#' onclick='show("+list[i].id+","+list[i].parentId+")'>查看</a>";
		str += "</td>";
		str += "</td></tr>";
	}

	$("#baseTable tbody").html(str);
}
	
function show(id,parentId){
	var index = layer.open({
		 title:"查看",		 
		  type: 2,
		  content: '${wmsUrl}/admin/shop/shopMng/toShow.shtml?gradeId='+id+"&parentId="+parentId,
		  maxmin: true
		});
		layer.full(index);
}


//点击展开下拉列表
$('#statusName').click(function(){
	$('.select-content').css('width',$(this).outerWidth());
	$('.select-content').css('left',$(this).offset().left);
	$('.select-content').css('top',$(this).offset().top + $(this).height());
	$('.select-content').stop();
	$('.select-content').slideDown(300);
});

//点击空白隐藏下拉列表
$('html').click(function(event){
	var el = event.target || event.srcelement;
	if(!$(el).parents('.select-content').length > 0 && $(el).attr('id') != "statusName"){
		$('.select-content').stop();
		$('.select-content').slideUp(300);
	}
});

//点击选择分类
$('.select-content').on('click','span',function(event){
	var el = event.target || event.srcelement;
	if(el.nodeName != 'I'){
		var name = $(this).attr('data-name');
		var id = $(this).attr('data-id');
		$('#statusName').val(name);
		$('#status').val(id);
		$('.select-content').stop();
		$('.select-content').slideUp(300);
	}
});

</script>
</body>
</html>
