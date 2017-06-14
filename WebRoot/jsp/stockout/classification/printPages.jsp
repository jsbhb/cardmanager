<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<%@include file="../../resource.jsp" %>
	<style type="text/css"> 
		a:link,a:visited{ 
		 text-decoration:none;  /*超链接无下划线*/ 
		} 
		a:hover{ 
		 text-decoration:underline;  /*鼠标放上去有下划线*/ 
		} 
   </style> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<SCRIPT for="window" event="onload">  
 
	document.all[document.all.PDFNotKnown ? "IfNoAcrobat": "IfAcrobat"].style.display = "block"; 
 
</SCRIPT> 
</head>
<body>
<OBJECT type="application/pdf" width="0" height="0" style="display:none">  
  <DIV id="PDFNotKnown" style="display:none"></DIV>
</OBJECT>
<table width="100%" border="0">
<tr><td id="td_" name="td_" align="center" width="100%">
<font size="-1"><a href="${wmsUrl }/js/AdbeRdr11000_zh_CN11.0.0.379.1410747856.exe">如果没有正常显示内容，可能需要先安装Adobe Reader才能浏览，点击下载Adobe Reader.</a></font><br/>
		<font size="-1" color="rgb(255,165,0)">请点击【打印】按钮进行打印 >>></font>
		<input type="button" name="print" value="打印" style="font-weight:bold;color:red" onclick="javascript:printExpress();">&nbsp;&nbsp;
		<input type="button" name="test"  value="关闭" onclick="window.close()">
		<div id="firefoxInfo" style="display:'none'"><font size="-1" color="blue">Firefox/Chrome/360浏览器请点击&lt;打印&gt;按钮后在新窗口中印刷。谢谢!</font></div>
	</td></tr>
	
	<tr><td align="center" width="100%">
		<DIV id="showExpressDiv" align="center" width="100%" style="Z-INDEX:99;POSITION:absolute;LEFT:5px; WIDTH: 99%">
			<embed name="expressPdf" id="expressPdf" width="1200" height="800" type="application/pdf" src="${wmsUrl }/output/${getDay}/${instructions}.pdf"/>
			<!--iframe name="expressPdf" id="expressPdf" src="/express/EMS1421807994187.pdf" width="450" height="580" frameborder="0"></iframe-->
			<input type="hidden" name="instructions" id="instructions" value="${instructions }"/>
		    <input type="hidden" name="userInfoId" id="userInfoId" value="${userInfoId }"/>
		    <input type="hidden" name="carrier" id="carrier" value="${carrier }"/>
		    <input type="hidden" name="errorInfoId" id="errorInfoId" value="${errorInfoId }"/>
		    <input type="hidden" name="jsoOrderId" id="jsoOrderId" value="${jsoOrderId }"/>
		</DIV>
	</td></tr>
</table>
<script type="text/javascript" for="window">

if ((navigator.userAgent.indexOf('MSIE')<0) && (navigator.userAgent.indexOf('Trident')<0)) {
	document.getElementById("firefoxInfo").style.display='';
} else {
	document.getElementById("firefoxInfo").style.display='none';
}

function printExpress(){
  document.getElementById("td_").innerHTML="";
  
   if ((navigator.userAgent.indexOf('MSIE')>=0) || (navigator.userAgent.indexOf('Trident')>=0)) {
		expressPdf.print();
	} else if(isCamino=navigator.userAgent.indexOf("Chrome")>0){
	   window.open("${wmsUrl }//output//${getDay}//${instructions}.pdf", "", "width=750,height=700,resizable=yes,location=no,scrollbars=yes,left=200,top=100");
	   parent.window.close();
	}else {
		var win=window.showModalDialog('${wmsUrl }//output//${getDay}//${instructions}.pdf',
			"非IE浏览器打印",
			"dialogWidth=600px;dialogHeight=610px;menubar=no;dialogLeft=20px;dialogTop=0px;toolbar=no;menubar=no;scrollbars=yes;resizable=no;location=no;status=no");
		win.focus();
	}  
    	    	   
};


function updateDeliveryPrintTimes(){
	var order_ids = window.opener.document.getElementById('logis_order_ids').value;
	if (order_ids != '' && order_ids != null) {
		$.post('/order/updateDeliveryPrintTimes' + order_ids,
				function(data) {
				}, 'json');
	}
}
</script>
</body>
</html>