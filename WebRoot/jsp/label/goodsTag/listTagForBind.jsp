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
<section class="content-iframe">
	<form class="form-horizontal" role="form" id="itemForm" style="margin-top:20px;">
		<div class="list-item">
				<input type="hidden" value = "${itemIds}" id = "itemIds">
				<div class="col-xs-3 item-left">标签名称</div>
				<div class="col-xs-9 item-right" id="goodsTag">
					<ul class="label-content-express" id="tag">
					<c:forEach var="item" items="${tagList}">
						<li data-id="${item.id}">${item.tagName}</li>
					</c:forEach>
					</ul>
				</div>
			</div>
		<div class="submit-btn">
            <button type="button" class="btn btn-primary" id="submitBtn">确定</button>
        </div>
	</form>
</section>
	<%@include file="../../resourceScript.jsp"%>
	<script type="text/javascript">
	
	//点击标签选中
	$('#goodsTag').on('click', '.label-content-express li', function() {
		if (!$(this).hasClass("active")) {
			$(this).addClass("active");
		} else {
			$(this).attr("class", "");
		}
	});
	 
	 $("#submitBtn").click(function(){
		 var valArr = new Array; 
		 $('#tag li.active').each(function(i){
			 valArr[i] = $(this).attr('data-id');
		 })
		 if(valArr.length == 0){
			layer.alert("请选择需要绑定的标签");
			return;
		 }
		 var itemIds = $("#itemIds").val();
		 var tagId;
		 tagId = valArr.join(',');//转换为逗号隔开的字符串 
		 $.ajax({
			 url:"${wmsUrl}/admin/goods/itemMng/batchBindGoodsTag.shtml?itemIds="+itemIds+"&tagId="+tagId,
			 type:'post',
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){
					 layer.alert("保存成功");
					 parent.layer.closeAll();
					 parent.refreshTag();
				 }else{
					 layer.alert(data.msg);
				 }
			 },
			 error:function(){
				 layer.alert("保存失败，请联系客服处理");
			 }
		 });
	 });
	 
	</script>
</body>
</html>
