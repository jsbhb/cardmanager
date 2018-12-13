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
	<section class="content-wrapper query content-iframe">
		<section class="content-header">
		      <ol class="breadcrumb">
		        <li><a href="javascript:void(0);">砍价活动</a></li>
		        <li class="active">信息查看</li>
		      </ol>
	    </section>
       	<section class="content-iframe content">
       		<div id="image" style="width:100%;height:100%;display: none;background:rgba(0,0,0,0.5);margin-left:-25px;margin-top:-62px;">
				<img alt="loading..." src="${wmsUrl}/img/loader.gif" style="position:fixed;top:50%;left:50%;margin-left:-16px;margin-top:-16px;" />
			</div>
			<div class="default-content">
				<div class="today-orders">
						<div class="today-orders-item">
							<a href="javascript:void(0);">${totalAllCount}</a>
							<p>已发起</p>
						</div>
						<div class="today-orders-item">
							<a href="javascript:void(0);">${totalBargainCount}</a>
							<p>砍价中</p>
						</div>
						<div class="today-orders-item">
							<a href="javascript:void(0);">${totalBuyCount}</a>
							<p>已购买</p>
						</div>
				</div>
			</div>
	       	<div class="list-content">
				<div class="row">
					<div class="col-md-12">
						<table id="baseTable" class="table table-hover myClass">
							<thead>
								<tr>
									<th width="30%">商品名称</th>
									<th width="5%">商品原价</th>
									<th width="5%">商品底价</th>
									<th width="10%">总发起数</th>
									<th width="10%">发起人</th>
									<th width="10%">创建时间</th>
									<th width="10%">参与人数</th>
									<th width="10%">优惠金额</th>
									<th width="10%">是否购买</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="list" items="${showPageInfoList}">
									<tr class="first-rows" data-id="${list.goodsRoleId}">
										<td><i class="fa fa-fw fa-plus"></i>${list.goodsName}</td>
				                		<td>${list.initPrice}</td>
				                		<td>${list.floorPrice}</td>
				                		<td>${list.recordList.size()}</td>
				                		<td></td>
				                		<td></td>
				                		<td></td>
				                		<td></td>
				                		<td></td>
									</tr>
									<c:forEach var="record" items="${list.recordList}">
										<tr class="second-rows" data-id="${record.id}" parentId="${list.goodsRoleId}">
				                			<td></td>
				                			<td></td>
				                			<td></td>
				                			<td></td>
											<td>${record.name}</td>
				                			<td>${record.createTime}</td>
				                			<td>${record.person}</td>
				                			<td>${record.disCount}</td>
					                		<td>${record.buy==true?"是":"否"}</td>
										</tr>
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
	<script src="${wmsUrl}/js/mainpage.js"></script>
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
	</script>
</body>
</html>
