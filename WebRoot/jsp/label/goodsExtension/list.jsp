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
	        <li class="active">商品推广维护</li>
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
	                  	<input type="text" class="form-control" name="goodsId" placeholder="请输入商品编码">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
			           <input type="text" class="form-control" name="hidGoodsName" placeholder="请输入商品名称">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
			            <select class="form-control" name="goodsType" id="goodsType">
		                	<option selected="selected" value="0">跨境商品</option>
		                	<option value="2">一般贸易商品</option>
			            </select>
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
								<th style="width: 5%;">商品编码</th>
								<th style="width: 10%;">商品图片</th>
								<th style="width: 15%;">商品名称</th>
								<th style="width: 10%;">商品品牌</th>
								<th style="width: 10%;">商品规格</th>
								<th style="width: 10%;">产地</th>
								<th style="width: 10%;">自定义字段</th>
								<th style="width: 10%;">保质期</th>
								<th style="width: 10%;">推荐理由</th>
								<th style="width: 10%;">操作</th>
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
	url :  "${wmsUrl}/admin/label/goodsExtensionMng/dataList.shtml",
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
		str = "<tr style='text-align:center'><td colspan=10><h5>没有查到数据</h5></td></tr>";
		$("#itemTable tbody").html(str);
		return;
	}

	for (var i = 0; i < list.length; i++) {
		str += "<tr>";
		str += "<td>" + list[i].goodsId;
		if (list[i].goodsPath == null) {
			str += "</td><td><img style='width:50px;height:50px;' src=${wmsUrl}/img/default_img.jpg>";
		} else {
			str += "</td><td><img style='width:50px;height:50px;' src="+list[i].goodsPath+">";
		}
		str += "</td><td>" + (list[i].goodsName == null ? "" : list[i].goodsName);
		str += "</td><td>" + (list[i].brand == null ? "" : list[i].brand);
		str += "</td><td>" + (list[i].specs == null ? "" : list[i].specs);
		str += "</td><td>" + (list[i].origin == null ? "" : list[i].origin);
		str += "</td><td>" + (list[i].custom == null ? "" : list[i].custom);
		str += "</td><td>" + (list[i].shelfLife == null ? "" : list[i].shelfLife);
		str += "</td><td>" + (list[i].reason == null ? "" : list[i].reason);
		str += "</td><td>";
		if (list[i].goodsPath == null) {
			str += "<a href='javascript:void(0);' class='table-btns' onclick='toEdit("+list[i].goodsId+")'>维护信息</a>";
		} else {
			str += "<a href='javascript:void(0);' class='table-btns' onclick='toEdit("+list[i].goodsId+")'>维护信息</a>";
			str += "<a href='javascript:void(0);' class='table-btns' onclick='downLoadFile("+list[i].goodsId+")'>下载图片</a>";
		}
		str += "</td></tr>";
	}
	$("#itemTable tbody").html(str);
}

function toEdit(id){
	var index = layer.open({
		  title:"编辑商品推广信息",		
		  type: 2,
		  content: '${wmsUrl}/admin/label/goodsExtensionMng/toEditInfo.shtml?goodsId='+id,
		  maxmin: true
		});
		layer.full(index);
}

function downLoadFile(id){
	window.open("${wmsUrl}/admin/label/goodsExtensionMng/downLoadFile.shtml?goodsId="+id);
}

</script>
</body>
</html>
