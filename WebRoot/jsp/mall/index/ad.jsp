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
<section class="content-wrapper">
	<section class="content">
		<div class="list-content">
			<c:choose>
				<c:when test="${dataList==null}">
					<div class="row">
						<div class="col-md-12 list-btns">
							<button type="button" onclick="init()">初始化广告位</button>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="row content-container">
						<div class="col-md-12 container-right active">
							<table id="floorTable" class="table table-hover myClass">
								<thead>
									<tr>
										<th width="10%">编号</th>
										<th width="10%">字典分类</th>
										<th width="10%">页面链接</th>
										<th width="50%">图片链接</th>
										<th width="10%">描述</th>
										<th width="10%">操作</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${dataList}" var="item">
										<tr>
											<td>广告${item.id}</td>
											<td>${item.dictId}</td>
											<td>${item.href}</td>
											<td><img style="width:62px;height:62px;"  src="${item.picPath}"/></td>
											<td>${item.description}</td>
											<td><a href='javascript:void(0);' class='table-btns' onclick='toEdit(${item.id})' >编辑</a></td>
										<tr>
									</c:forEach>
								</tbody>
							</table>
							<div class="pagination-nav">
								<ul id="pagination" class="pagination">
								</ul>
							</div>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</div>	
	</section>
</section>
	
<%@include file="../../resourceScript.jsp"%>
<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
<script type="text/javascript">

function init(){
	 $.ajax({
		 url:"${wmsUrl}/admin/mall/indexMng/init.shtml?module=module_00006&pageType=0",
		 type:'post',
		 contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 success:function(data){
			 if(data.success){	
				 layer.alert("插入成功");
				 window.location.reload();
			 }else{
				 parent.reloadTable();
				 layer.alert(data.msg);
			 }
		 },
		 error:function(){
			 layer.alert("提交失败，请联系客服处理");
		 }
	 });
}

function toEdit(id){
	var index = layer.open({
		  title:"广告编辑",		
		  type: 2,
		  content: '${wmsUrl}/admin/mall/indexMng/toEditContent.shtml?id='+id+'&pageType=0&bussinessType=ad&key='+id,
		  maxmin: false
		});
		layer.full(index);
}

</script>
</body>
</html>
