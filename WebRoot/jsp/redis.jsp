<%@ page language="java"  pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>redis</title>
	
</head>
<body>
<div class="page_location link_bk">

</div>
<table width="985" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:8px;" >
<tr>
<form action="${wmsUrl}/admin/redis/get.shtml" method="post" >
</tr>
  <tr>
  <td align="center" >
  <input type="radio" name="state" id="state" value="0">申报单号</input>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   <input type="radio" name="state" id="state" value="1">报检号</input>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="radio" name="state" id="state" value="2">订单号</input>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </td>
  </tr>
  <tr>
	  <td align="center" >
	  	
	  	
	  		<textarea   name="orderids" type="textarea"   id="orderids"  rows="13" cols="120"    >${orderids}</textarea >
	  		
	   </td>
  </tr>
  
  <tr>
	  <td align="center" >
	  	
	  		<input    type="submit"    value="提交"  >${msg}</input>
	   </td>
  </tr>
   </form>
   
   <form action="${wmsUrl}/admin/redis/deal.shtml" method="post" >
   <td align="center" >
	  	
	  		<input    type="submit"    value="同步"  >${msg1}</input>
	   </td>
   </form>
  
</table>
<table width="985" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:8px;" >
 <form action="${wmsUrl}/admin/redis/set.shtml" method="post" >
<tr>
<td align="center" >
<input type="radio" name="state" id="state" value="0">申报单号</input>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   <input type="radio" name="state" id="state" value="1">报检号</input>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="radio" name="state" id="state" value="2">订单号</input>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    </td>
    </tr>
    

 <tr>
   <td align="center" >
	  	<textarea rows="13" cols="120" type="text" value="" name="orderids" id="orderids" ></textarea>
	  		<input    type="submit"    value="添加"  >${msg2}</input>
	   </td>
	   </tr>
   </form>
   </table>
   
   <table width="985" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:8px;" >
 <form action="${wmsUrl}/admin/redis/del.shtml" method="post" >

 <tr>
   <td align="center" >
	  	<input type="text" value="" name="orderids" id="orderids" />
	  		<input    type="submit"    value="删除"  >${msg3}</input>
	   </td>
	   </tr>
   </form>
   </table>
</body>


</html>
