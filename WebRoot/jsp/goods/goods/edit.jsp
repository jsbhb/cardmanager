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
<link rel="stylesheet" href="${wmsUrl}/css/component/broadcast.css">
<%@include file="../../resourceLink.jsp"%>
</head>

<body>
	<section class="content-header">
	      <ol class="breadcrumb">
	        <li>商品管理</li>
	        <li class="active">编辑商品</li>
	      </ol>
    </section>
	<section class="content-iframe content">
	    <div class="list-tabBar">
			<ul>
				<li id="baseInfo" class="active" data-id="1">商品信息</li>
				<li id="detailInfo" data-id="2">图文详情</li>
			</ul>
		</div>
		<form class="form-horizontal" role="form" id="itemForm">
			<div class="title">
	       		<h1>基础信息</h1>
	       	</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">商品类型</div>
				<div class="col-sm-9 item-right">
					<select class="form-control" name="type" id="type">
						<c:choose>
						<c:when test="${backGoodsPo.goods.type==0}">
	                  	  	<option selected="selected" value="0">跨境商品</option>
                	  		<option value="2">一般贸易商品</option>
						</c:when>
						<c:otherwise>
                	  		<option value="0">跨境商品</option>
                	    	<option selected="selected" value="2">一般贸易商品</option>
						</c:otherwise>
						</c:choose>
	                </select>
		            <div class="item-content">
	             		（商品类型由跨境商品和一般贸易商品组成）
	             	</div>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">商品品牌</div>
				<div class="col-sm-9 item-right">
	                <input type="text" class="form-control" name="brand" id="brand" value="${backGoodsPo.goods.brandName}" readonly style="background:#fff;" placeholder="选择品牌"/>
	                <input type="hidden" class="form-control" name="brandId" id="brandId" value="${backGoodsPo.goods.brandId}"/>
	                <div class="item-content">
		             	（商品的品牌信息）
		            </div>
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
	                <div class="right-items">
						<select class="form-control" name="firstCatalogId" id="firstCatalogId">
		                  	<c:forEach var="first" items="${firsts}">
		                  		<c:choose>
								<c:when test="${first.firstId == backGoodsPo.goods.firstCategory}">
		                  			<option value="${first.firstId}" selected="selected">${first.name}</option>
								</c:when>
								<c:otherwise>
									<option value="${first.firstId}">${first.name}</option>
								</c:otherwise>
								</c:choose>
		                  	</c:forEach>
	                	</select>	
					</div>
					<div class="right-items">
						<select class="form-control" name="secondCatalogId" id="secondCatalogId">
							<option selected="selected" value="${backGoodsPo.goods.secondCategory}">${backGoodsPo.goods.secondCategoryName}</option>
		                </select>
	                </div>
	                <div class="right-items last-items">
						<select class="form-control" name="thirdCatalogId" id="thirdCatalogId">
							<option selected="selected" value="${backGoodsPo.goods.thirdCategory}">${backGoodsPo.goods.thirdCategoryName}</option>
		                </select>
	                </div>
	                <div class="item-content">
		             	（商品归属的三级分类）
		            </div>
				</div>
			</div>
	      	<div class="list-item">
				<div class="col-sm-3 item-left"><font style="color:red">*</font>商品名称</div>
				<div class="col-sm-9 item-right">
               		<input type="text" class="form-control" name="goodsName" id="goodsName" value="${backGoodsPo.goods.goodsName}">
               		<input type="hidden" class="form-control" name="goodsId" id="goodsId" value="${backGoodsPo.goods.goodsId}" readonly>
					<div class="item-content">
		             	（同类商品的通用名称，请不要带规格信息。例：爱他美婴幼儿奶粉）
		            </div>
				</div>
			</div>
	       	<div class="list-item">
				<div class="col-sm-3 item-left">商品卖点</div>
				<div class="col-sm-9 item-right">
               		<input type="text" class="form-control" name="description" id="description" value="${backGoodsPo.goods.description}">
					<div class="item-content">
		             	（在商品推广页面展示的卖点信息，建议40字以内）
		            </div>
				</div>
			</div>
	      	<div class="list-item">
				<div class="col-sm-3 item-left"><font style="color:red">*</font>原产国</div>
				<div class="col-sm-9 item-right">
	                 <input type="text" class="form-control" name="origin" id="origin" value="${backGoodsPo.goods.origin}">
					 <div class="item-content">
		             	（商品的产地信息，例：韩国）
		             </div>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">海关代码</div>
				<div class="col-sm-9 item-right">
                 	<input type="text" class="form-control" name="hscode" id="hscode" value="${backGoodsPo.goods.hscode}">
		            <div class="item-content">
	             		（海关代码HSCode）
	             	</div>
	            </div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">商品主图</div>
				<div class="col-sm-9 item-right addContent">
					<c:forEach var="file" items="${backGoodsPo.goods.goodsFileList}" varStatus="status">
                   	 	<div class="item-img choose" id="content${status.index+1}" data-id="${status.index+1}">
								<img src="${file.path}">
								<div class="bgColor"><i class="fa fa-arrow-left fa-fw"></i><i class="fa fa-trash fa-fw"></i><i class="fa fa-search fa-fw"></i><i class="fa fa-arrow-right fa-fw"></i></div>
								<input value="${file.path}" type="hidden" name="picPath" id="picPath${status.index+1}">
							</div>
                   	 </c:forEach>
				
					<div class="item-img" id="content${fn:length(backGoodsPo.goods.goodsFileList)+1}" data-id="${fn:length(backGoodsPo.goods.goodsFileList)+1}">
						+
						<input type="file" id="pic${fn:length(backGoodsPo.goods.goodsFileList)+1}" name="pic"/>
					</div>
				</div>
			</div>
			<div class="title">
	       		<h1>明细信息</h1>
	       	</div>
			<div id="specs" style="padding:0 20px;">
				<div class="list-item col-sm-6 col-sm-offset-3">
					<div class="list-all">
						<c:forEach var="info" items="${backGoodsPo.specsList[0].itemSpecsList}" varStatus="status">
							<div class="list-all-parent">
								<span class="remove_specs">&times;</span>
								<div class="list-all-item list-all-item-key">
									<div class="item-left">规格分类</div>
									<div class="item-right">
										<div class="select-item">
											<select class="form-control select-key" onchange="changeSpecsValueInfo(this)">
						               	  		<option value="${info.skId}" selected="selected">${info.skV}</option>
											</select>
										</div>
									</div>
								</div>
								<div class="list-all-item">
									<div class="item-left">规格值</div>
									<div class="item-right item-value">
										<div class="select-item">
											<select class="form-control select-value">
												<option value="${info.svId}" selected="selected">${info.svV}</option>
											</select>
										</div>
									</div>
								</div>
							</div>
		           	    </c:forEach>
						
						<div class="row-bg-gray">
							<a class="addBtn" href="javascript:void(0);" onclick="addSpecsModule(this)">添加规格</a>
						</div>
					</div>
				</div>
			</div>
	       	<div id="noSpecs" style="padding:0 20px;">
		       	<div class="list-item" style="width:100%;">
					<div class="col-sm-3 item-left"><font style="color:red">*</font>条形码</div>
					<div class="col-sm-9 item-right">
	               		<input type="text" class="form-control" name="encode" id="encode" value="${backGoodsPo.specsList[0].encode}">
	               		<input type="hidden" class="form-control" name="specsId" id="specsId" value="${backGoodsPo.specsList[0].specsId}" readonly>
	               		<input type="hidden" class="form-control" name="specsTpId" id="specsTpId" value="${backGoodsPo.goodsSpecsTpList[0].specsTpId}" readonly>
						<div class="item-content">
			             	（商品自带的条形码，用于识别相同商品）
			            </div>
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left">计量单位</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="unit" id="unit" value="${backGoodsPo.specsList[0].unit}">
						<div class="item-content">
		             		（包、件、个）
		             	</div>
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left"><font style="color:red">*</font>商品重量</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="weight" id="weight" value="${backGoodsPo.specsList[0].weight}">
						<div class="item-content">
							（单位：克，请按整数格式输入，例：2500）
						</div>
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left">商品信息</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="specsGoodsName" id="specsGoodsName" value="${backGoodsPo.specsList[0].specsGoodsName}">
						<div class="item-content">
			             	（请填写商品的规格信息，例：30ML）
			            </div>
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left">商品描述</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="specsDescription" id="specsDescription" value="${backGoodsPo.specsList[0].description}">
						<div class="item-content">
			             	（可以填写不同规格的卖点信息，建议40字以内）
			            </div>
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left"><font style="color:red">*</font>换算比例</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="conversion" id="conversion" value="${backGoodsPo.specsList[0].conversion}">
						<div class="item-content">
							（包装单位与计量单位的换算比例，如1包装单位=10计量单位，则填10）
						</div>
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left">商品箱规</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="carton" id="carton" value="${backGoodsPo.specsList[0].carton}">
						<div class="item-content">
							（例：8组，24罐）
						</div>
					</div>
				</div>
	        </div>
			
			<div class="title">
	       		<h1>供应商信息</h1>
	       	</div>
	       	<div id="item" style="padding:0 20px;">
	       		<div class="list-item">
					<div class="col-sm-3 item-left"><font style="color:red">*</font>供应商</div>
					<div class="col-sm-9 item-right">
						<select class="form-control" name="supplierId" id="supplierId" disabled>
		                   	<c:forEach var="supplier" items="${suppliers}">
		                   		<c:choose>
								<c:when test="${backGoodsPo.itemsList[0].supplierId == supplier.id}">
									<option selected="selected" value="${supplier.id}">${supplier.supplierName}</option>
								</c:when>
								<c:otherwise>
									<option value="${supplier.id}">${supplier.supplierName}</option>
								</c:otherwise>
								</c:choose>
		                   	</c:forEach>
		                </select>
		                <input type="hidden" class="form-control" name="supplierName" id="supplierName" value="${backGoodsPo.itemsList[0].supplierName}"/>
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left"><font style="color:red">*</font>商家编码</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="itemCode" id="itemCode" value="${backGoodsPo.itemsList[0].itemCode}">
	               		<input type="hidden" class="form-control" name="itemId" id="itemId" value="${backGoodsPo.itemsList[0].itemId}" readonly>
						<div class="item-content">
							（商家管理货物的编码）
						</div>
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left">保质期</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="shelfLife" id="shelfLife" value="${backGoodsPo.itemsList[0].shelfLife}">
						<div class="item-content">
							（商品的保质期，例：2年，18个月）
						</div>
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left">海关货号</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="sku" id="sku" value="${backGoodsPo.itemsList[0].sku}">
						<div class="item-content">
							（海关备案的商品编号）
						</div>
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left">海关单位</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="hsunit" id="hsunit" value="${backGoodsPo.itemsList[0].unit}">
						<div class="item-content">
							（海关备案的商品单位）
						</div>
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left"><font style="color:red">*</font>成本价</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="costPrice" id="costPrice" value="${backGoodsPo.priceList[0].costPrice}">
						<div class="item-content">
							（请按价格格式输入，例：113.35）
						</div>
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left"><font style="color:red">*</font>供货价</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="internalPrice" id="internalPrice" value="${backGoodsPo.priceList[0].internalPrice}">
						<div class="item-content">
							（请按价格格式输入，例：113.35）
						</div>
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left"><font style="color:red">*</font>库存</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="stockQty" id="stockQty" value="${backGoodsPo.stockList[0].fxqty}">
						<div class="item-content">
							（请按价格格式输入，例：113.35）
						</div>
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
					<script id="editor" type="text/plain" name="ueditor" style="height:320px;" align=center></script>
				</div>
			</div>
	        <div class="submit-btn">
	           	<button type="button" id="prePageBtn">上一页</button>
	           	<button type="button" id="submitBtn">修改商品信息</button>
	       	</div>
		</form>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script src="${wmsUrl}/js/component/broadcast.js"></script>
	<script type="text/javascript" src="${wmsUrl}/js/ajaxfileupload.js"></script>
	<script type="text/javascript" charset="utf-8" src="${wmsUrl}/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="${wmsUrl}/ueditor/ueditor.all.min.js"></script>
	<script type="text/javascript" charset="utf-8" src="${wmsUrl}/ueditor/lang/zh-cn/zh-cn.js"></script>
	<script type="text/javascript" charset="utf-8" src="${wmsUrl}/js/goodsJs/goods.js"></script>
	<script type="text/javascript">
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
			 
			 var url = "${wmsUrl}/admin/goods/goodsMng/editKJGoodsInfo.shtml";
			 var formData = sy.serializeObject($('#itemForm'));
			 var context = ue.getContent();
			 formData["detailPath"] = context;
			 formData["info"] = getSelectInfo();
			 //多张图片时序列化的值被清空了，重新赋值
			 if (formData["picPath"] == "") {
				 formData["picPath"] = getAllPicPath();
			 }
			 
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
			   goodsName: {
					message: '商品名称不正确',
					validators: {
						notEmpty: {
							message: '商品名称不能为空！'
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
			  itemCode: {
				   message: '商家编码不正确',
				   validators: {
					   notEmpty: {
						   message: '商家编码不能为空！'
					   }
				   }
			  },
			  encode: {
				  message: '条形码不正确',
				  validators: {
					   notEmpty: {
						   message: '条形码不能为空！'
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
			   costPrice:{
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
			   internalPrice:{
				   message:"供货价有误",
				   validators: {
					   notEmpty: {
							  message: '供货价不能为空'
						  },
						  numeric: {
						   message: '供货价只能输入数字'
					   }
				   }
			   }
		}});
		
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
				url : '${wmsUrl}/admin/uploadFileWithType.shtml?type=goods&key='+$("#goodsId").val(), //你处理上传文件的服务端
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
	            'goodsId': $("#goodsId").val()
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
	    $(window).load(function(){
			UE.getEditor('editor').execCommand('insertHtml', '${backGoodsPo.goods.detailPath}');
	    });
	    
		//新增规格
		  function addSpecsModule(e){
			var catalogId = "";
			var catalogType = "";
			var tmpFirstCatalogId = $("#firstCatalogId").val();
			if(tmpFirstCatalogId != -1){
				catalogId = tmpFirstCatalogId;
				catalogType = "1";
			}
			var tmpSecondCatalogId = $("#secondCatalogId").val();
			if(tmpSecondCatalogId != -1){
				catalogId = tmpSecondCatalogId;
				catalogType = "2";
			}
			var tmpThirdCatalogId = $("#thirdCatalogId").val();
			if(tmpThirdCatalogId != -1){
				catalogId = tmpThirdCatalogId;
				catalogType = "3";
			}
	    	var html = "<div class=\"list-all-parent\"><span class=\"remove_specs\">&times;</span><div class=\"list-all-item list-all-item-key\"><div class=\"item-left\">规格分类</div><div class=\"item-right\"><div class=\"select-item\">";
	    	$.ajax({
//	     		url:"${wmsUrl}/admin/goods/propertyMng/queryPropertyByCategory.shtml?catalogId="+catalogId+"&catalogType="+catalogType,
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
// 	 				url:"${wmsUrl}/admin/goods/propertyMng/queryPropertyValueById.shtml?id="+id,
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
						$(e).parent().parent().parent().parent().find(".item-value").html(html+"</select></div>");
					},
					error:function(){
						layer.alert("查询失败，请联系客服处理");
					}
			  });
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
		
		function getSelectInfo(){
			var tmpKeyId = [];
			var tmpKeyText = [];
			var tmpValueIdArray = [];
			var tmpValueTextArray = [];
			$(".select-key option:selected").each(function(){
				  if($(this).text()==''||$(this).val()==-1){		
					  return;
				  }
				  if (tmpKeyId.indexOf($(this).val()) == -1) {
					  tmpKeyText.push($(this).text());
					  tmpKeyId.push($(this).val());
				  } else {
					  return true;
				  }
				  var tmpIdArray = new Array();
				  var tmpTextArray = new Array();
				  $(this).parent().parent().parent().parent().parent().find(".select-value option:selected").each(function(){
					  if($(this).text()==''||$(this).val()==-1){		
						  return;
					  }
					  if (tmpIdArray.indexOf($(this).val()) == -1) {
						  tmpIdArray.push($(this).val())
						  tmpTextArray.push($(this).text())
					  }
				  });
				  if(tmpIdArray.length > 0){
					  tmpValueIdArray.push(tmpIdArray);
					  tmpValueTextArray.push(tmpTextArray);
				  }
			});
			
			var tmpInfoStr = "";
			for(var i=0; i<tmpKeyId.length; i++) {
				tmpInfoStr += tmpKeyId[i] + "|" + tmpKeyText[i] + "&" + tmpValueIdArray[i] + "|" + tmpValueTextArray[i] + ";";
			}
			return tmpInfoStr;
		}
	</script>
</body>
</html>
