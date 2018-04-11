<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<section class="content-wrapper">
	<section class="content-header">
	      <ol class="breadcrumb">
	        <li><a href="javascript:void(0);">首页</a></li>
	        <li>商品管理</li>
	        <li class="active">分类管理</li>
	      </ol>
    </section>
    <section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box box-warning">
					<div class="box-body">
					      <div class="tree well">
							<ul>
								<li>
									<button type="button" onclick="toAdd(-1,1)" class="btn btn-danger"><i class="fa fa-plus"></i></button>
								</li>
								<c:forEach var="first" items="${firsts}">
								<li>
									<span><i class="fa fa-folder"></i> ${first.name}</span>
									<a href="#" onclick="toAdd('${first.firstId}',2,'${first.name}')"><i class="fa fa-plus"></i></a>
			                		<a href="#" onclick="toEdit('${first.firstId}',1,'${first.name}')"><i class="fa fa-pencil"></i></a>
			                		<a href="#" onclick="del('${first.firstId}',1)"><i class="fa fa-trash-o"></i></a>
									<ul>
										<c:forEach var="second" items="${first.seconds}">
											<li style="display: none;">
							                	<span class="tree-font"><i class="fa fa-folder"></i>
							                		${second.name}
             										<a href="#" onclick="toAdd('${second.secondId}',3,'${second.name}')"><i class="fa fa-plus"></i></a>
							                		<a href="#" onclick="toEdit('${second.secondId}',2,'${second.name}')"><i class="fa fa-pencil"></i></a>
							                		<a href="#" onclick="del('${second.secondId}',2)"><i class="fa fa-trash-o"></i></a>
							                	</span>
							                	<ul>
													<c:forEach var="third" items="${second.thirds}">
														<li style="display: none;">
										                	<span class="tree-font">
										                		${third.name}
										                		<a href="#" onclick="toEdit('${third.thirdId}',3,'${third.name}')"><i class="fa fa-pencil"></i></a>
										                		<a href="#" onclick="del('${third.thirdId}',3)"><i class="fa fa-trash-o"></i></a>
										                	</span>
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
				</div>
			</div>
		</div>
	</section>
</section>

 <!-- Bootstrap 3.3.6 -->
<%@include file="../../resource.jsp" %>
<script src="${wmsUrl}/js/mytree.js"></script>
<script type="text/javascript">

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
		  area: ['320px', '195px'],
		  maxmin: true
		});
		layer.full(index);
}

function toEdit(id,catalog,name){
	if(id == 0 || id == null){
		layer.alert("信息不全，请联系技术人员！");
		return;
	}
	
	var url = encodeURI(encodeURI('${wmsUrl}/admin/goods/catalogMng/toEdit.shtml?id='+id+"&type="+catalog+"&name="+name));

	
	var index = layer.open({
		  title : "编辑分类",
		  type: 2,
		  content: url,
		  area: ['320px', '195px'],
		  maxmin: true
		});
		layer.full(index);
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

</script>
