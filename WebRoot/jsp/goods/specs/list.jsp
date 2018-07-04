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
<link rel="stylesheet" href="${wmsUrl}/adminLTE/css/style.css">
<%@include file="../../resourceLink.jsp"%>
</head>
<body>
<section class="content-wrapper query">
	<section class="content-header">
	      <ol class="breadcrumb">
	        <li>商品管理</li>
	        <li class="active">规格管理</li>
	      </ol>
    </section>	
	<section class="content">
		<div id="image" style="width:100%;height:100%;display: none;background:rgba(0,0,0,0.5);margin-left:-25px;margin-top:-62px;">
			<img alt="loading..." src="${wmsUrl}/img/loader.gif" style="position:fixed;top:50%;left:50%;margin-left:-16px;margin-top:-16px;" />
		</div>
		<div class="list-content">
			<div class="row">
				<div class="col-md-12 list-btns">
					<button type="button" onclick="toAdd(-1,'')">新增规格分类</button>
				</div>
			</div>
			<div class="treeList">
				<ul style="margin-left:0px">
					<c:forEach var="spe" items="${specs}">
					<li>
						<span><i class="fa fa-plus fa-fw"></i> ${spe.name}</span>
						<a href="javascript:void(0);" class='table-btns' onclick="toAdd('${spe.id}','${spe.name}')">新增</a>
                		<a href="javascript:void(0);" class='table-btns' onclick="toEditSpecs('${spe.id}','${spe.name}')">修改</a>
						<ul style="margin-left:30px">
							<c:forEach var="speValue" items="${spe.values}">
								<li style="display:none">
				                	<span><i class="fa fa-minus fa-fw"></i>${speValue.value}</span>
			                		<a href="javascript:void(0);" class='table-btns' onclick="toEditSpecsValue('${speValue.id}','${speValue.value}')">修改</a>
								</li>
							</c:forEach>
						</ul>
					</li>
					</c:forEach>
				</ul>
			</div>
		</div>	
	</section>
</section>
	
<%@include file="../../resourceScript.jsp"%>
<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
<script type="text/javascript">

$(function(){
    $('.treeList li:has(ul)').addClass('parent_li').find(' > span');
    $('.treeList li.parent_li > span').on('click', function (e) {
        var children = $(this).parent('li.parent_li').find(' > ul > li');
        if (children.is(":visible")) {
            children.hide();
            $(this).find(' > i').addClass('fa-plus').removeClass('fa-minus');
        } else {
            children.show();
            $(this).find(' > i').addClass('fa-minus').removeClass('fa-plus');
        }
        e.stopPropagation();
    });
});

function toAdd(typeId,typeName){
	if(typeId == 0 || typeId == null){
		layer.alert("信息不全，请联系技术人员！");
		return;
	}
	
	var tilte;
	
	if(typeId == -1){
		title = "新增规格分类";
	}else {
		title="新增规格值";
	}
	
	var url = encodeURI(encodeURI('${wmsUrl}/admin/goods/specsMng/toAdd.shtml?typeId='+typeId+"&typeName="+typeName));
	
	var index = layer.open({
	  title:title,
	  type: 2,
	  content: url,
	  area: ['60%', '45%'],
	  maxmin: false
	});
}

function toEditSpecs(id,name){
	if(id == 0 || id == null){
		layer.alert("信息不全，请联系技术人员！");
		return;
	}
	
	var url = encodeURI(encodeURI('${wmsUrl}/admin/goods/specsMng/toEditSpecs.shtml?id='+id+"&name="+name));

	var tilte="编辑规格分类";
	
	var index = layer.open({
	  title : title,
	  type: 2,
	  content: url,
	  area: ['60%', '40%'],
	  maxmin: false
	});
}

function toEditSpecsValue(id,name){
	if(id == 0 || id == null){
		layer.alert("信息不全，请联系技术人员！");
		return;
	}
	
	var url = encodeURI(encodeURI('${wmsUrl}/admin/goods/specsMng/toEditSpecsValue.shtml?id='+id+"&name="+name));

	var tilte="编辑规格值";
	
	var index = layer.open({
	  title : title,
	  type: 2,
	  content: url,
	  area: ['60%', '40%'],
	  maxmin: false
	});
}
</script>
</body>
</html>
