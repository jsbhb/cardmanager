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
<section class="content-wrapper query content-iframe">
	<section class="content-header">
	      <ol class="breadcrumb">
	        <li><a href="javascript:void(0);">财务管理</a></li>
	        <li class="active">资金池查看</li>
	      </ol>
	      <div class="search">
	      	<input type="text"  name="gradeName" id="gradeName" readonly style="background:#fff;width:200px;" placeholder="选择分级" value = "${list[0].name}">
			<input type="hidden" class="form-control" name="gradeId" id="gradeId">
	      	<div class="searchBtn" ><i class="fa fa-search fa-fw" id="querybtns"></i></div>
		  </div>
    </section>
	<div class="select-content">
        <ul class="first-ul" style="margin-left:10px;">
			<c:forEach var="menu" items="${list}">
				<c:set var="menu" value="${menu}" scope="request" />
				<%@include file="recursive.jsp"%>  
			</c:forEach>
	   	</ul>
	</div>
	<section class="content">
		<div id="image" style="width:100%;height:100%;display: none;background:rgba(0,0,0,0.5);margin-left:-25px;margin-top:-62px;">
			<img alt="loading..." src="${wmsUrl}/img/loader.gif" style="position:fixed;top:50%;left:50%;margin-left:-16px;margin-top:-16px;" />
		</div>
		<div class="list-content">
			<div class="row content-container">
				<div class="col-md-12 container-right active">
					<table id="orderTable" class="table table-hover myClass">
						<thead>
							<tr>
								<th>分级名称</th>
								<th>账户可用金额</th>
								<th>可用优惠金额</th>
								<th>冻结优惠金额</th>
								<th>账户使用金额</th>
								<th>使用优惠金额</th>
								<th>累计产生金额</th>
								<th>累计产生优惠</th>
								<th>分级状态</th>
								<th>操作</th>
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
	url :  "${wmsUrl}/admin/finance/capitalPoolMng/dataList.shtml",
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
	$("#orderTable tbody").html("");

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
		if (list[i].money < 1000) {
			str += "<tr style='color: #FF0000'>";
		} else {
			str += "<tr>";
		}
		var tmpCenterId = list[i].centerId;
		var tmpCenterName = "";
		var centerSelect = document.getElementById("centerId");
		var options = centerSelect.options;
		for(var j=0;j<options.length;j++){
			if (tmpCenterId==options[j].value) {
				tmpCenterName = options[j].text;
				break;
			}
		}
		str += "<td>" + (tmpCenterName == "" ? "" : tmpCenterName);
		str += "</td><td>" + list[i].money;
		str += "</td><td>" + list[i].preferential;
		str += "</td><td>" + list[i].frozenPreferential;
		str += "</td><td>" + list[i].useMoney;
		str += "</td><td>" + list[i].usePreferential;
		str += "</td><td>" + list[i].countMoney;
		str += "</td><td>" + list[i].countPreferential;
		var status = list[i].status;
		switch(status){
			case 0:str += "</td><td>停用";break;
			case 1:str += "</td><td>启用";break;
			default:str += "</td><td>停用";
		}
		str += "</td><td align='left'>";
		str += "<a href='javascript:void(0);' class='table-btns' onclick='toShow("+list[i].centerId+")'>充值</a>";
		str += "<a href='javascript:void(0);' class='table-btns' onclick='toDelete("+list[i].centerId+")'>清算</a>";
		str += "</td></tr>";
	}
	$("#orderTable tbody").html(str);
}

function toShow(centerId){
	var index = layer.open({
		  title:"资金池充值",		
		  type: 2,
		  content: '${wmsUrl}/admin/finance/capitalPoolMng/toShow.shtml?centerId='+centerId
		});
		layer.full(index);
}

function toDelete(centerId){
	var index = layer.open({
		  title:"资金池清算",		
		  type: 2,
		  content: '${wmsUrl}/admin/finance/capitalPoolMng/toDelete.shtml?centerId='+centerId
		});
		layer.full(index);
}


//点击展开
$('.select-content').on('click','li span i:not(active)',function(){
	$(this).addClass('active');
	$(this).parent().next().stop();
	$(this).parent().next().slideDown(300);
});
//点击收缩
$('.select-content').on('click','li span i.active',function(){
	$(this).removeClass('active');
	$(this).parent().next().stop();
	$(this).parent().next().slideUp(300);
});

//点击展开下拉列表
$('#gradeName').click(function(){
	$('.select-content').css('width',$(this).outerWidth());
	$('.select-content').css('left',$(this).offset().left);
	$('.select-content').css('top',$(this).offset().top + $(this).height());
	$('.select-content').stop();
	$('.select-content').slideDown(300);
});

//点击空白隐藏下拉列表
$('html').click(function(event){
	var el = event.target || event.srcelement;
	if(!$(el).parents('.select-content').length > 0 && $(el).attr('id') != "gradeName"){
		$('.select-content').stop();
		$('.select-content').slideUp(300);
	}
});
//点击选择分类
$('.select-content').on('click','span',function(event){
	var el = event.target || event.srcelement;
	if(el.nodeName != 'I'){
		var name = $(this).attr('data-name');
		var id = $(this).attr('data-id');
		$('#gradeName').val(name);
		$('#gradeId').val(id);
		$('.select-content').stop();
		$('.select-content').slideUp(300);
	}
});
</script>
</body>
</html>
