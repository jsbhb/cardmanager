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
<section class="content-wrapper query">
	<section class="content-iframe content">
		<div class="list-tabBar">
			<ul>
				<c:forEach var="goodPriceRatio" items="${goodPriceRatios}" varStatus="status">
	           	  	<c:choose>
					<c:when test="${status.index+1 == 1}">
						<li data-id="${goodPriceRatio.ratioPlatformId}" class="active">${goodPriceRatio.ratioPlatformName}</li>
					</c:when>
					<c:otherwise>
						<li data-id="${goodPriceRatio.ratioPlatformId}">${goodPriceRatio.ratioPlatformName}</li>
					</c:otherwise>
					</c:choose> 
          	    </c:forEach>
			</ul>
		</div>
		
		<c:forEach var="goodPriceRatio" items="${goodPriceRatios}" varStatus="status">
			<form class="form-horizontal" role="form" id="${goodPriceRatio.ratioPlatformId}">
				<div class="list-item">
					<div class="col-sm-3 item-left">商品编号</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="itemId" value="${itemId}" readonly>
						<div class="item-content">
		             		（设置比价的商品编号）
		             	</div>
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left">商品名称</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" value="${goodsName}" readonly>
						<div class="item-content">
		             		（设置比价的商品名称）
		             	</div>
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left">商品规格</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" value="${itemInfo}" readonly>
						<div class="item-content">
		             		（设置比价的商品规格）
		             	</div>
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left">对比价格</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="ratioPrice" value="${goodPriceRatio.ratioPrice}" onkeyup="clearNoNum(this)">
						<div class="item-content">
		             		（比价平台上商品的价格）
		             	</div>
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left">评价数</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="evaluateQty" value="${goodPriceRatio.evaluateQty}" onkeyup="this.value=this.value.replace(/[^?\d]/g,'')">
						<div class="item-content">
		             		（比价平台上商品的评价数）
		             	</div>
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left">销量</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="salesVolume" value="${goodPriceRatio.salesVolume}" onkeyup="this.value=this.value.replace(/[^?\d]/g,'')">
						<div class="item-content">
		             		（比价平台上商品的销量）
		             	</div>
					</div>
				</div>
				
		        <div class="submit-btn">
		           	<button type="button" onClick="submitInfo()">保存商品比价信息</button>
		       	</div>
			</form>
   	    </c:forEach>
	</section>
</section>
	
<%@include file="../../resourceScript.jsp"%>
<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
<script type="text/javascript">
var syncFlg = false;
$(document).ready(function(){
	var tabId = $('.list-tabBar ul li.active').attr('data-id');
	$('#'+ tabId).parent().find(">form").hide();
	$('#'+ tabId).show();
});

//切换tabBar
$('.list-tabBar').on('click','ul li:not(.active)',function(){
	$(this).addClass('active').siblings('.active').removeClass('active');
	var tabId = $(this).attr('data-id');
	
	$('#'+ tabId).parent().find(">form").hide();
	$('#'+ tabId).show();
});

function submitInfo() {
	if (syncFlg) {
		return;
	}
	var dataList = [];
	$(".list-tabBar ul li").each(function(){
		var tabId = $(this).attr('data-id');
		var formData = sy.serializeObject($('#'+ tabId));
		formData["ratioPlatformId"] = tabId;
		if (formData["ratioPrice"] != null) {
			dataList.push(formData)
		}
	});
	
	syncFlg = true;
	var url = "${wmsUrl}/admin/goods/goodsMng/syncRatioGoodsInfo.shtml";
	$.ajax({
		 url:url,
		 type:'post',
		 data:JSON.stringify(dataList),
		 contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 success:function(data){
			 if(data.success){
				 parent.layer.closeAll();
				 parent.location.reload();
			 }else{
				 layer.alert(data.msg);
			 }
		 },
		 error:function(){
			 layer.alert("提交失败，请联系客服处理");
		 },
		 complete:function() {
			 syncFlg = false;
		 }
	});
}

function clearNoNum(obj)    
{    
    //先把非数字的都替换掉，除了数字和.    
    obj.value = obj.value.replace(/[^\d.]/g,"");    
    //保证只有出现一个.而没有多个.    
    obj.value = obj.value.replace(/\.{2,}/g,".");    
    //必须保证第一个为数字而不是.    
    obj.value = obj.value.replace(/^\./g,"");    
    //保证.只出现一次，而不能出现两次以上    
    obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");    
    //只能输入两个小数  
    obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3');   
}
</script>
</body>
</html>
