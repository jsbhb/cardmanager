<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

 <!-- Bootstrap 3.3.6 -->
<%@include file="../../resource.jsp" %>


<section class="content-wrapper">
	<section class="content-header">
	      <h1><i class="fa fa-street-view"></i>功能管理</h1>
	      <ol class="breadcrumb">
	        <li><a href="javascript:void(0);"><i class="fa fa-dashboard"></i> 首页</a></li>
	        <li class="active">功能管理</li>
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
									<button type="button" onclick="showAddFunc(-1)" class="btn btn-danger"><i class="fa fa-plus"></i></button>
								</li>
								<c:forEach var="item" items="${menuList}">
								<li>
									<span><i class="fa fa-folder"></i> ${item.name}</span>
									<a href="javascript:void(0);" onclick="showAddFunc(${item.funcId})"><i class="fa fa-plus"></i></a>
									<a href="javascript:void(0);" onclick="showEditFunc(${item.funcId})"><i class="fa fa-pencil"></i></a>
			                		<a href="javascript:void(0);" onclick="deleteFunc(${item.funcId})"><i class="fa fa-trash-o"></i></a>
									<ul>
										<c:forEach var="node" items="${item.children}">
											<li style="display: none;">
							                	<span class="tree-font">
							                		${node.name}(${node.url})
							                		<a href="javascript:void(0);" onclick="showEditFunc(${node.funcId})"><i class="fa fa-pencil"></i></a>
							                		<a href="javascript:void(0);" onclick="deleteFunc(${node.funcId})"><i class="fa fa-trash-o"></i></a>
							                	</span>
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
<%@ include file="../../footer.jsp"%>
<script src="${wmsUrl}/js/mytree.js"></script>
<script type="text/javascript">

function showAddFunc(id){
	if(id == 0 || id == null){
		layer.alert("信息不全，请联系技术人员！");
		return;
	}
	
	var index = layer.open({
		  type: 2,
		  content: '${wmsUrl}/admin/system/funcMng/toAdd.shtml?parent_id='+id,
		  area: ['320px', '195px'],
		  maxmin: true
		});
		layer.full(index);
}

function showEditFunc(id){
	if(id == 0 || id == null){
		layer.alert("信息不全，请联系技术人员！");
		return;
	}
	
	var index = layer.open({
		  type: 2,
		  content: '${wmsUrl}/admin/system/funcMng/toEdit.shtml?func_id='+id,
		  area: ['320px', '195px'],
		  maxmin: true
		});
		layer.full(index);
}


function deleteFunc(id){
	
	layer.confirm('确定要删除该功能吗？', {
		  btn: ['确认删除','取消'] //按钮
		}, function(){
			$.ajax({
				 url:"${wmsUrl}/admin/system/funcMng/deleteFunc.shtml?id="+id,
				 type:'post',
				 dataType:'json',
				 success:function(data){
					 if(data.success){	
						 layer.alert("删除成功");
						 location.reload();
					 }else{
						 layer.alert(data.errInfo);
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
