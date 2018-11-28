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
<section class="content-wrapper query">
	<section class="content-header">
	      <ol class="breadcrumb">
	        <li><a href="javascript:void(0);">首页</a></li>
	        <li>标签管理</li>
	        <li class="active">商品二维码</li>
	      </ol>
	      <div class="search">
	      	<input type="text" name="goodsName" placeholder="请输入商品名称">
	      	<div class="searchBtn"><i class="fa fa-search fa-fw"></i></div>
	      	<div class="moreSearchBtn">高级搜索</div>
		  </div>
    </section>	
	<section class="content">
		<div class="moreSearchContent">
			<div class="row form-horizontal list-content">
				<div class="col-xs-3">
					<div class="searchItem">
	                  	<input type="text" class="form-control" name="goodsId" placeholder="请输入商品ID">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
			           <input type="text" class="form-control" name="hidGoodsName" placeholder="请输入商品名称">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchBtns">
						 <div class="lessSearchBtn">简易搜索</div>
                         <button type="button" class="query" id="querybtns" name="signup">提交</button>
                         <button type="button" class="clear">清除选项</button>
                    </div>
                </div>
            </div>
		</div>
		<div class="list-content">
			<div class="row content-container">
				<div class="col-md-12 container-right active">
					<table id="itemTable" class="table table-hover myClass">
						<thead>
							<tr>
								<th width="10%">商品ID</th>
								<th width="35%">商品名称</th>
								<th width="35%">商品链接</th>
								<th width="20%">操作</th>
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
<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
<script type="text/javascript">
//点击搜索按钮
$('.searchBtn').on('click',function(){
	$("#querybtns").click();
});

/**
 * 初始化分页信息
 */
var options = {
	queryForm : ".query",
	url :  "${wmsUrl}/admin/label/goodsQRMng/dataList.shtml",
	numPerPage:"10",
	currentPage:"",
	index:"1",
	callback:rebuildTable
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
	$("#itemTable tbody").html("");

	if (data == null || data.length == 0) {
		return;
	}
	
	var list = data.obj;
	var str = "";
	
	if (list == null || list.length == 0) {
		str = "<tr style='text-align:center'><td colspan=4><h5>没有查到数据</h5></td></tr>";
		$("#itemTable tbody").html(str);
		return;
	}

	for (var i = 0; i < list.length; i++) {
		str += "<tr>";
		str += "</td><td>" + list[i].goodsId;
		str += "</td><td>" + list[i].goodsName;
// 		str += "</td><td>" + list[i].sku;
// 		str += "</td><td>" + list[i].itemCode;
// 		str += "</td><td>" + list[i].itemId;
// 		str += "</td><td>" + list[i].supplierName;
		str += "</td><td>" + list[i].detailPath;
		str += "</td><td>";
		if (list[i].detailPath == "") {
			str += "";
		} else {
			if (list[i].description == null || list[i].description == "") {
				str += "<a href='javascript:void(0);' class='table-btns' onclick='downLoadQRCodeFile(\"";
				str += list[i].goodsId + "\",\"" + list[i].detailPath.replace("&","%26")
				str += "\")'>下载普通二维码</a>";
// 				str += "<a href='javascript:void(0);' class='table-btns' onclick='getWxAppletCode(";
// 				str += list[i].goodsId
// 				str += ")'>预览小程序码</a>";
			} else {
				str += "<a href='javascript:void(0);' class='table-btns' onclick='downLoadQRCodeFile(\"";
				str += list[i].goodsId + "\",\"" + list[i].detailPath.replace("&","%26")
				str += "\")'>下载普通二维码</a>";
// 				str += "<a href='javascript:void(0);' class='table-btns' onclick='getWxAppletCode(";
// 				str += list[i].goodsId
// 				str += ")'>预览小程序码</a>";
				str += "<a href='javascript:void(0);' class='table-btns' onclick='downLoadFile(\"";
				str += list[i].goodsId + "\",\"" + list[i].detailPath.replace("&","%26")
				str += "\")'>下载商品牌</a>";
			}
		}
		str += "</td></tr>";
	}
	$("#itemTable tbody").html(str);
}

function downLoadQRCodeFile(id,path){
	window.open("${wmsUrl}/admin/label/goodsQRMng/downLoadQRCodeFile.shtml?goodsId="+id+"&path="+path);
}

function downLoadFile(id,path){
	window.open("${wmsUrl}/admin/label/goodsQRMng/downLoadFile.shtml?goodsId="+id+"&path="+path);
}

function getWxAppletCode(goodsId) {
	var gradeId = ${sessionScope.session_Operator.gradeId};
	var reqUrl = "${wmsUrl}/admin/applet/code.shtml";
	
	var param = {};
	param["scene"] = "shopId=" + gradeId + "&goodsId=" + goodsId;
	param["page"] = "web/goodsDetail/goodsDetail";
	param["width"] = 400;
	
	reqUrl += "?needToCoverLogo=true";
	postAjaxToGetInfo(reqUrl,param);
	
// 	layer.confirm('是否用商品默认主图替换二维码中的LOGO？', {
// 	  btn: ['确认替换','无需替换'] //按钮
// 	}, function(index){
// 		reqUrl += "?needToCoverLogo=true";
// 		postAjaxToGetInfo(reqUrl,param);
//         layer.close(index);
// 	}, function(index){
// 		reqUrl += "?needToCoverLogo=false";
// 		postAjaxToGetInfo(reqUrl,param);
//         layer.close(index);
// 	});
}

function postAjaxToGetInfo(reqUrl, param) {
	var win = window.open();
	$.ajax({
		 url:reqUrl,
		 type:'post',
		 contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 data:JSON.stringify(param),
		 success:function(data){
			 if(data.success){
				 win.location.href=data.data;
			 } else {
				 win.close();
				 layer.alert(data.msg);
			 }
		 },
		 error:function(data){
			 win.close();
			 layer.alert(data.msg);
		 }
	});
}
</script>
</body>
</html>
