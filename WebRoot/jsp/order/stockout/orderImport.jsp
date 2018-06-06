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
	        <li class="active">订单导入</li>
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
				<span>上传订单数据：</span>
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
			<p>1、建议条数≤300条，文件大小≤2M</p>
			<p>2、黄底为选填，其余为必填</p>
			<p>3、（自有编码、换算比例）和商品编号2选1填写，如果都填写则以商品编号为准，如果填写自有编码则换算比例也必填</p>
			<p>4、如果订购人信息填写，请将订购人姓名，身份证，手机号全部填完整</p>
			<p>5、区域中心，订单来源，支付方式对应的参数请参考各个sheet，填写一定要准确</p>
			<p>6、如果区域中心有新增或修改，请重新下载模板</p>
			<p>7、订单如果多个商品，除了商品信息不一致其他信息请都保持一致</p>
			<p>8、零售价如果填写则以填写的为准，如果没有填写则以系统内为准,由于系统零售价有返佣，所以大客户订单请填写零售价</p>
			<p>9、其他相关问题请联系技术</p>
		</div>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script type="text/javascript" src="${wmsUrl}/js/ajaxfileupload.js"></script>
	<script type="text/javascript">
	
	function excelModelExport(){
		window.open("${wmsUrl}/admin/order/stockOutMng/downLoadOrderImportExcel.shtml");
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
			url : '${wmsUrl}/admin/uploadExcelFile.shtml?path=orderImport', //你处理上传文件的服务端
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
			 url:"${wmsUrl}/admin/order/stockOutMng/importOrder.shtml?filePath="+filePath,
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
