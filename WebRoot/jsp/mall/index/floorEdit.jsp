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
	<section class="content-wrapper">
		<section class="content-iframe content">
			<form class="form-horizontal" role="form" id="floorForm">
				<div class="list-item">
					<div class="col-sm-3 item-left">楼层编号</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" readonly name="id" value="${dict.id}"> 
						<input type="hidden" class="form-control" readonly name="layoutId" value="${dict.layoutId}"> 
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left">楼层分类</div>
					<div class="col-sm-9 item-right">
						<select class="form-control" name="firstCategory" id="firstCategory">
	                   	  <c:forEach var="first" items="${firsts}">
	                   	  	<c:if test="${dict.firstCategory == first.firstId}">
	                   	  		<option value="${first.firstId}" selected>${first.name}</option>
	                   	  	</c:if>
	                   	  	<c:if test="${dict.firstCategory != first.firstId}">
	                   	  		<option value="${first.firstId}">${first.name}</option>
	                   	  	</c:if>
	                   	  </c:forEach>
		                </select>
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left">楼层名称</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="name" value="${dict.name}"> 
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left">楼层别称</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="enname" value="${dict.enname}"> 
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left">楼层描述</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="description" value="${dict.description}"> 
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left">楼层顺序</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="sort" value="${dict.layout.sort}"> 
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left">楼层大图</div>
					<div class="col-sm-9 item-right addContent">
						<c:choose>
						   <c:when test="${dict.picPath1 != null && dict.picPath1 != ''}">
	               	  			<div class="item-img choose" id="content1" data-id="1">
									<img src="${dict.picPath1}">
									<div class="bgColor"><i class="fa fa-trash fa-fw"></i><i class="fa fa-search fa-fw"></i></div>
									<input value="${dict.picPath1}" type="hidden" name="picPath1" id="picPath1">
								</div>
						   </c:when>
						   <c:otherwise>
	                	  		<div class="item-img" id="content1" data-id="1">
									+
									<input type="file" id="pic1" name="pic" />
									<input type="hidden" class="form-control" name="picPath1" id="picPath1"> 
								</div>
						   </c:otherwise>
						</c:choose> 
					</div>
				</div>
				<div class="scrollImg-content broadcast"></div>
		        <div class="submit-btn">
		           	<button type="button" id="submitBtn">提交</button>
		       	</div>
	        </form>
	        <div class="list-content">
				<div class="row">
					<div class="col-md-12 list-btns">
						<button type="button" onclick="toAdd()">新增楼层商品</button>
					</div>
				</div>
				<div class="row content-container">
					<div class="col-md-12 container-right active">
						<table id="floorGoodsTable" class="table table-hover myClass">
							<thead>
								<tr>
									<th width="10%">编号</th>
									<th width="30%">图片地址</th>
									<th width="7%">跳转地址</th>
									<th width="30%">商品标题</th>
									<th width="7%">国家</th>
									<th width="7%">价格</th>
									<th width="9%">操作</th>
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
			</div>
		</section>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script src="${wmsUrl}/js/component/broadcast.js"></script>
	<script type="text/javascript" src="${wmsUrl}/js/ajaxfileupload.js"></script>
	<script type="text/javascript">
	
	/**
	 * 初始化分页信息
	 */
	var options = {
		queryForm : ".query",
		url :  "${wmsUrl}/admin/mall/indexMng/dataListForData.shtml?dictId=${dict.id}",
		numPerPage:"20",
		currentPage:"",
		index:"1",
		callback:rebuildTable
	}
	
	
	//点击上传图片
	$('.item-right').on('change','.item-img input[type=file]',function(){
		var id = $(this).parent().attr('data-id'); 
		var imagSize = document.getElementById("pic"+id).files[0].size;
		if(imagSize>1024*1024*3) {
			layer.alert("图片大小请控制在3M以内，当前图片为："+(imagSize/(1024*1024)).toFixed(2)+"M");
			return true;
		}

		var baseUrl = "${wmsUrl}/admin/uploadFileWithType.shtml";
		var pageTypeValue = "${dict.layout.pageType}";
		var tmpType = "";
		if (pageTypeValue == 0) {
			tmpType = "PC-floor";
		} else if (pageTypeValue == 1) {
			tmpType = "H5-floor";
		}
		baseUrl = baseUrl + "?type=" + tmpType + "&key=${dict.id}";
		
		$.ajaxFileUpload({
// 			url : '${wmsUrl}/admin/uploadFileForGrade.shtml', //你处理上传文件的服务端
			url : baseUrl, //你处理上传文件的服务端
			secureuri : false,
			fileElementId : "pic"+id,
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					var imgHt = '<img src="'+data.msg+'"><div class="bgColor"><i class="fa fa-trash fa-fw"></i><i class="fa fa-search fa-fw"></i></div>';
					var imgPath = imgHt+ '<input type="hidden" value='+data.msg+' id="picPath'+id+'" name="picPath'+id+'">'
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
		var id = $(this).parent().parent().attr("data-id");
		var ht = '<div class="item-img" id="content'+id+'" data-id="'+id+'">+<input type="file" id="pic'+id+'" name="pic"/><input type="hidden" name="picPath'+id+'" id="picPath'+id+'" value=""></div>';
		$(this).parent().parent().removeClass("choose");
		$(this).parent().parent().parent().html(ht);
	});
	
	function toAdd(){
		var index = layer.open({
			  title:"新增内容编辑",		
			  type: 2,
			  content: '${wmsUrl}/admin/mall/indexMng/toAddFloorContent.shtml?id=${dict.id}&pageType=${dict.layout.pageType}',
			  maxmin: false
			});
			layer.full(index);
	}
	
	function toEdit(id){
		var index = layer.open({
			  title:"内容编辑",		
			  type: 2,
			  content: '${wmsUrl}/admin/mall/indexMng/toEditContent.shtml?id='+id+'&pageType=${dict.layout.pageType}&bussinessType=floorGoods&key=${dict.id}',
			  maxmin: false
			});
			layer.full(index);
	}

	$(function(){
		 $(".pagination-nav").pagination(options);
	})


	function reloadTable(){
		$.page.loadData(options);
	}
	
	/**
	 * 重构table
	 */
	function rebuildTable(data){
		$("#floorGoodsTable tbody").html("");

		if (data == null || data.length == 0) {
			return;
		}
		
		var list = data.obj;
		var str = "";
		
		if (list == null || list.length == 0) {
			str = "<tr style='text-align:center'><td colspan=7><h5>没有查到数据</h5></td></tr>";
			$("#floorGoodsTable tbody").html(str);
			return;
		}
		
		for (var i = 0; i < list.length; i++) {
			str += "<tr>";
			str += "</td><td>" + list[i].id;
			str += "</td><td><img style='width:62px;height:62px;'  src=\"" + list[i].picPath+"\">";
			str += "</td><td>" + list[i].href;
			str += "</td><td>" + list[i].title;
			str += "</td><td>" + list[i].origin;
			str += "</td><td>" + list[i].price;
			str += "</td><td>";
			str += "<a href='javascript:void(0);' class='table-btns' onclick='toEdit("+list[i].id+")'>编辑</a>";
			str += "</td></tr>";
		}
		$("#floorGoodsTable tbody").html(str);
	}
	
	
	$("#submitBtn").click(function(){
		$('#floorForm').data("bootstrapValidator").validate();
		 if($('#floorForm').data("bootstrapValidator").isValid()){
			 $.ajax({
					url : '${wmsUrl}/admin/mall/indexMng/updateDict.shtml',
					type : 'post',
					contentType : "application/json; charset=utf-8",
					data : JSON.stringify(sy.serializeObject($('#floorForm'))),
					dataType : 'json',
					success : function(data) {
						if (data.success) {
							parent.location.reload();
							layer.alert("修改成功");
						} else {
							layer.alert(data.msg);
						}
					},
					error : function() {
						layer.alert("提交失败，请联系客服处理");
					}
				});
		 }else{
			 layer.alert("提交失败，请联系客服处理");
		 }
	})
	
	$('#floorForm').bootstrapValidator({
//      live: 'disabled',
      message: 'This value is not valid',
      feedbackIcons: {
          valid: 'glyphicon glyphicon-ok',
          invalid: 'glyphicon glyphicon-remove',
          validating: 'glyphicon glyphicon-refresh'
      },
      fields: {
    	  pic1: {
              message: '大图地址不能空',
              validators: {
                  notEmpty: {
                      message: '大图地址不能空！'
                  }
              }
      	  },
      	 name: {
            message: '楼层名称不能为空',
            validators: {
                notEmpty: {
                    message: '楼层名称不能为空！'
                }
            }
    	  }
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
	</script>
</body>
</html>
