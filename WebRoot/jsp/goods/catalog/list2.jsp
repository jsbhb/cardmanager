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
		<div id="image" style="width:100%;height:100%;display: none;background:rgba(0,0,0,0.5);margin-left:-25px;margin-top:-62px;">
			<img alt="loading..." src="${wmsUrl}/img/loader.gif" style="position:fixed;top:50%;left:50%;margin-left:-16px;margin-top:-16px;" />
		</div>
		<div class=list-content>
			<div class="row">
				<div class="col-md-12 list-btns">
					<button type="button" onclick = "toAdd(-1,1)">新增一级分类</button>
					<button type="button" onclick = "publish()">发布分类</button>
				</div>
			</div>
			<div class="treeList">
				<ul style="margin-left:0px">
					<c:forEach var="first" items="${firsts}">
					<li>
						<span><i class="fa fa-plus fa-fw"></i> ${first.name}</span>
						<a href="javascript:void(0);" class='table-btns' onclick="toAdd('${first.firstId}',2,'${first.name}')">新增</a>
                		<a href="javascript:void(0);" class='table-btns' onclick="toEdit('${first.firstId}',1,'${first.name}')">修改</a>
                		<a href="javascript:void(0);" class='table-btns' onclick="del('${first.firstId}',1)">删除</a>
						<ul style="margin-left:30px">
							<c:forEach var="second" items="${first.seconds}">
								<li style="display:none">
				                	<span><i class="fa fa-minus fa-fw"></i>${second.name}</span>
				                	<a href="javascript:void(0);" class='table-btns' onclick="toAdd('${second.secondId}',3,'${second.name}')">新增</a>
			                		<a href="javascript:void(0);" class='table-btns' onclick="toEdit('${second.secondId}',2,'${second.name}')">修改</a>
			                		<a href="javascript:void(0);" class='table-btns' onclick="del('${second.secondId}',2)">删除</a>
				                	<ul style="margin-left:30px">
										<c:forEach var="third" items="${second.thirds}">
											<li>
							                	<span><i class="fa fa-minus fa-fw"></i>${third.name}</span>
							                	<a href="javascript:void(0);" class='table-btns' onclick="toEdit('${third.thirdId}',3,'${third.name}')">修改</a>
							                	<a href="javascript:void(0);" class='table-btns' onclick="del('${third.thirdId}',3)">删除</a>
											</li>
										</c:forEach>
									</ul>
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
	  area: ['60%', '45%'],
	  maxmin: false
	});
}

function toEdit(id,catalog,name){
	if(id == 0 || id == null){
		layer.alert("信息不全，请联系技术人员！");
		return;
	}
	
	var url = encodeURI(encodeURI('${wmsUrl}/admin/goods/catalogMng/toEdit.shtml?id='+id+"&type="+catalog+"&name="+name));

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
	  area: ['60%', '40%'],
	  maxmin: false
	});
}


function del(id,catalog){
	layer.confirm('确定要删除该功能吗？', {
		  btn: ['确认删除','取消'] //按钮
		}, function(){
			$.ajax({
				 url:"${wmsUrl}/admin/goods/catalogMng/delete.shtml?id="+id+"&type="+catalog,
				 type:'post',
				 dataType:'json',
				 success:function(data){
					 if(data.success){	
						 layer.alert("删除成功");
						 location.reload();
					 }else{
						 layer.alert(data.msg);
					 }
				 },
				 error:function(){
					 layer.alert("系统出现问题啦，快叫技术人员处理");
				 }
			 });
		}, function(){
		  layer.close();
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
