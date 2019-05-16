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
	        <li>资讯管理</li>
	        <li class="active">商品介绍</li>
	      </ol>
    </section>
	<section class="content-iframe content">
		<form class="form-horizontal" role="form" id="itemForm2">
			<div class="title">
	       		<h1>商品介绍</h1>
	       	</div>
	       	<div class="submit-btn">
	           	<button type="button" id="addInfo">添加文字</button>
	           	<button type="button" id="addPic">添加图片</button>
	           	<button type="button" id="addViedo">添加视频</button>
	       	</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">SEO标题</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="title" id="title">
					<div class="item-content">
	             		（SEO标题，和文章内容有关联性）
	             	</div>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">SEO关键字</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="keywords" id="keywords">
					<div class="item-content">
	             		（SEO关键字，和文章内容有关联性）
	             	</div>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">SEO描述</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="description" id="description">
					<div class="item-content">
	             		（SEO描述，和文章内容有关联性）
	             	</div>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">文章标题</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="infoTitle-1" id="infoTitle">
					<div class="item-content">
	             		（文章标题）
	             	</div>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">封面</div>
				<div class="col-sm-9 item-right addContent">
					<div class="item-img" id="content0">
						+
						<input type="file" id="coverPic" name="pic" data-id="0" onchange="upload(this)"/>
					</div>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">文章时间/作者</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="infoAuth-2" id="infoAuth">
					<div class="item-content">
	             		（文章时间/作者）<a href="javascript:void(0);" onclick = "getTime()">获取时间</a>
	             	</div>
				</div>
			</div>
	        <div class="submit-btn">
	           	<button type="button" id="submitBtn">保存并发布</button>
	       	</div>
		</form>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script src="${wmsUrl}/js/component/broadcast.js"></script>
<%-- 	<script src="${wmsUrl}/plugins/ckeditor/ckeditor.js"></script> --%>
	<script type="text/javascript" src="${wmsUrl}/js/ajaxfileupload.js"></script>
	<script type="text/javascript" charset="utf-8" src="${wmsUrl}/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="${wmsUrl}/ueditor/ueditor.all.js"></script>
	<script type="text/javascript" charset="utf-8" src="${wmsUrl}/ueditor/lang/zh-cn/zh-cn.js"></script>
	<script type="text/javascript" charset="utf-8" src="${wmsUrl}/js/goodsJs/goods.js"></script>
	<script type="text/javascript">	 
	
	 $("#submitBtn").click(function(){
		 var infoTitle = $("#infoTitle").val();
		 if(infoTitle == ""){
			 layer.alert("请填写文章标题");
			 return;
		 }
		 var title = $("#title").val();
		 if(title == ""){
			 layer.alert("请填写SEO标题");
			 return;
		 }
		 var keywords = $("#keywords").val();
		 if(keywords == ""){
			 layer.alert("请填写SEO关键字");
			 return;
		 }
		 var description = $("#description").val();
		 if(description == ""){
			 layer.alert("请填写SEO描述");
			 return;
		 }
		 var url = "${wmsUrl}/admin/goods/evaluation/add.shtml";
		 var formData = sy.serializeObject($('#itemForm2'));
		 var arr = new Array();
		 var keys = Object.keys(formData);
		 var seo = {};
		 seo.title = formData.title;
		 seo.description = formData.description;
		 formData.introduction = formData.description;
		 seo.keywords = formData.keywords;
		 formData.seo = seo;
		 delete formData.title;
		 delete formData.description;
		 delete formData.keywords;
		 for(var i in keys){
			 var key = keys[i];
			 var obj = {};
			 var cont = {};
			 if(key.indexOf("info-") != -1){
				  obj.code = "information-left-text";
				  obj.sort = key.substring(5);
				  obj.area = "bodyCenter";
				  cont.text = formData[key];
				  obj.own = cont;
				  arr.push(obj);
				  delete formData[key];
			 }
			 if(key.indexOf("pic-") != -1){
				 obj.code = "information-left-pic";
				 obj.sort = key.substring(4);
				 obj.area = "bodyCenter";
				 cont.src = formData[key];
				 cont.alt = formData.seo.title
				 obj.own = cont;
				 arr.push(obj);
				 delete formData[key];
			 }
			 if(key.indexOf("infoTitle-") != -1){
				 obj.code = "information-left-title";
				 obj.sort = key.substring(10);
				 obj.area = "bodyCenter";
				 cont.text = formData[key];
				 obj.own = cont;
				 arr.push(obj);
				 formData.infoTitle = formData[key]
				 delete formData[key];
			 }
			 if(key.indexOf("infoAuth-") != -1){
				 obj.code = "information-left-time";
				 obj.sort = key.substring(9);
				 obj.area = "bodyCenter";
				 cont.text = formData[key];
				 obj.own = cont;
				 arr.push(obj);
				 delete formData[key];
			 }
		 }
		 formData.module = arr;
		 $.ajax({
			 url:url,
			 type:'post',
			 data:JSON.stringify(formData),
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){
					 jump(86)
				 }else{
					layer.alert(data.msg);
				 }
			 },
			 error:function(){
				 layer.alert("提交失败，请联系客服处理");
			 }
		 });
	 });
	 
	 var infoId = 3;
	 $("#addInfo").click(function() {
		 var str = "";
		 str += "<div class=\"list-item\">";
		 str += "<div class=\"col-sm-3 item-left\">主体文字</div>";
		 str += "<div class=\"col-sm-9 item-right\">";
		 str += "<textarea class=\"form-control\" name=\"info-"+infoId+"\" id=\"info-"+infoId+"\" data-id=\""+infoId+"\"></textarea>";
		 str += "<div class=\"item-content\">（文章内容）<a href=\"javascript:void(0);\" onclick = \"del(this)\">删除</a>&nbsp;&nbsp;<a href=\"javascript:void(0);\" onclick = \"addLink(this)\">增加链接</a>";
         str += "</div></div></div>";  		
		 $(".list-item:last").after(str);
		 infoId += 1;
	 });
	 
	 $("#addPic").click(function(){
		var str = "";
		str += "<div class=\"list-item\">";
		str += "<div class=\"col-sm-3 item-left\">添加图片</div>";
		str += "<div class=\"col-sm-9 item-right addContent\">";
		str += "<div class=\"item-img\" id=\"content"+infoId+"\">";
		str += "+<input type=\"file\" id=\"pic-"+infoId+"\" name=\"pic\" data-id=\""+infoId+"\" onchange=\"upload(this)\"/>";
		str += "</div><a href=\"javascript:void(0);\" onclick = \"del(this)\">删除</a></div></div>";
		$(".list-item:last").after(str);
		infoId += 1;
	 });
	 
	 function del(obj){
		 $(obj).parents(".list-item").remove();
	 }
	 
	//点击上传图片
	function upload(obj){
		var id = $(obj).attr("data-id");
		var fileId = $(obj).attr("id");
		var imagSize = document.getElementById(fileId).files[0].size;
		if(imagSize>1024*1024*3) {
			layer.alert("图片大小请控制在3M以内，当前图片为："+(imagSize/(1024*1024)).toFixed(2)+"M");
			return true;
		}
			
		$.ajaxFileUpload({
			url : '${wmsUrl}/admin/uploadFileWithType.shtml?type=info&key=info', //你处理上传文件的服务端
			secureuri : false,
			fileElementId : fileId,
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					var imgHt = '<img src="'+data.msg+'"><div class="bgColor"><i class="fa fa-trash fa-fw" onclick=\"delPic(this)\"></i></div>';
					var imgPath = imgHt+ '<input type="hidden" value='+data.msg+' name="'+fileId+'" id="'+fileId+'" data-id='+id+'>'
					$("#content"+id).html(imgPath);
					$("#content"+id).addClass('choose');
				} else {
					layer.alert(data.msg);
				}
			}
		})
	};
	//删除主图
	function delPic(obj){
		var id = $(obj).parent().next().attr("id");
		var dataId = $(obj).parent().next().attr("data-id");
		var html = '+<input type="file" id='+id+' name="pic" data-id="'+dataId+'"/ onchange=\"upload(this)\">';
		$(obj).parent().parent().removeClass('choose');
		$(obj).parent().parent().html(html);
	};
	
	function getTime(){
		var time = new Date().Format("yyyy-MM-dd HH:mm:ss");
		time += "  中国供销海外购"
		$("#infoAuth").val(time);
	}
	
	Date.prototype.Format = function (fmt) {
	    var o = {
	        "M+": this.getMonth() + 1, //月份 
	        "d+": this.getDate(), //日 
	        "H+": this.getHours(), //小时 
	        "m+": this.getMinutes(), //分 
	        "s+": this.getSeconds(), //秒 
	        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
	        "S": this.getMilliseconds() //毫秒 
	    };
	    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	    for (var k in o)
	    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
	    return fmt;
	}
	
	function addLink(obj){
		var str = $(obj).parent().prev().val();
		str += "<a href=\"\"></a>";
		$(obj).parent().prev().val(str)
	}
	</script>
</body>
</html>
