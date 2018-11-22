<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
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

<section class="content-wrapper">
	<section class="content-header">
      <ol class="breadcrumb">
        <li><a href="javascript:void(0);">个人中心</a></li>
        <li class="active">收货地址管理</li>
      </ol>
	</section>
	<section class="content" style="align:center">
		<div class="list-content">
			<div class="row">
				<div class="col-md-12 list-btns">
					<button type="button" onclick="toCreateAddress()">新增收货地址</button>
				</div> 
				<div class="orderSure-1-content">
					<div class="orderSure-address-1-content">
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
		                                    <span>收件名称</span>
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
				</div> 
			</div> 
			<div class="row">
				<div class="col-md-12">
					<table id="baseTable" class="table table-hover myClass">
						<thead>
							<tr>
								<th width="10%">所在省</th>
								<th width="10%">所在市</th>
								<th width="10%">所在区</th>
								<th width="20%">详细地址</th>
								<th width="10%">邮政编码</th>
								<th width="10%">收件人</th>
								<th width="10%">联系电话</th>
								<th width="5%">默认地址</th>
								<th width="15%">操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="address" items="${addressList}">
								<tr>
									<td>${address.province}</td>
									<td>${address.city}</td>
									<td>${address.area}</td>
			                		<td>${address.address}</td>
			                		<td>${address.zipCode}</td>
									<td>${address.receiveName}</td>
									<td>${address.receivePhone}</td>
									<c:choose>
										<c:when test="${address.setDefault == 1}">
											<td>是</td>
											<td>
												<a href="javascript:void(0);" class="table-btns" onclick="toEditAddress(${address.id})">修改</a>
												<a href="javascript:void(0);" class="table-btns" onclick="toDeleteAddress(${address.id})">删除</a>
											</td>
										</c:when>
										<c:otherwise>
											<td></td>
											<td>
												<a href="javascript:void(0);" class="table-btns" onclick="toEditAddress(${address.id})">修改</a>
												<a href="javascript:void(0);" class="table-btns" onclick="toDeleteAddress(${address.id})">删除</a>
												<a href="javascript:void(0);" class="table-btns" onclick="toSetDefualtAddress(${address.id})">设为默认</a>
											</td>
										</c:otherwise>
									</c:choose>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</section>
</section>
	
<%@include file="../../resourceScript.jsp"%>
<script src="${wmsUrl}/js/jquery.picker2.js"></script>
<script type="text/javascript">

$(".picker-country").picker();

function toCreateAddress() {
	$(".component-orderSure-address-alert > .address-add > p").find("span").text("新增地址");
	$(".component-orderSure-address-alert").css("display","block");
}
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
 				 clearNewAddressInfo();
				 location.reload();
			 }else{
				 layer.alert(data.msg);
			 }
		 },
		 error:function(){
			 layer.alert("用户收货地址保存失败，请联系客服处理");
		 }
	});
}

function toEditAddress(addressId) {
	<c:forEach items="${addressList}" var="item">
	if ("${item.id}" == addressId) {
		$(".component-orderSure-address-alert > .address-add > p").find("span").text("修改地址");
		$('.picker-province').attr('data-name',"${item.province}");
		$('.picker-city').attr('data-name',"${item.city}");
		$('.picker-area').attr('data-name',"${item.area}");
		$(".picker-country").picker();
		$(".address_state").val("${item.address}");
		$(".zipCode_state").val("${item.zipCode}");
		$('#address_id_state').val(addressId);
		$(".receiveName_state").val("${item.receiveName}");
		$(".receivePhone_state").val("${item.receivePhone}");
		if ("${item.setDefault}" == 0) {
			$(".checkDefault").prop("checked","");
		} else {
			$(".checkDefault").prop("checked","checked");
		}
		$(".component-orderSure-address-alert").css("display","block");
		return;
	}
	</c:forEach>
}

function toDeleteAddress(addressId) {
	layer.confirm('确定要删除选中收货地址吗？', {
	  btn: ['确认删除','取消'] //按钮
	}, function(){
		$.ajax({
			 url:"${wmsUrl}/admin/user/userAddressMng/deleteUserAddress.shtml?addressId="+addressId,
			 type:'post',
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){
	 				clearNewAddressInfo();
					location.reload();
				 }else{
					 layer.alert(data.msg);
				 }
			 },
			 error:function(){
				 layer.alert("删除用户收货地址失败，请联系客服处理");
			 }
		});
	}, function(){
	  layer.close();
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

function toSetDefualtAddress(addressId) {
	<c:forEach items="${addressList}" var="item">
	if ("${item.id}" == addressId) {
		$(".component-orderSure-address-alert > .address-add > p").find("span").text("修改地址");
		$('.picker-province').attr('data-name',"${item.province}");
		$('.picker-city').attr('data-name',"${item.city}");
		$('.picker-area').attr('data-name',"${item.area}");
		$(".picker-country").picker();
		$(".address_state").val("${item.address}");
		$(".zipCode_state").val("${item.zipCode}");
		$('#address_id_state').val(addressId);
		$(".receiveName_state").val("${item.receiveName}");
		$(".receivePhone_state").val("${item.receivePhone}");
		$(".checkDefault").prop("checked","checked");
		$(".btn_save").click();
		return;
	}
	</c:forEach>
}
</script>
</body>
</html>
