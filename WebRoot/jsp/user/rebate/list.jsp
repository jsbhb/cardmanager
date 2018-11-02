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
	<section class="content-wrapper query content-iframe">
		<section class="content-header">
		      <ol class="breadcrumb">
		        <li><a href="javascript:void(0);">财务管理</a></li>
		        <li class="active">返佣查看</li>
		      </ol>
		      <div class="search">
		      	<input type="text"  name="gradeName" id="gradeName" readonly style="background:#fff;width:200px;" placeholder="选择分级" value = "${list[0].name}">
				<input type="hidden" class="form-control" name="gradeId" id="gradeId" value = "${list[0].id}">
		      	<div class="searchBtn" ><i class="fa fa-search fa-fw" id="querybtns"></i></div>
		      	<div class="moreSearchBtn">高级搜索</div>
			  </div>
			  <c:if test="${prilvl == 1}">
		      	<button class="default-btn position-btn" type="button" onclick="excelExport(0)">订单导出</button>
		      </c:if>
		      <button class="default-btn position-btn" type="button" onclick="excelExport(1)">返佣导出</button>
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
       	<section class="content-iframe content">
       		<div id="image" style="width:100%;height:100%;display: none;background:rgba(0,0,0,0.5);margin-left:-25px;margin-top:-62px;">
				<img alt="loading..." src="${wmsUrl}/img/loader.gif" style="position:fixed;top:50%;left:50%;margin-left:-16px;margin-top:-16px;" />
			</div>
			<div class="moreSearchContent">
				<div class="row form-horizontal list-content">
					<div class="col-xs-3">
						<div class="searchItem">
				            <input type="text"  name="gradeName" id="gradeName" readonly style="background:#fff;" placeholder="选择分级">
							<input type="hidden" class="form-control" name="gradeId" id="gradeId">
						</div>
					</div>
					<div class="col-xs-3">
							<div class="searchItem">
								<input type="text" class="form-control" name="orderId" placeholder="请输入订单号">
							</div>
					</div>
					<div class="col-xs-3">
						<div class="searchItem">
				            <select class="form-control" name="orderFlag" id="orderFlag">
		                   	  <option selected="selected" value="">订单类型</option>
		                   	  <option value="0">跨境</option>
		                   	  <option value="2">一般贸易</option>
			                </select>
						</div>
					</div>
					<div class="col-xs-3">
						<div class="searchItem">
				            <select class="form-control" name="status" id="status">
		                   	  <option selected="selected" value="">订单状态</option>
		                   	  <option value="0">待到账</option>
		                   	  <option value="1">已到账</option>
		                   	  <option value="2">已退款</option>
			                </select>
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
			<div class="default-content">
				<div class="today-orders">
						<div class="today-orders-item">
							<a href="javascript:void(0);" id="alreadyCheck" onclick="toAdd()">￥0.00</a>
							<p>可提现</p>
						</div>
						<div class="today-orders-item">
							<a href="javascript:void(0);" id="canBePresented">￥0.00</a>
							<p>待对账</p>
						</div>
						<div class="today-orders-item">
							<a href="javascript:void(0);" id="alreadyPresented">￥0.00</a>
							<p>已提现</p>
						</div>
						<div class="today-orders-item">
							<a href="javascript:void(0);" id="stayToAccount">￥0.00</a>
							<p>待到账</p>
						</div>
				</div>
			</div>
	       	<form class="form-horizontal" role="form" id="gradeForm" >
		       	<div class="list-content">
		       		<div class="row content-container">
		       			<div class="col-md-10 col-md-offset-1 container-right active">
							<table id="staffTable" class="table table-hover myClass">
								<thead>
									<tr>
										<th>订单编号</th>
										<th>订单类型</th>
										<th>返佣金额</th>
										<th>返佣状态</th>
										<th>创建时间</th>
										<th>完成时间</th>
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
	       	</form>
       	</section>
	</section>
	<%@include file="../../resourceScript.jsp"%>
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
		url :  "${wmsUrl}/admin/user/rebateMng/dataList.shtml",
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
		$("#staffTable tbody").html("");

		if (data == null || data.length == 0) {
			return;
		}
		
		var list = data.obj;
		
		var rebate = data.object;
// 		var gradeName = $("#gradeName").val();
// 		$("#gradeName_1").val(gradeName);
		if(rebate != null){
			$("#canBePresented").html(rebate.canBePresented == null ? "￥0.00" : "￥"+(rebate.canBePresented).toFixed(2));
			$("#alreadyPresented").html(rebate.alreadyPresented == null ? "￥0.00" : "￥"+(rebate.alreadyPresented).toFixed(2));
			$("#stayToAccount").html(rebate.stayToAccount == null ? "￥0.00" : "￥"+(rebate.stayToAccount).toFixed(2));
			$("#alreadyCheck").html(rebate.alreadyCheck == null ? "￥0.00" : "￥"+(rebate.alreadyCheck).toFixed(2));
		} else {
			$("#canBePresented").html("￥0.00");
			$("#alreadyPresented").html("￥0.00");	
			$("#stayToAccount").html("￥0.00");
			$("#alreadyCheck").html("￥0.00");
		}
		
		var str = "";
		
		if (list == null || list.length == 0) {
			str = "<tr style='text-align:center'><td colspan=6><h5>没有查到数据</h5></td></tr>";
			$("#staffTable tbody").html(str);
			return;
		}

		
		for (var i = 0; i < list.length; i++) {
			str += "<tr><td>";
			str += list[i].orderId;
			var orderFlag = list[i].orderFlag;
			switch(orderFlag) {
			case 0:str += "</td><td>跨境订单";break;
			case 2:str += "</td><td>一般贸易订单";break;
			default : str += "</td><td>未知类型："+orderFlag;
			}
			str += "</td><td>" + list[i].rebateMoney;
			var status = list[i].status;
			switch(status) {
				case 0:str += "</td><td>待到账";break;
				case 1:str += "</td><td>已到账";break;
				case 2:str += "</td><td>返佣已退回";break;
				default : str += "</td><td>错误状态："+status;
			}
			str += "</td><td>" + (list[i].createTime == null ? "" : list[i].createTime);
			str += "</td><td>" + (list[i].updateTime == null ? "" : list[i].updateTime);
			str += "</td><td><a href='javascript:void(0);' onclick='toShow(\""+list[i].orderId+"\")'>查看详情</a>";
			str += "</td></tr>";
		}

		$("#staffTable tbody").html(str);
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
	$("[id='gradeName']").click(function(){
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
			$("[id='gradeName']").val(name);
			$("[id='gradeId']").val(id);
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
	
	function toShow(orderId){
		var gradeId = $("#gradeId").val();
		var index = layer.open({
			  title:"查看订单详情",		
			  type: 2,
			  content: '${wmsUrl}/admin/user/rebateMng/toShow.shtml?orderId='+orderId+'&gradeId='+gradeId,
			  maxmin: true
			});
			layer.full(index);
	}
	
	function toAdd(){
		
		var index = layer.open({
			  type: 2,
			  content: '${wmsUrl}/admin/user/userWithdrawalsMng/toAdd.shtml',
			  area: ['320px', '195px'],
			  maxmin: true
			});
			layer.full(index);
	}

	function excelExport(type){
		var titleName;
		if(0 == type){
			titleName = "订单导出";
		}
		if(1 == type){
			titleName = "返佣导出";
		}
		var index = layer.open({
		  title:titleName,		
		  type: 2,
		  area: ['55%','65%'],
		  content: '${wmsUrl}/admin/user/rebateMng/excelExport.shtml?type='+type,
		  maxmin: false
		});
	}
	laydate.render({
	    elem: '#searchTime', //指定元素
	    type: 'datetime',
	    range: '~',
	    value: null
	  });
	</script>
</body>
</html>
