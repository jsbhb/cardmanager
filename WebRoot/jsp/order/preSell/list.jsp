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
<script src="${wmsUrl}/plugins/laydate/laydate.js"></script>
</head>
<body>
<section class="content-wrapper query">
	<section class="content-header">
	      <ol class="breadcrumb">
	        <li><a href="javascript:void(0);">首页</a></li>
	        <li>订单管理</li>
	        <li class="active">预售订单</li>
	      </ol>
	      <div class="search">
	      	<input type="text" name="orderId" placeholder="输入订单编号" >
	      	<div class="searchBtn"><i class="fa fa-search fa-fw"></i></div>
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
			            <select class="form-control" name="supplierId" id="supplierId">
	                   	  <option selected="selected" value="">供应商</option>
	                   	  <c:forEach var="supplier" items="${supplierId}">
	                   	  	<option value="${supplier.id}">${supplier.supplierName}</option>
	                   	  </c:forEach>
		                </select>
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
			            <select class="form-control" name="status" id="status">
	                   	  <option selected="selected" value="">订单状态</option>
	                   	  <option value="-1">非取消</option>
	                   	  <option value="0">待支付</option>
	                   	  <option value="1">已付款</option>
	                   	  <option value="2">支付单报关</option>
	                   	  <option value="3">已发仓库</option>
	                   	  <option value="4">已报海关</option>
	                   	  <option value="5">单证放行</option>
	                   	  <option value="6">已发货</option>
	                   	  <option value="7">已收货</option>
	                   	  <option value="8">退单</option>
	                   	  <option value="9">超时取消</option>
	                   	  <option value="11">资金池不足</option>
	                   	  <option value="12">待发货</option>
	                   	  <option value="21">退款中</option>
	                   	  <option value="99">异常状态</option>
		                </select>
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
			            <select class="form-control" name="orderFlag" id="orderFlag">
	                   	  <option selected="selected" value="">订单类型</option>
	                   	  <option value="0">跨境</option>
	                   	  <option value="2">一般贸易</option>
	                   	  <option value="3">直邮</option>
		                </select>
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
			            <select class="form-control" name="orderSource" id="orderSource">
	                   	  <option selected="selected" value="">订单来源</option>
	                   	  <option value="0">PC商城</option>
	                   	  <option value="1">手机商城</option>
	                   	  <option value="3">有赞</option>
	                   	  <option value="4">线下</option>
	                   	  <option value="5">展厅</option>
	                   	  <option value="6">大客户</option>
	                   	  <option value="7">福利商城</option>
	                   	  <option value="8">后台订单</option>
	                   	  <option value="9">太平惠汇</option>
	                   	  <option value="10">小程序</option>
	                   	  <option value="11">聚民惠</option>
	                   	  <option value="12">拼多多</option>
	                   	  <option value="13">易捷北京</option>
	                   	  <option value="14">自营</option>
	                   	  <option value="15">金融工厂</option>
	                   	  <option value="16">中信乐益通</option>
	                   	  <option value="17">波罗蜜</option>
	                   	  <option value="18">马上消费金融</option>
	                   	  <option value="19">供销e家</option>
	                   	  <option value="20">淘宝</option>
		                </select>
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
			            <input type="text"  name="gradeName" id="gradeName" readonly style="background:#fff;" placeholder="选择分级" >
						<input type="hidden" class="form-control" name="gradeId" id="gradeId" >
					</div>
				</div>
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
				<div class="col-xs-3">
					<div class="searchItem">
			            <select class="form-control" name="tagfunc" id="tagfunc">
	                   	  <c:forEach var="tagFun" items="${tagFuncId}">
	                   	  	<option value="${tagFun.id}">${tagFun.funcName}</option>
	                   	  </c:forEach>
		                </select>
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
						<input type="text" class="form-control" name="orderId" placeholder="请输入订单号">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
						<input type="text" class="form-control" name="itemId" placeholder="请输入商品编号">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
						<input type="text" class="form-control" name="itemCode" placeholder="请输入商家编码">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
						<input type="text" class="chooseTime" id="searchTime" name="searchTime" placeholder="请选择查询时间" readonly>
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
			<div class="row">
				<div class="col-md-12 list-btns">
					<button type="button"  id="cancleFunc">全部推送</button>
					<button type="button" onclick="partCancleFunc()">部分推送</button>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<table id="baseTable" class="table table-hover myClass">
						<thead>
							<tr>
								<th><input type="checkbox" id="theadInp"></th>
								<th>订单编号</th>
								<th>订单状态</th>
								<th>快递公司</th>
								<th>物流单号</th>
								<th>供应商</th>
								<th>支付总金额</th>
								<th>收货人</th>
								<th>订单来源</th>
								<th>所属分级</th>
								<th>创建时间</th>
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
var cpLock = false;
$('#searchGrade').on('compositionstart', function () {
    cpLock = true;
});
$('#searchGrade').on('compositionend', function () {
    cpLock = false;
});
//点击搜索按钮
$('.searchBtn').on('click',function(){
	$("#querybtns").click();
});

/**
 * 初始化分页信息
 */
var options = {
			queryForm : ".query",
			url :  "${wmsUrl}/admin/order/preSellMng/dataList.shtml",
			numPerPage:"10",
			currentPage:"",
			index:"1",
			callback:rebuildTable
}


$(function(){
	 $(".pagination-nav").pagination(options);
})

laydate.render({
  elem: '#searchTime', //指定元素
  type: 'datetime',
  range: '~',
  value: null
});


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
		str = "<tr style='text-align:center'><td colspan=12><h5>没有查到数据</h5></td></tr>";
		$("#baseTable tbody").html(str);
		return;
	}

	for (var i = 0; i < list.length; i++) {
		str += "<tr>";
		
		var status = list[i].status;
		var tagFun = list[i].tagFun;
		if (tagFun == 1) {
			str += "<td>";
		} else {
			str += "<td><input type='checkbox' name='check' value='" + list[i].orderId + "' />";
		}
		str += "</td><td>" + list[i].orderId;
		switch(status){
			case 0:str += "</td><td>待支付";break;
			case 1:str += "</td><td>已付款";break;
			case 2:str += "</td><td>支付单报关";break;
			case 3:str += "</td><td>已发仓库";break;
			case 4:str += "</td><td>已报海关";break;
			case 5:str += "</td><td>单证放行";break;
			case 6:str += "</td><td>已发货";break;
			case 7:str += "</td><td>已收货";break;
			case 8:str += "</td><td>退单";break;
			case 9:str += "</td><td>超时取消";break;
			case 11:str += "</td><td>资金池不足";break;
			case 12:str += "</td><td>待发货";break;
			case 21:str += "</td><td>退款中";break;
			case 99:str += "</td><td>异常状态";break;
			default:str += "</td><td>未知状态";
		}
		
		var express = list[i].orderExpressList;
		var expressName = "";
		var expressId ="";
		if(express !=null){
			for(var j=0;j<express.length;j++){
				expressName += (express[j].expressName == null ? "" : express[j].expressName);
				expressId += (express[j].expressId == null ? "" : express[j].expressId);
				break;
			}
		}
		str += "</td><td>" + expressName;
		str += "</td><td>" + expressId;
		str += "</td><td>" + (list[i].supplierName == null ? "" : list[i].supplierName);
		str += "</td><td>" + list[i].orderDetail.payment;
		str += "</td><td>" + (list[i].orderDetail.receiveName == null ? "" : list[i].orderDetail.receiveName);
		var tmpOrderSource = list[i].orderSource;
		switch(tmpOrderSource){
			case 0:str += "</td><td>PC商城";break;
			case 1:str += "</td><td>手机商城";break;
			case 2:str += "</td><td>订货平台";break;
			case 3:str += "</td><td>有赞";break;
			case 4:str += "</td><td>线下";break;
			case 5:str += "</td><td>展厅";break;
			case 6:str += "</td><td>大客户";break;
			case 7:str += "</td><td>福利商城";break;
			case 8:str += "</td><td>后台订单";break;
			case 9:str += "</td><td>太平惠汇";break;
			case 10:str += "</td><td>小程序";break;
			case 11:str += "</td><td>聚民惠";break;
			case 12:str += "</td><td>拼多多";break;
			case 13:str += "</td><td>易捷北京";break;
			case 14:str += "</td><td>自营";break;
			case 15:str += "</td><td>金融工厂";break;
			case 16:str += "</td><td>中信乐益通";break;
			case 17:str += "</td><td>波罗蜜";break;
			case 18:str += "</td><td>马上消费金融";break;
			case 19:str += "</td><td>供销e家";break;
			case 20:str += "</td><td>淘宝";break;
			default:str += "</td><td>";
		}
		str += "</td><td>" + (list[i].shopName == "" ? "" : list[i].shopName);
		str += "</td><td>" + (list[i].createTime == null ? "" : list[i].createTime);
		if (true) {
			str += "<td align='left'>";
			str += "<a href='javascript:void(0);' onclick='toShow(\""+list[i].orderId+"\")'>详情</a>";
			str += "</td>";
		}
		str += "</td></tr>";
	}
	$("#baseTable tbody").html(str);
}
	

function toShow(orderId){
	var index = layer.open({
		  title:"查看订单详情",		
		  type: 2,
		  content: '${wmsUrl}/admin/order/stockOutMng/toShow.shtml?orderId='+orderId,
		  maxmin: true
		});
		layer.full(index);
}

$("#cancleFunc").click(function(){
	$.ajax({
		 url:"${wmsUrl}/admin/order/preSellMng/cancleOrderList.shtml?tagfunc="+$("#tagfunc").val(),
		 type:"post",
// 		 data:JSON.stringify(sy.serializeObject($('#orderForm'))),
		 contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 success:function(data){
			 if(data.success){
				 layer.alert("开始执行取消功能操作，请稍后查看结果");
				 reloadTable();
			 }else{
				 layer.alert(data.msg);
			 }
		 },
		 error:function(){
			 layer.alert("取消功能失败，请联系客服处理");
		 }
	 });
});

function partCancleFunc(){
	var valArr = new Array; 
	var orderIds;
    $("[name='check']:checked").each(function(i){ 
        valArr[i] = $(this).val(); 
    }); 
    if(valArr.length==0){
    	layer.alert("请勾选要取消功能的订单数据");
    	return;
    }
    orderIds = valArr.join(',');//转换为逗号隔开的字符串 
	$.ajax({
		 url:"${wmsUrl}/admin/order/preSellMng/partCancle.shtml?orderId="+orderIds,
		 type:'post',
		 contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 success:function(data){
			 if(data.success){	
				 layer.alert("开始执行部分取消功能操作，请稍后查看结果");
				 reloadTable();
			 }else{
				 layer.alert(data.msg);
			 }
		 },
		 error:function(){
			 layer.alert("提交失败，请联系客服处理");
		 }
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
