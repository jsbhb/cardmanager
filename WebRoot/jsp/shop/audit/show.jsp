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
<link rel="stylesheet" href="${wmsUrl}/css/component/broadcast.css">
<%@include file="../../resourceLink.jsp"%>
</head>

<body>
	<section class="content-iframe content">
		<form class="form-horizontal" role="form" id="form">
			<div class="title">
	       		<h1>基础信息</h1>
	       	</div>
			<div class="list-item">
				<label class="col-sm-3 item-left" >分级名称</label>
				<div class="col-sm-9 item-right">
            		<input type="text" class="form-control" name="gradeName" id = "gradeName" readonly value="${grade.gradeName}">
            		<input type="hidden" class="form-control" name="gradeId" id="gradeId" readonly value="${grade.id}">
				</div>
			</div>
			<div class="list-item">
				<label class="col-sm-3 item-left" >上级机构<font style="color:red">*</font> </label>
				<div class="col-sm-9 item-right">
				<input type="text" class="form-control" id="parentGradeName" style="background:#fff;" placeholder="选择上级机构" value="${grade.parentGradeName}"/>
	            <input type="hidden" class="form-control" name="parentId" id="parentId" value = "${grade.parentId}"/>
				<div class="list-item" style="display:none">
					<div class="col-sm-3 item-left">上级机构</div>
					<div class="col-sm-9 item-right">
				   		<select class="form-control" id="hidBrand">
			                <c:forEach var="g" items="${gradeList}">
			                <option value="${g.id}">${g.name}</option>
			                </c:forEach>
			            </select>
					</div>
				</div>
				</div>
			</div>
			<div class="select-content" id="parentGrade" style="width: 420px;top: 220px;">
				<input type="text" placeholder="请输入上级分级名称" id="searchBrand"/>
	            <ul class="first-ul" id = "grade-ul" style="margin-left:5px;">
	           		<c:forEach var="g" items="${gradeList}">
						<li><span data-id="${g.id}" data-name="${g.name}" class="no-child">${g.name}</span></li>
					</c:forEach>
	           	</ul>
		    </div>
			<div class="list-item">
				<label class="col-sm-3 item-left" >分级类型<font style="color:red">*</font> </label>
				<div class="col-sm-9 item-right">
					<c:choose>
					<c:when test="${not empty gradeTypeList}">
						<input type="text" class="form-control" id="gradeTypeName" readonly style="background:#fff;" value="${gradeType.name}">
		                <input type="hidden" readonly class="form-control" name="gradeType" id="gradeType" value="${grade.gradeType}">
					</c:when>
					<c:otherwise>
						<input type="text" class="form-control" id="gradeTypeName" readonly style="background:#fff;" value="">
		                <input type="hidden" readonly class="form-control" name="gradeType" id="gradeType" value="">
					</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="select-content" id="childGradeType" style="width: 420px;top: 170px;">
           		<ul class="first-ul" id="gradeType-ul" style="margin-left:5px;">
           			<c:if test="${not empty gradeTypeList}">
	           			<c:forEach var="g" items="${gradeTypeList}">
							<li><span data-id="${g.id}" data-name="${g.name}" class="no-child">${g.name}</span></li>
						</c:forEach>
					</c:if>
           		</ul>
           	</div>
			<div class="title">
	       		<h1>负责人信息</h1>
	       	</div>
			<div class="list-item">
				<label class="col-sm-3 item-left" >负责人名称</label>
				<div class="col-sm-9 item-right">
	                  <input type="text" class="form-control" name="personInCharge" readonly value="${grade.personInCharge}">
				</div>
			</div>
			<div class="list-item">
				<label class="col-sm-3 item-left" >负责人电话</label>
				<div class="col-sm-9 item-right">
	                  <input type="text" class="form-control" readonly name="phone" id="phone" readonly value="${grade.phone}">
				</div>
			</div>
			<div class="title">
	       		<h1>注册信息</h1>
	       	</div>
			<div class="list-item">
				<label class="col-sm-3 item-left" >门店名称</label>
				<div class="col-sm-9 item-right">
	                  <input type="text" class="form-control" name="storeName" readonly value="${grade.storeName}">
				</div>
			</div>
			<div class="list-item picker-country">
				<label class="col-sm-3 item-left" >门店地区</label>
				<div class="col-sm-9 item-right">
					<div class="right-items">
						  <input type="text" class="form-control" name="province" id="province" readonly value="${grade.province}"/>
					</div>
					<div class="right-items">
						  <input type="text" class="form-control" name="city" id="city" readonly value="${grade.city}"/>
					</div>
					<div class="right-items">
						  <input type="text" class="form-control" name="district" id="district" readonly value="${grade.district}"/>
					</div>
				</div>
			</div>
			<div class="list-item">
				<label class="col-sm-3 item-left" >门店地址</label>
				<div class="col-sm-9 item-right">
	                  <input type="text" class="form-control" name="address" readonly value="${grade.address}">
				</div>
			</div>
			<div class="list-item">
				<label class="col-sm-3 item-left" >备注</label>
				<div class="col-sm-9 item-right">
	                  <input type="text" class="form-control" name="remark" id="remark" value="${grade.remark}">
				</div>
				<div class="item-content">
					（由于短信限制，审核失败原因填写小于20字）
	            </div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">身份证正面照</div>
				<div class="col-sm-9 item-right addContent">
             	  	<div class="item-img choose" id="content1" data-id="1">
						<img src="${grade.picPath1}">
						<div class="bgColor"><i class="fa fa-search fa-fw"></i></div>
						<input value="${grade.picPath1}" type="hidden" name="picPath1" id="picPath1">
					</div>
				</div>
			</div>
			<div class="scrollImg-content broadcast"></div>
			<div class="submit-btn">
				<c:if test="${grade.status==0}">
       				<button type="button" class="btn btn-primary" id="pass">通过</button>
       				<button type="button" class="btn btn-primary" id="unpass">不通过</button>
				</c:if>
              	<button type="button" class="btn btn-info" id="closeBtn">关闭</button>
       		</div>
		</form>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script src="${wmsUrl}/js/component/broadcast.js"></script>
	<script src="${wmsUrl}/js/pagination.js"></script>
	<script src="${wmsUrl}/js/jquery.picker.js"></script>
	<script type="text/javascript" src="${wmsUrl}/js/ajaxfileupload.js"></script>
	<script type="text/javascript">

	var cpLock = false;
	$('#searchBrand').on('compositionstart', function () {
	    cpLock = true;
	});
	$('#searchBrand').on('compositionend', function () {
	    cpLock = false;
	});

	$("#pass").click(function(){
		 var gradeType = $('#gradeType').val();
		 if(gradeType == '' || gradeType == null){
			 layer.alert("请选择分级类型");
			 return;
		 }
		 var parentId = $('#parentId').val();
		 if(parentId == '' || parentId == null){
			 layer.alert("请选择父级分级");
			 return;
		 }
		 var gradeId = $("#gradeId").val();
		 var obj = {};
		 obj.gradeType = gradeType;
		 obj.parentId = parentId;
		 obj.status = 2;
		 obj.id = gradeId
		 $.ajax({
			 url:"${wmsUrl}/admin/shop/shopMng/audit.shtml",
			 type:'post',
			 data:JSON.stringify(obj),
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){	
					 parent.layer.closeAll();
					 parent.reloadTable();
				 }else{
					 parent.reloadTable();
					 layer.alert(data.msg);
				 }
			 },
			 error:function(){
				 layer.alert("提交失败，请联系客服处理");
			 }
		 });
	 });
	
	$("#unpass").click(function(){
		 var remark = $("#remark").val();
		 var gradeId = $("#gradeId").val();
		 var obj = {};
		 obj.remark = remark;
		 obj.status = 1;
		 obj.id = gradeId;
		 $.ajax({
			 url:"${wmsUrl}/admin/shop/shopMng/audit.shtml",
			 type:'post',
			 data:JSON.stringify(obj),
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){	
					 parent.layer.closeAll();
					 parent.reloadTable();
				 }else{
					 parent.reloadTable();
					 layer.alert(data.msg);
				 }
			 },
			 error:function(){
				 layer.alert("提交失败，请联系客服处理");
			 }
		 });
	 });
	
	//点击展开下拉列表
	$('#gradeTypeName').click(function(){
	
		$('#childGradeType').stop();
		$('#childGradeType').slideDown(300);
	});
	
	//点击空白隐藏下拉列表
	$('html').click(function(event){
		var el = event.target || event.srcelement;
		if(!$(el).parents('#childGradeType').length > 0 && $(el).attr('id') != "gradeTypeName"){
			$('#childGradeType').stop();
			$('#childGradeType').slideUp(300);
		}
	});
	//点击选择分类
	$('#childGradeType').on('click','span',function(event){
		var el = event.target || event.srcelement;
		if(el.nodeName != 'I'){
			var name = $(this).attr('data-name');
			var id = $(this).attr('data-id');
			$('#gradeTypeName').val(name);
			$('#gradeType').val(id);
			$('#childGradeType').stop();
			$('#childGradeType').slideUp(300);
		}
	});
	
	function setPicImgListData() {
		var valArr = new Array;
		var tmpPicPath="";
		for(var i=1;i<5;i++) {
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
	
	//点击展开下拉列表
	$('#parentGradeName').click(function(){
		$('#parentGrade').css('width',$(this).outerWidth());
		$('#parentGrade').css('left',$(this).offset().left - 25);
		$('#parentGrade').css('top',$(this).offset().top + $(this).height() - 18);
		$('#parentGrade').stop();
		$('#parentGrade').slideDown(300);
	});

	//点击空白隐藏下拉列表
	$('html').click(function(event){
		var el = event.target || event.srcelement;
		if(!$(el).parents('#parentGrade').length > 0 && $(el).attr('id') != "parentGradeName"){
			$('#parentGrade').stop();
			$('#parentGrade').slideUp(300);
		}
	});
	//点击选择分类
	$('#parentGrade').on('click','span',function(event){
		var el = event.target || event.srcelement;
		if(el.nodeName != 'I'){
			var id = $(this).attr('data-id');
			var name = $(this).attr('data-name');
			$('#parentId').val(id);
			$('#parentGradeName').val(name);
			$('#searchBrand').val("");
			reSetDefaultInfo();
			$('#parentGrade').stop();
			$('#parentGrade').slideUp(300);
			$("#gradeTypeName").val("");
			$("#gradeType").val("");
			$.ajax({
				url:"${wmsUrl}/admin/system/gradeMng/listGradeType.shtml?id="+id,
				 type:'post',
				 contentType: "application/json; charset=utf-8",
				 dataType:'json',
				 success:function(data){
					 if(data.success){	
						 var list = data.data;
						 var str = "";
						 if (list != null && list.length > 0) {
							 for(var i = 0; i<list.length; i++){
								 str += '<li><span data-id="'+list[i].id+'" data-name="'+list[i].name+'" class="no-child">'+list[i].name+'</span></li>';
							 }
						 }
						 $("#gradeType-ul").html(str);
					 }else{
						 layer.alert(data.msg);
					 }
				 },
				 error:function(){
					 layer.alert("提交失败，请联系客服处理");
				 }
			});
		}
	});

	$('#searchBrand').on("input",function(){
		if (!cpLock) {
			var tmpSearchKey = $(this).val();
			if (tmpSearchKey !='') {
				var searched = "";
				$('#grade-ul li').each(function(li_obj){
					var tmpLiId = $(this).find("span").attr('data-id');
					var tmpLiText = $(this).find("span").attr('data-name');
					var flag = tmpLiText.indexOf(tmpSearchKey);
					if(flag >=0) {
						searched = searched + "<li><span data-id=\""+tmpLiId+"\" data-name=\""+tmpLiText+"\" class=\"no-child\">"+tmpLiText+"</span></li>";
					}
				});
				$('#grade-ul').html(searched);
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
		$('#grade-ul').html(tmpBrands);
	}

	$('#closeBtn').click(function() {
		parent.layer.closeAll();
    });
	</script>
</body>
</html>
