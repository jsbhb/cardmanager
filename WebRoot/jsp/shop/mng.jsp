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
<%@include file="../resourceLink.jsp"%>
</head>
<body>
	<section class="content-header">
	      <ol class="breadcrumb">
	        <li><a href="javascript:void(0);">首页</a></li>
	        <li>微店管理</li>
	        <li class="active">信息维护</li>
	      </ol>
    </section>
	<section class="content-iframe content">
		<form class="form-horizontal" role="form" id="gradeConfigForm" >
			<div class="title">
	       		<h1>微店信息</h1>
	       	</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">店铺编号</div>
				<div class="col-sm-9 item-right">
					<input type="hidden" class="form-control" name="id" id="id" value="${shop.id}">
          			<input type="text" readonly class="form-control" name="gradeId" id="gradeId" value="${opt.gradeId}">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">店铺名称</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="name" id="name" value="${shop.name}">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">店铺简介</div>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" name="aboutUs" id="aboutUs" value="${shop.aboutUs}">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">店铺头像</div>
				<div class="col-sm-9 item-right addContent">
					<c:choose>
					   <c:when test="${shop.headImg != null && shop.headImg != ''}">
               	  			<div class="item-img choose" id="content" >
								<img src="${shop.headImg}">
								<div class="bgColor"><i class="fa fa-trash fa-fw"></i><i class="fa fa-search fa-fw"></i></div>
								<input value="${shop.headImg}" type="hidden" name="headImg" id="headImg">
							</div>
					   </c:when>
					   <c:otherwise>
                	  		<div class="item-img" id="content" >
								+
								<input type="file" id="pic" name="pic" />
								<input type="hidden" class="form-control" name="headImg" id="headImg"> 
							</div>
					   </c:otherwise>
					</c:choose> 
				</div>
			</div>
			<div class="scrollImg-content broadcast"></div>
	        <div class="submit-btn">
	           	<button type="button" id="submitBtn">保存</button>
           		<button type="button" onclick="downLoadExcel()">导出注册用户</button>
	       	</div>
            <div class="title">
	       		<h1>注册用户列表</h1>
	       	</div>
	       	
	       	<div class="list-content">
				<div class="col-md-12">
					<table id="staffTable" class="table table-hover myClass">
						<thead>
							<tr>
								<th>手机号</th>
								<th>姓名/昵称</th>
								<th>性别</th>
								<th>注册时间</th>
								<th>所属店铺</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
					<div class="pagination-nav">
						<ul id="pagination" class="pagination">
						</ul>
					</div>
				</div>
			</div>
		</form>
	</section>
	<%@include file="../resourceScript.jsp"%>
	<script src="${wmsUrl}/js/component/broadcast.js"></script>
	<script type="text/javascript" src="${wmsUrl}/js/ajaxfileupload.js"></script>
	<script type="text/javascript">	
	//点击上传图片
	$('.item-right').on('change','.item-img input[type=file]',function(){
		var imagSize = document.getElementById("pic").files[0].size;
		if(imagSize>1024*1024*3) {
			layer.alert("图片大小请控制在3M以内，当前图片为："+(imagSize/(1024*1024)).toFixed(2)+"M");
			return true;
		}
		$.ajaxFileUpload({
// 			url : '${wmsUrl}/admin/uploadFileForGrade.shtml', //你处理上传文件的服务端
			url : '${wmsUrl}/admin/uploadFileWithType.shtml?type=shop&key='+"${gradeId}", //你处理上传文件的服务端
			secureuri : false,
			fileElementId : "pic",
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					var imgHt = '<img src="'+data.msg+'"><div class="bgColor"><i class="fa fa-trash fa-fw"></i><i class="fa fa-search fa-fw"></i></div>';
					var imgPath = imgHt+ '<input type="hidden" value='+data.msg+' id="headImg" name="headImg">'
					$("#content").html(imgPath);
					$("#content").addClass('choose');
				} else {
					layer.alert(data.msg);
				}
			}
		})
	});
	//删除主图
	$('.item-right').on('click','.bgColor i.fa-trash',function(){
		var ht = '<div class="item-img" id="content" >+<input type="file" id="pic" name="pic"/><input type="hidden" name="headImg" id="headImg" value=""></div>';
		$(this).parent().parent().removeClass("choose");
		$(this).parent().parent().parent().html(ht);
	});
	
	$("#submitBtn").click(function(){
		 $.ajax({
			 url:"${wmsUrl}/admin/shop/shopMng/update.shtml",
			 type:'post',
			 data:JSON.stringify(sy.serializeObject($('#gradeConfigForm'))),
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){	
					 layer.alert("保存成功");
				 }else{
					 layer.alert(data.msg);
				 }
			 },
			 error:function(){
				 layer.alert("提交失败，请联系客服处理");
			 }
		 });
	 });
	
	function setPicImgListData() {
		var valArr = new Array;
		var tmpPicPath = $("#headImg").val();
		if (tmpPicPath != null && tmpPicPath != "") {
			valArr.push(tmpPicPath);
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
	
	/**
	 * 初始化分页信息
	 */
	var options = {
		queryForm : ".query",
		url :  "${wmsUrl}/admin/shop/shopMng/dataListForShop.shtml?shopId="+"${opt.gradeId}",
		numPerPage:"10",
		currentPage:"",
		index:"1",
		callback:rebuildTable
	}
	
	$(function(){
		$(".pagination-nav").pagination(options);
	})
	
	/**
	 * 重构table
	 */
	function rebuildTable(data){
		$("#staffTable tbody").html("");

		if (data == null || data.length == 0) {
			return;
		}

		var str = "";
		var list = data.obj;
		
		if (list == null || list.length == 0) {
			str = "<tr style='text-align:center'><td colspan=6><h5>没有查到数据</h5></td></tr>";
			$("#staffTable tbody").html(str);
			return;
		}
		
		for (var i = 0; i < list.length; i++) {
			str += "<tr>";
			str += "<td>" + list[i].phone;
			str += "</td><td>" + (list[i].userDetail.name == "" ? list[i].userDetail.nickName : list[i].userDetail.name);
			str += "</td><td>" + (list[i].userDetail.sex == "0" ? "男" : "女");
			str += "</td><td>" + (list[i].createTime == null ? "" : list[i].createTime);
			str += "</td><td>${shop.name}";
			str += "</td></tr>";
		}
		$("#staffTable tbody").html(str);
	}

	function reloadTable(){
		$.page.loadData(options);
	}
	
	function downLoadExcel(){
    	var shopId = "${opt.gradeId}";
    	var url = "${wmsUrl}/admin/shop/shopMng/downLoadExcel.shtml?shopId="+shopId;
    	window.open(url);
    }
	</script>
</body>
</html>
