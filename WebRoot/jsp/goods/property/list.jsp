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
	        <li>商品管理</li>
	        <li class="active">商品属性</li>
	      </ol>
	      <div class="search">
	      	<input type="text" name="name" placeholder="请输入属性名称">
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
			        	<input type="text" class="form-control" name="name" placeholder="请输入属性名称">
           				<input type="hidden" class="form-control" name="hidTabId" id="hidTabId" value="property">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
			           <input type="text" class="form-control" name="val" placeholder="请输入属性值">
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
				<li data-id="property" class="active">系列属性</li>
				<li data-id="guideProperty">导购属性</li>
			</ul>
		</div>
	
		<div class="list-content">
			<div class="row">
				<div class="col-md-12 list-btns">
                   	<button type="button" onclick="toAddName()">新增属性名</button>
				</div>
			</div>
			<div class="row content-container">
				<div class="col-md-12 container-right active">
					<table id="baseTable" class="table table-hover myClass">
						<thead>
							<tr>
								<th width="10%">属性名</th>
								<th width="10%">属性类型</th>
								<th width="10%">属性值</th>
								<th width="10%">显示顺序</th>
								<th width="10%">关联商品数</th>
								<th width="10%">更新时间</th>
								<th width="10%">操作人</th>
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
	url :  "${wmsUrl}/admin/goods/propertyMng/dataList.shtml",
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
	
	$('.list-tabBar').find('li').each(function() {
		if ($(this).attr('data-id') == $("#hidTabId").val()) {
			$(this).addClass('active').siblings('.active').removeClass('active');
		}
    })
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
	var tmpHidTabId = $("#hidTabId").val();

	for (var i = 0; i < list.length; i++) {
		str += "<tr data-id=" + list[i].id + ">";
		if (list[i].valueList != null) {
			str += "<td><i class='fa fa-fw fa-plus'></i>" + list[i].name;
		} else {
			str += "<td>" + list[i].name;
		}
		if (tmpHidTabId == "property") {
			str += "</td><td>系列属性";
		} else {
			str += "</td><td>导购属性";
		}
		str += "</td><td>";
		str += "</td><td>";
		str += "</td><td>";
		str += "</td><td>" + list[i].updateTime;
		str += "</td><td>" + list[i].opt;
		str += "</td><td>";	
		str += "<a href='javascript:void(0);' class='table-btns' onclick='toAddValue("+list[i].id+',"'+tmpHidTabId+"\")'>新增属性值</a>";
		str += "<a href='javascript:void(0);' class='table-btns' onclick='toEditName("+list[i].id+',"'+tmpHidTabId+"\")' >修改属性名</a>";
		str += "<a href='javascript:void(0);' class='table-btns' onclick='toDeleteName("+list[i].id+',"'+tmpHidTabId+"\")' >删除属性名</a>";	
		str += "</td></tr>";
		if (list[i].valueList != null) {
			for (var j = 0; j < valueList.length; j++) {
				str += "<tr data-id=" + list[j].id + " parentId=" + list[i].id + ">";
				str += "<td>";
				str += "</td><td>";
				str += "</td><td>" + list[j].val;
				str += "</td><td>" + list[j].sort;
				str += "</td><td>" + list[j].countNum;
				str += "</td><td>" + list[j].updateTime;
				str += "</td><td>" + list[j].opt;
				str += "</td><td>";	
				str += "<a href='javascript:void(0);' class='table-btns' onclick='toEditVal("+list[j].id+',"'+tmpHidTabId+"\")' >修改属性值</a>";
				str += "<a href='javascript:void(0);' class='table-btns' onclick='toDeleteVal("+list[j].id+',"'+tmpHidTabId+"\")' >删除属性值</a>";	
				str += "</td></tr>";
			}
		}
	}
	$("#baseTable tbody").html(str);
}

//切换tabBar
$('.list-tabBar').on('click','ul li:not(.active)',function(){
	var tabId = $(this).attr("data-id");
	$("#hidTabId").val(tabId);
	reloadTable();
});

$('#baseTable').on('click','td i.fa',function(){
	var ids = $(this).parent().parent().attr('data-id');
	var idss;
	if($(this).hasClass('fa-plus')){
		$(this).removeClass('fa-plus').addClass('fa-minus');
		$('tr[parentId="'+ids+'"]').show();
	}else if($(this).hasClass('fa-minus')){
		$(this).removeClass('fa-minus').addClass('fa-plus');
		for(var i=0;i<75;i++){
			$('tr[parentId="'+ids+'"]').hide();
			for(var j=0;j<$('tr[parentId="'+ids+'"]').length;j++){
				idss = $($('tr[parentId="'+ids+'"]')[j]).attr('data-id');
				$($('tr[parentId="'+ids+'"]')[j]).find('i').removeClass('fa-minus').addClass('fa-plus');
				if(idss != undefined){
					$('tr[parentId="'+idss+'"]').hide();
				}else{
					idss = undefined;
					break;
				}
			}
		}
	}
});

function toAddName(){
	var tmpHidTabId = $("#hidTabId").val();
	var index = layer.open({
	  title:"新增属性名称",	
	  area: ['80%', '80%'],		
	  type: 2,
	  content: '${wmsUrl}/admin/goods/propertyMng/toAddName.shtml?hidTabId='+tmpHidTabId,
	  maxmin: false
	});
}

function toEditName(id,hidTabId){
	var index = layer.open({
	  title:"修改属性名称",	
	  area: ['80%', '80%'],		
	  type: 2,
	  content: '${wmsUrl}/admin/goods/propertyMng/toEditName.shtml?hidTabId='+tmpHidTabId+'&id='+id,
	  maxmin: false
	});
}

function toDeleteName(id,hidTabId){
	layer.confirm('确定要删除当前属性名称吗？', {
		  btn: ['取消','确定']
	}, function(){
		layer.closeAll();
	}, function(){
		$.ajax({
			 url:"${wmsUrl}/admin/goods/propertyMng/deleteName.shtml?hidTabId="+tmpHidTabId+"&id="+id,
			 type:'post',
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){	
					 parent.layer.closeAll();
					 location.reload();
				 }else{
					 layer.alert(data.msg);
				 }
			 },
			 error:function(){
				 layer.alert("删除属性名称失败，请联系客服处理");
			 }
		 });
	});
}

function toAddValue(id,hidTabId){
	var index = layer.open({
	  title:"新增属性值",	
	  area: ['80%', '80%'],		
	  type: 2,
	  content: '${wmsUrl}/admin/goods/propertyMng/toAddValue.shtml??hidTabId='+tmpHidTabId+'&id='+id,
	  maxmin: false
	});
}

function toEditValue(id,hidTabId){
	var index = layer.open({
	  title:"修改属性值",	
	  area: ['80%', '80%'],		
	  type: 2,
	  content: '${wmsUrl}/admin/goods/propertyMng/toEditValue.shtml?hidTabId='+tmpHidTabId+'&id='+id,
	  maxmin: false
	});
}

function toDeleteValue(id,hidTabId){
	layer.confirm('确定要删除当前属性值吗？', {
		  btn: ['取消','确定']
	}, function(){
		layer.closeAll();
	}, function(){
		$.ajax({
			 url:"${wmsUrl}/admin/goods/propertyMng/deleteValue.shtml?hidTabId="+tmpHidTabId+"&id="+id,
			 type:'post',
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){	
					 parent.layer.closeAll();
					 location.reload();
				 }else{
					 layer.alert(data.msg);
				 }
			 },
			 error:function(){
				 layer.alert("删除属性值失败，请联系客服处理");
			 }
		 });
	});
}
</script>
</body>
</html>
