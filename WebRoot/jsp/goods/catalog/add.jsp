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
		<form class="form-horizontal" role="form" id="catalogForm" style="margin-top:20px">
        	<c:choose>
				<c:when test="${type==1}">
					<div class="list-item">
						<div class="col-sm-3 item-left">分类图标</div>
						<div class="col-sm-9 item-right addContent">
							<div class="item-img" id="content" >
								+
								<input type="file" id="pic" name="pic" />
								<input type="hidden" class="form-control" name="tagPath" id="tagPath">
							</div>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="list-item">
						<div class="col-xs-3 item-left">上级分类编号</div>
						<div class="col-xs-9 item-right">
							<input type="text" readonly class="form-control" name="parentId" value="${parentId}">
			             </div>
					</div>
					<div class="list-item">
						<div class="col-xs-3 item-left">上级分类名称</div>
						<div class="col-xs-9 item-right">
							<input type="text" readonly class="form-control" value="${parentName}">
			             </div>
					</div>
				</c:otherwise>
			</c:choose>
			<div class="list-item">
				<div class="col-xs-3 item-left">分类名称</div>
				<div class="col-xs-9 item-right">
           			<input type="hidden" readonly class="form-control" name="type" value="${type}">
					<input type="text" class="form-control" name="name" placeholder="请输入分类名称">
	            	<div class="item-content">
	             		（商品分类的名称，例：母婴用品）
	             	</div>
	             </div>
			</div>
			<div class="list-item">
				<div class="col-xs-3 item-left">分类别称</div>
				<div class="col-xs-9 item-right">
					<input type="text" class="form-control" name="accessPath" placeholder="请输入分类别称">
	            	<div class="item-content">
	             		（商品分类的别称，例：myyp）
	             	</div>
	             </div>
			</div>
			<div class="list-item">
				<div class="col-xs-3 item-left">分类顺序</div>
				<div class="col-xs-9 item-right">
					<input type="text" class="form-control" name="sort" placeholder="请输入分类顺序">
	            	<div class="item-content">
	             		（商品分类的顺序，例：2）
	             	</div>
	             </div>
			</div>
			<div class="submit-btn">
            	<button type="button" id="submitBtn">确定</button>
             </div>
		</form>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script type="text/javascript" src="${wmsUrl}/js/ajaxfileupload.js"></script>
	<script type="text/javascript">
	
	 $("#submitBtn").click(function(){
		 if($('#catalogForm').data("bootstrapValidator").isValid()){
			 $.ajax({
				 url:"${wmsUrl}/admin/goods/catalogMng/add.shtml",
				 type:'post',
				 data:JSON.stringify(sy.serializeObject($('#catalogForm'))),
				 contentType: "application/json; charset=utf-8",
				 dataType:'json',
				 success:function(data){
					 if(data.success){	
						 layer.alert("插入成功");
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
    	  name: {
              message: '分类名称不正确',
              validators: {
                  notEmpty: {
                      message: '分类名称不能为空！'
                  }
              }
      	  },
      	  accessPath: {
            message: '分类别称不正确',
            validators: {
                notEmpty: {
                    message: '分类别称不能为空！'
                }
            }
    	  },
      	  sort: {
              message: '分类顺序不正确',
              validators: {
                  notEmpty: {
                      message: '分类顺序不能为空！'
                  },
                  digits: {
                      message: '分类顺序只能使用数字！'
                  }
              }
      	  }
      }
  });

	//点击上传图片
	$('.item-right').on('change','.item-img input[type=file]',function(){
		var imagSize = document.getElementById("pic").files[0].size;
		if(imagSize>1024*1024*3) {
			layer.alert("图片大小请控制在3M以内，当前图片为："+(imagSize/(1024*1024)).toFixed(2)+"M");
			return true;
		}
		$.ajaxFileUpload({
			url : '${wmsUrl}/admin/uploadFileForGrade.shtml', //你处理上传文件的服务端
			secureuri : false,
			fileElementId : "pic",
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					var imgHt = '<img src="'+data.msg+'"><div class="bgColor"><i class="fa fa-trash fa-fw"></i></div>';
					var imgPath = imgHt+ '<input type="hidden" value='+data.msg+' id="tagPath" name="tagPath">'
					$("#content").html(imgPath);
					$("#content").addClass('choose');
				} else {
					layer.alert(data.msg);
				}
			}
		})
	});
	//删除主图
	$('.item-right').on('click','.bgColor i',function(){
		var ht = '<div class="item-img" id="content" >+<input type="file" id="pic" name="pic"/><input type="hidden" name="headImg" id="headImg" value=""></div>';
		$(this).parent().parent().removeClass("choose");
		$(this).parent().parent().parent().html(ht);
	});
	
	</script>
</body>
</html>
