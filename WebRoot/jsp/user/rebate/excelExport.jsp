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
		<div class="submit-btn">
           	<button type="button" onclick="downLoadExcel()">确认导出</button>
       	</div>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script type="text/javascript">
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
	    	if (dateType == 0) {
		    	if (startTime == "" || endTime == "") {
		    		layer.alert("自定义日期不能为空，请选择");
			    	return;
		    	}
	    	}
	    	location.href="${wmsUrl}/admin/user/rebateMng/downLoadExcel.shtml?startTime="+startTime+"&endTime="+endTime+"&dateType="+dateType+"&supplierId="+supplierId; 
	    }
	</script>
</body>
</html>