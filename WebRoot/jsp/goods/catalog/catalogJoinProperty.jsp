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
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<link rel="stylesheet" href="${wmsUrl}/css/component/broadcast.css">
<%@include file="../../resourceLink.jsp"%>
</head>
<body>
	<section class="content-iframe content">
		<form class="form-horizontal" role="form" id="itemForm">
			<div class="title">
	       		<h1>分类信息</h1>
	       	</div>
	       	<c:choose>
			   <c:when test="${catalog == 1}">
          	  		<div class="list-item">
						<div class="col-sm-3 item-left">一级类目</div>
						<div class="col-sm-9 item-right">
							<input type="hidden" class="form-control" name="firstId" readonly value="${catalogInfo.firstId}">
							<input type="text" class="form-control" name="firstName" readonly value="${catalogInfo.name}">
						</div>
					</div>
			   </c:when>
			   <c:when test="${catalog == 2}">
          	  		<div class="list-item">
						<div class="col-sm-3 item-left">一级类目</div>
						<div class="col-sm-9 item-right">
							<input type="hidden" class="form-control" name="firstId" readonly value="${catalogInfo.firstId}">
							<input type="text" class="form-control" name="firstName" readonly value="${catalogInfo.name}">
						</div>
					</div>
					<div class="list-item">
						<div class="col-sm-3 item-left">二级类目</div>
						<div class="col-sm-9 item-right">
		                 	<input type="hidden" class="form-control" name="secondId" readonly value="${catalogInfo.seconds[0].secondId}">
		                 	<input type="text" class="form-control" name="secondName" readonly value="${catalogInfo.seconds[0].name}">
			            </div>
					</div>
			   </c:when>
			   <c:otherwise>
              	  	<div class="list-item">
						<div class="col-sm-3 item-left">一级类目</div>
						<div class="col-sm-9 item-right">
							<input type="hidden" class="form-control" name="firstId" readonly value="${catalogInfo.firstId}">
							<input type="text" class="form-control" name="firstName" readonly value="${catalogInfo.name}">
						</div>
					</div>
					<div class="list-item">
						<div class="col-sm-3 item-left">二级类目</div>
						<div class="col-sm-9 item-right">
		                 	<input type="hidden" class="form-control" name="secondId" readonly value="${catalogInfo.seconds[0].secondId}">
		                 	<input type="text" class="form-control" name="secondName" readonly value="${catalogInfo.seconds[0].name}">
			            </div>
					</div>
					<div class="list-item">
						<div class="col-sm-3 item-left">三级类目</div>
						<div class="col-sm-9 item-right">
		                 	<input type="hidden" class="form-control" name="thirdId" readonly value="${catalogInfo.seconds[0].thirds[0].thirdId}">
		                 	<input type="text" class="form-control" name="thirdName" readonly value="${catalogInfo.seconds[0].thirds[0].name}">
			            </div>
					</div>
			   </c:otherwise>
			</c:choose> 
			<div class="list-item">
				<div class="col-sm-3 item-left">分类图标</div>
				<div class="col-sm-9 item-right addContent">
					<c:choose>
					   <c:when test="${tagPath != null && tagPath != ''}">
	           	  			<div class="item-img choose" id="content" >
								<c:choose>
									<c:when test="${tagPath.indexOf('http') != -1}">
										<img src="${tagPath}">
										<div class="bgColor"><i class="fa fa-search fa-fw"></i></div>
										<input value="${tagPath}" type="hidden" name="tagPath" id="tagPath">
									</c:when>
									<c:otherwise>
										<img src="${wmsUrl}/img/default_img.jpg">
										<div class="bgColor"><i class="fa fa-search fa-fw"></i></div>
										<input value="${wmsUrl}/img/default_img.jpg" type="hidden" name="tagPath" id="tagPath">
									</c:otherwise>
								</c:choose>
							</div>
					   </c:when>
					   <c:otherwise>
	               	  		<div class="item-img" id="content" >
								+
								<input type="file" id="pic" name="pic" />
								<input type="hidden" class="form-control" name="tagPath" id="tagPath"> 
							</div>
					   </c:otherwise>
					</c:choose> 
				</div>
			</div>
			<div class="scrollImg-content broadcast"></div>
			<div class="title">
				<c:choose>
				   <c:when test="${propertyType == 1}">
				   		<h1>系列属性列表</h1>
				   </c:when>
				   <c:otherwise>
				   		<h1>导购属性列表</h1>
				   </c:otherwise>
				</c:choose>
	       	</div>
			<div class="row">
				<div class="col-md-12 list-btns">
					<button type="button" onclick="joinProperty(${propertyType})">关联属性信息</button>
					<input type="hidden" id="categoryId" name="categoryId" value="${id}" readonly>
					<input type="hidden" id="categoryType" name="categoryType" value="${catalog}" readonly>
					<input type="hidden" id="propertyId" readonly>
				</div>
			</div>
	       	<div class="list-content">
				<div class="col-md-12">
					<table id="staffTable" class="table table-hover myClass">
						<thead>
							<tr>
								<th>属性ID</th>
								<th>属性名称</th>
								<th>属性类型</th>
								<th>显示顺序</th>
								<th>更新时间</th>
								<th>操作人</th>
								<th>操作</th>
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
		</form>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script src="${wmsUrl}/js/component/broadcast.js"></script>
	<script type="text/javascript">
	function setPicImgListData() {
		var valArr = new Array;
		var tmpPicPath = "";
		tmpPicPath = $("#tagPath").val();
		if (tmpPicPath != null && tmpPicPath != "") {
			valArr.push(tmpPicPath);
		}
		if (valArr != undefined && valArr.length > 0) {
			var data = {
		        imgList: valArr,
		        imgWidth: 500,
		        imgHeight: 500,
		        activeIndex: 0,
		        host: "${wmsUrl}"
		    };
		    setImgScroll('broadcast',data);
		} else {
			layer.alert("请先上传图片！");
		}
	}
	//图片放大
	$('.item-right').on('click','.bgColor i.fa-search',function(){
		setPicImgListData();
	});
	/**
	 * 初始化分页信息
	 */
	var options = {
		queryForm : ".query",
		url :  "${wmsUrl}/admin/goods/catalogMng/showJoinPropertyList.shtml?propertyType="+"${propertyType}",
		numPerPage:"10",
		currentPage:"",
		index:"1",
		callback:rebuildTable
	}
	
	$(function(){
		$(".pagination-nav").pagination(options);
	})
	
	/**
	 * 重构table
	 */
	function rebuildTable(data){
		$("#staffTable tbody").html("");

		if (data == null || data.length == 0) {
			return;
		}

		var str = "";
		var list = data.obj;
		
		if (list == null || list.length == 0) {
			str = "<tr style='text-align:center'><td colspan=6><h5>没有查到数据</h5></td></tr>";
			$("#staffTable tbody").html(str);
			return;
		}
		
		for (var i = 0; i < list.length; i++) {
			str += "<tr>";
			str += "<td>" + list[i].propertyId;
			str += "</td><td>" + list[i].name;
			str += "</td><td>" + list[i].sort;
			str += "</td><td>" + (list[i].updateTime == null ? "" : list[i].updateTime);
			str += "</td><td>" + (list[i].opt == null ? "" : list[i].opt);
			str += "</td><td>";
			str += "<a href='javascript:void(0);' onclick='toChangePropertySort("+list[i].id+",-1)'>上移属性</a>"
			str += "<a href='javascript:void(0);' onclick='toChangePropertySort("+list[i].id+",1)'>下移属性</a>"
			str += "<a href='javascript:void(0);' onclick='unJoinProperty("+list[i].id+")'>移除属性</a>"
			str += "</td></tr>";
		}
		$("#staffTable tbody").html(str);
	}

	function reloadTable(){
		$.page.loadData(options);
	}

	function joinProperty(propertyType){
		var index = layer.open({
		  title : "关联属性信息",
		  type: 2,
		  content: "${wmsUrl}/admin/goods/catalogMng/pageForSearch.shtml?propertyType="+propertyType,
		  area: ['70%', '70%'],
		  maxmin: false
		});
	}
	
	function selectAndJoinProperty(){
 		var formData = {};
 		formData["categoryId"]=$("#categoryId").val();
 		formData["categoryType"]=$("#categoryType").val();
 		formData["propertyId"]=$("#propertyId").val();
 		$.ajax({
			url:"${wmsUrl}/admin/goods/catalogMng/categoryJoinProperty.shtml?propertyType="+"${propertyType}",
			type:'post',
			data:JSON.stringify(formData),
			contentType: "application/json; charset=utf-8",
			dataType:'json',
			success:function(data){
				if(data.success){
					layer.msg('属性关联成功',{icon:1,time:2000},function(){reloadTable();});
				}else{
					layer.alert(data.msg);
				}
			},
			error:function(){
				layer.alert("提交失败，请联系客服处理");
			}
		});
	}
	
	function unJoinProperty(id){
 		$.ajax({
			url:"${wmsUrl}/admin/goods/catalogMng/categoryJoinProperty.shtml?propertyType="+"${propertyType}"+"&id="+id,
			type:'post',
			contentType: "application/json; charset=utf-8",
			dataType:'json',
			success:function(data){
				if(data.success){
					layer.msg('移除属性成功',{icon:1,time:2000},function(){reloadTable();});
				}else{
					layer.alert(data.msg);
				}
			},
			error:function(){
				layer.alert("提交失败，请联系客服处理");
			}
		});
	}
	
	function toChangePropertySort(id,sort){
		if(id == 0 || id == null){
			layer.alert("信息不全，请联系技术人员！");
			return;
		}
		
		$.ajax({
			 url:"${wmsUrl}/admin/goods/catalogMng/changeCategoryJoinPropertySort.shtml?id="+id+"&propertyType="+"${propertyType}"+"&sort="+sort,
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
	</script>
</body>
</html>
