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
<link rel="stylesheet" href="${wmsUrl}/adminLTE/css/style.css">
<%@include file="../../resourceLink.jsp"%>
</head>
<body>

<div class="title-discount">
	<h1>温馨提示</h1>
	<p>
		<span>返佣比例填写时：</span>
		1.上级返佣比例必须大于下级返佣比例。
		2.海外购不计算返佣比例。<br/>
		<span>返佣比例计算时：</span>
		1.订单由下级产生时：该级获取的返佣比例  = 该级设置的返佣比例 - 该下级设置的返佣比例。
		2.订单由该级产生时：该级获取的返佣比例  = 该级设置的返佣比例。
	</p>
	<div class="list-item" style="display:none">
		<select id="gradeTypeRebate">
			<c:forEach var="gradeTypeRebate" items="${rebateFormulaList}">
				<option value="${gradeTypeRebate.formula}">${gradeTypeRebate.gradeTypeId}</option>
			</c:forEach>
        </select>
	</div>
</div>

<div class="treeList">
<ul>
	<c:forEach var="menu" items="${gradeList}">
		<c:set var="menu" value="${menu}" scope="request" />
		<%@include file="recursive.jsp"%>  
	</c:forEach>
</ul>
</div>
<c:if test="${prilvl == 1}">
<div class="submit-btn">
	<span>保存设置</span>
</div>
</c:if>
	
<%@include file="../../resourceScript.jsp"%>
<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
<script type="text/javascript">

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
    $('.treeList').on('blur','input',function(){
    	var that = this;
    	var val = $(that).val();
    	var parentId = $(that).attr('parentId');
    	var id = $(that).attr('id');
    	if(id != 1){
    		if(val != ''){
        		if(parseFloat(val) >= 1){
            		layer.alert('请设置小于1的两位小数');
            		$(that).val('');
            		return;
            	}
            	if(parentId != 0 && parentId != null){
                	var parentVal = $('input[id='+parentId+']').val();
                	var childArr = $('input[parentId='+id+']');
                	if(parentId != 1){
                		if(parentVal == ''){
                    		layer.alert('请先设置上级比例');
                    	}else{
                    		if(parseFloat(parentVal) <= parseFloat(val)){
                    			if (parseFloat(val) != 0.0) {
                            		layer.alert('下级比例不能高于或等于上级');
                            		$(that).val('');
                    			}
                        	}
                    	}
                    	$.each(childArr,function(k,v){
                    		if($(v).val() >= val){
                    			if (parseFloat($(v).val()) != 0.0) {
                        			layer.alert('上级比例不能低于下级');
                        			$(that).val('');
                    			}
                    		}
                    	});
                	}
            	}
        	}
    	}
    })
    $('.submit-btn').on('click','span',function(){
    	var itemId = ${itemId};
    	var inputArr = $('.treeList input');
    	var data = [];
    	var errFlg = false;
    	$.each(inputArr,function(k,v){
    		if ($(v).val() < 0) {
    			errFlg = true;
    		}
    		data.push({
    			'itemId': itemId,
    			'gradeType': $(v).attr('id'),
    			'proportion': $(v).val() == '' ? 0 : $(v).val()
    		});
    	});
    	if (errFlg) {
    		layer.alert("返佣比例存在负数，请修改后重试！");
    		return;
    	}
    	$.ajax({
   		 url:"${wmsUrl}/admin/goods/itemMng/rebate.shtml",
   		 type:'post',
   		 contentType: "application/json; charset=utf-8",
   		 dataType:'json',
   		 data : JSON.stringify(data),
   		 success:function(data){
   			 if(data.success){	
   				 layer.alert("设置成功");
   			 }else{
   				 layer.alert(data.msg);
   			 }
   		 },
   		 error:function(){
   			 layer.alert("提交失败，请联系客服处理");
   		 }
   	 });
    });
    function GetQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
   }
});

$('.treeList').on('input','input',function(){
	var inputId = $(this).attr('id');
	var inputValue = $(this).val();
	if(inputId == 2){
		var gradeTypeSelect = document.getElementById("gradeTypeRebate");
		var gtoptions = gradeTypeSelect.options;
		for(var j=0;j<gtoptions.length;j++){
			var tmpInputId = gtoptions[j].text;
			var tmpInputMula = gtoptions[j].value.replace("rebate",inputValue).trim();
			var tmpValue = eval(tmpInputMula);
// 	 		$('#'+ tmpInputId).val(tmpValue.toFixed(2));
			if (tmpValue < 0.0) {
		 		$('#'+ tmpInputId).val(0);
			} else {
		 		$('#'+ tmpInputId).val(GetValueDigit(tmpValue));
			}
		}
	}
});

function GetValueDigit(value){
	var strValue = value+"";
	var valueArr = strValue.split(".");
	var digitLength = 0;
	if (valueArr.length>1) {
		if (valueArr[1].length>6) {
			digitLength = 6;
		}else{
			digitLength = valueArr[1].length;
		}
	}
	return value.toFixed(digitLength);
}
	
</script>
</body>
</html>
