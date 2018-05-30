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
	        <li>订单管理</li>
	        <li class="active">运单导入</li>
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
				<span>上传运单数据：</span>
			</div>
			<div class="col-sm-7 uploadBtns-right">
				<ul>
					<li>
						<span class="btn-upload">上传文件</span>
						<input type="file" id="import" name = "import" accept=".xlsx">
					</li>
				</ul>
				<p>请选择.xlsx格式文件，若无已导出的模板文件，<a href="javascript:void(0);" onclick="excelModelExport()">请下载空白模板</a></p>
			</div>
		</div>
		<div class="aside-footer-content">
			<p class="content-title">温馨提示</p>
			<p>1、建议运单条数≤500条，文件大小≤5M；</p>
			<p>2、其他相关问题请联系技术；</p>
		</div>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script type="text/javascript" src="${wmsUrl}/js/ajaxfileupload.js"></script>
	<script type="text/javascript">
	
	function excelModelExport(){
		window.open("${wmsUrl}/admin/order/stockOutMng/downLoadOrderModelExcel.shtml");
	}
	
	//点击上传文件
	$("body").on('change',"#import",function(){
		if(!$(".uploadFile-step-right").hasClass("nextStep")){
			$(".uploadFile-step-right").addClass("nextStep");
		}
		var imagSize = document.getElementById("import").files[0].size;
		if(imagSize>1024*1024*5) {
			layer.alert("文件大小请控制在5M以内，当前文件为："+(imagSize/(1024*1024)).toFixed(2)+"M");
			return true;
		}
		$.ajaxFileUpload({
			url : '${wmsUrl}/admin/uploadExcelFile.shtml', //你处理上传文件的服务端
			secureuri : false,
			fileElementId : "import",
			dataType : 'json',
			beforeSend : function() {
				$("#image").css({
					display : "block",
					position : "fixed",
					zIndex : 99,
				});
			},
			success : function(data) {
				//文件上传成功，进行读取操作
				var filePath = data.msg;
				readExcelForMaintain(filePath);
			},
			complete : function(data) {
				$("#image").hide();
			}
		})
	});
	
	function readExcelForMaintain(filePath){
		$.ajax({
			 url:"${wmsUrl}/admin/order/stockOutMng/readExcelForMaintain.shtml?filePath="+filePath,
			 type:'post',
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){
					 $(".uploadFile-step-right").removeClass("nextStep");
					 layer.alert("导入完成！");
				 }else{
					 layer.alert(data.msg);
				 }
			 },
			 error:function(){
				 layer.alert("处理失败，请联系客服处理");
			 }
		 });
	}
	</script>
</body>
</html>
