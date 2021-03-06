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
	<section class="content-iframe" style="margin-top:20px;">
		<div class="list-item">
			<div class="col-xs-3 item-left">自定义日期</div>
			<div class="col-xs-9 item-right">
				<input type="text" class="chooseTime" id="startTime" readonly>
				<input type="text" class="chooseTime" id="endTime" readonly>
				<div class="item-content">
             		（自定义日期间隔最长31天）
             	</div>
			</div>
		</div>
		<div class="list-item">
			<div class="col-xs-3 item-left">指定日期</div>
			<div class="col-xs-9 item-right">
				<ul class="label-content" id="dateType" style="min-width:240px;">
					<li data-id="0" class="active">不指定</li>
					<li data-id="1" class="">本周</li>
					<li data-id="2" class="">本月</li>
				</ul>
				<div class="item-content">
             		（指定日期优先于自定义日期）
             	</div>
			</div>
		</div>
		<div class="list-item">
			<div class="col-xs-3 item-left">供应商</div>
			<div class="col-xs-9 item-right">
				<select class="form-control" name="supplierId" id="supplierId">
                  	  <option selected="selected" value="-1">供应商</option>
                  	  <c:forEach var="supplier" items="${supplierId}">
                  	  	<option value="${supplier.id}">${supplier.supplierName}</option>
                  	  </c:forEach>
                </select>
			</div>
		</div>       	
		<div class="list-item">
			<div class="col-xs-3 item-left">分级列表</div>
			<div class="col-xs-9 item-right">
				<input type="text" class="form-control" id="gradeName" readonly style="background:#fff;" placeholder="选择分级" value="${list[0].name}">
				<input type="hidden" class="form-control" name="gradeId" id="gradeId" value="${list[0].id}">
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
		<div class="submit-btn">
           	<button type="button" onclick="downLoadExcel()">确认导出</button>
       	</div>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script type="text/javascript">
		var cpLock = false;
		$('#searchGrade').on('compositionstart', function () {
		    cpLock = true;
		});
		$('#searchGrade').on('compositionend', function () {
		    cpLock = false;
		});
		var nowDate = new Date();
		var stDate = new Date();
		stDate = getFormatDate(stDate);
		stDate = getNewDay(stDate, -7);
		laydate.render({
	      elem: '#startTime', //指定元素
	      value: stDate,
	      done: function(value, date){
	    	  var days = datedifference(value,$("#endTime").val());
	    	  if (days > 31) {
	    		  $("#endTime").val(getNewDay(value, 31));
	    	  }
	      }
	    });
		laydate.render({
	      elem: '#endTime', //指定元素
	      value: nowDate,
	      done: function(value, date){
	    	  var days = datedifference($("#startTime").val(),value);
	    	  if (days > 31) {
	    		  $("#startTime").val(getNewDay(value, -31));
	    	  }
	      }
	    });
		
		function datedifference(sDate1, sDate2) {    //sDate1和sDate2是2016-12-18格式  
	        var dateSpan,iDays;
	        sDate1 = Date.parse(sDate1);
	        sDate2 = Date.parse(sDate2);
	        dateSpan = sDate2 - sDate1;
	        dateSpan = Math.abs(dateSpan);
	        iDays = Math.floor(dateSpan / (24 * 3600 * 1000));
	        return iDays
	    };
	    
	    //日期加上天数得到新的日期  
	    //dateTemp 需要参加计算的日期，days要添加的天数，返回新的日期，日期格式：YYYY-MM-DD  
	    function getNewDay(dateTemp, days) {  
	    	var now = dateTemp.split('-');
	    	now = new Date(Number(now['0']),(Number(now['1'])-1),Number(now['2']));
	    	now.setDate(now.getDate() + days);
	    	return getFormatDate(now);
	    }
	    
	    //返回新的日期，日期格式：YYYY-MM-DD
	    function getFormatDate(dateTemp) {
	    	var year = dateTemp.getFullYear();
    	    var month = dateTemp.getMonth()+1, month = month < 10 ? '0' + month : month;
    	    var day = dateTemp.getDate(), day =day < 10 ? '0' + day : day;
    	    return year + '-' + month + '-' + day; 
	    }

	    function downLoadExcel(){
	    	var startTime = $("#startTime").val();
	    	var endTime = $("#endTime").val();
	    	var dateType = $('#dateType li.active').attr('data-id');
	    	var supplierId = $("#supplierId").val();
	    	var gradeId = $("#gradeId").val();
	    	if (dateType == 0) {
		    	if (startTime == "" || endTime == "") {
		    		layer.alert("自定义日期不能为空，请选择");
			    	return;
		    	}
	    	}
	    	window.open("${wmsUrl}/admin/order/stockOutMng/downLoadExcel.shtml?startTime="+startTime+"&endTime="+endTime+"&dateType="+dateType+"&supplierId="+supplierId+"&gradeId="+gradeId);
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
		
		//点击展开下拉列表
		$('#gradeName').click(function(){
			$('.select-content').css('width',$(this).outerWidth());
			$('.select-content').css('left',$(this).offset().left);
			$('.select-content').css('top',$(this).offset().top + 31);
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