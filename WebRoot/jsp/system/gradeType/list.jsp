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

</head>
<body>

<section class="content-wrapper">
	<section class="content-header">
      <ol class="breadcrumb">
        <li><a href="javascript:void(0);">系统管理</a></li>
        <li class="active">分级类型管理</li>
      </ol>
	</section>
	<section class="content" style="align:center">
		<div class="treeList">
		<ul>
			<c:forEach var="menu" items="${gradeList}">
				<c:set var="menu" value="${menu}" scope="request" />
				<%@include file="recursive.jsp"%>  
			</c:forEach>
		</ul>
		</div>
	</section>
</section>
	
<%@include file="../../resource.jsp"%>
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
				 url:"${wmsUrl}/admin/system/gradeType/delete.shtml?id="+id,
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



function toAdd(parentId,id){
	var index = layer.open({
		  title:"编辑分类",		
		  type: 2,
		  content: '${wmsUrl}/admin/system/gradeType/toAdd.shtml?parentId='+parentId+"&id="+id+"&type=0",
		  area: ['320px', '195px'],
		  maxmin: true
		});
		layer.full(index);
}


function toEdit(parentId,id){
	var index = layer.open({
		  title:"编辑分类",		
		  type: 2,
		  content: '${wmsUrl}/admin/system/gradeType/toAdd.shtml?parentId='+parentId+"&id="+id+"&type=1",
		  area: ['320px', '195px'],
		  maxmin: true
		});
		layer.full(index);
}
	
</script>
</body>
</html>
