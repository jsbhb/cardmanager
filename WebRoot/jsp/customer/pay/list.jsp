<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>中国供销海外购--支付页面</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@include file="../../resourceLink.jsp"%>
<link rel="stylesheet" href="${wmsUrl}/css/component/mall_scanPay.css">
</head>
<body>
<section class="content-wrapper query">
	<section class="content">
		<div class="list-content">
			<div class="pay-1-content">
				 <div class="pay-1-content">
			        <div class="pay-header">
			            <p class="pay-info">
			                               请您及时付款，以便为您尽快处理哦！
			                <span>订单号：${orderInfo.orderId}</span>
			                <b>￥<fmt:formatNumber type="number" value="${orderInfo.orderDetail.payment}" pattern="0.00" maxFractionDigits="2"/></b>
			            </p>
			            <p class="timeLimit">
			                                请您在提交订单后<span>1小时</span>内完成支付，否则订单会自动取消。 中国供销海外购为您服务。
			                <b status="hide">订单详情<i class="fa fa-fw fa-angle-down"></i></b>
			            </p>
			            <div class="showDetail">
			                <p>
			                	<c:forEach var="orderGoods" items="${orderInfo.orderGoodsList}">
									${orderGoods.itemName} * ${orderGoods.itemQuantity}
		               			</c:forEach>
			                	<span style="margin-left: 20px;">${orderInfo.supplierName}发货</span>
			                </p>
			                <p>${orderInfo.orderDetail.receiveProvince},${orderInfo.orderDetail.receiveCity},${orderInfo.orderDetail.receiveArea},${orderInfo.orderDetail.receiveAddress},${orderInfo.orderDetail.receiveName},手机号:${orderInfo.orderDetail.receivePhone}</p>
			            </div>
			        </div>
			        <div class="pay-body">
			            <div class="pay-body-left">
			                <p>微信支付</p>
			                <div class="qrcodeImg"></div>
			                <ul class="hint">
			                    <li class="icon"></li>
			                    <li>请使用微信扫一扫</li>
			                    <li>扫描二维码支付</li>
			                </ul>
			            </div>
			            <div class="pay-body-right"></div>
			        </div>
				</div>
		    </div>
		</div>
	</section>
</section>
<%@include file="../../resourceScript.jsp"%>
<script src="${wmsUrl}/js/component/jquery-qrcode.min.js"></script>
<script type="text/javascript">
	$(function(){
		$(".qrcodeImg").qrcode({
	        width:280,
	        height:280,
// 	        correctLevel:0,
	        text: "${strInfo}",
	        render: "canvas"
	    });
	});
	$('.list-content').on('click','.timeLimit b',function(){
		var status = $(this).attr('status');
		$(this).parent().next().stop();
		if(status == 'hide'){
			$(this).parent().next().slideDown(300);
			$(this).attr('status','show');
			$(this).find('i').removeClass('fa-angle-down').addClass('fa-angle-up');
		}else if(status == 'show'){
			$(this).parent().next().slideUp(300);
			$(this).attr('status','hide');
			$(this).find('i').removeClass('fa-angle-up').addClass('fa-angle-down');
		}
	});
</script>
</body>
</html>
