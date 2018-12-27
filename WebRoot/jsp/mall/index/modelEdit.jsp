<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
			<c:choose>
			   <c:when test="${modelKey == 'activity-1'}">
             	  	<form class="form-horizontal" role="form" id="adForm">
						<div class="list-item">
							<div class="col-sm-3 item-left">模块编号</div>
							<div class="col-sm-9 item-right">
								<input type="text" class="form-control" readonly id="cpId" name="cpId" value="${pageId}">
								<input type="hidden" class="form-control" readonly name="id" value="${mainData.id}"> 
							</div>
						</div>
						<div class="list-item">
							<div class="col-sm-3 item-left">商品标题</div>
							<div class="col-sm-9 item-right">
								<input type="text" class="form-control" name="title" value="${mainData.title}"> 
							</div>
						</div>
						<div class="list-item">
							<div class="col-sm-3 item-left">跳转链接</div>
							<div class="col-sm-9 item-right">
								<input type="text" class="form-control" name="href" value="${mainData.href}"> 
							</div>
						</div>
						<div class="list-item">
							<div class="col-sm-3 item-left">图片(750*340px)</div>
							<div class="col-sm-9 item-right addContent">
								<c:choose>
								   <c:when test="${mainData.picPath != null && mainData.picPath != ''}">
			               	  			<div class="item-img choose" id="content" >
											<img src="${mainData.picPath}">
											<div class="bgColor"><i class="fa fa-trash fa-fw"></i><i class="fa fa-search fa-fw"></i></div>
											<input value="${mainData.picPath}" type="hidden" name="picPath" id="picPath">
										</div>
								   </c:when>
								   <c:otherwise>
			                	  		<div class="item-img" id="content" >
											+
											<input type="file" id="pic" name="pic" />
											<input type="hidden" class="form-control" name="picPath" id="picPath"> 
										</div>
								   </c:otherwise>
								</c:choose> 
							</div>
						</div>
						<div class="scrollImg-content broadcast"></div>
				        <div class="submit-btn">
				           	<button type="button" onclick="save()">保存</button>
				       	</div>
					</form>
			   </c:when>
			   <c:otherwise>
			   		<form class="form-horizontal" role="form" id="itemForm">
				   		<div class="list-content">
		               		<div class="row">
								<div class="col-md-12 list-btns" style="margin-left:5px">
									<button type="button" onclick="showGoodsList()">添加商品</button>
	                				<input type="hidden" class="form-control" id="selectItem"/>
								</div>
							</div>
							<div id="goodsList" style="padding:0 20px;">
								<div class="list-item" id="goodsItem" style="width:100%;">
									<div class="list-all">
										<table class="dynamic-table" id="dynamicTable">
											<caption>商品列表</caption>
											<thead id="dynamic-thead">
											<tr>
												<th style='width: 10%;'>商品编号</th>
												<th style='width: 20%;'>商品名称</th>
												<th style='width: 10%;'>零售价</th>
												<th style='width: 10%;'><font style='color:red'>*</font>启用日期</th>
												<th style='width: 10%;'><font style='color:red'>*</font>活动价</th>
												<th style='width: 10%;'><font style='color:red'>*</font>划线价</th>
												<th style='width: 10%;'><font style='color:red'>*</font>活动返佣比例</th>
												<th style='width: 10%;'><font style='color:red'>*</font>展示顺序</th>
											</tr>
											</thead>
											<tbody id="dynamic-table">
												<c:forEach var="item" items="${dataList}">
													<tr>
														<td><input type="text" class="form-control" name="itemId" value="${item.itemId}" readonly><input type="hidden" name="picPath" value="${item.picPath}" readonly></td>
														<td>${item.goodsName}</td>
														<td><input type="text" class="form-control" name="oldRetailPrice" value="${item.oldRetailPrice}" readonly><input type="hidden" class="form-control" name="id" value="${item.id}"></td>
														<td><input type="text" class="form-control" name="startTime" value="${fn:split(item.startTime,' ')[0]}"><input type="hidden" class="form-control" name="goodsId" value="${item.goodsId}"></td>
														<td><input type="text" class="form-control" name="newRetailPrice" value="${item.newRetailPrice}"></td>
														<td><input type="text" class="form-control" name="linePrice" value="${item.linePrice}"></td>
														<td><input type="text" class="form-control" name="newRebate" value="${item.newRebate}"></td>
														<td><input type="text" class="form-control" name="sort" value="${item.sort}"></td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>
								</div>
							</div>
					        <div class="submit-btn">
					           	<button type="button" id="submitBtn">保存信息</button>
					       	</div>
				       	</div>
					</form>
			   </c:otherwise>
			</c:choose> 
		</section>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script src="${wmsUrl}/js/component/broadcast.js"></script>
	<script type="text/javascript" src="${wmsUrl}/js/ajaxfileupload.js"></script>
	<script type="text/javascript">
	var saveItemList=[];
	
	
	//点击上传图片
	$('.item-right').on('change','.item-img input[type=file]',function(){
		var imagSize = document.getElementById("pic").files[0].size;
		if(imagSize>1024*1024*3) {
			layer.alert("图片大小请控制在3M以内，当前图片为："+(imagSize/(1024*1024)).toFixed(2)+"M");
			return true;
		}
		var baseUrl = "${wmsUrl}/admin/uploadFileWithType.shtml";
		var pageTypeValue = "${pageType}";
		var bussinessTypeValue = "${bussinessType}";
		var tmpType = "";
		if (pageTypeValue == 0) {
			tmpType = "PC";
		} else if (pageTypeValue == 1) {
			tmpType = "H5";
		}
		tmpType = tmpType + "-" + bussinessTypeValue;
		baseUrl = baseUrl + "?type=" + tmpType + "&key=${key}";
		$.ajaxFileUpload({
// 			url : '${wmsUrl}/admin/uploadFileForGrade.shtml', //你处理上传文件的服务端
			url : baseUrl, //你处理上传文件的服务端
			secureuri : false,
			fileElementId : "pic",
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					var imgHt = '<img src="'+data.msg+'"><div class="bgColor"><i class="fa fa-trash fa-fw"></i><i class="fa fa-search fa-fw"></i></div>';
					var imgPath = imgHt+ '<input type="hidden" value='+data.msg+' id="picPath" name="picPath">'
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
		var ht = '<div class="item-img" id="content" >+<input type="file" id="pic" name="pic"/><input type="hidden" name="picPath" id="picPath" value=""></div>';
		$(this).parent().parent().removeClass("choose");
		$(this).parent().parent().parent().html(ht);
	});
	
	function save(){
		$('#adForm').data("bootstrapValidator").validate();
		 if($('#adForm').data("bootstrapValidator").isValid()){
			 $.ajax({
					url : '${wmsUrl}/admin/mall/indexMng/updateModelInfo.shtml',
					type : 'post',
					contentType : "application/json; charset=utf-8",
					data : JSON.stringify(sy.serializeObject($('#adForm'))),
					dataType : 'json',
					success : function(data) {
						if (data.success) {
							parent.location.reload();
							layer.alert("保存成功");
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
	}
	
	$('#adForm').bootstrapValidator({
//      live: 'disabled',
      message: 'This value is not valid',
      feedbackIcons: {
          valid: 'glyphicon glyphicon-ok',
          invalid: 'glyphicon glyphicon-remove',
          validating: 'glyphicon glyphicon-refresh'
      },
      fields: {
    	  picPath: {
              message: '图片地址不能空',
              validators: {
                  notEmpty: {
                      message: '图片地址不能空！'
                  }
              }
      	  }
      }
    });
	
	function setPicImgListData() {
		var valArr = new Array;
		var tmpPicPath = $("#picPath").val();
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
	  
	function addItemToTable(selectItemInfo){
		var trHtml = "";
		trHtml += "<tr>";
		trHtml += "<td><input type=\"text\" class=\"form-control\" name=\"itemId\" value=\""+selectItemInfo["itemId"]+"\" readonly><input type=\"hidden\" name=\"picPath\" value=\""+selectItemInfo["picPath"]+"\" readonly></td>";
		trHtml += "<td>"+selectItemInfo["goodsName"]+"</td>";
		trHtml += "<td><input type=\"text\" class=\"form-control\" name=\"oldRetailPrice\" value=\""+selectItemInfo["price"]+"\" readonly><input type=\"hidden\" name=\"id\" value=\"0\" readonly></td>";
		trHtml += "<td><input type=\"text\" class=\"form-control\" name=\"startTime\"><input type=\"hidden\" name=\"goodsId\" value=\""+selectItemInfo["goodsId"]+"\" readonly></td>";
		trHtml += "<td><input type=\"text\" class=\"form-control\" name=\"newRetailPrice\"></td>";
		trHtml += "<td><input type=\"text\" class=\"form-control\" name=\"linePrice\"></td>";
		trHtml += "<td><input type=\"text\" class=\"form-control\" name=\"newRebate\"></td>";
		trHtml += "<td><input type=\"text\" class=\"form-control\" name=\"sort\"></td>";
		trHtml += "</tr>"
		$("#dynamic-table").append(trHtml);
	}
	
	function showGoodsList(){
		var index = layer.open({
			title:"查看商品信息",	
			area: ['90%', '90%'],
			type: 2,
			content: '${wmsUrl}/admin/activity/activityMng/listForAdd.shtml',
			maxmin: false
		});
	}
	$("#submitBtn").click(function(){
		if ($('#dynamicTable tbody tr').length <1) {
			layer.alert("请添加商品！");
			return;
		}
		if (!checkTableInfo()) {
			saveItemList=[];
			return; 
		}
// 		console.log(saveItemList);
// 		return;
		var url = "${wmsUrl}/admin/mall/indexMng/mergeInfoToBigSale.shtml";
		$.ajax({
			url:url,
			type:'post',
			data:JSON.stringify(saveItemList),
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
	});
	
	function getSelectItemInfo(){
		var itemInfo = $("#selectItem").val().split("|");
	 	var selectItemInfo={};
	 	selectItemInfo["itemId"] = itemInfo[0].trim();
	 	selectItemInfo["goodsName"] = itemInfo[1].trim();
	 	selectItemInfo["price"] = itemInfo[2].trim();
	 	selectItemInfo["stock"] = itemInfo[3].trim();
	 	selectItemInfo["picPath"] = itemInfo[4].trim();
	 	selectItemInfo["goodsId"] = itemInfo[5].trim();
		addItemToTable(selectItemInfo);
	}
	
	function checkTableInfo(){
		var retFlg = true;
		var e_index = "";
		var e_msg;
		saveItemList=[];
		$.each($('#dynamicTable tbody tr'),function(r_index,r_obj){
			var obj_name="";
			var obj_value="";
			var tdItemInfo={};
			$.each($(r_obj).find('td'),function(c_index,c_obj){
				obj_name = $(c_obj.firstChild).attr('name');
				var type = c_obj.firstChild.nodeName;
				if(type == 'INPUT'){
					obj_value = $(c_obj.firstChild).val();
					if (obj_name == "itemId" || obj_name == "oldRetailPrice" ||
						obj_name == "startTime" || obj_name == "newRetailPrice" ||
						obj_name == "linePrice" || obj_name == "newRebate" ||
						obj_name == "sort") {
						if (obj_value == "") {
							e_index = e_index + (r_index+1) + ",";
							retFlg = false;
							return false;
						}
						tdItemInfo[obj_name] = obj_value;
					}
				}
				obj_name = $(c_obj.lastChild).attr('name');
				type = c_obj.lastChild.nodeName;
				if(type == 'INPUT'){
					obj_value = $(c_obj.lastChild).val();
					if (obj_name == "picPath" || obj_name == "goodsId") {
						if (obj_value == "") {
							e_index = e_index + (r_index+1) + ",";
							retFlg = false;
							return false;
						}
						tdItemInfo[obj_name] = obj_value;
					} else if (obj_name == "id") {
						tdItemInfo[obj_name] = obj_value;
					}
				}
			});
			saveItemList.push(tdItemInfo);
		});
		if (!retFlg) {
			e_index = e_index.substring(0,e_index.length-1);
			e_msg = "第"+(e_index)+"条商品信息填写有误，请确认！";
			layer.alert(e_msg);
			return retFlg;
		}
	  	return retFlg;
	}
	</script>
</body>
</html>
