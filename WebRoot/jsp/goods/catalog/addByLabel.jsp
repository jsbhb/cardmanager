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
       	<form class="form-horizontal" role="form" id="catalogForm" style="margin-top:20px;">
       		<div class="list-item">
				<div class="col-xs-3 item-left" for="form-field-1">上级分类<font style="color:red">*</font> </div>
				<div class="col-xs-9 item-right">
					<input type="text" class="form-control" name="category" id="category" readonly style="background:#fff;">
					<input type="hidden" class="form-control" name="parentId" id="parentId">
					<input type="hidden" class="form-control" name="type" id="type">
	            	<div class="item-content">
	             		（顶级分类请选择[无]）
	             	</div>
				</div>
			</div>
       		<div class="select-content">
           		<ul class="first-ul">
           			<li>
           				<span data-name="无" data-id="" data-type="1" style="margin-left:16px;">无</span>
           			</li>
           			<c:forEach var="first" items="${firsts}">
	           			<li>
	           				<span data-id="${first.firstId}" data-type="2" data-name="${first.name}"><i class="fa fa-caret-right fa-fw active"></i>${first.name}</span>
	           				<ul class="second-ul">
	           					<c:forEach var="second" items="${first.seconds}">
									<li><span data-id="${second.secondId}" data-type="3" data-name="${second.name}" class="no-child">${second.name}</span></li>
								</c:forEach>
	           				</ul>
	           			</li>
					</c:forEach>
           		</ul>
           	</div>
			<div class="list-item">
				<div class="col-xs-3 item-left" for="form-field-1">分类名称<font style="color:red">*</font> </div>
				<div class="col-xs-9 item-right">
					<input type="text" class="form-control" name="name" id="name">
	            	<div class="item-content">
	             		（请输入数字、英文和汉字，限1-40字）
	             	</div>
				</div>
			</div>
			<div class="submit-btn">
                <button type="button" class="btn btn-primary" id="submitBtn">确定</button>
            </div>
		</form>
	</section>
	
	<%@include file="../../resourceScript.jsp"%>
	<script type="text/javascript">
	
	 $("#submitBtn").click(function(){
		 $('#catalogForm').data("bootstrapValidator").validate();
		 if($('#catalogForm').data("bootstrapValidator").isValid()){
			 $.ajax({
				 url:"${wmsUrl}/admin/goods/catalogMng/add.shtml",
				 type:'post',
				 data:JSON.stringify(sy.serializeObject($('#catalogForm'))),
				 contentType: "application/json; charset=utf-8",
				 dataType:'json',
				 success:function(data){
					 if(data.success){	
						 parent.layer.closeAll();
						 parent.location.reload();
					 }else{
						 layer.alert(data.msg);
					 }
				 },
				 error:function(){
					 layer.alert("提交失败，请联系客服处理");
				 }
			 });
		 }else{
			 layer.alert("信息填写有误");
		 }
	 });
	
	$('#catalogForm').bootstrapValidator({
//      live: 'disabled',
      message: 'This value is not valid',
      feedbackIcons: {
          valid: 'glyphicon glyphicon-ok',
          invalid: 'glyphicon glyphicon-remove',
          validating: 'glyphicon glyphicon-refresh'
      },
      fields: {
    	  category: {
              message: '上级分类不正确',
              validators: {
                  notEmpty: {
                      message: '上级分类不能为空！'
                  }
              }
      	  },
    	  name: {
              message: '分类名称不正确',
              validators: {
                  notEmpty: {
                      message: '分类名称不能为空！'
                  }
              }
      	  }
      }
  });
	
	//点击展开
	$('.first-ul').on('click','li span i:not(active)',function(){
		$(this).addClass('active');
		$(this).parent().next().stop();
		$(this).parent().next().slideDown(300);
	});
	//点击收缩
	$('.first-ul').on('click','li span i.active',function(){
		$(this).removeClass('active');
		$(this).parent().next().stop();
		$(this).parent().next().slideUp(300);
	});
	
	//点击展开下拉列表
	$('#category').click(function(){
		$('.select-content').stop();
		$('.select-content').slideDown(300);
	});
	//点击空白隐藏下拉列表
	$('html').click(function(event){
		var el = event.target || event.srcelement;
		if(!$(el).parents('.select-content').length > 0 && $(el).attr('id') != "category"){
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
			var type = $(this).attr('data-type');
			$('#category').val(name);
			$('#parentId').val(id);
			$('#type').val(type);
			$('.select-content').stop();
			$('.select-content').slideUp(300);
		}
	});
	
	</script>
</body>
</html>
