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
		        <li><a href="javascript:void(0);">砍价活动</a></li>
		        <li class="active">信息查看</li>
		      </ol>
		      <div class="search">
		      	<input type="text" class="chooseTime" style="width:250px" id="searchTime" name="searchTime" placeholder="请选择查询时间" readonly>
		      	<div class="searchBtn"><i class="fa fa-search fa-fw"></i></div>
		      	<div class="moreSearchBtn">高级搜索</div>
			  </div>
	    </section>
       	<section class="content-iframe content">
       		<div id="image" style="width:100%;height:100%;display: none;background:rgba(0,0,0,0.5);margin-left:-25px;margin-top:-62px;">
				<img alt="loading..." src="${wmsUrl}/img/loader.gif" style="position:fixed;top:50%;left:50%;margin-left:-16px;margin-top:-16px;" />
			</div>
			<div class="moreSearchContent">
				<div class="row form-horizontal list-content">
					<div class="col-xs-3">
						<div class="searchItem">
							<input type="text" class="chooseTime" id="hidSearchTime" name="hidSearchTime" placeholder="请选择查询时间" readonly>
						</div>
					</div>
					<div class="col-xs-3">
						<div class="searchItem">
				            <select class="form-control" name="buyFlg" id="buyFlg">
			                	<option selected="selected" value="">--请选择购买状态--</option>
				                <option value="1">已购买</option>
				                <option value="0">未购买</option>
				            </select>
						</div>
					</div>
					<div class="col-xs-3">
						<div class="searchItem">
		                  	<input type="text" class="form-control" id="joinPerson" placeholder="请输入参与人数"  onkeyup="this.value=this.value.replace(/[^?\d]/g,'')" onafterpaste="this.value=this.value.replace(/[^?\d]/g,'')">
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
							<a href="javascript:void(0);" id="totalAllCount">${totalAllCount}</a>
							<p>已发起</p>
						</div>
						<div class="today-orders-item">
							<a href="javascript:void(0);" id="totalBargainCount">${totalBargainCount}</a>
							<p>未购买</p>
						</div>
						<div class="today-orders-item">
							<a href="javascript:void(0);" id="totalBuyCount">${totalBuyCount}</a>
							<p>已购买</p>
						</div>
				</div>
			</div>
	       	<div class="list-content">
				<div class="row">
					<div class="col-md-12">
						<table id="baseTable" class="table table-hover myClass">
							<thead>
								<tr>
									<th width="30%">商品名称</th>
									<th width="20%">商品原价</th>
									<th width="20%">商品底价</th>
									<th width="15%">总发起数</th>
									<th width="15%">总购买数</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="list" items="${showPageInfoList}">
									<tr class="first-rows" data-id="${list.goodsRoleId}">
										<td><i class="fa fa-fw fa-plus"></i>${list.goodsName}</td>
				                		<td>${list.initPrice}</td>
				                		<td>${list.floorPrice}</td>
				                		<td>${list.recordList.size()}</td>
				                		<td>${list.buyCount}</td>
									</tr>
									<tr class="second-rows" data-id="0" parentId="${list.goodsRoleId}">
			                			<td>发起人</td>
			                			<td>发起时间</td>
			                			<td>参与人数</td>
			                			<td>优惠金额</td>
			                			<td>是否购买</td>
									</tr>
									<c:forEach var="record" items="${list.recordList}">
										<tr class="second-rows" data-id="${record.id}" parentId="${list.goodsRoleId}">
											<td>${record.name}</td>
				                			<td>${record.createTime}</td>
				                			<td>${record.person}</td>
				                			<td>${record.disCount}</td>
					                		<td>${record.buy==true?"是":"否"}</td>
										</tr>
									</c:forEach>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
       	</section>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script src="${wmsUrl}/js/mainpage.js"></script>
	<script type="text/javascript">
	
	//点击搜索按钮
	$('.searchBtn').on('click',function(){
		$("#querybtns").click();
	});
	
	$('#querybtns').on('click',function(){
		var tmpTime = $("#searchTime").val();
		var tmpHidTime = $("#hidSearchTime").val();
		var tmpBuy = $('#buyFlg option:selected').val();
		var tmpJoinPerson = $("#joinPerson").val();
		var param = "?searchTime="+tmpTime+"&hidSearchTime="+tmpHidTime+"&buyFlg="+tmpBuy+"&joinPerson="+tmpJoinPerson;
		
		$.ajax({
			 url:"${wmsUrl}/admin/activity/bargainMng/showPageQueryByParam.shtml"+param,
			 type:'post',
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){
					 rebuildTable(data);
				 }else{
					 layer.alert(data.msg);
				 }
			 },
			 error:function(){
				 layer.alert("查询失败，请重试");
			 }
		});
	});
	
	
	laydate.render({
	  elem: '#searchTime', //指定元素
	  type: 'datetime',
	  range: '~',
	  value: null
	});
	laydate.render({
	  elem: '#hidSearchTime', //指定元素
	  type: 'datetime',
	  range: '~',
	  value: null
	});
	
	function rebuildTable(data){
		$("#baseTable tbody").html("");
		if (data == null || data.length == 0) {
			return;
		}
		var list = data.data.showPageInfoList;
		$("#totalAllCount").html(data.data.totalAllCount);
		$("#totalBargainCount").html(data.data.totalBargainCount);	
		$("#totalBuyCount").html(data.data.totalBuyCount);
		
		var str = "";
		
		if (list == null || list.length == 0) {
			str = "<tr style='text-align:center'><td colspan=6><h5>没有查到数据</h5></td></tr>";
			$("#baseTable tbody").html(str);
			return;
		}
		
		var tmpGoodsRoleId = "";
		for (var i = 0; i < list.length; i++) {
			tmpGoodsRoleId = list[i].goodsRoleId;
			str += "<tr class='first-rows' data-id="+tmpGoodsRoleId+">";
			str += "<td><i class='fa fa-fw fa-plus'></i>"+list[i].goodsName+"</td>";
			str += "<td>"+list[i].initPrice+"</td>";
			str += "<td>"+list[i].floorPrice+"</td>";
			str += "<td>"+list[i].recordList.length+"</td>";
			str += "<td>"+list[i].buyCount+"</td>";
			str += "</tr>";
			str += "<tr class='second-rows' data-id='0' parentId="+tmpGoodsRoleId+">";
			str += "<td>发起人</td>";
			str += "<td>发起时间</td>";
			str += "<td>参与人数</td>";
			str += "<td>优惠金额</td>";
			str += "<td>是否购买</td>";
			str += "</tr>";
			var recordList = list[i].recordList;
			for (var j = 0; j < recordList.length; j++) {
				str += "<tr class='second-rows' data-id="+recordList[j].id+" parentId="+tmpGoodsRoleId+">";
				str += "<td>"+recordList[j].name+"</td>";
				str += "<td>"+recordList[j].createTime+"</td>";
				str += "<td>"+recordList[j].person+"</td>";
				str += "<td>"+recordList[j].disCount+"</td>";
				if (recordList[j]==true) {
					str += "<td>是</td>";
				} else {
					str += "<td>否</td>";
				}
				str += "</tr>";
			}
		}
		$("#baseTable tbody").html(str);
	}
	
	$(function(){
	    $('.treeList li:has(ul)').addClass('parent_li').find(' > span');
	    $('.treeList li.parent_li > span').on('click', function (e) {
	        var children = $(this).parent('li.parent_li').find(' > ul > li');
	        if (children.is(":visible")) {
	            children.hide();
	            $(this).find(' > i').addClass('fa-plus').removeClass('fa-minus');
	        } else {
	            children.show();
	            $(this).find(' > i').addClass('fa-minus').removeClass('fa-plus');
	        }
	        e.stopPropagation();
	    });
	});

	$('#baseTable').on('click','td i.fa',function(){
		var ids = $(this).parent().parent().attr('data-id');
		var idss;
		if($(this).hasClass('fa-plus')){
			$(this).removeClass('fa-plus').addClass('fa-minus');
			$('tr[parentId="'+ids+'"]').show();
		}else if($(this).hasClass('fa-minus')){
			$(this).removeClass('fa-minus').addClass('fa-plus');
			for(var i=0;i<75;i++){
				$('tr[parentId="'+ids+'"]').hide();
				for(var j=0;j<$('tr[parentId="'+ids+'"]').length;j++){
					idss = $($('tr[parentId="'+ids+'"]')[j]).attr('data-id');
					$($('tr[parentId="'+ids+'"]')[j]).find('i').removeClass('fa-minus').addClass('fa-plus');
					if(idss != undefined){
						$('tr[parentId="'+idss+'"]').hide();
					}else{
						idss = undefined;
						break;
					}
				}
			}
		}
	});
	</script>
</body>
</html>
