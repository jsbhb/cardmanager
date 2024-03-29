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
	<section class="content-header">
	      <ol class="breadcrumb">
	        <li><a href="javascript:void(0);">首页</a></li>
	        <li>商品管理</li>
	        <li class="active">新增商品</li>
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
	       		<h1>基础信息</h1>
	       	</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">商品品牌</div>
				<div class="col-sm-9 item-right">
	                <input type="text" class="form-control" name="brand" id="brand" readonly style="background:#fff;" placeholder="选择品牌"/>
	                <input type="hidden" class="form-control" name="baseId" id="baseId"/>
	                <input type="hidden" class="form-control" name="brandId" id="brandId"/>
					<a class="addBtn" href="javascript:void(0);" onclick="toBrand()">新增品牌</a>
					<a class="addBtn" href="javascript:void(0);" onclick="showBaseGoods()">浏览模板</a>
				</div>
			</div>
			<div class="list-item" style="display:none">
				<div class="col-sm-3 item-left">商品品牌</div>
				<div class="col-sm-9 item-right">
			   		<select class="form-control" id="hidBrand">
		                <c:forEach var="brand" items="${brands}">
		                <option value="${brand.brandId}">${brand.brand}</option>
		                </c:forEach>
		            </select>
				</div>
			</div>
			<div class="select-content">
				<input type="text" placeholder="请输入品牌名称" id="searchBrand"/>
	            <ul class="first-ul" style="margin-left:5px;">
	           		<c:forEach var="brand" items="${brands}">
	           			<c:set var="brand" value="${brand}" scope="request" />
						<li><span data-id="${brand.brandId}" data-name="${brand.brand}" class="no-child">${brand.brand}</span></li>
					</c:forEach>
	           	</ul>
	       	</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">商品分类</div>
				<div class="col-sm-9 item-right">
	                <input type="hidden" class="form-control" name="catalog" id="catalog"/>
	                <div class="right-items">
						<select class="form-control" name="firstCatalogId" id="firstCatalogId">
	                  	  <option selected="selected" value="-1">选择分类</option>
	                  	  <c:forEach var="first" items="${firsts}">
	                  	  	<option value="${first.firstId}">${first.name}</option>
	                  	  </c:forEach>
	                	</select>	
					</div>
					<div class="right-items">
						<select class="form-control" name="secondCatalogId" id="secondCatalogId">
						<option selected="selected" value="-1">选择分类</option>
		                </select>
	                </div>
	                <div class="right-items last-items">
						<select class="form-control" name="thirdCatalogId" id="thirdCatalogId">
						<option selected="selected" value="-1">选择分类</option>
		                </select>
	                </div>
					<a class="addBtn" href="javascript:void(0);" onclick="toCategory()">新增分类</a>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">计量单位</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="unit" id="unit">
					<div class="item-content">
	             		（包、件、个）
	             	</div>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">海关代码</div>
				<div class="col-sm-9 item-right">
                 	<input type="text" class="form-control" name="hscode" id="hscode">
		            <div class="item-content">
	             		（海关代码HSCode）
	             	</div>
	            </div>
			</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">增值税率</div>
				<div class="col-sm-9 item-right">
                	<input type="text" class="form-control" name="incrementTax" id="incrementTax" value="0.13"/>
					<div class="item-content">
		             	（请按小数格式输入，例：0.17）
		            </div>
				</div>
			</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">海关税率</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="tariff" id="tariff"/>
					<div class="item-content">
		             	（请按小数格式输入，例：0.17）
		            </div>
				</div>
			</div>
	      	<div class="list-item">
				<div class="col-sm-3 item-left">商品名称</div>
				<div class="col-sm-9 item-right">
               		<input type="text" class="form-control" name="goodsName" id="goodsName">
				</div>
			</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">供应商</div>
				<div class="col-sm-9 item-right">
					<select class="form-control" name="supplierId" id="supplierId">
                	  <option selected="selected" value="-1">未选择</option>
                   	  <c:forEach var="supplier" items="${suppliers}">
                   	  	<option value="${supplier.id}">${supplier.supplierName}</option>
                   	  </c:forEach>
	                </select>
	               <input type="hidden" class="form-control" name="supplierName" id="supplierName"/>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">商品类型</div>
				<div class="col-sm-9 item-right">
					<select class="form-control" name="type" id="type">
                	  <option selected="selected" value="0">保税商品</option>
                	  <option value="2">一般贸易商品</option>
                	  <option value="3">直邮商品</option>
	                </select>
	               <input type="hidden" class="form-control" name="supplierName" id="supplierName"/>
				</div>
			</div>
	      	<div class="list-item">
				<div class="col-sm-3 item-left">原产国</div>
				<div class="col-sm-9 item-right">
	                 <input type="text" class="form-control" name="origin">
				</div>
			</div>
	      	<div class="list-item">
				<div class="col-sm-3 item-left">商品权重</div>
				<div class="col-sm-9 item-right">
	                 <input type="text" class="form-control" name="goodsTagRatio">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">商品标签</div>
				<div class="col-sm-9 item-right">
					<ul class="label-content-express" id="tagId">
						<c:forEach var="tag" items="${tags}">
							<li data-id="${tag.id}">${tag.tagName}</li>
	             	    </c:forEach>
					</ul>
					<a class="addBtn" href="javascript:void(0);" onclick="toTag()">+新增标签</a>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">商品主图</div>
				<div class="col-sm-9 item-right addContent">
					<div class="item-img" id="content1" data-id="1">
						+
						<input type="file" id="pic1" name="pic"/>
					</div>
				</div>
			</div>
			
			<div class="title">
	       		<h1>明细信息</h1>
	       	</div>
	       	
	       	<div class="list-item">
				<div class="col-sm-3 item-left">产品规格</div>
				<div class="col-sm-9 item-right">
             		<ul class="label-content" id="specsSwitch" style="padding-left:10px;">
             			<li class="active" data-type="0">无规格</li>
             			<li data-type="1">商品规格</li>
             		</ul>
             		<div class="item-content">
		             	（如有颜色、尺码等多种规格，请选择商品规格）
		            </div>
				</div>
			</div>
	       
	        <div id="noSpecs" style="padding:0 20px;">
				<div class="list-item">
					<div class="col-sm-3 item-left"><font style="color:red">*</font>商家编码</div>
					<div class="col-sm-9 item-right">
	             		<input type="text" class="form-control" name="itemCode" id="itemCode">
						<div class="item-content">
			             	（货主管理货物的编码）
			            </div>
					</div>
				</div>
		       	<div class="list-item">
					<div class="col-sm-3 item-left"><font style="color:red">*</font>自有编码</div>
					<div class="col-sm-9 item-right">
	               		<input type="text" class="form-control" name="sku" id="sku">
						<div class="item-content">
			             	（自行管理货物的编码或商家编码）
			            </div>
					</div>
				</div>
		       	<div class="list-item">
					<div class="col-sm-3 item-left">条形码</div>
					<div class="col-sm-9 item-right">
	               		<input type="text" class="form-control" name="encode" id="encode">
						<div class="item-content">
			             	（商品自带的条形码）
			            </div>
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left"><font style="color:red">*</font>商品重量</div>
					<div class="col-sm-9 item-right">
		                <input type="text" class="form-control" name="weight" id="weight">
						<div class="item-content">
							（单位：克，请按整数格式输入，例：2500）
			            </div>
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left"><font style="color:red">*</font>换算比例</div>
					<div class="col-sm-9 item-right">
		                <input type="text" class="form-control" name="conversion" id="conversion" value="1">
						<div class="item-content">
							（包装单位与计量单位的换算比例，如1包装单位=10计量单位，则填10）
			            </div>
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left">消费税率</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="exciseTax" id="exciseTax" value="0">
						<div class="item-content">
			             	（请按小数格式输入，例：0.17）
			            </div>
		            </div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left">保质期</div>
					<div class="col-sm-9 item-right">
		                <input type="text" class="form-control" name="shelfLife" id="shelfLife">
						<div class="item-content">
							（商品的保质期，例：2年，18个月）
			            </div>
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left">箱规</div>
					<div class="col-sm-9 item-right">
		                <input type="text" class="form-control" name="carTon" id="carTon">
						<div class="item-content">
							（例：8组，24罐）
			            </div>
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left"><font style="color:red">*</font>成本价</div>
					<div class="col-sm-9 item-right">
		                <input type="text" class="form-control" name="proxyPrice" id="proxyPrice">
		                <div class="item-content">
			             	（请按价格格式输入，例：113.35）
			            </div>
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left"><font style="color:red">*</font>分销价</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="fxPrice" id="fxPrice">
						<div class="item-content">
			             	（请按价格格式输入，例：113.35）
			            </div>
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left"><font style="color:red">*</font>零售价</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="retailPrice" id="retailPrice">
						<div class="item-content">
			             	（请按价格格式输入，例：113.35）
			            </div>
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left"><font style="color:red">*</font>划线价</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="linePrice" id="linePrice">
						<div class="item-content">
			             	（请按价格格式输入，例：113.35）
			            </div>
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left">限购数量</div>
					<div class="col-sm-9 item-right">
						<div class="right-item">
		              		<input type="text" class="form-control" name="min" id="min" value="1" placeholder="请输入最小购买量">
						</div>
		            	<div class="right-item last-item">
	                 		<input type="text" class="form-control" name="max" id="max" placeholder="请输入最大购买量">
						</div>
						<div class="item-content">
			             	（请按整数格式输入，填0表示不限制数量）
			            </div>
					</div>
				</div>
	        </div>
			
			<div id="specs" style="display:none;padding:0 20px;">
				<div class="list-item col-sm-6 col-sm-offset-3" id="specsOperation">
					<div class="list-all">
						<div class="row-bg-gray">
							<a class="addBtn" href="javascript:void(0);" onclick="addSpecsModule(this)">添加规格</a>
						</div>
					</div>
				</div>
				
				<div class="list-item" id="specsItem" style="width:100%;">
					<div class="list-all">
						<table class="dynamic-table" id="dynamicTable">
							<caption>规格明细</caption>
							<thead id="dynamic-thead">
							</thead>
							<tbody id="dynamic-table">
							</tbody>
							<tfoot>
								<tr>
									<td colspan="13">
										<span>批量设置 ： </span>
										<span>
											<a href="javascript:void(0)" onclick="batchSetTableItem('weight')">商品重量</a>
											<a href="javascript:void(0)" onclick="batchSetTableItem('shelfLife')">保质期</a>
											<a href="javascript:void(0)" onclick="batchSetTableItem('carTon')">箱规</a>
											<a href="javascript:void(0)" onclick="batchSetTableItem('proxyPrice')">成本价</a>
											<a href="javascript:void(0)" onclick="batchSetTableItem('fxPrice')">分销价</a>
											<a href="javascript:void(0)" onclick="batchSetTableItem('retailPrice')">零售价</a>
											<a href="javascript:void(0)" onclick="batchSetTableItem('linePrice')">划线价</a>
											<a href="javascript:void(0)" onclick="batchSetTableItem('min')">限购数量(min)</a>
											<a href="javascript:void(0)" onclick="batchSetTableItem('max')">限购数量(max)</a>
										</span>
										<div id="batchSetting" class="batchSetting">
											<input type="text" class="inline-input" id="batchInput"/>
											<a href="javascript:void(0)" onclick="batchSaveTableItem()">保存</a>
											<a href="javascript:void(0)" onclick="batchSetedTableItem()">取消</a>
										</div>
									</td>
								</tr>
							</tfoot>
						</table>
					</div>
				</div>
			</div>
			
			<div class="scrollImg-content broadcast"></div>
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
					<div id="editor" type="text/plain" name="ueditor" style="height:320px;" align=center></div>
				</div>
			</div>
	        <div class="submit-btn">
	           	<button type="button" id="prePageBtn">上一页</button>
	           	<button type="button" id="submitBtn">新增商品</button>
	       	</div>
		</form>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script src="${wmsUrl}/js/component/broadcast.js"></script>
<%-- 	<script src="${wmsUrl}/plugins/ckeditor/ckeditor.js"></script> --%>
	<script type="text/javascript" src="${wmsUrl}/js/ajaxfileupload.js"></script>
	<script type="text/javascript" charset="utf-8" src="${wmsUrl}/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="${wmsUrl}/ueditor/ueditor.all.min.js"></script>
	<script type="text/javascript" charset="utf-8" src="${wmsUrl}/ueditor/lang/zh-cn/zh-cn.js"></script>
	<script type="text/javascript" charset="utf-8" src="${wmsUrl}/js/goodsJs/goods.js"></script>
	<script type="text/javascript">	 
	var cpLock = false;
    $('#searchBrand').on('compositionstart', function () {
        cpLock = true;
    });
    $('#searchBrand').on('compositionend', function () {
        cpLock = false;
    });
    
 	$("#brand").change(function(){
		//赋值
		$("#baseId").val("");
	});
 	
 	$("#unit").change(function(){
		$("#baseId").val("");
 	});
 	
 	$("#hscode").change(function(){
		$("#baseId").val("");
 	});
	 
	$("#supplierId").change(function(){
		$("#supplierName").val($("#supplierId").find("option:selected").text());
	});
	
 	//模板选择后
 	function choiseModel(){
 		var tmpBaseId = $("#baseId").val();
		//分类
		var tmpCatalog = $("#catalog").val();
 		var firstSelect = document.getElementById("firstCatalogId");
		var foptions = firstSelect.options;
		for(var j=0;j<foptions.length;j++){
			if (tmpCatalog.split("-")[0]==foptions[j].text) {
				foptions[j].selected = true;
				break;
			}
		}
		$("#firstCatalogId").change();
 		var secondSelect = document.getElementById("secondCatalogId");
		var soptions = secondSelect.options;
		for(var j=0;j<soptions.length;j++){
			if (tmpCatalog.split("-")[1]==soptions[j].text) {
				soptions[j].selected = true;
				break;
			}
		}
		$("#secondCatalogId").change();
 		var thirdSelect = document.getElementById("thirdCatalogId");
		var toptions = thirdSelect.options;
		for(var j=0;j<toptions.length;j++){
			if (tmpCatalog.split("-")[2]==toptions[j].text) {
				toptions[j].selected = true;
				break;
			}
		}
		//赋值
		$("#baseId").val(tmpBaseId);
		$("#catalog").val("");
	}
	
	$("#firstCatalogId").change(function(){
		$("#baseId").val("");
		var firstId = $("#firstCatalogId").val();
		var secondSelect = $("#secondCatalogId");
		var thirdSelect = $("#thirdCatalogId");
		secondSelect.empty();
		secondSelect.append("<option value='-1'>选择分类</option>")
		thirdSelect.empty();
		thirdSelect.append("<option value='-1'>选择分类</option>")
		$.ajax({
			 url:"${wmsUrl}/admin/goods/catalogMng/querySecondCatalogByFirstId.shtml?firstId="+firstId,
			 type:'post',
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 async:false,
			 success:function(data){
				 if(data.success){
					 if (data == null || data.length == 0) {
							return;
						}
						
						var list = data.obj;
						
						if (list == null || list.length == 0) {
							return;
						}
						for (var i = 0; i < list.length; i++) {
							secondSelect.append("<option value='"+list[i].secondId+"'>"+list[i].name+"</option>")
						}
				 }else{
					 layer.alert(data.msg);
				 }
			 },
			 error:function(){
				 layer.alert("提交失败，请联系客服处理");
			 }
		 });
	});
	
	$("#secondCatalogId").change(function(){
		$("#baseId").val("");
		var secondId = $("#secondCatalogId").val();
		var thirdSelect = $("#thirdCatalogId");
		thirdSelect.empty();
		thirdSelect.append("<option value='-1'>选择分类</option>")
		$.ajax({
			 url:"${wmsUrl}/admin/goods/catalogMng/queryThirdCatalogBySecondId.shtml?secondId="+secondId,
			 type:'post',
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 async:false,
			 success:function(data){
				 if(data.success){
					 if (data == null || data.length == 0) {
							return;
						}
						
						var list = data.obj;
						
						if (list == null || list.length == 0) {
							return;
						}

						thirdSelect.empty();
						for (var i = 0; i < list.length; i++) {
							thirdSelect.append("<option value='"+list[i].thirdId+"'>"+list[i].name+"</option>")
						}
				 }else{
					 layer.alert(data.msg);
				 }
			 },
			 error:function(){
				 layer.alert("提交失败，请联系客服处理");
			 }
		 });
	});
	
	$("#thirdCatalogId").change(function(){
		$("#baseId").val("");
	});
	 
	 $("#saveInfoBtn").click(function(){
		 $("#submitBtn").click();
	 });
	 
	 $("#submitBtn").click(function(){
		 $('#itemForm').data("bootstrapValidator").validate();
		 if($('#itemForm').data("bootstrapValidator").isValid()){
			 var tmpBrand = $("#brand").val();
			 if(tmpBrand == ""){
				 layer.alert("请选择品牌信息");
				 return;
			 }
			 var tmpBrandId = $("#brandId").val();
			 if(tmpBrandId == ""){
				 layer.alert("请重新选择品牌信息");
				 return;
			 }
			 var tmpFirstCatalogId = $("#firstCatalogId").val();
			 if(tmpFirstCatalogId == -1){
				 layer.alert("请选择商品一级分类");
				 return;
			 }
			 var tmpSecondCatalogId = $("#secondCatalogId").val();
			 if(tmpSecondCatalogId == -1){
				 layer.alert("请选择商品二级分类");
				 return;
			 }
			 var tmpThirdCatalogId = $("#thirdCatalogId").val();
			 if(tmpThirdCatalogId == -1){
				 layer.alert("请选择商品三级分类");
				 return;
			 }
			 var tmpSupplierId = $("#supplierId").val();
			 if(tmpSupplierId == -1){
				 layer.alert("请选择供应商");
				 return;
			 }
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
			 var url = "${wmsUrl}/admin/goods/goodsMng/createGoodsInfo.shtml";
			 var formData = sy.serializeObject($('#itemForm'));
			 var context = ue.getContent();
			 formData["detailInfo"] = context;
			 
			 var valArr = new Array;
			 var tagId;
			 $('#tagId li.active').each(function(i){
				 valArr[i] = $(this).attr('data-id');
			 });
			 if(valArr.length == 0){
				 tagId = "";
			 } else {
			 	 tagId = valArr.join('|');//转换为|隔开的字符串 
			 }
			 formData["tagId"] = tagId;
			 var specsSwitchId = $('#specsSwitch li.active').attr('data-type');
			 if (specsSwitchId == "1") {
				 if ($('#dynamicTable tbody tr').length <1) {
					 layer.alert("请选择规格信息！");
					 return;
				 }
				 if (!checkTableInfo()) {
					return; 
				 }
				 formData["items"] = getTableInfo();
				 for(var json in formData){
					 if(formData[json].indexOf(",")!=-1){
						 formData[json] = "";
					 }
				 }
			 }
			 //多张图片时序列化的值被清空了，重新赋值
			 if (formData["picPath"] == "") {
				 formData["picPath"] = getAllPicPath();
			 }
			 formData["createKey"] = "${key}";
			 
// 			 console.log(formData);
// 			 return;
			 
			 $.ajax({
				 url:url,
				 type:'post',
				 data:JSON.stringify(formData),
				 contentType: "application/json; charset=utf-8",
				 dataType:'json',
				 success:function(data){
					 if(data.success){
						 if (data.msg != null) {
							 updateStaticFolderNameById(data.msg);
						 } else {
	 						 jump(10);
						 }
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
	 
	 function updateStaticFolderNameById(movePath) {
		var oldPath = movePath.split("|")[0];
		var newPath = movePath.split("|")[1];
		
		$.ajax({
			 url:"${renameApiUrl}",
			 method:'post',
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 data:JSON.stringify([{"old":oldPath,"new":newPath}]),
			 success:function(data){
				 if(data.success){	
					 jump(10);
				 }else{
					 layer.alert("商品图片保存目录重命名失败，请联系客服处理");
				 }
			 },
			 error:function(){
				 layer.alert("新建商品时重命名目录异常，请联系客服处理");
			 }
		 });
	 }
	 
		function showBaseGoods(){
			var index = layer.open({
				  title:"查看基础商品",	
				  area: ['90%', '90%'],
				  type: 2,
				  content: '${wmsUrl}/admin/goods/baseMng/listForAdd.shtml',
				  maxmin: false
				});
		}
		
		$('#itemForm').bootstrapValidator({
		//   live: 'disabled',
		   message: 'This value is not valid',
		   feedbackIcons: {
		       valid: 'glyphicon glyphicon-ok',
		       invalid: 'glyphicon glyphicon-remove',
		       validating: 'glyphicon glyphicon-refresh'
		   },
		   fields: {
				  unit: {
						message: '计量单位不正确',
						validators: {
							notEmpty: {
								message: '计量单位不能为空！'
							}
						}
				  },
// 				  hscode: {
// 						message: '海关代码不正确',
// 						validators: {
// 							notEmpty: {
// 								message: '海关代码不能为空！'
// 							}
// 						}
// 				  },
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
				  goodsName: {
						message: '商品名称不正确',
						validators: {
							notEmpty: {
								message: '商品名称不能为空！'
							}
						}
				  },
				  itemCode: {
					   message: '商家编码不正确',
					   validators: {
						   notEmpty: {
							   message: '商家编码不能为空！'
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
					  message: '原产国不正确',
					  validators: {
						   notEmpty: {
							   message: '原产国不能为空！'
						   }
					   }
				  },
				  weight: {
						message: '商品重量不正确',
						validators: {
							notEmpty: {
								message: '商品重量不能为空！'
							},
							numeric: {
							   message: '商品重量只能输入数字'
						   }
						}
				   },
				   conversion: {
						message: '换算比例不正确',
						validators: {
							notEmpty: {
								message: '换算比例不能为空！'
							},
							numeric: {
							   message: '换算只能输入数字'
						   }
						}
				   },
				   proxyPrice:{
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
					   message:"分销价有误",
					   validators: {
						   notEmpty: {
								  message: '分销价不能为空'
							  },
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
				   linePrice:{
					   message: '划线价有误',
					   validators: {
						   notEmpty: {
							   message: '划线不能为空'
						   },
						   numeric: {
							   message: '划线价只能输入数字'
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
		
		function toBrand(){
			var index = layer.open({
				  title:"新增品牌",	
				  area: ['80%', '40%'],	
				  type: 2,
				  content: '${wmsUrl}/admin/goods/brandMng/toAdd.shtml',
				  maxmin: false
				});
		}
		
		function toCategory(){
			var index = layer.open({
				  title:"新增分类",	
				  area: ['80%', '55%'],	
				  type: 2,
				  content: '${wmsUrl}/admin/goods/catalogMng/createCategoryInfo.shtml',
				  maxmin: false
				});
		}
		
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
// 				url : '${wmsUrl}/admin/uploadFileForGrade.shtml', //你处理上传文件的服务端
				url : '${wmsUrl}/admin/uploadFileWithType.shtml?type=goods&key='+"${key}", //你处理上传文件的服务端
				secureuri : false,
				fileElementId : "pic"+id,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						var ht = '<div class="item-img" id="content'+nextId+'" data-id="'+nextId+'">+<input type="file" id="pic'+nextId+'" name="pic"/></div>';
						var imgHt = '<img src="'+data.msg+'"><div class="bgColor"><i class="fa fa-arrow-left fa-fw"></i><i class="fa fa-trash fa-fw"></i><i class="fa fa-search fa-fw"></i><i class="fa fa-arrow-right fa-fw"></i></div>';
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
		$('.item-right').on('click','.bgColor i.fa-trash',function(){
			$(this).parent().parent().remove();
		});
		//图片左移
		$('.item-right').on('click','.bgColor i.fa-arrow-left',function(){
			var thePar = $(this).parent().parent();
			var prev = thePar.prev();
			var theImg = thePar.find('img').attr('src');
			var prevImg = prev.find('img').attr('src');
			var lastImg = thePar.parent().children("div:eq(-2)").find('img').attr('src');
			if(prevImg == undefined){
				thePar.find('img').attr('src',lastImg);
				thePar.parent().children("div:eq(-2)").find('img').attr('src',theImg);
				thePar.find('input').attr('value',lastImg);
				thePar.parent().children("div:eq(-2)").find('input').attr('value',theImg);
			}else{
				thePar.find('img').attr('src',prevImg);
				prev.find('img').attr('src',theImg);
				thePar.find('input').attr('value',prevImg);
				prev.find('input').attr('value',theImg);
			}
		});
		//图片右移
		$('.item-right').on('click','.bgColor i.fa-arrow-right',function(){
			var thePar = $(this).parent().parent();
			var next = thePar.next();
			var theImg = thePar.find('img').attr('src');
			var nextImg = next.find('img').attr('src');
			var firstImg = thePar.parent().children("div:first-child").find('img').attr('src');
			if(nextImg == undefined){
				thePar.find('img').attr('src',firstImg);
				thePar.parent().children("div:first-child").find('img').attr('src',theImg);
				thePar.find('input').attr('value',firstImg);
				thePar.parent().children("div:first-child").find('input').attr('value',theImg);
			}else{
				thePar.find('img').attr('src',nextImg);
				next.find('img').attr('src',theImg);
				thePar.find('input').attr('value',nextImg);
				next.find('input').attr('value',theImg);
			}
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
		//自定义请求参数
	    ue.ready(function() {
	        ue.execCommand('serverparam', {
	            'goodsId': '${key}'
	        });
	    });
	    function sleep(numberMillis) { 
	    	var now = new Date(); 
	    	var exitTime = now.getTime() + numberMillis; 
	    	while (true) { 
		    	now = new Date(); 
		    	if (now.getTime() > exitTime) 
		    	return; 
	    	} 
	   	}
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
	    
	    
	  //新增规格
	  function addSpecsModule(e){
    	var html = "<div class=\"list-all-parent\"><span class=\"remove_specs\">&times;</span><div class=\"list-all-item list-all-item-key\"><div class=\"item-left\">规格分类</div><div class=\"item-right\"><div class=\"select-item\">";
    	$.ajax({
    		url:"${wmsUrl}/admin/goods/specsMng/queryAllSpecs.shtml",
    		type:'post',
    		contentType: "application/json; charset=utf-8",
    		dataType:'json',
    		success:function(data){
    			var list = data;
    			html += "<select class=\"form-control select-key\"";
    			
    			if (list == null || list.length == 0) {
    				html += " name=\"type\"><option value=\"-1\">没有可选择的值</option>";
				}else{
					html += " onchange=\"changeSpecsValueInfo(this)\"><option value=\"-1\">请选择</option>"
					for (var i = 0; i < list.length; i++) {
	    				html += "<option value=\""+list[i].id+"\">"+list[i].name+"</option>";
					}
				}
    			html += "</select></div></div></div><div class=\"list-all-item\"><div class=\"item-left\">规格值</div><div class=\"item-right item-value\"></div></div></div>"
    		    $(e).parent(0).before(html);
    			
    			$('.remove_specs').on('click',function(){
    				$(this).parent().remove();
    				rebuildTable();
    			});
    		},
    		error:function(){
    			layer.alert("查询失败，请联系客服处理");
    		}
    	});
	  }
	  
	  function changeSpecsValueInfo(e){
		  
		  var id = $(e).find("option:selected").val();
		  
		  $(e).parent().parent().parent().parent().find(".item-value").empty();
		  
		  //alert($(e).parent().parent().parent().parent().find('.item-value').prop("outerHTML"));
		  $.ajax({
				url:"${wmsUrl}/admin/goods/specsMng/queryAllSpecsValue.shtml?id="+id,
				type:'post',
				contentType: "application/json; charset=utf-8",
				dataType:'json',
				success:function(data){
					var html="<div class=\"select-item\"><select onchange=\"rebuildTable(this)\" class=\"form-control select-value\"><option value=\"-1\">请选择</option>";
					var list = data;
					if (list == null || list.length == 0) {
						html +=  '<option value="-1">没有可选择的值</option>';
					}else{
						for (var i = 0; i < list.length; i++) {
							html +=  '<option value="'+list[i].id+'">'+list[i].value+'</option>';
						}
					}
					$(e).parent().parent().parent().parent().find(".item-value").html(html+"</select></div><a class=\"addBtn\" href=\"javascript:void(0);\" onclick=\"addSpecsValue(this)\">添加规格值</a>");
				},
				error:function(){
					layer.alert("查询失败，请联系客服处理");
				}
		  });
	  }
	  
	  function batchSetTableItem(itemName){
		  $("#batchSetting").addClass("active");
		  $("#batchSetting").attr("data-id",itemName);
	  }
	  
	  function batchSaveTableItem(){
		  var tmpItem = $("#batchSetting").attr("data-id");
		  var tmpItemInput = $("#batchInput").val();
		  
		  $.each($('#dynamicTable tbody tr'),function(r_index,r_obj){
			var obj_name="";
			$.each($(r_obj).find('td'),function(c_index,c_obj){
				obj_name = $(c_obj.firstChild).attr('name');
				if (obj_name == tmpItem) {
					$(c_obj.firstChild).val(tmpItemInput);
				}
			});
		  });

		  $("#batchInput").val("");
		  $("#batchSetting").removeAttr("data-id");
		  batchSetedTableItem();
	  }
	  
	  function batchSetedTableItem(){
		  $("#batchSetting").removeClass("active");
	  }

	  function checkTableInfo(){
		 var retFlg = true;
		 var e_index = "";
		 var e_msg;
	  	 $.each($('#dynamicTable tbody tr'),function(r_index,r_obj){
	  		var obj_name="";
			var obj_value="";
	  		$.each($(r_obj).find('td'),function(c_index,c_obj){
	  			obj_name = $(c_obj.firstChild).attr('name');
	  			var type = c_obj.firstChild.nodeName;
	  			if(type == 'INPUT'){
	  				obj_value = $(c_obj.firstChild).val();
	  				if (obj_name == "itemCode" || obj_name == "sku" ||
  		  				obj_name == "weight" || obj_name == "conversion" ||
  		  				obj_name == "proxyPrice" || obj_name == "fxPrice" ||
  		  				obj_name == "retailPrice" || obj_name == "linePrice") {
	  					if (obj_value == "") {
	  						e_index = e_index + (r_index+1) + ",";
	  						retFlg = false;
	  						return false;
	  					}
  		  			}
	  			}
	  		});
	  	 });
	  	 if (!retFlg) {
	  		e_index = e_index.substring(0,e_index.length-1);
	  		e_msg = "第"+(e_index)+"条规格信息填写有误，请确认！";
	  		layer.alert(e_msg);
		  	return retFlg;
	  	 }
	  	 
	  	 e_index = "";
	  	 var tmpSkuArr = $("#dynamicTable [name='sku']");
	  	 var tmpConversionArr = $("#dynamicTable [name='conversion']");
	  	 for(var i=0; i<tmpSkuArr.length; i++) {
	  		 for(var j=i+1; j<tmpSkuArr.length; j++) {
	  			 if ($(tmpSkuArr[i]).val() == $(tmpSkuArr[j]).val() && 
	  				 $(tmpConversionArr[i]).val() == $(tmpConversionArr[j]).val()) {
	  				e_index = e_index + (i+1) + "," + (j+1) + ";";
					retFlg = false;
					break;
	  			 }
	  		 }
	  	 }
	  	 if (!retFlg) {
	  		e_index = e_index.substring(0,e_index.length-1);
	  		e_msg = "第"+(e_index)+"条规格自有编码与换算比例重复，请确认！";
	  		layer.alert(e_msg);
		  	return retFlg;
	  	 }
	  	 return retFlg;
	  }
		
		//点击展开下拉列表
		$('#brand').click(function(){
			$('.select-content').css('width',$(this).outerWidth());
			$('.select-content').css('left',$(this).offset().left - 25);
			$('.select-content').css('top',$(this).offset().top + $(this).height() - 108);
			$('.select-content').stop();
			$('.select-content').slideDown(300);
		});
		
		//点击空白隐藏下拉列表
		$('html').click(function(event){
			var el = event.target || event.srcelement;
			if(!$(el).parents('.select-content').length > 0 && $(el).attr('id') != "brand"){
				$('.select-content').stop();
				$('.select-content').slideUp(300);
			}
		});
		//点击选择分类
		$('.select-content').on('click','span',function(event){
			var el = event.target || event.srcelement;
			if(el.nodeName != 'I'){
				var id = $(this).attr('data-id');
				var name = $(this).attr('data-name');
				$('#brandId').val(id);
				$('#brand').val(name);
				$('#searchBrand').val("");
				reSetDefaultInfo();
				$('.select-content').stop();
				$('.select-content').slideUp(300);
			}
		});
		
		$('#searchBrand').on("input",function(){
			if (!cpLock) {
				var tmpSearchKey = $(this).val();
				if (tmpSearchKey !='') {
					var searched = "";
					$('.first-ul li').each(function(li_obj){
						var tmpLiId = $(this).find("span").attr('data-id');
						var tmpLiText = $(this).find("span").attr('data-name');
						var flag = tmpLiText.indexOf(tmpSearchKey);
						if(flag >=0) {
							searched = searched + "<li><span data-id=\""+tmpLiId+"\" data-name=\""+tmpLiText+"\" class=\"no-child\">"+tmpLiText+"</span></li>";
						}
					});
					$('.first-ul').html(searched);
				} else {
					reSetDefaultInfo();
				}
	        }
		});
		
		function reSetDefaultInfo() {
			var tmpBrands = "";
			var hidBrandSelect = document.getElementById("hidBrand");
			var options = hidBrandSelect.options;
			for(var j=0;j<options.length;j++){
				tmpBrands = tmpBrands + "<li><span data-id=\""+options[j].value+"\" data-name=\""+options[j].text+"\" class=\"no-child\">"+options[j].text+"</span></li>";
			}
			$('.first-ul').html(tmpBrands);
		}
		
		//点击标签选中
		$('.label-content-express').on('click', 'li', function() {
			if (!$(this).hasClass("active")) {
				$(this).addClass("active");
			} else {
				$(this).attr("class", "");
			}
		});
		
		function setPicImgListData() {
			var valArr = new Array;
			var tmpPicPath="";
			for(var i=1;i<15;i++) {
				tmpPicPath = $("#picPath"+i).val();
				if (tmpPicPath != null && tmpPicPath != "") {
					valArr.push(tmpPicPath);
				}
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
		
		function getAllPicPath() {
			var tmpPicPath = "";
			$("input[name='picPath']").each(function(){
				tmpPicPath += $(this).val() + ",";
			})
			return tmpPicPath.substring(0,tmpPicPath.length-1);
		}
	</script>
</body>
</html>
