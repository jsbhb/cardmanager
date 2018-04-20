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
        <li><a href="javascript:void(0);">系统管理</a></li>
        <li class="active">角色管理</li>
      </ol>
	</section>
	<section class="content" style="align:center">
		<div class=list-content>
			<div class="row">
				<div class="col-md-12 list-btns">
					<button type="button" onclick = "toAdd(0,0)">新增一级角色</button>
				</div>
			</div>
			<div class="treeList">
				<ul>
					<c:forEach var="menu" items="${roleTree}">
						<c:set var="menu" value="${menu}" scope="request" />
						<%@include file="recursive.jsp"%>  
					</c:forEach>
				</ul>
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




function remove(id){
	if(id == 0 || id == null){
		layer.alert("信息不全，请联系技术人员！");
		return;
	}
	
	layer.confirm('确定要删除该功能吗？', {
		  btn: ['确认删除','取消'] //按钮
		}, function(){
			$.ajax({
				 url:"${wmsUrl}/admin/system/roleMng/delete.shtml?id="+id,
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



function toAdd(id,parentId){
	var index = layer.open({
		  title:"新增分类",		
		  type: 2,
		  content: '${wmsUrl}/admin/system/roleMng/toAdd.shtml?parentId='+parentId+"&id="+id+"&type=0",
		  area: ['320px', '195px'],
		  maxmin: true
		});
		layer.full(index);
}


function toEdit(id,parentId){
	var index = layer.open({
		  title:"编辑分类",		
		  type: 2,
		  content: '${wmsUrl}/admin/system/roleMng/toEdit.shtml?roleId='+id,
		  area: ['320px', '195px'],
		  maxmin: true
		});
		layer.full(index);
}
	
</script>
</body>
</html>
