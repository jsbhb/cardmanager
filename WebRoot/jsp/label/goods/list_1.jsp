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
	                  	<input type="text" class="form-control" name="itemCode" placeholder="请输入商品编码">
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
								<th width="15%">商品编码</th>
								<th width="20%">商品名称</th>
								<th width="50%">商品链接</th>
								<th width="15%">操作</th>
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
	
<%@include file="../../resource.jsp"%>
<script src="${wmsUrl}/js/pagination.js"></script>
<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
<script type="text/javascript">


/**
 * 初始化分页信息
 */
var options = {
			queryForm : ".query",
			url :  "${wmsUrl}/admin/label/goodsQRMng/dataList.shtml",
			numPerPage:"20",
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
	
	if (list == null || list.length == 0) {
		layer.alert("没有查到数据");
		return;
	}

	var str = "";
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
			str += "<button type='button' class='btn btn-primary' onclick='downLoadFile(\"";
			str += list[i].goodsId + "\",\"" + list[i].detailPath.replace("&","%26")
			str += "\")'>下载</button>";
		}
		str += "</td></tr>";
	}
	$("#itemTable tbody").html(str);
}
	
// function downLoadFile(id,path){
// 	$.ajax({
// 		 url:"${wmsUrl}/admin/label/goodsQRMng/downLoadFile.shtml?goodsId="+id+"&path="+path,
// 		 type:'post',
// 		 contentType: "application/json; charset=utf-8",
// 		 dataType:'json',
// 		 success:function(data){
// 		 },
// 		 error:function(){
// 			 layer.alert("下载失败，请重试");
// 		 }
// 	 });
// }

function downLoadFile(id,path){
// 	var left1 = 300;
// 	var top1 = 200;
	location.href="${wmsUrl}/admin/label/goodsQRMng/downLoadFile.shtml?goodsId="+id+"&path="+path;
// 	window.open('${wmsUrl}/admin/label/goodsQRMng/downLoadFile.shtml?goodsId='+id+'&path='+path, "", "width=750,height=700,resizable=yes,location=no,scrollbars=yes,left=" + left1.toString() + ",top=" + top1.toString());
}

</script>
</body>
</html>
