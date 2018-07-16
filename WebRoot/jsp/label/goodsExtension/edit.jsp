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
	<section class="content-iframe content">
		<form class="form-horizontal" role="form" id="goodsForm">
	       	<div class="list-item">
				<div class="col-sm-3 item-left">商品品牌</div>
				<div class="col-sm-9 item-right">
			   		<input type="text" class="form-control" name="brand" id="brand" value="${goodsExtensionInfo.brand}">
			   		<div class="item-content">
		             	（请选择商品品牌）
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
						<li><span data-name="${brand.brand}" class="no-child">${brand.brand}</span></li>
					</c:forEach>
	           	</ul>
	       	</div>
            <input type="hidden" class="form-control" name="goodsId" id="goodsId" value="${goodsExtensionInfo.goodsId}"/>
	      	<div class="list-item">
				<div class="col-sm-3 item-left">商品名称</div>
				<div class="col-sm-9 item-right">
               		<input type="text" class="form-control" name="goodsName" value="${goodsExtensionInfo.goodsName}">
               		<div class="item-content">
		             	（商品名称请控制在12个字以内）
		            </div>
				</div>
			</div>
	      	<div class="list-item">
				<div class="col-sm-3 item-left">商品规格</div>
				<div class="col-sm-9 item-right">
	                 <input type="text" class="form-control" name="specs" value="${goodsExtensionInfo.specs}">
	                 <div class="item-content">
		             	（商品规格请控制在5个字以内）
		             </div>
				</div>
			</div>
	      	<div class="list-item">
				<div class="col-sm-3 item-left">产地</div>
				<div class="col-sm-9 item-right">
	                 <input type="text" class="form-control" name="origin" value="${goodsExtensionInfo.origin}">
				</div>
			</div>
	      	<div class="list-item">
				<div class="col-sm-3 item-left">自定义字段</div>
				<div class="col-sm-9 item-right">
	                 <input type="text" class="form-control" name="custom" value="${goodsExtensionInfo.custom}">
	                 <div class="item-content">
		             	（请用英文冒号':'作为分隔符。例：适用年龄:0-3岁，适合肤质:所有肤质）
		             </div>
				</div>
			</div>
	      	<div class="list-item">
				<div class="col-sm-3 item-left">保质期</div>
				<div class="col-sm-9 item-right">
	                 <input type="text" class="form-control" name="shelfLife" value="${goodsExtensionInfo.shelfLife}">
	                 <div class="item-content">
		             	（无保质期商品请填写无）
		             </div>
				</div>
			</div>
	      	<div class="list-item">
				<div class="col-sm-3 item-left">推荐理由</div>
				<div class="col-sm-9 item-right">
					<textarea class="form-control" name="reason">${goodsExtensionInfo.reason}</textarea>
             		<div class="item-content">
		             	（请用英文分号';'作为多个值的分隔符,最多支持3个分隔符）
		            </div>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">商品图片(1441*890px)</div>
				<div class="col-sm-9 item-right addContent">
					<c:choose>
					   <c:when test="${goodsExtensionInfo.goodsPath != null && goodsExtensionInfo.goodsPath != ''}">
               	  			<div class="item-img choose" id="content" >
								<img src="${goodsExtensionInfo.goodsPath}">
								<div class="bgColor"><i class="fa fa-trash fa-fw"></i></div>
								<input value="${goodsExtensionInfo.goodsPath}" type="hidden" name="goodsPath" id="goodsPath">
							</div>
					   </c:when>
					   <c:otherwise>
                	  		<div class="item-img" id="content" >
								+
								<input type="file" id="pic" name="pic" />
								<input type="hidden" class="form-control" name="goodsPath" id="goodsPath"> 
							</div>
					   </c:otherwise>
					</c:choose>
				</div>
			</div>
			
	        <div class="submit-btn">
	           	<button type="button" id="submitBtn">保存信息</button>
	       	</div>
		</form>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script src="${wmsUrl}/plugins/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="${wmsUrl}/js/ajaxfileupload.js"></script>
	<script type="text/javascript">
	var cpLock = false;
    $('#searchBrand').on('compositionstart', function () {
        cpLock = true;
    });
    $('#searchBrand').on('compositionend', function () {
        cpLock = false;
    });
	 
	 $("#submitBtn").click(function(){
		 $('#goodsForm').data("bootstrapValidator").validate();
		 if($('#goodsForm').data("bootstrapValidator").isValid()){
			 var tmpGoodsPath = $("#goodsPath").val();
			 if (tmpGoodsPath == "" || tmpGoodsPath == null) {
				 layer.alert("请上传商品图片！");
				 return;
			 }
			 var url = "${wmsUrl}/admin/label/goodsExtensionMng/editGoodsInfo.shtml";
			 
			 var formData = sy.serializeObject($('#goodsForm'));
			 
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
		
		$('#goodsForm').bootstrapValidator({
		//   live: 'disabled',
		   message: 'This value is not valid',
		   feedbackIcons: {
		       valid: 'glyphicon glyphicon-ok',
		       invalid: 'glyphicon glyphicon-remove',
		       validating: 'glyphicon glyphicon-refresh'
		   },
		   fields: {
				  goodsName: {
						trigger:"change",
						message: '商品名称不正确',
						validators: {
							notEmpty: {
								message: '商品名称不能为空！'
							},
							stringLength: {
			                    max: 12,
			                    message: '商品名称请小于12个字'
			                }
						}
				  },
				  specs: {
						trigger:"change",
						message: '商品规格不正确',
						validators: {
							notEmpty: {
								message: '商品规格不能为空！'
							},
							stringLength: {
			                    max: 5,
			                    message: '商品规格请小于5个字'
			                }
						}
				  },
				  origin: {
						trigger:"change",
						message: '原产国不正确',
						validators: {
							notEmpty: {
								message: '原产国不能为空！'
							}
						}
				  },
				  custom: {
						trigger:"change",
						message: '自定义字段不正确',
						validators: {
							notEmpty: {
								message: '自定义字段不能为空！'
							}
						}
				  },
				  shelfLife: {
						trigger:"change",
						message: '保质期字段不正确',
						validators: {
							notEmpty: {
								message: '保质期字段不能为空！'
							}
						}
				  },
				  reason: {
						trigger:"change",
						message: '推荐理由不正确',
						validators: {
							notEmpty: {
								message: '推荐理由不能为空！'
							}
						}
				  }
		   }
		});
		
		//点击上传图片
		$('.item-right').on('change','.item-img input[type=file]',function(){
			var imagSize = document.getElementById("pic").files[0].size;
			if(imagSize>1024*1024*3) {
				layer.alert("图片大小请控制在3M以内，当前图片为："+(imagSize/(1024*1024)).toFixed(2)+"M");
				return true;
			}
			$.ajaxFileUpload({
				url : '${wmsUrl}/admin/uploadFileForGrade.shtml', //你处理上传文件的服务端
				secureuri : false,
				fileElementId : "pic",
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						var imgHt = '<img src="'+data.msg+'"><div class="bgColor"><i class="fa fa-trash fa-fw"></i></div>';
						var imgPath = imgHt+ '<input type="hidden" value='+data.msg+' id="goodsPath" name="goodsPath">'
						$("#content").html(imgPath);
						$("#content").addClass('choose');
					} else {
						layer.alert(data.msg);
					}
				}
			})
		});
		//删除主图
		$('.item-right').on('click','.bgColor i',function(){
			var ht = '<div class="item-img" id="content" >+<input type="file" id="pic" name="pic"/><input type="hidden" name="goodsPath" id="goodsPath" value=""></div>';
			$(this).parent().parent().removeClass("choose");
			$(this).parent().parent().parent().html(ht);
		});
		
		//点击展开下拉列表
		$('#brand').click(function(){
			$('.select-content').css('width',$(this).outerWidth());
			$('.select-content').css('left',$(this).offset().left - 25);
			$('.select-content').css('top',$(this).offset().top + $(this).height() - 2);
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
				var name = $(this).attr('data-name');
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
//	 				var unSearched = "";
					$('.first-ul li').each(function(){
						var tmpLiText = $(this).text();
						var flag = tmpLiText.indexOf(tmpSearchKey);
						if(flag >=0) {
							searched = searched + "<li><span data-name=\""+tmpLiText+"\" class=\"no-child\">"+tmpLiText+"</span></li>";
//	 					}else {
//	 						unSearched = unSearched + "<li><span data-name=\""+tmpLiText+"\" class=\"no-child\">"+tmpLiText+"</span></li>";
						}
					});
//	 				searched = searched + unSearched;
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
 				tmpBrands = tmpBrands + "<li><span data-name=\""+options[j].text+"\" class=\"no-child\">"+options[j].text+"</span></li>";
 			}
			$('.first-ul').html(tmpBrands);
		}
	</script>
</body>
</html>
