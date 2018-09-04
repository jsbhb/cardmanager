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
<link rel="stylesheet" href="http://test2.cncoopbuy.com/css/page/page-mall-pc.min.css">
<link rel="stylesheet" href="${wmsUrl}/css/mall/mall.css">

</head>
<body>
<section class="content" style="padding:0 15px;">
	<section style="position:relative;">
	  <div class="component_doBtns">
	  	<ul>
	  		<li><i class="fa fa-edit fa-fw"></i></li>
	  		<li><i class="fa fa-trash fa-fw"></i></li>
	  	</ul>
	  </div>
      <div id="body-center" style="float:left">
          <div class="banner-1-1" pagecode="6">
                 <div class="banner-1-content">
                     <div class="banner-bannerImg">
                     <c:forEach var="module" items="${page.module}">
                     		<c:if test="${module.key == 'banner-1'}">
                     			<c:forEach var="banner" items="${module.list}" varStatus="status">
                     			  <a href="#" class="imgBox" style="z-index:95; opacity: 1;">
		                              <img id="c-banner${status.index+1}" src="${banner.picPath}">
		                          </a>
                     			</c:forEach>
                     		</c:if>
                     </c:forEach>
                     </div>
                 </div>
          </div>
          <div class="module-advertising-2-001" pagecode="7">
              <component-advertising-2>
                  <div class="component-advertising-content" style="width:620px;">
	                  <c:forEach var="module" items="${page.module}">
	                      <c:if test="${module.key == 'advertising-1'}">
	                      	<c:set var="adviceSize" value="${fn:length(module.list)}"></c:set>
	                      	<c:forEach var="ad" items="${module.list}" varStatus="status">
		                  	  	<div class="component-advertising-item" >
		                          <a href="${ad.href}" type="4" activiey="0">
		                              <img id="c-ad${status.index+1}" src="http://test3.cncoopbuy.com/${ad.picPath}">
		                          </a>
		                      	</div>
	                      	</c:forEach>
	                  	  </c:if>	
	                  </c:forEach>
	                  <c:if test="${adviceSize<4}">
	                  	<c:forEach  begin="${adviceSize}" end="4" varStatus="status">
	                  		<div class="component-advertising-item" >
	                          <a href="" type="4" activiey="0">
	                              <img id="c-ad${status.index+adviceSize}" src="">
	                          </a>
                      		</div>
	                  	</c:forEach>
	                  </c:if>
                  </div>
              </component-advertising-2>
          </div>
          <div class="module-floor-1-001" id="1" pagecode="8">
              <component-floor-1>
                  <div class="component-floor-content" id="page_3">
                      <div class="component-floor-title">
                          <div class="component-floor-title-left">
                              <ul>
                                  <li>母婴专场</li>
                                  <li>Baby Care</li>
                              </ul>
                          </div>
                          <div class="component-floor-title-right">
                              <p>
                                  <a>查看更多 &gt;&gt;
                                  </a>
                              </p>
                          </div>
                      </div>
                      <div class="component-floor-left">
                          <img src="http://139.196.74.68:8080/grade/1f23ec4d-854a-4370-8c2c-6eecc48fd666.png">
                      </div>
                      <div class="component-floor-right">
                          <div class="floor-right-top">
                              <ul>
                                  <li><a href="javascript:void(0);" goodsid="1079"><img id="c-f1-floorAd1" src="http://139.196.74.68:8080/grade/ab731d2f-802b-49a7-8033-c648685d9037.png"></a></li>
                                  <li><a href="javascript:void(0);" goodsid="100000323"><img id="c-f1-floorAd2" src="http://139.196.74.68:8080/grade/35029f4e-cdaf-42c5-8d1c-2589f96e3e71.png"></a></li>
                                  <li><a href="javascript:void(0);" goodsid="100000138"><img id="c-f1-floorAd3" src="http://139.196.74.68:8080/grade/35959667-dd6f-4a50-87f2-0df84410e8de.png"></a></li>
                              </ul>
                          </div>
                          <div class="floor-right-bottom">
                              <div class="floor-item">
                                  <a href="javascript:void(0);" goodsid="100000171">
                                      <ul>
                                          <li><img id="c-f1-floorGoods1" src="http://139.196.74.68:8080/grade/efe95546-e434-4c0d-8ecf-2d2a57127f42.png"></li>
                                          <li>Bio Island婴幼儿鳕鱼肝油</li>
                                          <li>￥128.00</li>
                                      </ul>
                                  </a>
                              </div>
                              <div class="floor-item">
                                  <a href="javascript:void(0);" goodsid="100000393">
                                      <ul>
                                          <li><img id="c-f1-floorGoods2" src="http://139.196.74.68:8080/grade/2fcf7705-11ae-4039-bfae-9dcaf90b74e4.jpg"></li>
                                          <li>Fisher Price声光安抚海马</li>
                                          <li>￥89.00</li>
                                      </ul>
                                  </a>
                              </div>
                              <div class="floor-item">
                                  <a href="javascript:void(0);" goodsid="100000432">
                                      <ul>
                                          <li><img id="c-f1-floorGoods3" src="http://139.196.74.68:8080/grade/739c233f-2591-4ce8-bd85-399fa9669651.jpg"></li>
                                          <li>Skin Vape防蚊驱蚊喷雾</li>
                                          <li>￥76.00</li>
                                      </ul>
                                  </a>
                              </div>
                              <div class="floor-item">
                                  <a href="javascript:void(0);" goodsid="100000023">
                                      <ul>
                                          <li><img id="c-f1-floorGoods4" src="http://139.196.74.68:8080/grade/83272a63-d287-4d25-acb2-c6132583c6f5.jpg"></li>
                                          <li>sanosan婴儿防晒喷雾</li>
                                          <li>￥168.00</li>
                                      </ul>
                                  </a>
                              </div>
                          </div>
                      </div>
                  </div>
              </component-floor-1>
          </div>
        </div>
        <div class="page_edit_list banner_edit">
        	<form>
        	<h1 class="page_edit_list_title">
        		<span>轮播组件</span>
        		<button>保存</button>
        	</h1>
        	<c:forEach var="module" items="${page.module}">
	           <c:if test="${module.key == 'banner-1'}">
	           		<c:forEach var="banner" items="${module.list}" varStatus="status">
	           			<div class="page_edit_list_item" data-id="banner${status.index+1}">
		        		<h2>轮播图${status.index+1}</h2>
		        		<c:choose>
		        		<c:when test="${banner.picPath == ''}">
		        			<div class="page_edit_list_item_img">
		        			+
			        		<input type="file" id="banner${status+1}" name="pic"/>
			        		</div>
		        		</c:when>
		        		<c:otherwise>
		        			<div class="page_edit_list_item_img active">
			        			<img src="${banner.picPath}">
			        			<p>
				  					<i class="fa fa-trash fa-fw"></i>
			        				<i class="fa fa-edit fa-fw"></i>
				  				</p>
			        		</div>
		        		</c:otherwise>
		        		</c:choose>
		        		<p>(图片格式仅限jpg、png、gif，建议尺寸：***x***)</p>
		        	</div>
	           		</c:forEach>
		        </c:if>
	        </c:forEach>
        	</form>
        </div>
        <div class="page_edit_list ad_edit">
        	<form>
        	<h1 class="page_edit_list_title">
        		<span>广告组件</span>
        		<button>保存</button>
        	</h1>
        	<c:forEach var="module" items="${page.module}">
	            <c:if test="${module.key == 'advertising-1'}">
	            	<c:forEach var="ad" items="${module.list}" varStatus="status">
	           			<div class="page_edit_list_item" data-id="ad${status.index+1}">
		        		<h2>广告位${status.index+1}</h2>
		        		<c:choose>
		        		<c:when test="${banner.picPath == ''}">
		        			<div class="page_edit_list_item_img">
		        			+
			        		<input type="file" id="ad${status+1}" name="pic"/>
			        		</div>
		        		</c:when>
		        		<c:otherwise>
		        			<div class="page_edit_list_item_img active">
			        			<img src="${banner.picPath}">
			        			<p>
				  					<i class="fa fa-trash fa-fw"></i>
			        				<i class="fa fa-edit fa-fw"></i>
				  				</p>
			        		</div>
		        		</c:otherwise>
		        		</c:choose>
		        		<p>(图片格式仅限jpg、png、gif，建议尺寸：***x***)</p>
		        	</div>
	           		</c:forEach>
	            </c:if>
            </c:forEach>
        	</form>
        </div>
        <div class="page_edit_list floor_edit">
        	<form>
        	<h1 class="page_edit_list_title">
        		<span  id="floorName">楼层设置</span>
        		<button>保存</button>
        	</h1>
        	<div class="page_edit_list_item">
        		<h2>楼层信息</h2>
        		<input type="text" placeholder="楼层标题">
        		<input type="text" placeholder="楼层别称">
        		<input type="text" placeholder="更多链接">
        	</div>
        	<div class="page_edit_list_item" data-id="floorAd1">
        		<h2>广告图1</h2>
        		<div class="page_edit_list_item_img">
        			+
        			<input type="file" id="ad1" name="pic"/>
        		</div>
        		<p>(图片格式仅限jpg、png、gif，建议尺寸：***x***)</p>
        	</div>
        	<div class="page_edit_list_item" data-id="floorAd2">
        		<h2>广告图2</h2>
        		<div class="page_edit_list_item_img active">
        			<img src="http://139.196.74.68:8080/grade/739c233f-2591-4ce8-bd85-399fa9669651.jpg">
        			<p>
	  					<i class="fa fa-trash fa-fw"></i>
        				<i class="fa fa-edit fa-fw"></i>
	  				</p>
        		</div>
        		<p>(图片格式仅限jpg、png、gif，建议尺寸：***x***)</p>
        	</div>
        	<div class="page_edit_list_item" data-id="floorAd3">
        		<h2>广告图3</h2>
        		<div class="page_edit_list_item_img active">
        			<img src="http://139.196.74.68:8080/grade/739c233f-2591-4ce8-bd85-399fa9669651.jpg">
        			<p>
	  					<i class="fa fa-trash fa-fw"></i>
        				<i class="fa fa-edit fa-fw"></i>
	  				</p>
        		</div>
        		<p>(图片格式仅限jpg、png、gif，建议尺寸：***x***)</p>
        	</div>
        	<div class="page_edit_list_item" data-id="floorGoods1">
        		<h2>商品1</h2>
        		<div class="page_edit_list_item_img active">
        			<img src="http://139.196.74.68:8080/grade/739c233f-2591-4ce8-bd85-399fa9669651.jpg">
        			<p>
	  					<i class="fa fa-trash fa-fw"></i>
        				<i class="fa fa-edit fa-fw"></i>
	  				</p>
        		</div>
        		<p>(图片格式仅限jpg、png、gif，建议尺寸：***x***)</p>
        	</div>
        	<div class="page_edit_list_item" data-id="floorGoods2">
        		<h2>商品2</h2>
        		<div class="page_edit_list_item_img active">
        			<img src="http://139.196.74.68:8080/grade/739c233f-2591-4ce8-bd85-399fa9669651.jpg">
        			<p>
	  					<i class="fa fa-trash fa-fw"></i>
        				<i class="fa fa-edit fa-fw"></i>
	  				</p>
        		</div>
        		<p>(图片格式仅限jpg、png、gif，建议尺寸：***x***)</p>
        	</div>
        	<div class="page_edit_list_item" data-id="floorGoods3">
        		<h2>商品3</h2>
        		<div class="page_edit_list_item_img active">
        			<img src="http://139.196.74.68:8080/grade/739c233f-2591-4ce8-bd85-399fa9669651.jpg">
        			<p>
	  					<i class="fa fa-trash fa-fw"></i>
        				<i class="fa fa-edit fa-fw"></i>
	  				</p>
        		</div>
        		<p>(图片格式仅限jpg、png、gif，建议尺寸：***x***)</p>
        	</div>
        	<div class="page_edit_list_item" data-id="floorGoods4">
        		<h2>商品4</h2>
        		<div class="page_edit_list_item_img active">
        			<img src="http://139.196.74.68:8080/grade/739c233f-2591-4ce8-bd85-399fa9669651.jpg">
        			<p>
	  					<i class="fa fa-trash fa-fw"></i>
        				<i class="fa fa-edit fa-fw"></i>
	  				</p>
        		</div>
        		<p>(图片格式仅限jpg、png、gif，建议尺寸：***x***)</p>
        	</div>
        	</form>
        </div>
  </section>
</section>
	
<%@include file="../../resourceScript.jsp"%>
<script type="text/javascript" src="${wmsUrl}/js/ajaxfileupload.js"></script>
<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
<script type="text/javascript">

$('body').on('mouseover','[class^="module-"]',function(){
	var _top = $(this).position().top;
	$('[class^="module-"]').removeClass('active');
	$(this).addClass('active');
	$('.component_doBtns').css('top',_top);
	$('.component_doBtns').show();
	$('.component_doBtns li').attr('data-id',1);//识别符赋值
});

$('body').on('click','[class^="module-banner-1-001"]',function(){
	$('.banner_edit').show();//弹出编辑框
	$('.ad_edit').hide()
	$('.floor_edit').hide();
});

$('body').on('click','[class^="module-advertising-2-001"]',function(){
	$('.ad_edit').show();//弹出编辑框
	$('.banner_edit').hide();
	$('.floor_edit').hide();
});

$('body').on('click','[class^="module-floor-1"]',function(){
	
	var floorName=$(this).attr('id');
	
	$('#floorName').text("楼层"+floorName+"设置");
	
	$('.floor_edit').show();//弹出编辑框
	$('.banner_edit').hide();//弹出编辑框
	$('.ad_edit').hide()
});




//点击上传图片
$('.page_edit_list_item').on('change','.page_edit_list_item_img input[type=file]',function(){
	var id =  $(this).parent().parent().attr("data-id");
	
	var imagSize = document.getElementById(id).files[0].size;
	if(imagSize>1024*1024*3) {
		layer.alert("图片大小请控制在3M以内，当前图片为："+(imagSize/(1024*1024)).toFixed(2)+"M");
		return true;
	}
	
	var parent = $(this).parent();
	
	$.ajaxFileUpload({
		url : '${wmsUrl}/admin/uploadFileForGrade.shtml', //你处理上传文件的服务端
		secureuri : false,
		fileElementId : id,
		dataType : 'json',
		success : function(data) {
			if (data.success) {
				var imgHt = '<img src="'+data.msg+'"><p><i class="fa fa-trash fa-fw"></i><i class="fa fa-edit fa-fw"></i></p>';
				var imgPath = imgHt+ '<input type="hidden" value='+data.msg+' name="'+id+'">';
				$("#c-"+id).attr("src",data.msg);
				
				parent.html(imgPath);
				parent.addClass('active');
			} else {
				layer.alert(data.msg);
			}
		}
	})
});
//删除主图
$('.page_edit_list_item').on('click','.fa-trash',function(){
	var id =  $(this).parent().parent().parent().attr("data-id");
	var html = '+<input type="file"';
	html  += 'id="'+id+'" name="pic"/>';
	$(this).parent().parent().html(html);
	$("#c-"+id).attr("src","");
});

</script>
</body>
</html>
