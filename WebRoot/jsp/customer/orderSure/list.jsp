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
<link rel="stylesheet" href="${wmsUrl}/css/component/mall_order_sure.css">
</head>
<body>
<section class="content-wrapper query">
	<section class="content-header">
	      <ol class="breadcrumb">
	        <li>进销存管理</li>
	        <li class="active">确认采购单</li>
	      </ol>
    </section>	
	<section class="content">
		<div id="image" style="width:100%;height:100%;display: none;background:rgba(0,0,0,0.5);margin-left:-25px;margin-top:-62px;">
			<img alt="loading..." src="${wmsUrl}/img/loader.gif" style="position:fixed;top:50%;left:50%;margin-left:-16px;margin-top:-16px;" />
		</div>
		<div class="list-content">
			<div class="orderSure-1-content">
				<div class="orderSure-address-1-content">
					<h1 class="component-orderSure-address-title">
	                    <span class="title">选择收货地址</span>
	                    <b status="hide">展开列表</b>
	                </h1>
	                <div class="component-orderSure-address-list">
		                <c:forEach var="addressInfoList" items="${userAddressInfoList}">
		                	<c:choose>
								<c:when test="${addressInfoList.setDefault==1}">
									<div id="addressInfoDiv" class="address-item active default" data-addressId="${addressInfoList.id}" data-province="${addressInfoList.province}" data-info="${addressInfoList.province}|${addressInfoList.city}|${addressInfoList.area}|${addressInfoList.address}|${addressInfoList.zipCode}|${addressInfoList.receiveName}|${addressInfoList.receivePhone}|${addressInfoList.setDefault}">
				                        <h2>
				                            ${addressInfoList.province}${addressInfoList.city}<span>(${addressInfoList.receiveName} 收)</span>
				                            <i class="active">默认地址</i>
				                        </h2>
				                        <p>
				                        	${addressInfoList.area}${addressInfoList.address}<b>${addressInfoList.receivePhone}</b>
				                        </p>
				                        <div class="item-btn btn_edit">
				                            <span>再次修改</span>
				                        </div>
				                    </div>
								</c:when>
								<c:otherwise>
									<div id="addressInfo" class="address-item" data-addressId="${addressInfoList.id}" data-province="${addressInfoList.province}" data-info="${addressInfoList.province}|${addressInfoList.city}|${addressInfoList.area}|${addressInfoList.address}|${addressInfoList.zipCode}|${addressInfoList.receiveName}|${addressInfoList.receivePhone}|${addressInfoList.setDefault}">
				                        <h2>
				                            ${addressInfoList.province}${addressInfoList.city}<span>(${addressInfoList.receiveName} 收)</span>
				                            <i>设为默认</i>
				                        </h2>
				                        <p>
				                        	${addressInfoList.area}${addressInfoList.address}<b>${addressInfoList.receivePhone}</b>
				                        </p>
				                        <div class="item-btn btn_edit">
				                            <span>再次修改</span>
				                        </div>
				                    </div>
								</c:otherwise>
							</c:choose>
		                </c:forEach>
	                </div>
	                <div class="component-orderSure-address-btnGroup">
	                    <ul>
	                        <li class="btn btn_newAddress">使用新地址</li>
	                    </ul>
	                </div>
	                <div class="component-orderSure-address-alert" style="display:none;">
	                    <div class="address-add">
	                        <p><span>新增地址</span><b class="btn_close">&times;</b></p>
	                        <div class="address-add-list">
	                            <ul>
	                                <li>
	                                    <span>所在地区</span>
	                                    <div class="picker-country">
											  <select class="picker-province" name="province" id="province"></select>
											  <select class="picker-city" name="city" id="city"></select>
											  <select class="picker-area" name="district" id="district"></select>
	                                    </div>
	                                </li>
	                                <li>
	                                    <span>详细地址</span>
	                                    <textarea cols="30" rows="10" class="address_state"></textarea>
	                                </li>
	                                <li>
	                                    <span>邮政编码</span>
	                                    <input type="text" maxlength="6" class="zipCode_state">
	                                    <input type="hidden" id="address_id_state" value="0">
	                                </li>
	                                <li>
	                                    <span>真实姓名</span>
	                                    <input type="text" class="receiveName_state">
	                                </li>
	                                <li>
	                                    <span>手机号码</span>
	                                    <input type="text" maxlength="11" class="receivePhone_state">
	                                </li>
	                                <li>
	                                    <input type="checkbox" class="checkDefault" checked="checked">
	                                    <i>设置为默认地址</i>
	                                </li>
	                            </ul>
	                            <div class="address-add-list-btn">
	                                <span class="btn btn_save">保存</span>
	                            </div>
	                        </div>
	                    </div>
	                </div>
				</div>
				<div class="orderSure-detail-1-content">
                	<h1 class="component-orderSure-detail-title">确认订单信息</h1>
                	<c:forEach var="supplierInfo" items="${suppliersMap}">
                		<div class="component-orderSure-detail-list-header">
		                    <ul>
		                        <li>商品名称</li>
		                        <li>商品编号</li>
		                        <li>发货仓库</li>
		                        <li>商品单价</li>
		                        <li>采购数量</li>
		                        <li>支付金额</li>
		                    </ul>
		                </div>
		                <div class="component-orderSure-detail-list-body" data-supplier="${supplierInfo.key}">
		                	<c:forEach var="infoList" items="${ShoppingCartInfoList}">
		                		<c:choose>
									<c:when test="${infoList.supplierId==supplierInfo.key}">
				               	  		<ul data-item-info="${infoList.goodsSpecs.minPrice}|${infoList.goodsSpecs.goodsId}|${infoList.goodsSpecs.itemCode}|${infoList.goodsSpecs.itemId}|${infoList.picPath}|${infoList.goodsSpecs.opt}|${infoList.goodsName}|${infoList.goodsSpecs.realMinPrice}|${infoList.quantity}|${infoList.goodsSpecs.sku}|${infoList.id}">
					                        <li>
					                        	<ul>
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
					                        <li><b>${infoList.quantity}</b></li>
					                        <li><b>￥<span data-total-money="${infoList.goodsSpecs.maxPrice}"><fmt:formatNumber type="number" value="${infoList.goodsSpecs.maxPrice}" pattern="0.00" maxFractionDigits="2"/></span></b></li>
					                    </ul>
									</c:when>
								</c:choose>
		                	</c:forEach>
		                </div>
		                <div class="component-orderSure-detail-list-footer" data-supplier="${supplierInfo.key}">
		                	<c:forEach var="postFee" items="${postFeeList}">
		                		<c:choose>
									<c:when test="${postFee.supplierId==supplierInfo.key}">
		                    			<p data-postfee="${postFee.postFee}">运输(普通配送快递):￥<fmt:formatNumber value="${postFee.postFee}" pattern="0.00" maxFractionDigits="2"/></p>
		                    			<p data-rebate="${gradeRebateInfo.alreadyCheck}">返佣可用金额:<font color="#FF0000"><b>￥<fmt:formatNumber type="number" value="${gradeRebateInfo.alreadyCheck}" pattern="0.00" maxFractionDigits="2"/></b></font></p>
					                    <div class="component-orderSure-discountNumber">
					                    	<c:choose>
												<c:when test="${gradeRebateInfo.alreadyCheck==0.00}">
													<input type="hidden" readonly="readonly" placeholder="请输入金额" value='<fmt:formatNumber value="0.00" pattern="0.00" maxFractionDigits="2"/>' onkeyup="clearNoNum(this)">
<!-- 					                    			<span>返佣抵扣金额:</span> -->
												</c:when>
												<c:otherwise>
							               	  		<input type="text" placeholder="请输入金额" value='<fmt:formatNumber value="0.00" pattern="0.00" maxFractionDigits="2"/>' onkeyup="clearNoNum(this)">
					                    			<span>返佣抵扣金额:</span>
												</c:otherwise>
											</c:choose>
					                    </div>
					                    <h2 class="component-orderSure-detail-orderPrice">
					                                                总计金额: <b>￥<i><fmt:formatNumber type="number" value="${supplierInfo.value + postFee.postFee}" pattern="0.00" maxFractionDigits="2"/></i><s data-total="${supplierInfo.value + postFee.postFee}">￥<fmt:formatNumber type="number" value="${supplierInfo.value + postFee.postFee}" pattern="0.00" maxFractionDigits="2"/></s></b>
					                    </h2>
					                    <div class="component-orderSure-detail-payType">
					                        <ul>
					                            <li class="active" payType="2"><img src="${wmsUrl}/img/customer/zfb.png" alt="中国供销海外购"></li>
					                            <li payType="1"><img src="${wmsUrl}/img/customer/wx.png" alt="中国供销海外购"></li>
					                            <li payType="5"><img src="${wmsUrl}/img/customer/yb.png"></li>
					                        </ul>
					                        <span>支付方式：</span>
					                    </div>
					                    <div class="component-orderSure-detail-leavingMessage">
					                        <input type="text" placeholder="买家留言：选填，填写内容已和客服确认">
					                    </div>
									</c:when>
								</c:choose>
		                	</c:forEach>
		                </div>
		                <div class="component-orderSure-detail-list-btn-submit">
		                    <span class="order_submit" data-supplier="${supplierInfo.key}">提交订单</span>
		                </div>
                	</c:forEach>
                </div>
			</div>
		</div>
	</section>
</section>
	
<%@include file="../../resourceScript.jsp"%>
<script src="${wmsUrl}/js/jquery.picker2.js"></script>
<script type="text/javascript">
$('.orderSure-address-1-content').on('click','.address-item',function(){
	$(this).addClass('active').siblings('.active').removeClass('active');
	refreshSupplierPostFee($(this).attr("data-province"));
});
$('.orderSure-address-1-content').on('click','.address-item h2 i:not(.active)',function(){
	var tmpAddressId = $(this).parent().parent().attr("data-addressid");
	$(".component-orderSure-address-list > div").each(function () {
		if ($(this).attr("data-addressId") == tmpAddressId) {
			var addressInfo = $(this).attr("data-info").split("|");
			$(".component-orderSure-address-alert > .address-add > p").find("span").text("修改地址");
			$('.picker-province').attr('data-name',addressInfo[0]);
			$('.picker-city').attr('data-name',addressInfo[1]);
			$('.picker-area').attr('data-name',addressInfo[2]);
			$(".picker-country").picker();
			$(".address_state").val(addressInfo[3]);
			$(".zipCode_state").val(addressInfo[4]);
			$('#address_id_state').val(tmpAddressId);
			$(".receiveName_state").val(addressInfo[5]);
			$(".receivePhone_state").val(addressInfo[6]);
			$(".checkDefault").prop("checked","checked");
			$(".btn_save").click();
			refreshSupplierPostFee(addressInfo[0]);
			return;
		}
	});
});
$('.orderSure-address-1-content').on('click','.component-orderSure-address-title b',function(){
	var status = $(this).attr('status');
	if(status == 'hide'){
		$(this).attr('status','show');
		$('.component-orderSure-address-list').css('height','inherit');
		$(this).html('收起列表');
	}else if(status == 'show'){
		$(this).attr('status','hide');
		$('.component-orderSure-address-list').css('height','150px');
		$(this).html('展开列表');
	}
})
$(".picker-country").picker();

$(".btn_newAddress").on('click',function(){
	$(".component-orderSure-address-alert > .address-add > p").find("span").text("新增地址");
	$(".component-orderSure-address-alert").css("display","block");
})
$(".btn_close").on('click',function(){
	clearNewAddressInfo();
})
function clearNewAddressInfo() {
	var defData =     {
        name_province:  province,
        name_city:      city,
        name_district:  district
    };
	$(".picker-country").picker(defData);
	$('.address-add-list textarea').val('');
	$('.address-add-list input').val('');
	$('#address_id_state').val('0');
	$(".checkDefault").prop("checked","checked");
	$(".component-orderSure-address-alert").css("display","none");
}
$(".btn_save").on('click',function(){
	if (!checkAddressInfo()) {
		return;
	}
	var tmpAddressId = $("#address_id_state").val();
	if (tmpAddressId == "0") {
		saveAddressInfo("save");
	} else {
		saveAddressInfo("update");
	}
})
function saveAddressInfo(saveType) {
	var formData = {};
	formData["province"] = $("#province").val();
	formData["city"] = $("#city").val();
	formData["area"] = $("#district").val();
	formData["address"] = $(".address_state").val();
	formData["zipCode"] = $(".zipCode_state").val();
	formData["id"] = $("#address_id_state").val();
	formData["receivePhone"] = $(".receivePhone_state").val();
	formData["receiveName"] = $(".receiveName_state").val();
	if ($(".checkDefault").is(':checked')) {
		formData["setDefault"] = "1";
	} else {
		formData["setDefault"] = "0";
	}
	
	$.ajax({
		 url:"${wmsUrl}/admin/customer/purchaseMng/saveUserAddressInfoByParam.shtml?saveType="+saveType,
		 type:'post',
		 data:JSON.stringify(formData),
		 contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 success:function(data){
			 if(data.success){	
// 				layer.alert("保存成功");
				refreshAddressList();
				clearNewAddressInfo();
			 }else{
				 layer.alert(data.msg);
			 }
		 },
		 error:function(){
			 layer.alert("用户收货地址保存失败，请联系客服处理");
		 }
	});
}
function refreshAddressList() {
	$.ajax({
		 url:"${wmsUrl}/admin/customer/purchaseMng/refreshAddressList.shtml",
		 type:'post',
		 contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 success:function(data){
			 if(data.success){
				 if (data == null || data.length == 0) {
				 	return;
				 }
				 var list = data.data;
				 if (list == null || list.length == 0) {
					return;
				 }
				 $(".component-orderSure-address-list").html("");
				 var str = "";
				 for (var i = 0; i < list.length; i++) {
					 if (list[i].setDefault==1) {
						 str = str + "<div id='addressInfoDiv' class='address-item active default' data-addressId='"+list[i].id+"' data-province="+list[i].province+" data-info="+list[i].province+"|"+list[i].city+"|"+list[i].area+"|"+list[i].address+"|"+list[i].zipCode+"|"+list[i].receiveName+"|"+list[i].receivePhone+"|"+list[i].setDefault+">";
						 str = str + "<h2>" + list[i].province + list[i].city + "<span>(" + list[i].receiveName + " 收)</span>";
						 str = str + "<i class='active'>默认地址</i></h2><p>" + list[i].area + list[i].address + "<b>" + list[i].receivePhone + "</b>";
						 str = str + "</p><div class='item-btn btn_edit'><span>再次修改</span></div></div>";
					 } else {
						 str = str + "<div id='addressInfoDiv' class='address-item' data-addressId='"+list[i].id+"' data-province="+list[i].province+" data-info="+list[i].province+"|"+list[i].city+"|"+list[i].area+"|"+list[i].address+"|"+list[i].zipCode+"|"+list[i].receiveName+"|"+list[i].receivePhone+"|"+list[i].setDefault+">";
						 str = str + "<h2>" + list[i].province + list[i].city + "<span>(" + list[i].receiveName + " 收)</span><i>设为默认</i>";
						 str = str + "</h2><p>" + list[i].area + list[i].address + "<b>" + list[i].receivePhone + "</b>";
						 str = str + "</p><div class='item-btn btn_edit'><span>再次修改</span></div></div>";
					 }
				 }
				 $(".component-orderSure-address-list").html(str);
			 }else{
				 layer.alert(data.msg);
			 }
		 },
		 error:function(){
			 layer.alert("刷新收货地址失败，请联系客服处理");
		 }
	});
}

function refreshSupplierPostFee(province) {
	var reqData = {};
	reqData["suppliersMap"] = "${suppliersMap}";
	reqData["itemsMap"] = "${itemsMap}";
	$.ajax({
		 url:"${wmsUrl}/admin/customer/purchaseMng/refreshSupplierPostFee.shtml?province="+encodeURI(encodeURI(province)),
		 type:'post',
		 data:reqData,
		 contentType: "application/x-www-form-urlencoded",
		 dataType:'json',
		 success:function(data){
			 if(data.success){
				 if (data == null || data.length == 0) {
				 	return;
				 }
				 var list = data.data;
				 if (list == null || list.length == 0) {
					return;
				 }
				 for (var i = 0; i < list.length; i++) {
					 $(".orderSure-detail-1-content > .component-orderSure-detail-list-footer").each(function(){
						var supplierId = $(this).attr("data-supplier");
						if (supplierId == list[i].supplierId) {
							var supplierTotal = 0;
							<c:forEach items="${suppliersMap}" var="item">
								if ("${item.key}" == supplierId) {
									supplierTotal = eval("${item.value}");
								}
							</c:forEach>
							var countMoney = list[i].postFee + supplierTotal;
							$(this).html("");
							var str = "";
							str = str + "<p data-postfee="+(list[i].postFee).toFixed(2)+">运输(普通配送快递):￥"+(list[i].postFee).toFixed(2)+"</p>";
							str = str + "<p data-rebate='${gradeRebateInfo.alreadyCheck}'>返佣可用金额:<font color='#FF0000'><b>￥<fmt:formatNumber type='number' value='${gradeRebateInfo.alreadyCheck}' pattern='0.00' maxFractionDigits='2'/></b></font></p>";
							str = str + "<div class='component-orderSure-discountNumber'>";
							var userAlreadyCheck = ${gradeRebateInfo.alreadyCheck};
							if (userAlreadyCheck==0.00) {
								str = str + "<input type='hidden' readonly='readonly' placeholder='请输入金额' value='<fmt:formatNumber value='0.00' pattern='0.00' maxFractionDigits='2'/>' onkeyup='clearNoNum(this)'>";
							} else {
								str = str + "<input type='text' placeholder='请输入金额' value='<fmt:formatNumber value='0.00' pattern='0.00' maxFractionDigits='2'/>' onkeyup='clearNoNum(this)'><span>返佣抵扣金额:</span>";
							}
							str = str + "</div><h2 class='component-orderSure-detail-orderPrice'>";
							str = str + "总计金额: <b>￥<i>"+(countMoney).toFixed(2)+"</i><s data-total="+(countMoney).toFixed(2)+">￥"+(countMoney).toFixed(2)+"</s></b>";
							str = str + "</h2><div class='component-orderSure-detail-payType'>";
							str = str + "<ul><li class='active' payType='2'><img src='${wmsUrl}/img/customer/zfb.png' alt='中国供销海外购'></li>";
							str = str + "<li payType='1'><img src='${wmsUrl}/img/customer/wx.png' alt='中国供销海外购'></li>";
							str = str + "<li payType='5'><img src='${wmsUrl}/img/customer/yb.png' alt='中国供销海外购'></li>";
							str = str + "</ul><span>支付方式：</span></div>";
							str = str + "<div class='component-orderSure-detail-leavingMessage'><input type='text' placeholder='买家留言：选填，填写内容已和客服确认'></div>";
							$(this).html(str);
						}
					 })
				 }
			 }else{
				 layer.alert(data.msg);
			 }
		 },
		 error:function(){
			 layer.alert("刷新运费价格失败，请联系客服处理");
		 }
	});
}

function checkAddressInfo() {
	var tmpProvince = $("#province").val();
	if (tmpProvince.indexOf("-") != -1) {
		layer.alert("请选择省级地址！");
		return false;
	}
	var tmpCity = $("#city").val();
	if (tmpCity.indexOf("-") != -1) {
		layer.alert("请选择市级地址！");
		return false;
	}
	var tmpDistrict = $("#district").val();
	if (tmpDistrict.indexOf("-") != -1) {
		layer.alert("请选择区/县级地址！");
		return false;
	}
	var tmpAddress = $(".address_state").val();
	if (tmpAddress == "") {
		layer.alert("请填写详细地址！");
		return false;
	}
	var tmpZipCode = $(".zipCode_state").val();
	if (tmpZipCode == "") {
		layer.alert("请填写邮政编码！");
		return false;
	}
	var tmpReceiveName = $(".receiveName_state").val();
	if (tmpReceiveName == "") {
		layer.alert("请填写真实姓名！");
		return false;
	}
	var tmpReceivePhone = $(".receivePhone_state").val();
	if (tmpReceivePhone == "") {
		layer.alert("请填写手机号码！");
		return false;
	}
	tmpReceivePhone = tmpReceivePhone.replace(/[^0-9]/ig,"");
	var reg = /^1[3|4|5|6|7|8|9][0-9]\d{4,8}$/;
	if(!reg.test(tmpReceivePhone)) 
	{ 
		layer.alert("请输入有效的手机号码！");
		return false; 
	}
	return true;
}

// $(".btn_edit").on('click','span',function(){
$('.orderSure-address-1-content').on('click','.address-item div span',function(){
	var tmpAddressId = $(this).parent().parent().attr("data-addressid");
	$(".component-orderSure-address-list > div").each(function () {
		if ($(this).attr("data-addressId") == tmpAddressId) {
			var addressInfo = $(this).attr("data-info").split("|");
			$(".component-orderSure-address-alert > .address-add > p").find("span").text("修改地址");
			$('.picker-province').attr('data-name',addressInfo[0]);
			$('.picker-city').attr('data-name',addressInfo[1]);
			$('.picker-area').attr('data-name',addressInfo[2]);
			$(".picker-country").picker();
			$(".address_state").val(addressInfo[3]);
			$(".zipCode_state").val(addressInfo[4]);
			$('#address_id_state').val(tmpAddressId);
			$(".receiveName_state").val(addressInfo[5]);
			$(".receivePhone_state").val(addressInfo[6]);
	 		if (addressInfo[7] == 0) {
				$(".checkDefault").prop("checked","");
			} else {
				$(".checkDefault").prop("checked","checked");
			}
			$(".component-orderSure-address-alert").css("display","block");
			return;
		}
	});
})

function clearNoNum(obj) {
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
    var rebate = eval($(obj).parent().prev().attr("data-rebate")).toFixed(2);
    var total = eval($(obj).parent().next().find("s").attr("data-total")).toFixed(2);
    if (rebate - total > 0.00) {
    	rebate = total;
    }
    if (obj.value - rebate > 0.00) {
    	$(obj).val(rebate)
        var totalPay = eval(total - rebate).toFixed(2);
        $(obj).parent().next().find("i").text(totalPay);
    } else {
        var totalPay = eval(total - obj.value).toFixed(2);
        $(obj).parent().next().find("i").text(totalPay);
    }
}
$('.component-orderSure-detail-list-footer').on('click','.component-orderSure-detail-payType ul li',function(){
	$(this).addClass('active').siblings('.active').removeClass('active');
})
$('.component-orderSure-detail-list-btn-submit').on('click','.order_submit',function(){
	var shopcartIds = "";
	var suppplierId = $(this).attr("data-supplier");
	var formData = {};
	var orderDetail={};
	//orderDetail
	var addressInfoStr = $(".component-orderSure-address-list > .address-item.active").attr("data-info");
	if (addressInfoStr == null || addressInfoStr == undefined) {
		layer.alert("收货地址信息有误，请重新选择");
		return;
	}
	var addressInfo = addressInfoStr.split("|");
	orderDetail["receiveProvince"] = addressInfo[0];
	orderDetail["receiveCity"] = addressInfo[1];
	orderDetail["receiveArea"] = addressInfo[2];
	orderDetail["receiveAddress"] = addressInfo[3];
	orderDetail["receiveZipCode"] = addressInfo[4];
	orderDetail["receiveName"] = addressInfo[5];
	orderDetail["receivePhone"] = addressInfo[6];
	orderDetail["taxFee"] = "0.00";
	formData["orderFlag"] = "2";
	//orderGoodsList
	$(".orderSure-detail-1-content > .component-orderSure-detail-list-body").each(function(){
		if ($(this).attr("data-supplier") == suppplierId) {
			var itemList = $(this).children();
			var orderGoodsList=[];
			for(var i=0; i<itemList.length;i++){
				var itemListInfo = $(itemList[i]).attr("data-item-info").split("|");
				var itemData={};
				itemData["actualPrice"] = itemListInfo[0];
				itemData["id"] = itemListInfo[1];
				itemData["itemCode"] = itemListInfo[2];
				itemData["itemId"] = itemListInfo[3];
				itemData["itemImg"] = itemListInfo[4];
				itemData["itemInfo"] = itemListInfo[5];
				itemData["itemName"] = itemListInfo[6];
				itemData["itemPrice"] = itemListInfo[7];
				itemData["itemQuantity"] = itemListInfo[8];
				itemData["sku"] = itemListInfo[9];
				shopcartIds += itemListInfo[10] + ",";
				orderGoodsList.push(itemData);
			}
			formData["orderGoodsList"] = orderGoodsList;
			formData["tdq"] = orderGoodsList.length;
			return false;
		}
	})
	//paymentInfo
	$(".orderSure-detail-1-content > .component-orderSure-detail-list-footer").each(function(){
		if ($(this).attr("data-supplier") == suppplierId) {
			orderDetail["postFee"] = $($(this).children("p").get(0)).attr("data-postfee");
// 			orderDetail["disAmount"] = $($(this).find(".component-orderSure-discountNumber input")).val();
			orderDetail["rebateFee"] = $($(this).find(".component-orderSure-discountNumber input")).val();
			orderDetail["payment"] = $($(this).find("s").get(0)).attr("data-total");
// 			orderDetail["payment"] = $($(this).find("i").get(0)).text();
			orderDetail["payType"] = $($(this).find('.component-orderSure-detail-payType ul li.active')).attr("paytype");
			formData["remark"] = $($(this).find(".component-orderSure-detail-leavingMessage input")).val();
		}
	})
	formData["supplierId"] = suppplierId;
	formData["orderDetail"] = orderDetail;
	formData["tagFun"] = "0";
	
	if (shopcartIds.length <= 0) {
		layer.alert("获取商品数据失败，请联系客服处理");
		return;
	}
	
	shopcartIds = shopcartIds.substring(0,shopcartIds.length-1);
	var win = window.open('about:blank');
	$.ajax({
		 url:"${wmsUrl}/admin/customer/purchaseMng/getInfoToOrder.shtml?shopcartIds="+shopcartIds,
		 type:'post',
		 data:JSON.stringify(formData),
		 contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 success:function(data){
			 if(data.success){
				 if (data.msg != null && data.msg != "") {
					 var orderId = data.msg.split("|")[0];
					 var type = data.msg.split("|")[1];
					 var strInfo = data.msg.split("|")[2];
					 if (type == 1) {
					 	var url = "${wmsUrl}/admin/customer/purchaseMng/toPay.shtml?orderId="+orderId+"&strInfo="+strInfo;
					 	win.location.href = url;
					 } else if (type == 2) {
						 win.document.write(strInfo);
					 } else if (type == 4) {
						 win.close();
					 } else if (type == 5) {
						 win.location.href = strInfo;
					 }
					 //page jump
					 jump(77);
				 }
			 }else{
				 layer.alert(data.msg);
				 win.close();
			 }
		 },
		 error:function(){
			 layer.alert("提交订单失败，请联系客服处理");
			 win.close();
		 }
	});
})
</script>
</body>
</html>
