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
<link rel="stylesheet" href="${wmsUrl}/validator/css/bootstrapValidator.min.css">
<script type="text/javascript" charset="utf-8" src="${wmsUrl}/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${wmsUrl}/ueditor/ueditor.all.min.js"></script>
<script type="text/javascript" charset="utf-8" src="lang/zh-cn/zh-cn.js"></script>
</head>

<body>
	<section class="content-header">
	      <ol class="breadcrumb">
	        <li><a href="javascript:void(0);">首页</a></li>
	        <li>商城管理</li>
	        <li class="active">首页设置</li>
	      </ol>
    </section>
	<section class="content-iframe content">
	    <div class="list-tabBar">
			<ul>
				<li id="floorInfo" class="active" data-id="1">楼层设置</li>
				<li id="PCBannerInfo" data-id="2">PC轮播设置</li>
				<li id="H5BannerInfo" data-id="3">H5轮播设置</li>
				<li id="adInfo" data-id="4">广告设置</li>
			</ul>
		</div>
		<form class="form-horizontal" role="form" id="floorInfoForm">
			<div class="list-content">
				<div class="row">
					<div class="col-md-12 list-btns">
						<button type="button" onclick="toAdd()">新增楼层</button>
					</div>
				</div>
				<div class="row content-container">
					<div class="col-md-12 container-right active">
						<table id="floorInfoTable" class="table table-hover myClass">
							<thead>
								<tr>
									<th width="10%">布局编号</th>
									<th width="15%">分类中文名</th>
									<th width="15%">分类英文名</th>
									<th width="15%">页面类型</th>
									<th width="15%">页面类型</th>
									<th width="15%">是否显示</th>
									<th width="15%">操作</th>
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
		</form>
		
		<form class="form-horizontal" role="form" id="PCBannerInfoForm" style="display:none;">
			<div class="list-item">
				<div class="col-sm-3 item-left">商品标签</div>
				<div class="col-sm-9 item-right">
					<ul class="label-content" id="tagId">
						<c:forEach var="tag" items="${tags}">
							<li data-id="${tag.id}">${tag.tagName}</li>
	             	    </c:forEach>
					</ul>
					<a class="addBtn" href="javascript:void(0);" onclick="toTag()">+新增标签</a>
				</div>
			</div>
		</form>
		
		<form class="form-horizontal" role="form" id="H5BannerInfoForm" style="display:none;">
			<div class="list-item">
				<div class="col-sm-3 item-left">商品标签</div>
				<div class="col-sm-9 item-right">
					<ul class="label-content" id="tagId">
						<c:forEach var="tag" items="${tags}">
							<li data-id="${tag.id}">${tag.tagName}</li>
	             	    </c:forEach>
					</ul>
					<a class="addBtn" href="javascript:void(0);" onclick="toTag()">+新增标签</a>
				</div>
			</div>
		</form>
		
		<form class="form-horizontal" role="form" id="adInfoForm" style="display:none;">
			<div class="list-item">
				<div class="col-sm-3 item-left">商品标签</div>
				<div class="col-sm-9 item-right">
					<ul class="label-content" id="tagId">
						<c:forEach var="tag" items="${tags}">
							<li data-id="${tag.id}">${tag.tagName}</li>
	             	    </c:forEach>
					</ul>
					<a class="addBtn" href="javascript:void(0);" onclick="toTag()">+新增标签</a>
				</div>
			</div>
		</form>
	</section>
	<%@include file="../../resource.jsp"%>
	<script src="${wmsUrl}/validator/js/bootstrapValidator.min.js"></script>
	<script src="${wmsUrl}/plugins/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="${wmsUrl}/js/ajaxfileupload.js"></script>
	<script type="text/javascript">	
	
	/**
	 * 初始化分页信息
	 */
	var options = {
		queryForm : ".query",
		url :  "${wmsUrl}/admin/mall/indexMng/dataList.shtml?code=module_00024",
		numPerPage:"20",
		currentPage:"",
		index:"1",
		callback:rebuildTable
	}
	
	$(function(){
		 $(".pagination-nav").pagination(options);
	})

	function reloadTable(){
		$.page.loadData(options);
	}
	
	/**
	 * 重构table
	 */
	function rebuildTable(data){
		$("#floorInfoForm tbody").html("");
		
		if (data == null || data.length == 0) {
			return;
		}
		
		var list = data.obj;
		
		if (list == null || list.length == 0) {
			layer.alert("没有查到数据");
			return;
		}
		
		var str = "";
		for (var i = 0; i < list.length; i++) {
			str += "<tr>";
			str += "</td><td>" + list[i].id;
			str += "</td><td>" + list[i].name;
			str += "</td><td>" + list[i].enname;
			
			var type = list[i].type;
			switch(type){
				case 0:str += "</td><td>新品";break;
				case 1:str += "</td><td>特推";break;
				case 2:str += "</td><td>渠道";break;
				case 3:str += "</td><td>精选";break;
				case 4:str += "</td><td>普通分类";break;
				default:str += "</td><td>无";
			}
			var pageType = list[i].layout.pageType;
			if(pageType==0){
				str += "</td><td>PC";
			}else if(pageType==1){
				str += "</td><td>手机";			
			}else{
				str += "</td><td>无";
			}
			
			var isShow = list[i].layout.show;
			if(isShow==0){
				str += "</td><td>PC";
			}else if(isShow==0){
				str += "</td><td>不显示";			
			}else{
				str += "</td><td>显示";
			}
			str += "</td><td>" + list[i].createTime;
			str += "</td><td>";
			str += "<a href='javascript:void(0);' class='table-btns' onclick='toEdit("+list[i].id+")'>编辑</a>";
			str += "<a href='javascript:void(0);' class='table-btns' onclick='delete("+list[i].id+")'>删除</a>";
			str += "</td></tr>";
		}
		
		$("#floorInfoForm tbody").html(str);
	}

	//切换tabBar
	$('.list-tabBar').on('click','ul li:not(.active)',function(){
		$(this).addClass('active').siblings('.active').removeClass('active');
		var typeId = $(this).attr('data-id'); 
		if(typeId == 1){
			$('#floorInfoForm').show();
			$('#PCBannerInfoForm').hide();
			$('#H5BannerInfoForm').hide();
			$('#adInfoForm').hide();
		}else if(typeId == 2){
			$('#floorInfoForm').hide();
			$('#PCBannerInfoForm').show();
			$('#H5BannerInfoForm').hide();
			$('#adInfoForm').hide();
		}else if(typeId == 3){
			$('#floorInfoForm').hide();
			$('#PCBannerInfoForm').hide();
			$('#H5BannerInfoForm').show();
			$('#adInfoForm').hide();
		}else if(typeId == 4){
			$('#floorInfoForm').hide();
			$('#PCBannerInfoForm').hide();
			$('#H5BannerInfoForm').hide();
			$('#adInfoForm').show();
		}
	});
	</script>
</body>
</html>
