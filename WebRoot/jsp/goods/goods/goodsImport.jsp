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
<%@include file="../../resourceLink.jsp"%>
</head>

<body>
	<section class="content-header">
	      <ol class="breadcrumb">
	        <li><a href="javascript:void(0);">首页</a></li>
	        <li>商品管理</li>
	        <li class="active">商品导入</li>
	      </ol>
    </section>
	<section class="content">
		<div id="image" style="width:100%;height:100%;display: none;background:rgba(0,0,0,0.5);margin-left:-25px;margin-top:-62px;">
			<img alt="loading..." src="${wmsUrl}/img/loader.gif" style="position:fixed;top:50%;left:50%;margin-left:-16px;margin-top:-16px;" />
		</div>
		<div class="uploadFile-status">
			<div class="uploadFile-tail col-sm-8 col-sm-offset-2">
				<i></i>
			</div>
			<div class="uploadFile-step col-sm-8 col-sm-offset-2">
				<div class="uploadFile-step-left">
					<div class="uploadFile-step-header">
						<div class="step-header-inner">
							<span class="step-header-icon">1</span>
						</div>
					</div>
					<div class="uploadFile-step-main">
						<div class="step-main-title">导入模板</div>
					</div>
				</div>
				<div class="uploadFile-step-right nextStep">
					<div class="uploadFile-step-header">
						<div class="step-header-inner">
							<span class="step-header-icon">2</span>
						</div>
					</div>
					<div class="uploadFile-step-main">
						<div class="step-main-title">完成</div>
					</div>
				</div>
			</div>
		</div>
		<div class="uploadBtns">
			<div class="col-sm-5 uploadBtns-left">
				<span>上传商品数据：</span>
			</div>
			<div class="col-sm-7 uploadBtns-right">
				<ul>
					<li>
						<span class="btn-upload">上传文件</span>
						<input type="file" id="import" name = "import" accept=".xls,.xlsx">
					</li>
				</ul>
				<p>请选择.xlsx或.xls格式文件，若无已导出的商品文件，<a href="javascript:void(0);" onclick="excelModelExport()">请下载空白模板</a></p>
			</div>
		</div>
		<div class="aside-footer-content">
			<p class="content-title">温馨提示</p>
			<p>1、建议条数≤500条，文件大小≤2M</p>
			<p>2、黄底为选填，其余为必填</p>
			<p>3、多规格商品编号一定要一样，第一条填完之后，其他规格的商品“商家编码”前的数据除编号外其他可不填</p>
			<p>4、规格项、规格值一定要成对出现，而且要都填，只填一个会忽略，如果没有请删除这字段，规格项、规格值尽量看参照表，也可以自己定义</p>
			<p>5、分级名称、返佣值一定要成对出现，而且要都填，只填一个会忽略，如果没有返佣请删除这个字段</p>
			<p>6、返佣填写时，一定要从分级类型高的开始，且下一级分级的返佣比例要小于上一级返佣比例，返佣比例不能大于1，中国供销海外购的返佣可不填</p>
			<p>7、如果分级、供应商、三级分类、品牌有新增或修改，请重新下载模板</p>
			<p>8、商家编码如果没有请和自有编码填写一致，如果以后需做系统对接，则请维护好商家编码</p>
			<p>9、其他问题请联系技术</p>
		</div>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script type="text/javascript" src="${wmsUrl}/js/ajaxfileupload.js"></script>
	<script type="text/javascript">
	
	function excelModelExport(){
		window.open("${wmsUrl}/admin/goods/goodsMng/exportGoodsInfoTemplate.shtml");
	}
	
	//点击上传文件
	$("body").on('change',"#import",function(){
		if(!$(".uploadFile-step-right").hasClass("nextStep")){
			$(".uploadFile-step-right").addClass("nextStep");
		}
		$("#image").css({
			display : "block",
			position : "fixed",
			zIndex : 99,
		});
		$.ajaxFileUpload({
			url : '${wmsUrl}/admin/uploadExcelFile.shtml?path=goodsImport', //你处理上传文件的服务端
			secureuri : false,
			fileElementId : "import",
			dataType : 'json',
			success : function(data) {
				//文件上传成功，进行读取操作
				var filePath = data.msg;
				readExcelForImport(filePath);
			}
		})
	});
	
	function readExcelForImport(filePath){
		$.ajax({
			 url:"${wmsUrl}/admin/goods/goodsMng/importGoodsInfo.shtml?filePath="+filePath,
			 type:'post',
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){
					 $(".uploadFile-step-right").removeClass("nextStep");
					 if(data.msg != '' && data.msg != null){
						 layer.alert(data.msg);
					 }
				 }else{
					 layer.alert(data.msg);
				 }
				 $("#image").hide();
			 },
			 error:function(){
				 $("#image").hide();
				 layer.alert("处理失败，请联系客服处理");
			 }
		 });
	}

	</script>
</body>
</html>
