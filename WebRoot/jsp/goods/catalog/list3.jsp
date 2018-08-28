<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
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

<section class="content-wrapper">
	<section class="content-header">
      <ol class="breadcrumb">
        <li><a href="javascript:void(0);">商品管理</a></li>
        <li class="active">分类管理</li>
      </ol>
	</section>
	<section class="content" style="align:center">
		<div class="list-content">
			<div class="row">
				<div class="col-md-12 list-btns">
					<button type="button" onclick="toAdd(-1,1)">新增一级分类</button>
					<button type="button" onclick="publish()">发布分类</button>
<!-- 					<button type="button" onclick="">全部展开</button> -->
<!-- 					<button type="button" onclick="">全部收起</button> -->
				</div> 
			</div> 
			<div class="row">
				<div class="col-md-12">
					<table id="baseTable" class="table table-hover myClass">
						<thead>
							<tr>
								<th width="5%"><input style="float:none;margin: 4px 0 0;" type="checkbox"></th>
								<th width="15%">分类名称</th>
								<th width="15%">分类图标</th>
								<th width="10%">分类别称</th>
								<th width="10%">分类顺序</th>
								<th width="10%">分类状态</th>
								<th width="15%">分类维护</th>
								<th width="20%">操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="first" items="${firsts}">
								<tr class="first-rows" data-id="${first.firstId}">
									<td><input type="checkbox"></td>
									<td><i class="fa fa-fw fa-plus"></i>${first.name}</td>
									<td>
									<c:choose>
										<c:when test="${first.tagPath.indexOf('http') != -1}">
											<img style="width:50px;height:50px;" src="${first.tagPath}"/>
										</c:when>
										<c:otherwise>
											<img style="width:50px;height:50px;" src="${webUrl}/${first.tagPath}"/>
										</c:otherwise>
									</c:choose>
									</td>
			                		<td>${first.accessPath}</td>
			                		<td>${first.sort}</td>
									<td>
									<c:choose>
										<c:when test="${first.status == 0}">
											隐藏
										</c:when>
										<c:otherwise>
											显示
										</c:otherwise>
									</c:choose>
									</td>
									<td>
										<a href="javascript:void(0);" class='table-btns' onclick="toAdd('${first.firstId}',2,'${first.name}')">新增子分类</a>
				                		<a href="javascript:void(0);" class='table-btns' onclick="toEdit('${first.firstId}',1,'${first.name}','${first.accessPath}','${first.sort}','${first.tagPath}')">修改分类</a>
<%-- 				                		<a href="javascript:void(0);" class='table-btns' onclick="del('${first.firstId}',1)">删除分类</a> --%>
			                		</td>
									<td>
										<a href="javascript:void(0);" onclick="toChangeSort('${first.firstId}',1,-1)">上移分类</a>
										<a href="javascript:void(0);" onclick="toChangeSort('${first.firstId}',1,1)">下移分类</a>
										<c:choose>
											<c:when test="${first.status == 1}">
												<a href="javascript:void(0);" onclick="toChangeStatus('${first.firstId}',1,0)">隐藏分类</a>
											</c:when>
											<c:otherwise>
												<a href="javascript:void(0);" onclick="toChangeStatus('${first.firstId}',1,1)">显示分类</a>
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
								<c:forEach var="second" items="${first.seconds}">
									<tr class="second-rows" data-id="${second.secondId}" parentId="${first.firstId}">
										<td><input type="checkbox"></td>
										<td><i class="fa fa-fw fa-plus"></i>${second.name}</td>
										<td></td>
			                			<td>${second.accessPath}</td>
			                			<td>${second.sort}</td>
										<td>
										<c:choose>
											<c:when test="${second.status == 0}">
												隐藏
											</c:when>
											<c:otherwise>
												显示
											</c:otherwise>
										</c:choose>
										</td>
										<td>
											<a href="javascript:void(0);" class='table-btns' onclick="toAdd('${second.secondId}',3,'${second.name}')">新增子分类</a>
					                		<a href="javascript:void(0);" class='table-btns' onclick="toEdit('${second.secondId}',2,'${second.name}','${second.accessPath}','${second.sort}','')">修改分类</a>
<%-- 					                		<a href="javascript:void(0);" class='table-btns' onclick="del('${second.secondId}',2)">删除分类</a> --%>
										</td>
										<td>
											<a href="javascript:void(0);" onclick="toChangeSort('${second.secondId}',2,-1)">上移分类</a>
											<a href="javascript:void(0);" onclick="toChangeSort('${second.secondId}',2,1)">下移分类</a>
											<c:choose>
												<c:when test="${second.status == 1}">
													<a href="javascript:void(0);" onclick="toChangeStatus('${second.secondId}',2,0)">隐藏分类</a>
												</c:when>
												<c:otherwise>
													<a href="javascript:void(0);" onclick="toChangeStatus('${second.secondId}',2,1)">显示分类</a>
												</c:otherwise>
											</c:choose>
										</td>
									</tr>
									<c:forEach var="third" items="${second.thirds}">
										<tr class="thrid-rows" data-id="${third.thirdId}" parentId="${second.secondId}">
											<td><input type="checkbox"></td>
											<td>${third.name}</td>
											<td></td>
			                				<td>${third.accessPath}</td>
			                				<td>${third.sort}</td>
											<td>
											<c:choose>
												<c:when test="${third.status == 0}">
													隐藏
												</c:when>
												<c:otherwise>
													显示
												</c:otherwise>
											</c:choose>
											</td>
											<td>
												<a href="javascript:void(0);" class='table-btns' onclick="toEdit('${third.thirdId}',3,'${third.name}','${third.accessPath}','${third.sort}','')">修改分类</a>
<%-- 							                	<a href="javascript:void(0);" class='table-btns' onclick="del('${third.thirdId}',3)">删除分类</a> --%>
											</td>
											<td>
												<a href="javascript:void(0);" onclick="toChangeSort('${third.thirdId}',3,-1)">上移分类</a>
												<a href="javascript:void(0);" onclick="toChangeSort('${third.thirdId}',3,1)">下移分类</a>
												<c:choose>
													<c:when test="${third.status == 1}">
														<a href="javascript:void(0);" onclick="toChangeStatus('${third.thirdId}',3,0)">隐藏分类</a>
													</c:when>
													<c:otherwise>
														<a href="javascript:void(0);" onclick="toChangeStatus('${third.thirdId}',3,1)">显示分类</a>
													</c:otherwise>
												</c:choose>
												<c:choose>
													<c:when test="${third.isPopular == 1}">
														<a href="javascript:void(0);" onclick="toChangePopular('${third.thirdId}',0)">取消高亮分类</a>
													</c:when>
													<c:otherwise>
														<a href="javascript:void(0);" onclick="toChangePopular('${third.thirdId}',1)">设置高亮分类</a>
													</c:otherwise>
												</c:choose>
											</td>
										</tr>
									</c:forEach>
								</c:forEach>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</section>
</section>
	
<%@include file="../../resourceScript.jsp"%>
<script src="${wmsUrl}/js/pagination.js"></script>
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

function toAdd(id,catalog,name){
	if(id == 0 || id == null){
		layer.alert("信息不全，请联系技术人员！");
		return;
	}
	
	var tilte;
	
	if(catalog == 1){
		title = "新增一级分类";
	}else if(catalog==2){
		title="新增二级分类";
	}else{
		title ="新增三级分类";
	}
	
	var url = encodeURI(encodeURI('${wmsUrl}/admin/goods/catalogMng/toAdd.shtml?parentId='+id+"&type="+catalog+"&name="+name));
	
	var index = layer.open({
	  title:title,
	  type: 2,
	  content: url,
	  area: ['70%', '60%'],
	  maxmin: false
	});
}

function toEdit(id,catalog,name,accessPath,sort,tagPath){
	if(id == 0 || id == null){
		layer.alert("信息不全，请联系技术人员！");
		return;
	}
	
	var url = encodeURI(encodeURI('${wmsUrl}/admin/goods/catalogMng/toEdit.shtml?id='+id+"&type="+catalog+"&name="+name+"&accessPath="+accessPath+"&sort="+sort+"&tagPath="+tagPath));

	var tilte;
	
	if(catalog == 1){
		title = "编辑一级分类";
	}else if(catalog==2){
		title="编辑二级分类";
	}else{
		title ="编辑三级分类";
	}
	
	var index = layer.open({
	  title : title,
	  type: 2,
	  content: url,
	  area: ['70%', '60%'],
	  maxmin: false
	});
}

function toChangeSort(id,catalog,sort){
	if(id == 0 || id == null){
		layer.alert("信息不全，请联系技术人员！");
		return;
	}
	
	$.ajax({
		 url:"${wmsUrl}/admin/goods/catalogMng/changeCategorySort.shtml?id="+id+"&catelog="+catalog+"&sort="+sort,
		 type:'post',
		 contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 success:function(data){
			 if(data.success){
				 location.reload();
			 }else{
				 layer.alert(data.msg);
			 }
		 },
		 error:function(){
			 layer.alert("提交失败，请联系客服处理");
		 }
	});
}

function toChangeStatus(id,catalog,status){
	if(id == 0 || id == null){
		layer.alert("信息不全，请联系技术人员！");
		return;
	}
	
	$.ajax({
		 url:"${wmsUrl}/admin/goods/catalogMng/changeCategoryStatus.shtml?id="+id+"&catelog="+catalog+"&status="+status,
		 type:'post',
		 contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 success:function(data){
			 if(data.success){
				 location.reload();
			 }else{
				 layer.alert(data.msg);
			 }
		 },
		 error:function(){
			 layer.alert("提交失败，请联系客服处理");
		 }
	});
}


function toChangePopular(id,popular){
	if(id == 0 || id == null){
		layer.alert("信息不全，请联系技术人员！");
		return;
	}
	
	$.ajax({
		 url:"${wmsUrl}/admin/goods/catalogMng/changeCategoryPopular.shtml?id="+id+"&popular="+popular,
		 type:'post',
		 contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 success:function(data){
			 if(data.success){
				 location.reload();
			 }else{
				 layer.alert(data.msg);
			 }
		 },
		 error:function(){
			 layer.alert("提交失败，请联系客服处理");
		 }
	});
}

function publish(){
	$.ajax({
		 url:"${wmsUrl}/admin/goods/catalogMng/categoryInfoPublish.shtml",
		 type:'post',
		 dataType:'json',
		 beforeSend : function() {
			$("#image").css({
				display : "block",
				position : "fixed",
				zIndex : 99,
			});
		 },
		 success:function(data){
			 if(data.success){	
				 layer.alert("发布成功");
			 }else{
				 layer.alert(data.msg);
			 }
		 },
		 error:function(){
			 layer.alert("发布分类信息失败，请联系技术人员");
		 },
		 complete : function(data) {
				$("#image").hide();
		 }
	});
}
</script>
</body>
</html>
