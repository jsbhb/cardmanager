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
	       		<h1>基础商品</h1>
	       	</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">商品品牌</div>
				<div class="col-sm-9 item-right">
					<select class="form-control" name="brandId" id="brandId">
	                	<option selected="selected" value="">--请选择商品品牌--</option>
		                <c:forEach var="brand" items="${brands}">
		                <option value="${brand.brandId}">${brand.brand}</option>
		                </c:forEach>
		            </select>
	                <input type="hidden" class="form-control" name="brand" id="brand"/>
	                <input type="hidden" class="form-control" name="baseId" id="baseId"/>
					<a class="addBtn" href="javascript:void(0);" onclick="toBrand()">新增品牌</a>
					<a class="addBtn" href="javascript:void(0);" onclick="showBaseGoods()">浏览模板</a>
				</div>
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
						<select class="form-control" hidden name="thirdCatalogId" id="thirdCatalogId">
						<option selected="selected" value="-1">选择分类</option>
		                </select>
	                </div>
				</div>
			</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">增值税率</div>
				<div class="col-sm-9 item-right">
                	<input type="text" class="form-control" name="incrementTax" id="incrementTax"/>
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
			<div class="title">
	       		<h1>明细信息</h1>
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
				<div class="col-sm-3 item-left">商家编码</div>
				<div class="col-sm-9 item-right">
             		<input type="text" class="form-control" name="itemCode">
					<div class="item-content">
		             	（货主管理货物的编码）
		            </div>
				</div>
			</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">海关货号</div>
				<div class="col-sm-9 item-right">
               		<input type="text" class="form-control" name="sku">
					<div class="item-content">
		             	（海关备案货号或商家编码）
		            </div>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">消费税率</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="exciseFax" id="exciseFax">
					<div class="item-content">
		             	（请按小数格式输入，例：0.17）
		            </div>
	            </div>
			</div>
	      	<div class="list-item">
				<div class="col-sm-3 item-left">原产国</div>
				<div class="col-sm-9 item-right">
	                 <input type="text" class="form-control" name="origin">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">商品重量</div>
				<div class="col-sm-9 item-right">
	                <input type="text" class="form-control" name="weight">
					<div class="item-content">
						（计量单位：克或毫升。请按整数格式输入，例：2500）
		            </div>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">成本价</div>
				<div class="col-sm-9 item-right">
	                <input type="text" class="form-control" name="proxyPrice">
	                <div class="item-content">
		             	（请按价格格式输入，例：113.35）
		            </div>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">分销价</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="fxPrice">
					<div class="item-content">
		             	（请按价格格式输入，例：113.35）
		            </div>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">零售价</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="retailPrice">
					<div class="item-content">
		             	（请按价格格式输入，例：113.35）
		            </div>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">限购数量</div>
				<div class="col-sm-9 item-right">
					<div class="right-item">
	              		<input type="text" class="form-control" name="min" placeholder="请输入最小购买量">
					</div>
	            	<div class="right-item last-item">
                 		<input type="text" class="form-control" name="max" placeholder="请输入最大购买量">
					</div>
					<div class="item-content">
		             	（请按整数格式输入，填0表示不限制数量）
		            </div>
				</div>
			</div>
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
			<div class="list-item">
				<div class="col-sm-3 item-left">商品主图</div>
				<div class="col-sm-9 item-right addContent">
					<div class="item-img">
						+
						<input type="file" id="pic1"/>
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
	           	<button type="button" id="submitBtn">新增商品</button>
	       	</div>
		</form>
	</section>
	<%@include file="../../resource.jsp"%>
	<script src="${wmsUrl}/validator/js/bootstrapValidator.min.js"></script>
	<script src="${wmsUrl}/plugins/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="${wmsUrl}/js/ajaxfileupload.js"></script>
	<script type="text/javascript">
	 $(function () {
	     CKEDITOR.replace('editor1');
	     $(".textarea").wysihtml5();
	 });
	 
 	$("#brandId").change(function(){
		$("#brand").val($("#brandId").find("option:selected").text());
		//赋值
		$("#baseId").val("");
	});
	 
	$("#supplierId").change(function(){
		$("#supplierName").val($("#supplierId").find("option:selected").text());
	});
	
 	//模板选择后
 	function choiseModel(){
 		var tmpBaseId = $("#baseId").val();
 		//品牌
 		var tmpBrand = $("#brand").val();
 		var brandSelect = document.getElementById("brandId");
		var boptions = brandSelect.options;
		for(var j=0;j<boptions.length;j++){
			if (tmpBrand==boptions[j].text) {
				boptions[j].selected = true;
				break;
			}
		}
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
						var str = "";
						secondSelect.append("<option value='-1'>选择分类</option>")
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
						
						var str = "";
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
	 
	 function uploadFile(id) {
			$.ajaxFileUpload({
				url : '${wmsUrl}/admin/uploadFile.shtml', //你处理上传文件的服务端
				secureuri : false,
				fileElementId : "pic"+id,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$("#picPath"+id).val(data.msg);
						$("#img"+id).attr("src",data.msg);
					} else {
						layer.alert(data.msg);
					}
				}
			})
		}
	 
	 function refresh(){
		parent.location.reload();
	 }
	 
	 $("#saveInfoBtn").click(function(){
		 $("#submitBtn").click();
	 });
	 
	 $("#submitBtn").click(function(){
		 $('#itemForm').data("bootstrapValidator").validate();
		 if($('#itemForm').data("bootstrapValidator").isValid()){
			 var tmpExciseFax = $("#exciseFax").val();
			 if(tmpExciseFax > 1){
				 layer.alert("消费税率填写有误，请重新填写！");
				 return;
			 }
			 
			 var url = "${wmsUrl}/admin/goods/goodsMng/createGoodsInfo.shtml";
// 			 var templateId = $("#templateId").val();
			 
			 var formData = sy.serializeObject($('#itemForm'));
			 var context = ue.getContent();
			 formData["detailInfo"] = context;
			 var tagId = $('#tagId li.active').attr('data-id');
			 formData["tagId"] = tagId;
			 
// 			 var newFormData;
// 			 if(templateId!= null && templateId!=""){
// 				 var key = "";
// 				 var value = "";
				 
// 				 newFormData={};
// 				 for(var json in formData){
// 					 if(json.indexOf(":")!=-1){
// 						 key +=json+";"
// 						 value += formData[json]+";"
// 					 }else{
// 						 newFormData[json] = formData[json];
// 					 }
// 				}
				 
// 				 if(key == ""||value == ""){
// 					 layer.alert("没选择规格信息！");
// 					 return;
// 				 }
				 
// 				 newFormData["keys"] = key;
// 				 newFormData["values"] = value;
// 			 }else{
// 				 newFormData = formData;
// 			 }
		
			 $.ajax({
				 url:url,
				 type:'post',
				 data:JSON.stringify(formData),
				 contentType: "application/json; charset=utf-8",
				 dataType:'json',
				 success:function(data){
					 if(data.success){
						 refresh();
						 layer.alert("商品新增成功");
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
	 
		function showBaseGoods(){
			var index = layer.open({
				  title:"查看基础商品",	
				  area: ['90%', '90%'],
				  type: 2,
				  content: '${wmsUrl}/admin/goods/baseMng/listForAdd.shtml',
				  maxmin: false
				});
		}
		
		function showSpaceGoods(){
			var index = layer.open({
				  title:"查看商品规格",	
				  area: ['70%', '80%'],
				  type: 2,
				  content: '${wmsUrl}/admin/goods/specsMng/listForAdd.shtml',
				  maxmin: false
				});
		}
		
		function createSpecs(id){
			 $.ajax({
				 url:"${wmsUrl}/admin/goods/specsMng/queryById.shtml?id="+id,
				 type:'post',
				 contentType: "application/json; charset=utf-8",
				 dataType:'json',
				 success:function(data){
					 if(data.id == null){
						 layer.alert("同步模板失败！");
					 }else{
						 $("#specsName").html("");
						 $("#specsTemplate").html("");
						 $("#specsName").html(data.name);
						 var specs = data.specs;
						 
						 for(var i = 0 ;i<specs.length;i++){
							 var spec = specs[i];
							 var label = $("<label></label");
							 label.addClass="col-sm-12 control-label no-padding-right";
							 label.append(spec.name+": ");
							 $("#specsTemplate").append(label);
							 $("#templateId").val(data.id);
							 
							 var values = spec.values;
							 var radio;
							 for(var j =0;j<values.length;j++){
								 radio = document.createElement("input");
								 radio.setAttribute("type","radio");
								 radio.setAttribute("name",spec.id+":"+spec.name);
								 radio.setAttribute("value", values[j].id+":"+values[j].value);
								 $("#specsTemplate").append(radio);
								 $("#specsTemplate").append(values[j].value+" ");
							 }
							 $("#specsTemplate").append("<br/>");
						 }
						
						 $("#specsInfo").show();
					 }
					 
				 },
				 error:function(){
					 layer.alert("提交失败，请联系客服处理");
				 }
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
			   	  baseId: {
			 		   trigger:"change",
		          	   message: '基础商品未添加',
		          	   validators: {
			               notEmpty: {
			                   message: '基础商品未添加！'
			               }
			           }
			   	  },
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
						   regexp: {
							   regexp: /^\d+(\.\d+)?$/,
							   message: '增值税率格式有误'
						   }
					   }
				  },
				  tariff:{
					   message: '海关税率不正确',
					   validators: {
						   notEmpty: {
							   message: '海关税率不能为空'
						   },
						   regexp: {
							   regexp: /^\d+(\.\d+)?$/,
							   message: '海关税率格式有误'
						   }
					   }
				  },
				  exciseFax:{
					   message: '消费税率不正确',
					   validators: {
						   notEmpty: {
							   message: '消费税率不能为空'
						   },
						   regexp: {
							   regexp: /^\d+(\.\d+)?$/,
							   message: '消费税率格式有误'
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
						   regexp: {
							   regexp: /^\d+(\.\d+)?$/,
							   message: '重量格式有误'
						   }
						}
				   },
				   proxyPrice:{
					   trigger:"change",
					   message:"成本价格有误",
					   validators: {
						   notEmpty: {
								  message: '成本价格不能为空'
							  },
						   regexp: {
							   regexp: /^\d+(\.\d+)?$/,
							   message: '成本价格格式有误'
						   }
						}
				   },
				   fxPrice:{
					   trigger:"change",
					   message:"分销价格有误",
					   validators: {
						   regexp: {
							   regexp: /^\d+(\.\d+)?$/,
							   message: '成本价格格式有误'
						   }
					   }
				   },
				   retailPrice:{
					   message: '零售价有误',
					   validators: {
						   notEmpty: {
							   message: '零售价不能为空'
						   },
						   regexp: {
							   regexp: /^\d+(\.\d+)?$/,
							   message: '消费税格式有误'
						   }
					   }
				   },
				   min:{
					   message: '最小限购数量有误',
					   validators: {
						   regexp: {
							   regexp: /^\d+(\.\d+)?$/,
							   message: '最小限购数量格式有误'
						   }
					   }
				   },
				   max:{
					   message: '最大限购数量有误',
					   validators: {
						   regexp: {
							   regexp: /^\d+(\.\d+)?$/,
							   message: '最大限购数量格式有误'
						   }
					   }
				   }
		}});
		
		
		function toList(){
				$("#list",window.parent.document).trigger("click");
		}
		
		function toTag(){
			var index = layer.open({
				  title:"新增标签",	
				  area: ['40%', '30%'],	
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
				  area: ['50%', '30%'],	
				  type: 2,
				  content: '${wmsUrl}/admin/goods/brandMng/toAdd.shtml',
				  maxmin: false
				});
		}
		
		//点击分类选中
		$('.item-right').on('click','.label-content li:not(active)',function(){
		});
		//点击分类取消
		$('.item-right').on('click','.label-content li.active',function(){
		});
		//点击上传图片
		$('.item-right').on('change','.item-img input[type=file]',function(){
			alert(1);
			var ht = '<div class="item-img">+<input type="file"/></div>';
			var imgHt = '<img src="${wmsUrl}/adminLTE/img/user2-160x160.jpg"><div class="bgColor"><i class="fa fa-trash fa-fw"></i></div>';
			$('.addContent').append(ht);
			$(this).parent().addClass('choose');
			$(this).parent().html(imgHt);
		});
		//删除主图
		$('.item-right').on('click','.bgColor i',function(){
			alert(111);
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
	    function saveHtml(){
	    	var context = ue.getContent();
	    	if(context == ''){
	    		layer.alert("没有内容！");
	    		return;
	    	}
	    	
	    	$.ajax({
				 url:"${wmsUrl}/admin/goods/goodsMng/saveHtml.shtml",
				 type:'post',
				 data:{"html":context,"goodsId":""},
				 dataType:'json',
				 success:function(data){
					 if(data.success){	
						 layer.alert("保存成功");
						 parent.reloadTable();
					 }else{
						 layer.alert(data.msg);
					 }
				 },
				 error:function(){
					 layer.alert("提交失败，请联系客服处理");
				 }
			 });
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
	</script>
</body>
</html>
