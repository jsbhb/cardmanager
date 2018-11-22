<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@include file="../../resourceLink.jsp"%>
<link rel="stylesheet" href="${wmsUrl}/css/component/mall_shopCart.css">
</head>
<body>
<section class="content-wrapper query">
	<section class="content-header">
	      <ol class="breadcrumb">
	        <li>进销存管理</li>
	        <li class="active">购物车</li>
	      </ol>
    </section>	
	<section class="content">
		<div id="image" style="width:100%;height:100%;display: none;background:rgba(0,0,0,0.5);margin-left:-25px;margin-top:-62px;">
			<img alt="loading..." src="${wmsUrl}/img/loader.gif" style="position:fixed;top:50%;left:50%;margin-left:-16px;margin-top:-16px;" />
		</div>
		<div class="list-content">
			<div class="shopCart-1-content">
				<div class="shopCart-list">
					<c:choose>
						<c:when test="${fn:length(ShoppingCartInfoList) > 0}">
		        			<h1>全部购物车 (<span>${countShoppingCart}</span>)
			                    <span class="volume">
			                        <i class="fa fa-volume-up fa-fw"></i>
			                        <em class="text">温馨提示：一般贸易仓商品采购需满足500元!</em>
			                    </span>
			                    <span class="shopCart-title-btns"><a href="javascript:void(0);" onclick="jump(73)">继续挑选商品</a></span>
		                	</h1>
		                	<div class="list-header">
			                    <ul>
			                        <li class="btn_selectAll">
			                            <span class="fa fa-fw fa-check-circle"></span>全选
			                        </li>
			                        <li>商品名称</li>
			                        <li>商品编号</li>
			                        <li>发货仓库</li>
			                        <li>商品单价</li>
			                        <li>订购数量</li>
			                        <li>支付金额</li>
			                    </ul>
			                </div>
			                <div class="list-body">
			                	<c:forEach var="infoList" items="${ShoppingCartInfoList}">
			                		<c:choose>
										<c:when test="${infoList.goodsSpecs.status==1}">
					                		<div class="list-body-item">
						                        <ul>
						                            <li>
						                                <span class="fa fa-fw fa-check-circle" data-id="${infoList.id}" data-itemId="${infoList.itemId}"></span>
						                            </li>
						                            <li>
						                                <ul class="item-commodity">
						                                    <li>
						                                    	<c:choose>
																	<c:when test="${infoList.picPath==null}">
												               	  		<img src="${wmsUrl}/img/default_img.jpg">
																	</c:when>
																	<c:otherwise>
												               	  		<img src="${infoList.picPath}">
																	</c:otherwise>
																</c:choose>
						                                    </li>
						                                    <li><a target="_blank" href="${webUrl}${infoList.href}">${infoList.goodsName}</a></li>
						                                    <li>
						                                    	<c:choose>
																	<c:when test="${infoList.goodsSpecs.info!=null}">
																		<c:set value="${fn:split(infoList.goodsSpecs.info,'|')}" var="specsInfoList"/>
																		<c:forEach var="specsInfo" items="${specsInfoList}">
																			<span>${specsInfo}</span>
												               			</c:forEach>
																	</c:when>
																</c:choose>
						                                    </li>
						                                </ul>
						                            </li>
						                            <li>${infoList.itemId}</li>
						                            <li><span data-supplierId="${infoList.supplierId}">${infoList.supplierName}</span></li>
						                            <li>￥<span><fmt:formatNumber type="number" value="${infoList.goodsSpecs.minPrice}" pattern="0.00" maxFractionDigits="2"/></span></li>
						                            <li>
						                                <span class="minus btn"></span>
						                                <input type="text" value="${infoList.quantity}" onkeyup="checkInputNumber(this)" onpaste="return false;" data-qty="${infoList.quantity}" data-price="${infoList.goodsSpecs.minPrice}" data-min="${infoList.goodsSpecs.priceList[0].min}" data-max="${infoList.goodsSpecs.priceList[0].max}">
						                                <span class="add btn"></span>
						                            </li>
						                            <li>￥<span data-total-money="${infoList.goodsSpecs.maxPrice}"><fmt:formatNumber type="number" value="${infoList.goodsSpecs.maxPrice}" pattern="0.00" maxFractionDigits="2"/></span></li>
						                        </ul>
						                    </div>
										</c:when>
										<c:otherwise>
					                		<div class="list-body-item item-lose">
						                        <ul>
						                            <li>
						                                <b data-id="${infoList.id}">失效</b>
						                            </li>
						                            <li>
						                                <ul class="item-commodity">
						                                    <li>
						                                    	<c:choose>
																	<c:when test="${infoList.picPath==null}">
												               	  		<img src="${wmsUrl}/img/default_img.jpg">
																	</c:when>
																	<c:otherwise>
												               	  		<img src="${infoList.picPath}">
																	</c:otherwise>
																</c:choose>
						                                    </li>
						                                    <li><a target="_blank" href="${webUrl}${infoList.href}">${infoList.goodsName}</a></li>
						                                    <li>
						                                    	<c:choose>
																	<c:when test="${infoList.goodsSpecs.info!=null}">
																		<c:set value="${fn:split(infoList.goodsSpecs.info,'|')}" var="specsInfoList"/>
																		<c:forEach var="specsInfo" items="${specsInfoList}">
																			<span>${specsInfo}</span>
												               			</c:forEach>
																	</c:when>
																</c:choose>
						                                    </li>
						                                </ul>
						                            </li>
						                            <li>${infoList.itemId}</li>
						                            <li>${infoList.supplierName}</li>
						                            <li>￥<span><fmt:formatNumber type="number" value="${infoList.goodsSpecs.minPrice}" pattern="0.00" maxFractionDigits="2"/></span></li>
						                            <li>
						                                <span class="minus btn"></span>
						                                <input type="text" disabled value="${infoList.quantity}" onkeyup="checkInputNumber(this)" onpaste="return false;" data-qty="${infoList.quantity}" data-price="${infoList.goodsSpecs.minPrice}" data-min="${infoList.goodsSpecs.priceList[0].min}" data-max="${infoList.goodsSpecs.priceList[0].max}">
						                                <span class="add btn"></span>
						                            </li>
						                            <li>￥<span data-total-money="${infoList.goodsSpecs.maxPrice}"><fmt:formatNumber type="number" value="${infoList.goodsSpecs.maxPrice}" pattern="0.00" maxFractionDigits="2"/></span></li>
						                        </ul>
						                    </div>
										</c:otherwise>
									</c:choose>
			                	</c:forEach>
		                	</div>
		                	<div class="list-footer">
			                    <div class="list-footer-btn">
			                        <ul>
			                            <li class="btn_selectAll">
			                                <span class="fa fa-fw fa-check-circle"></span>全选
			                            </li>
			                            <li class="btn_selectAll_del">删除选中商品</li>
			                            <li class="btn_lose_del">清除失效商品</li>
			                        </ul>
			                    </div>
			                    <div class="list-footer-msg">
			                        <ul>
			                            <li>已选商品<span> ${countShoppingCart} </span>件</li>
			                            <li>
			                            	总计金额:<b>￥<span> <fmt:formatNumber type="number" value="${totalShoppingCartMoney}" pattern="0.00" maxFractionDigits="2"/> </span></b>
			                            </li>
			                            <li><span class="btn_settlement" onclick="toOrderSure()">结算</span></li>
			                        </ul>
			                    </div>
			                </div>
						</c:when>
						<c:otherwise>
							<div class="emptyCart">
							<img src="${wmsUrl}/img/customer/icon_emptyCart.png"> 
							<p>您的购物车还是空的，马上去 <a href="javascript:void(0);" onclick="jump(73)">挑选商品</a> 吧！</p>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
        	</div>
		</div>
	</section>
</section>
	
<%@include file="../../resourceScript.jsp"%>
<script type="text/javascript">
$(".btn_selectAll").on('click', function() {
	var selectedClass = $(".btn_selectAll > span").attr("class");
	if (selectedClass == "fa fa-fw fa-check-circle") {
		$(".btn_selectAll > span").attr("class","fa fa-fw fa-circle-thin");
		setItemSelectedFlag("fa fa-fw fa-check-circle","fa fa-fw fa-circle-thin");
	} else {
		$(".btn_selectAll > span").attr("class","fa fa-fw fa-check-circle");
		setItemSelectedFlag("fa fa-fw fa-circle-thin","fa fa-fw fa-check-circle");
	}
	countSelectedItemInfo();
})

function setItemSelectedFlag(checkString, setString) {
	$(".list-body > .list-body-item > ul > li > span").each(function(i){
		if ($(this).attr("class") == checkString) {
			$(this).attr("class",setString)
		}
	})
}

function countSelectedItemInfo() {
	var countSelectedItemNum = 0;
	var countSelectedItemMoney = 0;
	$(".list-body > .list-body-item").each(function(i){
		if ($(this).find("ul li span").first().attr("class") != "fa fa-fw fa-check-circle") {
			return true;
		} else {
			countSelectedItemNum ++;
		}
		if ($(this).find("ul li span").last().attr("data-total-money") != "" && $(this).find("ul li span").last().attr("data-total-money") != undefined) {
			countSelectedItemMoney = countSelectedItemMoney + eval($(this).find("ul li span").last().attr("data-total-money"));
		}
	})
	var str = "";
	str += "<ul><li>已选商品<span> "+countSelectedItemNum+" </span>件</li><li>总计金额:<b>￥<span> "+countSelectedItemMoney.toFixed(2)+" </span></b></li>"
	if (countSelectedItemNum == 0) {
		str += "<li><span class='btn_settlement noSelect'>结算</span></li></ul>";
	} else {
		str += "<li><span class='btn_settlement' onclick='toOrderSure()'>结算</span></li></ul>";
	}
	$(".list-footer-msg").html(str);
}

$(".list-body > .list-body-item > ul > li > span").on('click', function() {
	if ($(this).attr("class") == "fa fa-fw fa-check-circle") {
		$(this).attr("class","fa fa-fw fa-circle-thin")
		countSelectedItemInfo();
	} else if ($(this).attr("class") == "fa fa-fw fa-circle-thin") {
		$(this).attr("class","fa fa-fw fa-check-circle")
		countSelectedItemInfo();
	}
})

$(".list-body").on('click', '.list-body-item:not(.item-lose) .minus', function() {
	var tmpMin = $(this).next().attr("data-min");
	var tmpPrice = $(this).next().attr("data-price");
	if (tmpMin == "" || tmpMin == "0") {
		tmpMin = 1;
	}
	var tmpValue = $(this).next().val();
	tmpValue = eval(tmpValue) - 1;
	if (tmpValue >= tmpMin) {
		$(this).next().val(tmpValue);
		$(this).parent().next().children("span").attr("data-total-money",(eval(tmpPrice)*eval(tmpValue)).toFixed(2));
		$(this).parent().next().children("span").text((eval(tmpPrice)*eval(tmpValue)).toFixed(2));
	} else {
		$(this).next().val(1);
		$(this).parent().next().children("span").attr("data-total-money",(eval(tmpPrice)).toFixed(2));
		$(this).parent().next().children("span").text((eval(tmpPrice)).toFixed(2));
		layer.alert("当前数量已是最小购买量！");
	}
	countSelectedItemInfo();
})

$(".list-body").on('click', '.list-body-item:not(.item-lose) .add', function() {
	var tmpMax = $(this).prev().attr("data-max");
	var tmpPrice = $(this).prev().attr("data-price");
	var tmpValue = $(this).prev().val();
	tmpValue = eval(tmpValue) + 1;
	if (tmpMax == "" || tmpMax == "0") {
		$(this).prev().val(tmpValue);
		$(this).parent().next().children("span").attr("data-total-money",(eval(tmpPrice)*eval(tmpValue)).toFixed(2));
		$(this).parent().next().children("span").text((eval(tmpPrice)*eval(tmpValue)).toFixed(2));
	} else {
		if (tmpValue < eval(tmpMax)) {
			$(this).prev().val(tmpValue);
			$(this).parent().next().children("span").attr("data-total-money",(eval(tmpPrice)*eval(tmpValue)).toFixed(2));
			$(this).parent().next().children("span").text((eval(tmpPrice)*eval(tmpValue)).toFixed(2));
		} else {
			$(this).prev().val(tmpMax);
			$(this).parent().next().children("span").attr("data-total-money",(eval(tmpPrice)*eval(tmpMax)).toFixed(2));
			$(this).parent().next().children("span").text((eval(tmpPrice)*eval(tmpMax)).toFixed(2));
			layer.alert("当前数量已是最大购买量！");
		}
	}
	countSelectedItemInfo();
})

function checkInputNumber(e) {
	var tmpMin = $(e).attr("data-min");
	var tmpMax = $(e).attr("data-max");
	var tmpPrice = $(e).attr("data-price");
	var tmpValue = $(e).val().replace(/[^?\d]/g,'');
	if (tmpValue == "" || tmpValue == "0") {
		tmpValue = 1;
	}
	
	if (tmpMax == "" || tmpMax == "0") {
		$(e).val(tmpValue);
		$(e).parent().next().children("span").attr("data-total-money",(eval(tmpPrice)*eval(tmpValue)).toFixed(2));
		$(e).parent().next().children("span").text((eval(tmpPrice)*eval(tmpValue)).toFixed(2));
	} else {
		if (tmpValue < eval(tmpMax)) {
			$(e).val(tmpValue);
			$(e).parent().next().children("span").attr("data-total-money",(eval(tmpPrice)*eval(tmpValue)).toFixed(2));
			$(e).parent().next().children("span").text((eval(tmpPrice)*eval(tmpValue)).toFixed(2));
		} else {
			$(e).val(tmpMax);
			$(e).parent().next().children("span").attr("data-total-money",(eval(tmpPrice)*eval(tmpMax)).toFixed(2));
			$(e).parent().next().children("span").text((eval(tmpPrice)*eval(tmpMax)).toFixed(2));
			layer.alert("当前数量已是最大购买量！");
		}
	}
}

$(".btn_selectAll_del").on('click', function() {
	var ids = "";
	$(".list-body > .list-body-item > ul > li > span").each(function(){
		if ($(this).attr("class") == "fa fa-fw fa-check-circle") {
			ids = ids + $(this).attr("data-id") + ",";
		}
	})
	if (ids.length <= 0) {
		return;
	}
	
	ids = ids.substring(0,ids.length-1);
	layer.confirm('确定要删除选中商品吗？', {
	  btn: ['确认删除','取消'] //按钮
	}, function(){
		$.ajax({
			 url:"${wmsUrl}/admin/customer/purchaseMng/deleteItemToShoppingCart.shtml?ids="+ids,
			 type:'post',
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){
					 location.reload();
				 }else{
					layer.alert(data.msg);
					return;
				 }
			 },
			 error:function(){
				 layer.alert("从购物车删除商品失败，请重新删除！");
				 return;
			 }
		});
	}, function(){
	  layer.close();
	});
})

$(".btn_lose_del").on('click', function() {
	var ids = "";
	$(".list-body > .item-lose > ul > li > b").each(function(){
		if ($(this).attr("data-id") != "" && $(this).attr("data-id") != undefined) {
			ids = ids + $(this).attr("data-id") + ",";
		}
	})
	if (ids.length <= 0) {
		return;
	}
	
	ids = ids.substring(0,ids.length-1);
	layer.confirm('确定要删除失效商品吗？', {
	  btn: ['确认删除','取消'] //按钮
	}, function(){
		$.ajax({
			 url:"${wmsUrl}/admin/customer/purchaseMng/deleteItemToShoppingCart.shtml?ids="+ids,
			 type:'post',
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){
					 location.reload();
				 }else{
					layer.alert(data.msg);
					return;
				 }
			 },
			 error:function(){
				 layer.alert("从购物车删除商品失败，请重新删除！");
				 return;
			 }
		});
	}, function(){
	  layer.close();
	});
})


function toOrderSure() {
	var supplierMap = new Map();
	var ids = "";
	var itemInfoList = "";
	$(".list-body > .list-body-item > ul > li > span").each(function(){
		if ($(this).attr("class") == "fa fa-fw fa-check-circle") {
			ids = ids + $(this).attr("data-id") + ",";
			var tmpItemId = $(this).parent().next().next().text();
			var tmpQuantity = $(this).parent().next().next().next().next().next().children("input").val();
			var tmpQty = $(this).parent().next().next().next().next().next().children("input").attr("data-qty");
			if ((tmpQuantity - tmpQty) != 0) {
				itemInfoList = itemInfoList + tmpItemId + "|" + (tmpQuantity - tmpQty) + ",";
			}
			var tmpSupplierId = $(this).parent().next().next().next().children("span").attr("data-supplierId");
			var tmpSupplierMoney = $(this).parent().next().next().next().next().next().next().children("span").attr("data-total-money");
			if (!supplierMap.has(tmpSupplierId)) {
				supplierMap.set(tmpSupplierId,tmpSupplierMoney);
			} else {
				supplierMap.set(tmpSupplierId,eval(supplierMap.get(tmpSupplierId)) + eval(tmpSupplierMoney));
			}
		}
	})
	if (ids.length <= 0) {
		return;
	}
	ids = ids.substring(0,ids.length-1);
	if (itemInfoList.length > 1) {
		itemInfoList = itemInfoList.substring(0,itemInfoList.length-1);
	}
// 	var checkMoney = supplierMap.get("6");
// 	if (checkMoney != undefined) {
// 		if (checkMoney - 500 < 0) {
// 			layer.alert("一般贸易仓商品采购需满足500元!");
// 			return;
// 		}
// 	}
	
	window.location.href = encodeURI(encodeURI("${wmsUrl}/admin/customer/purchaseMng/toCheckOrderInfo.shtml?ids="+ids+"&itemInfoList="+itemInfoList));
}
</script>
</body>
</html>
