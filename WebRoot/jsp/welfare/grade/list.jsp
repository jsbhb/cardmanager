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
		        <li><a href="javascript:void(0);">福利模块</a></li>
		        <li class="active">客户列表</li>
		      </ol>
		      <div class="search">
		      	<input type="text" name="gradeName" placeholder="输入分级名称" >
		      	<div class="searchBtn" ><i class="fa fa-search fa-fw" id="querybtns"></i></div>
	      		<div class="moreSearchBtn">高级搜索</div>
			  </div>
	    </section>
	<section class="content">
		<div id="image" style="width:100%;height:100%;display: none;background:rgba(0,0,0,0.5);margin-left:-25px;margin-top:-62px;">
			<img alt="loading..." src="${wmsUrl}/img/loader.gif" style="position:fixed;top:50%;left:50%;margin-left:-16px;margin-top:-16px;" />
		</div>
		<div class="moreSearchContent">
			<div class="row form-horizontal list-content">
				<div class="col-xs-3">
					<div class="searchItem">
						<input type="text" readonly class="form-control" id="gradeTypeId" placeholder="分级类型" style="background:#fff;">
		                <input type="hidden" readonly class="form-control" name="gradeType" id="gradeType">
					</div>
				</div>
				<div class="select-content" style="width: 420px;top: 219px;">
	           		<ul class="first-ul" style="margin-left:10px;">
	           			<c:forEach var="menu" items="${gradeList}">
	           				<c:set var="menu" value="${menu}" scope="request" />
	           				<%@include file="recursive.jsp"%>  
						</c:forEach>
	           		</ul>
	           	</div>
				<div class="col-xs-3">
					<div class="searchItem">
			            <select class="form-control" name="welfareType" id="welfareType">
		                	<option selected="selected" value="-1">--请选择客户类型--</option>
		                	<option value="1">福利客户</option>
		                	<option value="0">普通客户</option>
			            </select>
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
			           <input type="text" class="form-control" name="gradeName" placeholder="请输入分级名称">
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
		<div class="default-content">
			<div class="today-orders">
		        <div class="today-orders-item">
					<a href="javascript:void(0);" id="gradeCount" onclick="gradeCustomer()">${gradeCount}</a>
					<p>普通客户</p>
				</div>
		        <div class="today-orders-item">
					<a href="javascript:void(0);" id="welfareCount" onclick="welfareCustomer()">${welfareCount}</a>
					<p>福利客户</p>
				</div>
			</div>
		</div>
		<div class="list-content">
			<div class="col-md-12 ">
				<table id="baseTable" class="table table-hover myClass">
					<thead>
						<tr>
							<th>等级编号</th>
							<th>分级名称</th>
							<th>分级类型</th>
							<th>客户类型</th>
							<th>优惠比例</th>
							<th>负责人</th>
							<th>电话号码</th>
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
	</section>
</section>
<%@include file="../../resourceScript.jsp"%>
<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
<script src="${wmsUrl}/js/mainpage.js"></script>
<script type="text/javascript">


/**
 * 初始化分页信息
 */
var options = {
	queryForm : ".query",
	url :  "${wmsUrl}/admin/welfare/welfareMng/gradeDataList.shtml",
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
	$("#baseTable tbody").html("");

	if (data == null || data.length == 0) {
		return;
	}
	
	var list = data.obj;
	var str = "";
	
	if (list == null || list.length == 0) {
		str = "<tr style='text-align:center'><td colspan=9><h5>没有查到数据</h5></td></tr>";
		$("#baseTable tbody").html(str);
		return;
	}

	for (var i = 0; i < list.length; i++) {
		str += "<tr>";
		str += "<td>" + list[i].id;
		str += "</td><td>" + (list[i].gradeName == null ? "" : list[i].gradeName);
		str += "</td><td>" + (list[i].gradeTypeName == null ? "" : list[i].gradeTypeName);
		var welfareType = list[i].welfareType;
		switch(welfareType){
			case 0:str += "</td><td>普通客户";break;
			case 1:str += "</td><td>福利客户";break;
			default:str += "</td><td>状态错误："+welfareType;
		}
		str += "</td><td>" + (list[i].welfareRebate == null ? "" : list[i].welfareRebate);
		str += "</td><td>" + (list[i].personInCharge == null ? "" : list[i].personInCharge);
		str += "</td><td>" + (list[i].phone == null ? "" : list[i].phone);
		str += "<td align='left'>";
		str += "<a href='#' onclick='toEdit("+list[i].id+")'>编辑</a>";
		str += "</td>";
		str += "</td></tr>";
	}

	$("#baseTable tbody").html(str);
}

function toEdit(id){
	var index = layer.open({
	  title:"编辑客户类型",	
	  area: ['60%', '40%'],		
	  type: 2,
	  content: '${wmsUrl}/admin/welfare/welfareMng/toEditWelfareType.shtml?gradeId='+id,
	  maxmin: false
	});
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
$('#gradeTypeId').click(function(){
	$('.select-content').css('width',$(this).outerWidth());
	$('.select-content').css('left',$(this).offset().left);
	$('.select-content').css('top',$(this).offset().top + $(this).height());
	$('.select-content').stop();
	$('.select-content').slideDown(300);
});

//点击空白隐藏下拉列表
$('html').click(function(event){
	var el = event.target || event.srcelement;
	if(!$(el).parents('.select-content').length > 0 && $(el).attr('id') != "gradeTypeId"){
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
		$('#gradeTypeId').val(name);
		$('#gradeType').val(id);
		$('.select-content').stop();
		$('.select-content').slideUp(300);
	}
});
function gradeCustomer(){
	$("#clearbtns").click();
	$("#gradeName").val("");
	$("#welfareType").val(0);
	$("#querybtns").click();
}

function welfareCustomer(){
	$("#clearbtns").click();
	$("#gradeName").val("");
	$("#welfareType").val(1);
	$("#querybtns").click();
}

</script>
</body>
</html>
