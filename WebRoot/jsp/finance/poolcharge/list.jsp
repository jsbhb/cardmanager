<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
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
	        <li class="active">资金池</li>
	      </ol>
	      <div class="search">
	      	<input type="text"  name="gradeName" id="gradeName" readonly style="background:#fff;width:200px;" placeholder="选择分级" value = "${list[0].name}">
			<input type="hidden" class="form-control" name="gradeId" id="gradeId">
	      	<div class="searchBtn" ><i class="fa fa-search fa-fw" id="querybtns"></i></div>
		  </div>
    </section>
	<div class="list-item" style="display:none">
		<div class="col-sm-3 item-left">分级列表</div>
		<div class="col-sm-9 item-right">
            <ul id="hidGrade">
           		<c:forEach var="menu" items="${list}">
           			<c:set var="menu" value="${menu}" scope="request" />
           			<%@include file="recursive.jsp"%>  
				</c:forEach>
           	</ul>
		</div>
	</div>
	<div class="select-content">
		<input type="text" placeholder="请输入分级名称" id="searchGrade"/>
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
		<div class="default-content">
			<div class="today-orders">
				<div class="today-orders-item">
					<a href="javascript:void(0);" id="total" onclick="totalCustomer()">${overview.total}</a>
					<p>分级数量</p>
				</div>
		        <div class="today-orders-item">
					<a href="javascript:void(0);" id="money">${overview.totalFee}</a>
					<p>总可用金额</p>
				</div>
				<div class="today-orders-item">
					<a href="javascript:void(0);" id="warning" onclick="warningCustomer(${overview.warningId})">${fn:length(overview.warningId)}</a>
					<p>预警</p>（可用金额低于3000）
				</div>
			</div>
		</div>
		<div class="list-content">
			<div class="row">
				<div class="col-md-10 list-btns">
					<c:if test="${prilvl == 1}">
					<button type="button" onclick="toAdd()">添加资金池记录</button>
					</c:if>
				</div>
			</div>
			<div class="row content-container">
				<div class="col-md-12 container-right active">
					<table id="orderTable" class="table table-hover myClass">
						<thead>
							<tr>
								<th>客户名称</th>
								<th>客户类型</th>
								<th>客户公司</th>
								<th>可用金额</th>
								<th>已用金额</th>
								<th>累计金额</th>
								<th>状态</th>
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
<script src="${wmsUrl}/js/mainpage.js"></script>
<script type="text/javascript">
var cpLock = false;
$('#searchGrade').on('compositionstart', function () {
    cpLock = true;
});
$('#searchGrade').on('compositionend', function () {
    cpLock = false;
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
	var str = "";
	
	if (list == null || list.length == 0) {
		str = "<tr style='text-align:center'><td colspan=8><h5>没有查到数据</h5></td></tr>";
		$("#orderTable tbody").html(str);
		return;
	}

	for (var i = 0; i < list.length; i++) {
		var tmpStatus = "";
		if (list[i].money < 3000) {
			str += "<tr style='color: #FF0000'>";
			tmpStatus = "预警";
		} else {
			str += "<tr>";
			tmpStatus = "正常";
		}
		str += "<td>" + (list[i].centerName == "" ? "" : list[i].centerName);
		str += "</td><td>" + (list[i].gradeTypeName == null ? "" : list[i].gradeTypeName);
		str += "</td><td>" + (list[i].company == null ? "" : list[i].company);
		str += "</td><td>" + eval(list[i].money).toFixed(2);
		str += "</td><td>" + list[i].useMoney;
		str += "</td><td>" + list[i].countMoney;
		str += "</td><td>" + tmpStatus;
		str += "</td><td>";
		str += "<a href='javascript:void(0);' onclick='toShow("+list[i].centerId+")'>查看详情</a>";
		str += "</td></tr>";
	}
	$("#orderTable tbody").html(str);
}

function toShow(gradeId){
	var index = layer.open({
	  title:"查看详情",
	  type: 2,
	  content: '${wmsUrl}/admin/finance/capitalPoolMng/showCapitalDetail.shtml?gradeId='+gradeId
	});
	layer.full(index);
}

function toAdd(){
	var url = "${wmsUrl}/admin/finance/capitalPoolMng/toAdd.shtml";
	var index = layer.open({
	  title:"添加资金池记录",
	  type: 2,
	  content: url,
	  maxmin: true
	});
	layer.full(index);
}

function warningCustomer(ids){
	var arr = new Array();
	if(ids != null && ids.length > 0){
		for(var i=0;i<ids.length;i++){
			arr[i] = ids[i]
		}
	} else {
		return;
	}
	var gradeIds = arr.join(',');
	$("#gradeId").val(gradeIds);
	$("#gradeName").val("");
	$("#querybtns").click();
}

function totalCustomer(){
	$("#gradeId").val("");
	$("#querybtns").click();
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
		$('#searchGrade').val("");
		reSetDefaultInfo();
		$('.select-content').stop();
		$('.select-content').slideUp(300);
	}
});

$('#searchGrade').on("input",function(){
	if (!cpLock) {
		var tmpSearchKey = $(this).val();
		if (tmpSearchKey !='') {
			var searched = "";
			$('.first-ul li').each(function(li_obj){
				var tmpLiId = $(this).find("span").attr('data-id');
				var tmpLiText = $(this).find("span").attr('data-name');
				var flag = tmpLiText.indexOf(tmpSearchKey);
				if(flag >=0) {
					searched = searched + "<li><span data-id=\""+tmpLiId+"\" data-name=\""+tmpLiText+"\" class=\"no-child\">"+tmpLiText+"</span></li>";
				}
			});
			$('.first-ul').html(searched);
		} else {
			reSetDefaultInfo();
		}
}
});

function reSetDefaultInfo() {
	var $clone = $('#hidGrade').find('>li').clone();
	$('.first-ul').empty().append($clone);
}
</script>
</body>
</html>
