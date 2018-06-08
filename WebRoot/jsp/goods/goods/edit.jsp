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
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@include file="../../resourceLink.jsp"%>
</head>

<body>
	<section class="content-header">
	      <ol class="breadcrumb">
	        <li><a href="javascript:void(0);">首页</a></li>
	        <li>商品管理</li>
	        <li class="active">编辑商品</li>
	      </ol>
    </section>
	<section class="content-iframe content">
	    <div class="list-tabBar">
			<ul>
				<li id="baseInfo" class="active" data-id="1">基本信息</li>
				<li id="detailInfo" data-id="2">图文详情</li>
			</ul>
		</div>
		<form class="form-horizontal" role="form" id="itemForm">
			<div class="title">
	       		<h1>商品信息</h1>
	       	</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">商品品牌</div>
				<div class="col-sm-9 item-right">
					<select class="form-control" name="brandId" id="brandId" disabled>
	                	<option selected="selected" value="${goodsInfo.goodsBase.brandId}">${goodsInfo.goodsBase.brand}</option>
<!-- 	                	<option selected="selected" value="">--请选择商品品牌--</option> -->
<%-- 		                <c:forEach var="brand" items="${brands}"> --%>
<%-- 		                <option value="${brand.brandId}">${brand.brand}</option> --%>
<%-- 		                </c:forEach> --%>
		            </select>
				</div>
			</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">商品分类</div>
				<div class="col-sm-9 item-right">
	                <div class="right-items">
						<select class="form-control" name="firstCatalogId" id="firstCatalogId" disabled>
	                  	  <option selected="selected" value="${goodsInfo.goodsBase.firstCatalogId}">${firstName}</option>
<!-- 	                  	  <option selected="selected" value="-1">选择分类</option> -->
<%-- 	                  	  <c:forEach var="first" items="${firsts}"> --%>
<%-- 	                  	  	<option value="${first.firstId}">${first.name}</option> --%>
<%-- 	                  	  </c:forEach> --%>
	                	</select>	
					</div>
					<div class="right-items">
						<select class="form-control" name="secondCatalogId" id="secondCatalogId" disabled>
	                  	  <option selected="selected" value="${goodsInfo.goodsBase.secondCatalogId}">${secondName}</option>
<!-- 						<option selected="selected" value="-1">选择分类</option> -->
		                </select>
	                </div>
	                <div class="right-items last-items">
						<select class="form-control" name="thirdCatalogId" id="thirdCatalogId" disabled>
	                  	  <option selected="selected" value="${goodsInfo.goodsBase.thirdCatalogId}">${thirdName}</option>
<!-- 						<option selected="selected" value="-1">选择分类</option> -->
		                </select>
	                </div>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">计量单位</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="unit" id="unit" value="${goodsInfo.goodsBase.unit}" readonly>
					<div class="item-content">
	             		（包、件、个）
	             	</div>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">海关代码</div>
				<div class="col-sm-9 item-right">
                 	<input type="text" class="form-control" name="hscode" id="hscode" value="${goodsInfo.goodsBase.hscode}" readonly>
		            <div class="item-content">
	             		（海关代码HSCode）
	             	</div>
	            </div>
			</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">增值税率</div>
				<div class="col-sm-9 item-right">
                	<input type="text" class="form-control" name="incrementTax" id="incrementTax" value="${goodsInfo.goodsBase.incrementTax}" readonly/>
					<div class="item-content">
		             	（请按小数格式输入，例：0.17）
		            </div>
				</div>
			</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">海关税率</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="tariff" id="tariff" value="${goodsInfo.goodsBase.tariff}" readonly/>
					<div class="item-content">
		             	（请按小数格式输入，例：0.17）
		            </div>
				</div>
			</div>
			
            <input type="hidden" class="form-control" name="baseId" id="baseId" value="${goodsInfo.goodsBase.id}"/>
            <input type="hidden" class="form-control" name="goodsId" id="goodsId" value="${goodsInfo.goods.goodsId}"/>
            <input type="hidden" class="form-control" name="goodsDetailPath" id="goodsDetailPath" value="${goodsInfo.goods.detailPath}"/>
            <input type="hidden" class="form-control" name="itemId" id="itemId" value="${goodsInfo.goods.goodsItem.itemId}"/>
            <input type="hidden" class="form-control" name="itemStatus" id="itemStatus" value="${goodsInfo.goods.goodsItem.status}"/>
	      	<div class="list-item">
				<div class="col-sm-3 item-left">商品名称</div>
				<div class="col-sm-9 item-right">
               		<input type="text" class="form-control" name="goodsName" id="goodsName" value="${goodsInfo.goods.goodsName}">
				</div>
			</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">供应商</div>
				<div class="col-sm-9 item-right">
					<select class="form-control" name="supplierId" id="supplierId">
                   	  <c:forEach var="supplier" items="${suppliers}">
                   	  	<c:choose>
						<c:when test="${goodsInfo.goods.supplierId==supplier.id}">
                   	  	<option value="${supplier.id}" selected="selected">${supplier.supplierName}</option>
						</c:when>
						<c:otherwise>
                   	  	<option value="${supplier.id}">${supplier.supplierName}</option>
						</c:otherwise>
						</c:choose> 
                   	  </c:forEach>
	                </select>
	               <input type="hidden" class="form-control" name="supplierName" id="supplierName" value="${goodsInfo.goods.supplierName}"/>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">商品类型</div>
				<div class="col-sm-9 item-right">
					<select class="form-control" name="type" id="type">
						<c:choose>
						<c:when test="${goodsInfo.goods.type==0}">
	                  	  	<option selected="selected" value="0">跨境商品</option>
                	  		<option value="2">一般贸易商品</option>
						</c:when>
						<c:otherwise>
                	  		<option value="0">跨境商品</option>
                	    	<option selected="selected" value="2">一般贸易商品</option>
						</c:otherwise>
						</c:choose> 
	                </select>
				</div>
			</div>
	      	<div class="list-item">
				<div class="col-sm-3 item-left">原产国</div>
				<div class="col-sm-9 item-right">
	                 <input type="text" class="form-control" name="origin" value="${goodsInfo.goods.origin}">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">商品标签</div>
				<div class="col-sm-9 item-right">
					<ul class="label-content" id="tagId">
						<c:forEach var="tag" items="${tags}">
							<c:choose>
							<c:when test="${goodsInfo.goods.goodsTagBind.tagId==tag.id}">
							<li data-id="${tag.id}" class="active">${tag.tagName}</li>
							</c:when>
							<c:otherwise>
							<li data-id="${tag.id}">${tag.tagName}</li>
							</c:otherwise>
							</c:choose>
	             	    </c:forEach>
					</ul>
					<a class="addBtn" href="javascript:void(0);" onclick="toTag()">+新增标签</a>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">商品主图</div>
				<div class="col-sm-9 item-right addContent">
					<c:forEach var="file" items="${goodsInfo.goods.files}" varStatus="status">
                   	 	<div class="item-img choose" id="content${status.index+1}" data-id="${status.index+1}">
								<img src="${file.path}">
								<div class="bgColor"><i class="fa fa-trash fa-fw"></i></div>
								<input value="${file.path}" type="hidden" name="picPath" id="picPath${status.index+1}">
							</div>
                   	 </c:forEach>
				
					<div class="item-img" id="content${fn:length(goodsInfo.goods.files)+1}" data-id="${fn:length(goodsInfo.goods.files)+1}">
						+
						<input type="file" id="pic${fn:length(goodsInfo.goods.files)+1}" name="pic"/>
					</div>
				</div>
			</div>
			<div class="title">
	       		<h1>规格信息</h1>
	       	</div>
			<div id="specsInfo">
				<c:forEach var="info" items="${specsInfos}" varStatus="status">
					<div id="specsInfoCate${status.index+1}">
						<div class="list-item">
							<div class="col-sm-3 item-left">规格项</div>
							<div class="col-sm-9 item-right">
								<select class="form-control" id="specsCateInfo${status.index+1}" onChange="changeSpecsCateInfo(${status.index+1})">
									<option value="${info.skId}">${info.skV}</option>
								</select>
								<input type="text" id="specsCateInfoText${status.index+1}" placeholder="请选择" value="${info.skV}" onkeyup="searchKey('cate',${status.index+1})">
							</div>
						</div>
						<div class="list-item">
							<div class="col-sm-3 item-left">规格值</div>
							<div class="col-sm-9 item-right" id="specsValueInfoList${status.index+1}">
								<div id="specsValueInfoItem${status.index+1}">
								
								<select class="form-control" id="specsValueInfo${status.index+1}_1" onChange="changeSpecsValueInfo('${status.index+1}_1')">
									<option value="${info.svId}">${info.svV}</option>
								</select>
								<input type="text" id="specsValueInfoText${status.index+1}_1" placeholder="请选择" value="${info.svV}" onkeyup="searchKey('value','${status.index+1}_1')">
								
								</div>
								<a class="addBtn" href="javascript:void(0);" onclick="addSpecsValueInfo(${status.index+1})">添加规格值</a>
							</div>
						</div>
					</div>
           	    </c:forEach>
	       	</div>
	       	<div class="list-content" style="padding-bottom:40px; min-height:0;">
				<div class="row">
					<div class="col-md-10 list-btns">
						<button type="button" onclick="createSpecsCategoryInfo()" id="addSpecsBtn">新增规格项</button>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<table id="goodsTable" class="table table-hover myClass">
							<thead>
								<tr>
									<c:forEach var="title" items="${specsTitles}">
										<th>${title}</th>
									</c:forEach>
									<th>商家编码</th>
									<th>海关货号</th>
									<th>条形码</th>
									<th>消费税率</th>
									<th>商品重量</th>
									<th>换算比例</th>
									<th>保质期</th>
									<th>箱规</th>
									<th>成本价</th>
									<th>分销价</th>
									<th>零售价</th>
									<th colspan="2">限购数量</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="goodsItem" items="${goodsInfo.goods.items}">
									<tr>
										<c:forEach var="specs" items="${goodsItem.specs}">
											<td><span name="info">${specs.svV}</span></td>
										</c:forEach>
										<td><input type="text" class="form-control" name="itemCode" value="${goodsItem.itemCode}" data-id="${goodsItem.itemId}" data-status="${goodsItem.status}"></td>
										<td><input type="text" class="form-control" name="sku" value="${goodsItem.sku}"></td>
										<td><input type="text" class="form-control" name="encode" value="${goodsItem.encode}"></td>
										<td><input type="text" class="form-control" name="exciseTax" value="${goodsItem.exciseTax}"></td>
										<td><input type="text" class="form-control" name="weight" value="${goodsItem.weight}"></td>
										<td><input type="text" class="form-control" name="conversion" value="${goodsItem.conversion}"></td>
										<td><input type="text" class="form-control" name="shelfLife" value="${goodsItem.shelfLife}"></td>
										<td><input type="text" class="form-control" name="carTon" value="${goodsItem.carTon}"></td>
										<td><input type="text" class="form-control" name="proxyPrice" value="${goodsItem.goodsPrice.proxyPrice}"></td>
										<td><input type="text" class="form-control" name="fxPrice" value="${goodsItem.goodsPrice.fxPrice}"></td>
										<td><input type="text" class="form-control" name="retailPrice" value="${goodsItem.goodsPrice.retailPrice}"></td>
										<td><input type="text" class="form-control" name="min" placeholder="最小值" value="${goodsItem.goodsPrice.min}"></td>
										<td><input type="text" class="form-control" name="max" placeholder="最大值" value="${goodsItem.goodsPrice.max}"></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			
	        <div class="submit-btn">
	           	<button type="button" id="nextPageBtn">下一页</button>
	           	<button type="button" id="saveInfoBtn">保存信息</button>
	       	</div>
		</form>
		
		<form class="form-horizontal" role="form" id="itemForm2" style="display:none;">
			<div class="title">
	       		<h1>商品详情</h1>
	       	</div>
			<div class="list-item">
				<div class="col-sm-12">
					<script id="editor" type="text/plain" name="ueditor" style="height:320px;" align=center></script>
				</div>
			</div>
	        <div class="submit-btn">
	           	<button type="button" id="prePageBtn">上一页</button>
	           	<button type="button" id="submitBtn">修改商品信息</button>
	       	</div>
		</form>
	</section>
	<script type="text/javascript" charset="utf-8" src="${wmsUrl}/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="${wmsUrl}/ueditor/ueditor.all.min.js"></script>
	<script type="text/javascript" charset="utf-8" src="${wmsUrl}/ueditor/lang/zh-cn/zh-cn.js"></script>
	<%@include file="../../resourceScript.jsp"%>
	<script src="${wmsUrl}/plugins/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="${wmsUrl}/js/ajaxfileupload.js"></script>
	<script type="text/javascript">
	var specsCategory=[];//规格分类
	var specsCategoryItem=[];//规格值
	var specsCategoryItemTotal=[];//规格值汇总
	var specsCategoryItemRecord=[];//规格记录
	var baseTableStr = $("#goodsTable tbody").html();
	
	function searchKey(type,index){
		var text = null;
		var object = null;
		//获得input输入框的内容
		if (type == "cate") {
			text = document.getElementById("specsCateInfoText"+index).value;
			object = document.getElementById("specsCateInfo"+index);
		} else {
			text = document.getElementById("specsValueInfoText"+index).value;
			object = document.getElementById("specsValueInfo"+index);
		}
		//如果输入的内容为空，所有的选项都匹配
		if(text!= '')
		{
			var allText = getSelectText(type,index);
			var eachOption = new Array();
			var searchedOption = new Array();
			var unsearchedOption = new Array();
			eachOption=allText.split(","); //字符分割
			for (i=0;i<eachOption.length;i++ )
			{
				//如果option内容中有输入的内容就返回第一次匹配的位置（大于等于0），如果没有匹配的就返回-1
				var flag = eachOption[i].indexOf(text) ;
				if(flag >=0)
				{
					var option = new Option(object[i].innerText,object[i].value);
					searchedOption.push(option);
				} else {
					var option = new Option(object[i].innerText,object[i].value);
					unsearchedOption.push(option);
				}
			}
			searchedOption.push.apply(searchedOption,unsearchedOption);
			var objectSelect = null;
			if (type == "cate") {
				objectSelect = $("#specsCateInfo"+index);
			} else {
				objectSelect = $("#specsValueInfo"+index);
			}
			objectSelect.empty();
			for (var i = 0; i < searchedOption.length; i++) {
				objectSelect.append(searchedOption[i]);
			}
		}
	}
	
	function getSelectText(type,index){
		var object = null;
		if (type == "cate") {
			object = document.getElementById("specsCateInfo"+index);
		} else {
			object = document.getElementById("specsValueInfo"+index);
		}
		var allText = '';
		for(i=0;i<object.length;i++)
		{
			allText+= object[i].innerText+','; //关键是通过option对象的innerText属性获取到选项文本
		}
		allText = allText.substring(0,allText.length-1);
		return allText;
	}
	
	function changeSpecsCateInfo(index){
		//将当前选中的下拉框的内容找到并赋值给对应的输入框
		var object = document.getElementById("specsCateInfo"+index);
		var s_index = object.selectedIndex;
		var value= object.options[s_index].value;
		var text= object.options[s_index].innerText;
		$('#specsCateInfoText'+index).val(text);

		//清空之前添加的规格值
		$('#specsValueInfoList'+index).empty();
		//更新specsCategory,specsCategoryItem数组的内容
		reCalcSpecsBaseArrInfo();
		
		if (specsCategoryItem.length > 0) {
			//重新汇总规格值
			reTotalItem();
			//重新计算数组
			reCalcRecord();
			//重新绘制表格
			rePaintTable();
		}
		
		//加载新选择的规格分类的值
		var data = [];
		for(var i=0; i<specsCategoryItem.length; i++) {
			var tmpSpecsCategoryItem = specsCategoryItem[i];
			var tmpSpecsCategoryItemId = tmpSpecsCategoryItem.split(":")[1].split("|")[0];
			data.push(tmpSpecsCategoryItemId);
		}
		$.ajax({
			url:"${wmsUrl}/admin/goods/specsMng/queryAllSpecsValueExceptParam.shtml?id="+value,
			type:'post',
			contentType: "application/json; charset=utf-8",
			dataType:'json',
			data : JSON.stringify(data),
			success:function(data){
				var list = data;
				if (list == null || list.length == 0) {
					return;
				} else {
					var info = '';
					info = info + '<div id="specsValueInfoItem'+index+'">';
					info = info + '<select class="form-control" id="specsValueInfo'+index+'_1" onChange="changeSpecsValueInfo(\''+index+'_1\')">';
					for (var i = 0; i < list.length; i++) {
						info = info + '<option value="'+list[i].id+'">'+list[i].value+'</option>';
					}
					info = info + '</select>';
					info = info + '<input type="text" id="specsValueInfoText'+index+'_1" placeholder="请选择" onkeyup="searchKey(\'value\',\''+index+'_1\')">';
					info = info + '</div>';
					info = info + '<a class="addBtn" href="javascript:void(0);" onclick="addSpecsValueInfo('+index+')">添加规格值</a>';
					$('#specsValueInfoList'+index).append(info);
				}
			},
			error:function(){
				layer.alert("查询失败，请联系客服处理");
			}
		});
	}
	
	function addSpecsValueInfo(index){
		var divId=document.all["specsValueInfoItem"+index];
		var ids=divId.getElementsByTagName("select");
		var tmpMaxIndex = 0;
		for(var i=0;i<ids.length;i++)
		{
			var tmpIndex = ids.item(i).id.split("_")[1];
			if (tmpMaxIndex < tmpIndex) {
				tmpMaxIndex = tmpIndex;
			}
		}
		tmpMaxIndex++;
		
		var object = document.getElementById("specsCateInfo"+index);
		var s_index = object.selectedIndex;
		var value= object.options[s_index].value;
		
		var data = [];
		for(var i=0; i<specsCategoryItem.length; i++) {
			var tmpSpecsCategoryItem = specsCategoryItem[i];
			var tmpSpecsCategoryItemIdArr = tmpSpecsCategoryItem.split(":")[1].split(",");
			for(var j=0; j<tmpSpecsCategoryItemIdArr.length; j++) {
				data.push(tmpSpecsCategoryItemIdArr[j].split("|")[0]);
			}
		}

		$.ajax({
			url:"${wmsUrl}/admin/goods/specsMng/queryAllSpecsValueExceptParam.shtml?id="+value,
			type:'post',
			contentType: "application/json; charset=utf-8",
			dataType:'json',
			data : JSON.stringify(data),
			success:function(data){
				var list = data;
				var info = '';
				info = info + '<select class="form-control" id="specsValueInfo'+index+'_'+tmpMaxIndex+'" onChange="changeSpecsValueInfo(\''+index+'_'+tmpMaxIndex+'\')">';
				for (var i = 0; i < list.length; i++) {
					info = info + '<option value="'+list[i].id+'">'+list[i].value+'</option>';
				}
				info = info + '</select>';
				info = info + '<input type="text" id="specsValueInfoText'+index+'_'+tmpMaxIndex+'" placeholder="请选择" onkeyup="searchKey(\'value\',\''+index+'_'+tmpMaxIndex+'\')">';
				$('#specsValueInfoItem'+index).append(info);
			},
			error:function(){
				layer.alert("查询失败，请联系客服处理");
			}
		});
	}
	
	function changeSpecsValueInfo(index){
		//将当前选中的下拉框的内容找到并赋值给对应的输入框
		var object = document.getElementById("specsValueInfo"+index);
		var s_index = object.selectedIndex;
		var value = object.options[s_index].value;
		var text = object.options[s_index].innerText;
		$('#specsValueInfoText'+index).val(text);
		
		//更新specsCategory,specsCategoryItem数组的内容
		reCalcSpecsBaseArrInfo();
		//重新汇总规格值
		reTotalItem();
		//重新计算数组
		reCalcRecord();
		//重新绘制表格
// 		rePaintTable();
		changeTableRow();
	}
	
	//数组排列组合
	function doExchange(arr){
		var len = arr.length;
		if (len >= 2) {
			var len1 = arr[0].length;
			var len2 = arr[1].length;
			var lenBoth = len1 * len2;
			var items = new Array(lenBoth);
			var index = 0;
			for (var i=0; i<len1; i++) {
				for (var j=0; j<len2; j++) {
					items[index] = arr[0][i]+","+arr[1][j];
					index++;
				}
			}
			var newArr = new Array(len - 1);
			for(var i=2; i<arr.length; i++) {
				newArr[i-1] = arr[i];
			}
			newArr[0] = items;
			return doExchange(newArr);
		} else {
			return arr[0];
		}
	}
	
	function reCalcSpecsBaseArrInfo(){
		specsCategory = [];
		specsCategoryItem = [];
		var info=document.all["specsInfo"];
		var ids=info.getElementsByTagName("select");
		for(var i=0;i<ids.length;i++)
		{
			if (ids.item(i).id.indexOf("specsCateInfo") != -1 ) {
				//type
				var t_index = ids.item(i).id.replace("specsCateInfo","");
				var t_object = document.getElementById("specsCateInfo"+t_index);
				var t_s_index = t_object.selectedIndex;
				var t_value= t_object.options[t_s_index].value;
				var t_text= t_object.options[t_s_index].innerText;
				var t_tmpArrayInfo = "specsCateInfo"+t_index+":"+t_value+"|"+t_text;
				specsCategory.push(t_tmpArrayInfo);
			} else if (ids.item(i).id.indexOf("specsValueInfo") != -1 ) {
				//item
				var i_index = ids.item(i).id.replace("specsValueInfo","");
				var i_object = document.getElementById("specsValueInfo"+i_index);
				var i_s_index = i_object.selectedIndex;
				var i_value= i_object.options[i_s_index].value;
				var i_text= i_object.options[i_s_index].innerText;
				var i_tmpArrayInfo = "specsValueInfo"+i_index+":"+i_value+"|"+i_text;
				specsCategoryItem.push(i_tmpArrayInfo);
			}
		}
	}
	
	function reTotalItem(){
		var infos=document.all["specsInfo"];
		var indexs=infos.getElementsByTagName("div");
		var index = 1;
		for(var i=0;i<indexs.length;i++)
		{
			if (indexs.item(i).id.indexOf("specsInfoCate") != -1 ) {
				index = indexs.item(i).id.replace("specsInfoCate","");
			}
		}
		
		specsCategoryItemTotal = [];
		for(var i=1;i<=index;i++) {
			var tmpStr = "";
			var divId=document.all["specsValueInfoItem"+i];
			if (divId == undefined) {
				continue;
			}
			var ids=divId.getElementsByTagName("select");
			if (ids.length > 0) {
				tmpStr = "specsValueInfoList"+i+":";
				for(var j=0;j<ids.length;j++)
				{
					var object = document.getElementById(ids.item(j).id);
					var s_index = object.selectedIndex;
					var value= object.options[s_index].value;
					var text = object.options[s_index].innerText;
					tmpStr = tmpStr+value+"|"+text+",";
				}
				tmpStr = tmpStr.substring(0,tmpStr.length-1);
				specsCategoryItemTotal.push(tmpStr);
			}
		}
	}
	
	function reCalcRecord(){
		var arrItem=[];
		for (var i = 0; i < specsCategoryItemTotal.length; i++) {
			var itemInfo = specsCategoryItemTotal[i];
			arrItem[i] = itemInfo.split(":")[1].split(",");
		}
		specsCategoryItemRecord = doExchange(arrItem);
		
		console.log(specsCategory);
		console.log(specsCategoryItem);
		console.log(specsCategoryItemTotal);
		console.log(specsCategoryItemRecord);
	}
	
	function rePaintTable(){
		var headStr = "";
		headStr = headStr + "<tr>";
		for(var i=0; i<specsCategoryItemTotal.length; i++) {
			var tmpSpecsCategory = specsCategory[i].split(":")[1].split("|")[1];
			headStr = headStr + "<th>" + tmpSpecsCategory + "</th>";
		}
		headStr = headStr + "<th>商家编码</th>";
		headStr = headStr + "<th>海关货号</th>";
		headStr = headStr + "<th>条形码</th>";
		headStr = headStr + "<th>消费税率</th>";
		headStr = headStr + "<th>商品重量</th>";
		headStr = headStr + "<th>换算比例</th>";
		headStr = headStr + "<th>保质期</th>";
		headStr = headStr + "<th>箱规</th>";
		headStr = headStr + "<th>成本价</th>";
		headStr = headStr + "<th>分销价</th>";
		headStr = headStr + "<th>零售价</th>";
		headStr = headStr + "<th colspan='2'>限购数量</th>";
		headStr = headStr + "</tr>";
		$("#goodsTable thead").html("");
		$("#goodsTable thead").html(headStr);

		var bodyStr = "";
		for(var i=0; i<specsCategoryItemRecord.length; i++) {
			bodyStr = bodyStr + "<tr>";
			var tmpSpecsCategoryItemRecordArr = specsCategoryItemRecord[i].split(",");
			for(var j=0; j<tmpSpecsCategoryItemRecordArr.length; j++) {
				bodyStr = bodyStr + "<td><span name='info'>" + tmpSpecsCategoryItemRecordArr[j].split("|")[1] + "</span></td>";
			}
			bodyStr = bodyStr + "<td><input type='text' class='form-control' name='itemCode' data-id='' data-status=''></td>";
			bodyStr = bodyStr + "<td><input type='text' class='form-control' name='sku'></td>";
			bodyStr = bodyStr + "<td><input type='text' class='form-control' name='encode'></td>";
			bodyStr = bodyStr + "<td><input type='text' class='form-control' name='exciseTax'></td>";
			bodyStr = bodyStr + "<td><input type='text' class='form-control' name='weight'></td>";
			bodyStr = bodyStr + "<td><input type='text' class='form-control' name='conversion'></td>";
			bodyStr = bodyStr + "<td><input type='text' class='form-control' name='shelfLife'></td>";
			bodyStr = bodyStr + "<td><input type='text' class='form-control' name='carTon'></td>";
			bodyStr = bodyStr + "<td><input type='text' class='form-control' name='proxyPrice'></td>";
			bodyStr = bodyStr + "<td><input type='text' class='form-control' name='fxPrice'></td>";
			bodyStr = bodyStr + "<td><input type='text' class='form-control' name='retailPrice'></td>";
			bodyStr = bodyStr + "<td><input type='text' class='form-control' name='min' placeholder='最小值'></td>";
			bodyStr = bodyStr + "<td><input type='text' class='form-control' name='max' placeholder='最大值'></td>";
			bodyStr = bodyStr + "</tr>";
		}
		$("#goodsTable tbody").html("");
		$("#goodsTable tbody").html(bodyStr);
	}
	
	function createSpecsCategoryInfo(){
		var divId=document.all["specsInfo"];
		var ids=divId.getElementsByTagName("div");
		var index = 0;
		for(var i=0;i<ids.length;i++)
		{
			if (ids.item(i).id.indexOf("specsInfoCate") != -1 ) {
				index = ids.item(i).id.replace("specsInfoCate","");
			}
		}
		index++;

		var data = [];
		for(var i=0; i<specsCategory.length; i++) {
			var tmpSpecsCategory = specsCategory[i];
			var tmpSpecsId = tmpSpecsCategory.split(":")[1].split("|")[0];
			data.push(tmpSpecsId);
		}
		
		$.ajax({
			url:"${wmsUrl}/admin/goods/specsMng/queryAllSpecsCategoryExceptParam.shtml",
			type:'post',
			contentType: "application/json; charset=utf-8",
			dataType:'json',
	   		data : JSON.stringify(data),
			success:function(data){
				var list = data;
				var info = '<div id="specsInfoCate'+index+'">';
				info = info + '<div class="list-item"><div class="col-sm-3 item-left">规格项</div><div class="col-sm-9 item-right">';
				info = info + '<select class="form-control" id="specsCateInfo'+index+'" onChange="changeSpecsCateInfo('+index+')">';
				for (var i = 0; i < list.length; i++) {
					info = info + '<option value="'+list[i].id+'">'+list[i].name+'</option>';
				}
				info = info + '</select>';
				info = info + '<input type="text" id="specsCateInfoText'+index+'" placeholder="请选择" onkeyup="searchKey(\'cate\','+index+')"></div></div>';
				info = info + '<div class="list-item"><div class="col-sm-3 item-left">规格值</div><div class="col-sm-9 item-right" id="specsValueInfoList'+index+'">';
				info = info + '</div></div></div>';
				$('#specsInfo').append(info);
			},
			error:function(){
				layer.alert("查询失败，请联系客服处理");
			}
		});
	}
	
	function changeTableRow(){
		var headStr = "";
		headStr = headStr + "<tr>";
		for(var i=0; i<specsCategoryItemTotal.length; i++) {
			var tmpSpecsCategory = specsCategory[i].split(":")[1].split("|")[1];
			headStr = headStr + "<th>" + tmpSpecsCategory + "</th>";
		}
		headStr = headStr + "<th>商家编码</th>";
		headStr = headStr + "<th>海关货号</th>";
		headStr = headStr + "<th>条形码</th>";
		headStr = headStr + "<th>消费税率</th>";
		headStr = headStr + "<th>商品重量</th>";
		headStr = headStr + "<th>换算比例</th>";
		headStr = headStr + "<th>保质期</th>";
		headStr = headStr + "<th>箱规</th>";
		headStr = headStr + "<th>成本价</th>";
		headStr = headStr + "<th>分销价</th>";
		headStr = headStr + "<th>零售价</th>";
		headStr = headStr + "<th colspan='2'>限购数量</th>";
		headStr = headStr + "</tr>";
		$("#goodsTable thead").html("");
		$("#goodsTable thead").html(headStr);
		
		for(var j=0; j<specsCategoryItemRecord.length; j++) {
			var tmpRecord = specsCategoryItemRecord[j].split(",");
			var tmpKey = "";
			var tmpStr = "";
			for(var k=0; k<tmpRecord.length; k++) {
				tmpKey = tmpKey + tmpRecord[k].split("|")[1] + ",";
			}
			for(var k=0; k<specsCategory.length; k++) {
				tmpStr = tmpStr + $("#goodsTable tbody").find("tr").eq(j).find("td").eq(k).text() + ",";
			}
			
			if (tmpKey == tmpStr) {
				console.log("row:"+j+"-----------"+specsCategoryItemRecord[j]+"---------ok");
			} else {
				console.log("row:"+j+"-----------"+specsCategoryItemRecord[j]+"---------add");
				var tb = document.getElementById("goodsTable");
				var newTr = tb.insertRow(j+1);
				var tmpNewTds = specsCategoryItemRecord[j].split(",");
				for(var i=0; i<tmpNewTds.length; i++) {
					var newTd = newTr.insertCell(); 
		            newTd.innerHTML = "<span name='info'>" + tmpNewTds[i].split("|")[1] + "</span>";
				}
				var newTd1 = newTr.insertCell(); 
	            newTd1.innerHTML = "<input type='text' class='form-control' name='itemCode' data-id='' data-status=''>";
	            var newTd1 = newTr.insertCell(); 
	            newTd1.innerHTML = "<input type='text' class='form-control' name='sku'>";
				var newTd1 = newTr.insertCell(); 
	            newTd1.innerHTML = "<input type='text' class='form-control' name='encode'>";
	            var newTd1 = newTr.insertCell(); 
	            newTd1.innerHTML = "<input type='text' class='form-control' name='exciseTax'>";
	            var newTd1 = newTr.insertCell(); 
	            newTd1.innerHTML = "<input type='text' class='form-control' name='weight'>";
	            var newTd1 = newTr.insertCell(); 
	            newTd1.innerHTML = "<input type='text' class='form-control' name='conversion'>";
				var newTd1 = newTr.insertCell(); 
	            newTd1.innerHTML = "<input type='text' class='form-control' name='shelfLife'>";
	            var newTd1 = newTr.insertCell(); 
	            newTd1.innerHTML = "<input type='text' class='form-control' name='carTon'>";
	            var newTd1 = newTr.insertCell(); 
	            newTd1.innerHTML = "<input type='text' class='form-control' name='proxyPrice'>";
	            var newTd1 = newTr.insertCell(); 
	            newTd1.innerHTML = "<input type='text' class='form-control' name='fxPrice'>";
	            var newTd1 = newTr.insertCell(); 
	            newTd1.innerHTML = "<input type='text' class='form-control' name='retailPrice'>";
				var newTd1 = newTr.insertCell(); 
	            newTd1.innerHTML = "<input type='text' class='form-control' name='min' placeholder='最小值'>";
	            var newTd1 = newTr.insertCell(); 
	            newTd1.innerHTML = "<input type='text' class='form-control' name='max' placeholder='最大值'>";
			}
		}
	}
	
	$("#supplierId").change(function(){
		$("#supplierName").val($("#supplierId").find("option:selected").text());
	});
	 
	 $("#saveInfoBtn").click(function(){
		 $("#submitBtn").click();
	 });
	 
	 $("#submitBtn").click(function(){
		 $('#itemForm').data("bootstrapValidator").validate();
		 if($('#itemForm').data("bootstrapValidator").isValid()){
			 var tmpIncrementTax = $("#incrementTax").val();
			 if(tmpIncrementTax > 1){
				 layer.alert("增值税率填写有误，请重新填写！");
				 return;
			 }
			 var tmpTariff = $("#tariff").val();
			 if(tmpTariff > 1){
				 layer.alert("海关税率填写有误，请重新填写！");
				 return;
			 }
			 var tmpExciseTax = $("#exciseTax").val();
			 if(tmpExciseTax > 1){
				 layer.alert("消费税率填写有误，请重新填写！");
				 return;
			 }
			 
			 var url = "${wmsUrl}/admin/goods/goodsMng/editGoodsInfo.shtml";
			 
			 var formData = sy.serializeObject($('#itemForm'));
			 var context = ue.getContent();
			 formData["detailInfo"] = context;
			 var tagId = $('#tagId li.active').attr('data-id');
			 if (tagId == undefined) {
				 tagId = "";
			 }
			 formData["tagId"] = tagId;
			 
			 var itemDataList=[];
 			 $.each($('#goodsTable tbody tr'),function(r_index,r_obj){
 				var itemData={};
 				var itemPriceData={};
 				var obj_name="";
 				var obj_value="";
 				$.each($(r_obj).find('td'),function(c_index,c_obj){
					obj_name = $(c_obj.firstChild).attr('name');
					if (obj_name == "itemCode") {
						var tmpItemId = $(c_obj.firstChild).attr('data-id');
						var tmpItemStatus = $(c_obj.firstChild).attr('data-status');
						itemData["itemId"] = tmpItemId;
						itemData["status"] = tmpItemStatus;
					}
	 				var type = c_obj.firstChild.nodeName;
	 				if(type == 'INPUT'){
	 					obj_value = $(c_obj.firstChild).val();
	 				}else if(type == 'SPAN'){
// 	 					obj_value = obj_value + $(c_obj.firstChild).text()+ ";" ;
	 					for(var i=0; i<specsCategoryItem.length; i++) {
	 						if ($(c_obj.firstChild).text() == specsCategoryItem[i].split(":")[1].split("|")[1]) {
	 							var tmpSV = specsCategoryItem[i].split(":")[1];
	 							var tmpSK = "";
	 							var tmpSKIndex = specsCategoryItem[i].split(":")[0].split("_")[0].replace("specsValueInfo","");
	 							for(var j=0; j<specsCategory.length; j++) {
	 								if (tmpSKIndex == specsCategory[j].split(":")[0].replace("specsCateInfo","")) {
	 									tmpSK = specsCategory[j].split(":")[1]
	 									break;
	 								}
	 								
	 							}
 								obj_value = obj_value + tmpSK + "&" + tmpSV + ";" ;
 								break;
 							}
	 					}
	 				}

					if (obj_name == "proxyPrice" || obj_name == "fxPrice" ||
						obj_name == "retailPrice" || obj_name == "min" ||
						obj_name == "max") {
						itemPriceData[obj_name] = obj_value;
					} else {
						itemData[obj_name] = obj_value;
					}
	 			});
 				itemData["goodsPrice"] = itemPriceData;
 				itemDataList.push(itemData);
 			 });
			 formData["items"] = itemDataList;
			 for(var json in formData){
				 if(formData[json].indexOf(",")!=-1){
					 formData[json] = "";
				 }
			 }
			 console.log(formData);
			 
			 $.ajax({
				 url:url,
				 type:'post',
				 data:JSON.stringify(formData),
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
				 }
			 });
		 }else{
			 layer.alert("信息填写有误");
		 }
	 });
		
		$('#itemForm').bootstrapValidator({
		//   live: 'disabled',
		   message: 'This value is not valid',
		   feedbackIcons: {
		       valid: 'glyphicon glyphicon-ok',
		       invalid: 'glyphicon glyphicon-remove',
		       validating: 'glyphicon glyphicon-refresh'
		   },
		   fields: {
// 			   	  baseId: {
// 			 		   trigger:"change",
// 		          	   message: '基础商品未添加',
// 		          	   validators: {
// 			               notEmpty: {
// 			                   message: '基础商品未添加！'
// 			               }
// 			           }
// 			   	  },
				  goodsName: {
						trigger:"change",
						message: '商品名称不正确',
						validators: {
							notEmpty: {
								message: '商品名称不能为空！'
							}
						}
				  },
				  itemCode: {
					   trigger:"change",
					   message: '商家编码不正确',
					   validators: {
						   notEmpty: {
							   message: '商家编码不能为空！'
						   }
					   }
				  },
				  incrementTax:{
					   message: '增值税率不正确',
					   validators: {
						   notEmpty: {
							   message: '增值税率不能为空'
						   },
						   numeric: {
							   message: '增值税率只能输入数字'
						   }
					   }
				  },
				  tariff:{
					   message: '海关税率不正确',
					   validators: {
						   notEmpty: {
							   message: '海关税率不能为空'
						   },
						   numeric: {
							   message: '海关税率只能输入数字'
						   }
					   }
				  },
				  exciseTax:{
					   message: '消费税率不正确',
					   validators: {
						   notEmpty: {
							   message: '消费税率不能为空'
						   },
						   numeric: {
							   message: '消费税率只能输入数字'
						   }
					   }
				  },
				  origin: {
					  trigger:"change",
					  message: '国家不正确',
					  validators: {
						   notEmpty: {
							   message: '国家不能为空！'
						   }
					   }
				  },
				  weight: {
						trigger:"change",
						message: '重量不正确',
						validators: {
							notEmpty: {
								message: '重量不能为空！'
							},
							numeric: {
							   message: '重量只能输入数字'
						   }
						}
				   },
				   proxyPrice:{
					   trigger:"change",
					   message:"成本价有误",
					   validators: {
						   notEmpty: {
								  message: '成本价不能为空'
							  },
							  numeric: {
							   message: '成本价只能输入数字'
						   }
						}
				   },
				   fxPrice:{
					   trigger:"change",
					   message:"分销价有误",
					   validators: {
						   numeric: {
							   message: '分销价只能输入数字'
						   }
					   }
				   },
				   retailPrice:{
					   message: '零售价有误',
					   validators: {
						   notEmpty: {
							   message: '零售价不能为空'
						   },
						   numeric: {
							   message: '零售价只能输入数字'
						   }
					   }
				   },
				   min:{
					   message: '最小限购数量有误',
					   validators: {
						   numeric: {
							   message: '最小限购数量只能输入数字'
						   }
					   }
				   },
				   max:{
					   message: '最大限购数量有误',
					   validators: {
						   numeric: {
							   message: '最大限购数量只能输入数字'
						   }
					   }
				   }
		}});
		
		function toTag(){
			var index = layer.open({
				  title:"新增标签",	
				  area: ['80%', '40%'],	
				  type: 2,
				  content: '${wmsUrl}/admin/goods/goodsMng/toTag.shtml',
				  maxmin: false
				});
		}
		
		function refreshTag(){
			$.ajax({
				 url:"${wmsUrl}/admin/goods/goodsMng/refreshTag.shtml",
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
							$("#tagId").html("");
							var str = "";
							for (var i = 0; i < list.length; i++) {
								str += "<li>"+list[i].tagName+"</li>";
							}
							$("#tagId").html(str);
					 }else{
						 layer.alert(data.msg);
					 }
				 },
				 error:function(){
					 layer.alert("刷新标签内容失败，请联系客服处理");
				 }
			 });
	 	}
		
		//点击标签选中
		$('.item-right').on('click','.label-content li:not(active)',function(){
		});
		//点击标签取消
		$('.item-right').on('click','.label-content li.active',function(){
		});
		//点击上传图片
		$('.item-right').on('change','.item-img input[type=file]',function(){
			var id = $(this).parent().attr("data-id");
			var nextId =  parseInt(id)+1;
			
			var imagSize = document.getElementById("pic"+id).files[0].size;
			if(imagSize>1024*1024*3) {
				layer.alert("图片大小请控制在3M以内，当前图片为："+(imagSize/(1024*1024)).toFixed(2)+"M");
				return true;
			}
			
			$.ajaxFileUpload({
				url : '${wmsUrl}/admin/uploadFileForGrade.shtml', //你处理上传文件的服务端
				secureuri : false,
				fileElementId : "pic"+id,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						var ht = '<div class="item-img" id="content'+nextId+'" data-id="'+nextId+'">+<input type="file" id="pic'+nextId+'" name="pic"/></div>';
						var imgHt = '<img src="'+data.msg+'"><div class="bgColor"><i class="fa fa-trash fa-fw"></i></div>';
						var imgPath = imgHt+ '<input type="hidden" value='+data.msg+' id="picPath'+id+'" name="picPath">'
						$('.addContent').append(ht);
						$("#content"+id).html(imgPath);
						$("#content"+id).addClass('choose');
					} else {
						layer.alert(data.msg);
					}
				}
			})
		});
		//删除主图
		$('.item-right').on('click','.bgColor i',function(){
			$(this).parent().parent().remove();
		});
		//切换tabBar
		$('.list-tabBar').on('click','ul li:not(.active)',function(){
			$(this).addClass('active').siblings('.active').removeClass('active');
			var typeId = $(this).attr('data-id'); 
			if(typeId == 1){
				$('#itemForm').show();
				$('#itemForm2').hide();
			}else if(typeId == 2){
				$('#itemForm2').show();
				$('#itemForm').hide();
			}
		});
		 
		 $("#nextPageBtn").click(function(){
			$("#detailInfo").addClass('active').siblings('.active').removeClass('active');
			$('#itemForm2').show();
			$('#itemForm').hide();
		 });
		 
		 $("#prePageBtn").click(function(){
			$("#baseInfo").addClass('active').siblings('.active').removeClass('active');
			$('#itemForm').show();
			$('#itemForm2').hide();
		 });
		 
		//实例化编辑器
	    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
		var ue = UE.getEditor('editor');
	    function sleep(numberMillis) { 
	    	var now = new Date(); 
	    	var exitTime = now.getTime() + numberMillis; 
	    	while (true) { 
		    	now = new Date(); 
		    	if (now.getTime() > exitTime) 
		    	return; 
	    	} 
	   	}
// 	    function saveHtml(){
// 	    	var context = ue.getContent();
// 	    	if(context == ''){
// 	    		layer.alert("没有内容！");
// 	    		return;
// 	    	}
	    	
// 	    	$.ajax({
// 				 url:"${wmsUrl}/admin/goods/goodsMng/saveHtml.shtml",
// 				 type:'post',
// 				 data:{"html":context,"goodsId":""},
// 				 dataType:'json',
// 				 success:function(data){
// 					 if(data.success){	
// 						 layer.alert("保存成功");
// 						 parent.reloadTable();
// 					 }else{
// 						 layer.alert(data.msg);
// 					 }
// 				 },
// 				 error:function(){
// 					 layer.alert("提交失败，请联系客服处理");
// 				 }
// 			 });
// 	    }
	    function isFocus(e){
	        alert(UE.getEditor('editor').isFocus());
	        UE.dom.domUtils.preventDefault(e)
	    }
	    function setblur(e){
	        UE.getEditor('editor').blur();
	        UE.dom.domUtils.preventDefault(e)
	    }
	    function insertHtml() {
	        var value = prompt('插入html代码', '');
	        UE.getEditor('editor').execCommand('insertHtml', value)
	    }
	    function createEditor() {
	        enableBtn();
	        UE.getEditor('editor');
	    }
	    function getAllHtml() {
	        alert(UE.getEditor('editor').getAllHtml())
	    }
	    function getContent() {
	        var arr = [];
	        arr.push("使用editor.getContent()方法可以获得编辑器的内容");
	        arr.push("内容为：");
	        arr.push(UE.getEditor('editor').getContent());
	        alert(arr.join("\n"));
	    }
	    function getPlainTxt() {
	        var arr = [];
	        arr.push("使用editor.getPlainTxt()方法可以获得编辑器的带格式的纯文本内容");
	        arr.push("内容为：");
	        arr.push(UE.getEditor('editor').getPlainTxt());
	        alert(arr.join('\n'))
	    }
	    function setContent(isAppendTo) {
	        var arr = [];
	        arr.push("使用editor.setContent('欢迎使用ueditor')方法可以设置编辑器的内容");
	        UE.getEditor('editor').setContent('欢迎使用ueditor', isAppendTo);
	        alert(arr.join("\n"));
	    }
	    function setDisabled() {
	        UE.getEditor('editor').setDisabled('fullscreen');
	        disableBtn("enable");
	    }
	    function setEnabled() {
	        UE.getEditor('editor').setEnabled();
	        enableBtn();
	    }
	    function getText() {
	        //当你点击按钮时编辑区域已经失去了焦点，如果直接用getText将不会得到内容，所以要在选回来，然后取得内容
	        var range = UE.getEditor('editor').selection.getRange();
	        range.select();
	        var txt = UE.getEditor('editor').selection.getText();
// 	        alert(txt)
	    }
	    function getContentTxt() {
	        var arr = [];
	        arr.push("使用editor.getContentTxt()方法可以获得编辑器的纯文本内容");
	        arr.push("编辑器的纯文本内容为：");
	        arr.push(UE.getEditor('editor').getContentTxt());
// 	        alert(arr.join("\n"));
	    }
	    function hasContent() {
	        var arr = [];
	        arr.push("使用editor.hasContents()方法判断编辑器里是否有内容");
	        arr.push("判断结果为：");
	        arr.push(UE.getEditor('editor').hasContents());
// 	        alert(arr.join("\n"));
	    }
	    function setFocus() {
	        UE.getEditor('editor').focus();
	    }
	    function deleteEditor() {
	        disableBtn();
	        UE.getEditor('editor').destroy();
	    }
	    function disableBtn(str) {
	        var div = document.getElementById('btns');
	        var btns = UE.dom.domUtils.getElementsByTagName(div, "button");
	        for (var i = 0, btn; btn = btns[i++];) {
	            if (btn.id == str) {
	                UE.dom.domUtils.removeAttributes(btn, ["disabled"]);
	            } else {
	                btn.setAttribute("disabled", "true");
	            }
	        }
	    }
	    function enableBtn() {
	        var div = document.getElementById('btns');
	        var btns = UE.dom.domUtils.getElementsByTagName(div, "button");
	        for (var i = 0, btn; btn = btns[i++];) {
	            UE.dom.domUtils.removeAttributes(btn, ["disabled"]);
	        }
	    }
	    function getLocalData () {
// 	        alert(UE.getEditor('editor').execCommand( "getlocaldata" ));
	    }
	    function clearLocalData () {
	        UE.getEditor('editor').execCommand( "clearlocaldata" );
// 	        alert("已清空草稿箱")
	    }
	    
	    $(window).load(function(){
			UE.getEditor('editor').execCommand('insertHtml', '${detailInfo}');
	    });
	    
// 		 $(function () {
// 	 	     CKEDITOR.replace('editor1');
// 	 	     $(".textarea").wysihtml5();
// 		 });
	</script>
</body>
</html>
