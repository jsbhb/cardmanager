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
<%@include file="../../resourceLink.jsp"%>
</head>

<body>
	<section class="content-iframe" style="margin-top:20px;">
		<div class="list-item">
			<div class="col-xs-3 item-left">供应商</div>
			<div class="col-xs-9 item-right">
				<select class="form-control" name="supplierId" id="supplierId">
                  	  <option selected="selected" value="-1">请选择供应商</option>
                  	  <c:forEach var="supplier" items="${suppliers}">
                  	  	<option value="${supplier.id}">${supplier.supplierName}</option>
                  	  </c:forEach>
                </select>
			</div>
		</div>
		<div class="list-item">
			<div class="col-sm-3 item-left">分级类型</div>
			<div class="col-xs-9 item-right">
				<input type="text" class="form-control" id="gradeTypeId" readonly style="background:#fff;" value="${gradeList[0].name}">
                <input type="hidden" readonly class="form-control" name="gradeType" id="gradeType" value="${gradeList[0].id}">
			</div>
		</div>
		<div class="select-content" style="width: 420px;top: 92px;">
       		<ul class="first-ul" style="margin-left:10px;">
       			<c:forEach var="menu" items="${gradeList}">
       				<c:set var="menu" value="${menu}" scope="request" />
       				<%@include file="gradeTyperecursive.jsp"%>  
				</c:forEach>
       		</ul>
       	</div>
       	<div class="list-item">
			<div class="col-sm-3 item-left">商品分类</div>
			<div class="col-sm-9 item-right">
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
			</div>
		</div>
		<div class="list-item">
			<div class="col-xs-3 item-left">商品类型</div>
			<div class="col-xs-9 item-right">
				<select class="form-control" name="goodsType" id="goodsType">
                	<option selected="selected" value="0">保税商品</option>
                	<option value="2">一般贸易商品</option>
                	<option value="3">直邮商品</option>
                	<option value="-1">全部商品</option>
               	</select>
			</div>
		</div>
		<c:if test="${type == 1 || type == 2}">
			<div class="list-item">
				<div class="col-xs-3 item-left">上下架状态</div>
				<div class="col-xs-9 item-right">
					<select class="form-control" name="itemStatus" id="itemStatus">
                  	  <option selected="selected" value="1">上架</option>
                  	  <option value="0">下架</option>
                  	  <option value="-1">全部</option>
                	</select>
               		<input type="hidden" readonly class="form-control" name="type" id="type" value="${type}">
				</div>
			</div>
		</c:if>
		<c:if test="${type == 3}">
			<div class="list-item">
				<div class="col-xs-3 item-left">上下架状态</div>
				<div class="col-xs-9 item-right">
					<select class="form-control" disabled name="itemStatus" id="itemStatus">
                  	  <option selected="selected" value="1">上架</option>
                	</select>
               		<input type="hidden" readonly class="form-control" name="type" id="type" value="${type}">
				</div>
			</div>
		</c:if>
       	<div class="list-item">
			<div class="col-xs-3 item-left">返佣比例区间</div>
			<div class="col-xs-9 item-right">
				<input type="text" class="chooseTime" id="rebateStart" onkeyup="clearNoNum(this)">
				<input type="text" class="chooseTime" id="rebateEnd" onkeyup="clearNoNum(this)">
				<div class="item-content">
             		（返佣比例请小于1,例如0.17）
             	</div>
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
			</div>
		</div>
		<div class="submit-btn">
           	<button type="button" onclick="downLoadExcel()">确认导出</button>
       	</div>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script type="text/javascript">
		//点击展开下拉列表
		$('#gradeTypeId').click(function(){
			$('.select-content').stop();
			$('.select-content').slideDown(300);
		});
		//点击空白隐藏下拉列表
		$('html').click(function(event){
			var el = event.target || event.srcelement;
			if(!$(el).parents('.select-content').length > 0 && $(el).attr('id') != "gradeTypeId"){
				$('.select-content').stop();
				$('.select-content').slideUp(300);
			}
		});
		//点击展开
		$('.select-content').on('click','li span i:not(active)',function(){
			$(this).addClass('active');
			$(this).parent().next().stop();
			$(this).parent().next().slideDown(300);
		});
		//点击收缩
		$('.select-content').on('click','li span i.active',function(){
			$(this).removeClass('active');
			$(this).parent().next().stop();
			$(this).parent().next().slideUp(300);
		});
		//点击选择分类
		$('.select-content').on('click','span',function(event){
			var el = event.target || event.srcelement;
			if(el.nodeName != 'I'){
				var name = $(this).attr('data-name');
				var id = $(this).attr('data-id');
				$('#gradeTypeId').val(name);
				$('#gradeType').val(id);
				$('.select-content').stop();
				$('.select-content').slideUp(300);
			}
		});
		
		//点击标签选中
		$('.label-content-express').on('click', 'li', function() {
			if (!$(this).hasClass("active")) {
				$(this).addClass("active");
			} else {
				$(this).attr("class", "");
			}
		});
		
	    function downLoadExcel(){
	    	var type = $("#type").val();
	    	var supplierId = $("#supplierId").val();
	    	var gradeType = $("#gradeType").val();
	    	var tagIdArr = new Array;
	    	var tmpTag = "";
			$('#tagId li.active').each(function(i){
				tmpTag = $(this).attr('data-id');
				if (tmpTag != undefined) {
					tagIdArr[i] = tmpTag;
				}
			})
	    	var rebateStart = $("#rebateStart").val();
			if (rebateStart >= 1){
				layer.alert('返佣比例起始区间有误，请确认');
        		return;
			}
	    	var rebateEnd = $("#rebateEnd").val();
			if (rebateEnd >= 1){
				layer.alert('返佣比例结束区间有误，请确认');
        		return;
			}

			var tmpFirstCatalogId = $("#firstCatalogId").val();
			var tmpSecondCatalogId = $("#secondCatalogId").val();
			var tmpThirdCatalogId = $("#thirdCatalogId").val();
			var tmpGoodsType = $("#goodsType").val();
			var tmpItemStatus = $("#itemStatus").val();
			
	    	var url = "${wmsUrl}/admin/goods/itemMng/downLoadExcel.shtml?type="+type+"&gradeType="+gradeType+
	    			  "&tagIds="+tagIdArr+"&supplierId="+supplierId+"&rebateStart="+rebateStart+"&rebateEnd="+rebateEnd+
	    			  "&firstCatalogId="+tmpFirstCatalogId+"&secondCatalogId="+tmpSecondCatalogId+"&thirdCatalogId="+tmpThirdCatalogId+
	    			  "&goodsType="+tmpGoodsType+"&itemStatus="+tmpItemStatus;
	    	window.open(url);
	    }
	    
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
	    }
		
		$("#firstCatalogId").change(function(){
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
							thirdSelect.append("<option value='-1'>选择分类</option>")
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
	</script>
</body>
</html>