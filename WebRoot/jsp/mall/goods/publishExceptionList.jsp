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
	        <li><a href="javascript:void(0);">首页</a></li>
	        <li>商城管理</li>
	        <li class="active">发布商品</li>
	      </ol>
	      <div class="search">
	      	<input type="text" name="goodsName" placeholder="请输入商品名称">
	      	<div class="searchBtn"><i class="fa fa-search fa-fw" id="querybtns"></i></div>
		  </div>
    </section>	
	<section class="content-iframe content">
		<div id="image" style="width:100%;height:100%;display: none;background:rgba(0,0,0,0.5);margin-left:-25px;margin-top:-62px;">
			<img alt="loading..." src="${wmsUrl}/img/loader.gif" style="position:fixed;top:50%;left:50%;margin-left:-16px;margin-top:-16px;" />
		</div>
	
		<div class="list-tabBar">
			<ul>
				<li data-id="first" class="active">已上架未发布</li>
				<li data-id="second">已下架未删除</li>
			</ul>
		</div>
	
		<div class="list-content">
			<input type="hidden" class="form-control" name="hidTabId" id="hidTabId" value="first">
			<c:if test="${prilvl == 1}">
				<div class="row">
					<div class="col-md-12 list-btns">
						<button type="button" onclick = "publish('')">批量发布</button>
						<button type="button" onclick = "unPublish('')">批量删除</button>
					</div>
				</div>
			</c:if>
			<div class="row content-container">
				<div class="col-md-12 container-right active">
					<table id="baseTable" class="table table-hover myClass">
						<thead>
							<tr>
								<!-- 这里增加了字段列，需要调整批量功能取值的列数 -->
								<c:if test="${prilvl == 1}">
								<th width="3%"><input type="checkbox" id="theadInp"></th>
								</c:if>
								<th width="15%">商品图片</th>
								<th width="35%">商品名称</th>
								<th width="15%">商品ID</th>
								<th width="12%">供应商</th>
								<th width="10%">商品类型</th>
								<c:if test="${prilvl == 1}">
								<th width="10%">操作</th>
								</c:if>
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
	url :  "${wmsUrl}/admin/mall/goodsMng/publishList.shtml",
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
		str = "<tr style='text-align:center'><td colspan=10><h5>没有查到数据</h5></td></tr>";
		$("#baseTable tbody").html(str);
		return;
	}

	var prilvl = "${prilvl}";
	for (var i = 0; i < list.length; i++) {
		str += "<tr>";
		if(prilvl == 1){
			str += "<td><input type='checkbox' name='check' value='" + list[i].goodsId + "'/></td>"
		}
		if (list[i].files == null || list[i].files.length == 0) {
			str += "<td><img style='width:50px;height:50px;' src=${wmsUrl}/img/default_img.jpg>";
		} else {
			str += "<td><img style='width:50px;height:50px;' src="+list[i].files[0].path+">";
		}
		str += "</td><td style='text-align:center;'>" + list[i].goodsName;
		str += "</td><td>" + list[i].goodsId;
		str += "</td><td>" + list[i].supplierName;

		var goodsType = list[i].type;
		switch(goodsType){
			case 0:str += "</td><td>跨境商品";break;
			case 2:str += "</td><td>一般贸易商品";break;
			default:str += "</td><td>状态类型："+goodsType;
		}
		if(prilvl == 1){
			var id = $(".list-tabBar .active").attr("data-id");
			str += "</td><td style='text-align:center;'>";
			if(id == "first"){
				str += "<a href='javascript:void(0);'  onclick='publish("+list[i].goodsId+")'>发布</a>";
			}else if(id == "second"){
				str += "<a href='javascript:void(0);'  onclick='unPublish("+list[i].goodsId+")'>删除</a>";
			}
		}
		str += "</td></tr>";
	}

	$("#baseTable tbody").html(str);
}


function publish(id){
	if(id == ""){
		var valArr = new Array; 
		var goodsIds;
	    $("[name='check']:checked").each(function(i){
	 	      valArr[i] = $(this).val(); 
	    }); 
	    if(valArr.length==0){
	    	layer.alert("请选择数据");
	    	return;
	    } 
	    goodsIds = valArr.join(',');//转换为逗号隔开的字符串 
	} else {
		goodsIds = id;
	}
	$.ajax({
		 url:"${wmsUrl}/admin/mall/goodsMng/publish.shtml?goodsIds="+goodsIds,
		 type:'post',
		 contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 success:function(data){
			 if(data.success){	
				 layer.alert("设置成功");
				 reloadTable();
				 $("#theadInp").prop("checked", false);
			 }else{
				 layer.alert(data.msg);
			 }
		 },
		 error:function(){
			 layer.alert("提交失败，请联系客服处理");
		 }
	 });
}
function unPublish(id){
	if(id == ""){
		var valArr = new Array; 
		var goodsIds;
	    $("[name='check']:checked").each(function(i){
	 	       valArr[i] = $(this).val(); 
	    }); 
	    if(valArr.length==0){
	    	layer.alert("请选择数据");
	    	return;
	    } 
	    goodsIds = valArr.join(',');//转换为逗号隔开的字符串 
	} else {
		goodsIds = id;
	}
	$.ajax({
		 url:"${wmsUrl}/admin/mall/goodsMng/unPublish.shtml?goodsIds="+goodsIds,
		 type:'post',
		 contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 success:function(data){
			 if(data.success){	
				 layer.alert("设置成功");
				 reloadTable();
				 $("#theadInp").prop("checked", false);
			 }else{
				 layer.alert(data.msg);
			 }
		 },
		 error:function(){
			 layer.alert("提交失败，请联系客服处理");
		 }
	 });
}

//切换tabBar
$('.list-tabBar').on('click','ul li:not(.active)',function(){
	var tabId = $(this).attr("data-id");
	queryDataByLabelTouch("","",tabId);
});

//点击分类标签及tab标签时做数据查询动作
function queryDataByLabelTouch(typeId,categoryId,tabId){
	$("#hidTabId").val(tabId);
	
	reloadTable();
}

</script>
</body>
</html>
