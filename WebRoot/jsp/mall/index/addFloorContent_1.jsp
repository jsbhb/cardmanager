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
<link rel="stylesheet" href="${wmsUrl}/validator/css/bootstrapValidator.min.css">
</head>

<body>
	<section class="content-wrapper">
		<section class="content-iframe content">
			<form class="form-horizontal" role="form" id="floorContentForm">
				<div class="list-item">
					<div class="col-sm-3 item-left">楼层编号</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" readonly name="dictId" value="${id}"> 
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left">标题</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="title"> 
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left">国家</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="origin"> 
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left">商品编号</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="goodsId"> 
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left">价格</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="price"> 
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left">跳转链接</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="href" value=""> 
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left">描述</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="description"  value="${data.description}"> 
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left">大图 H5:(224*224px)PC:(309*148px)</div>
					<div class="col-sm-9 item-right addContent">
						<div class="item-img">
							+
							<input type="file" id="picPath"/>
						</div>
					</div>
				</div>
		        <div class="submit-btn">
		           	<button type="button" onclick="save()">添加</button>
		       	</div>
			</form>
		</section>
	</section>
	<%@include file="../../resource.jsp"%>
	<script src="${wmsUrl}/validator/js/bootstrapValidator.min.js"></script>
	<script src="${wmsUrl}/plugins/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="${wmsUrl}/js/ajaxfileupload.js"></script>
	<script type="text/javascript">
	
	function save(){
		$('#floorContentForm').data("bootstrapValidator").validate();
		 if($('#floorContentForm').data("bootstrapValidator").isValid()){
			 $.ajax({
					url : '${wmsUrl}/admin/mall/indexMng/saveData.shtml',
					type : 'post',
					contentType : "application/json; charset=utf-8",
					data : JSON.stringify(sy.serializeObject($('#floorContentForm'))),
					dataType : 'json',
					success : function(data) {
						if (data.success) {
							parent.location.reload();
							layer.alert("修改成功");
						} else {
							layer.alert(data.msg);
						}
					},
					error : function() {
						layer.alert("提交失败，请联系客服处理");
					}
				});
		 }else{
			 layer.alert("提交失败，请联系客服处理");
		 }
	}

	function uploadFile(id) {
		$.ajaxFileUpload({
			url : '${wmsUrl}/admin/uploadFile.shtml', //你处理上传文件的服务端
			secureuri : false,
			fileElementId : "pic",
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					$("#picPath").val(data.msg);
				} else {
					layer.alert(data.msg);
				}
			}
		})
	}
	
	$('#floorContentForm').bootstrapValidator({
//      live: 'disabled',
      message: 'This value is not valid',
      feedbackIcons: {
          valid: 'glyphicon glyphicon-ok',
          invalid: 'glyphicon glyphicon-remove',
          validating: 'glyphicon glyphicon-refresh'
      },
      fields: {
    	  picPath: {
              message: '大图地址不能空',
              validators: {
                  notEmpty: {
                      message: '大图地址不能空！'
                  }
              }
      	  },
      	  description: {
              message: '描述不能空',
              validators: {
                  notEmpty: {
                      message: '描述不能空！'
                  }
              }
      	  },
      	  price: {
              message: '价格不能空',
              validators: {
                  notEmpty: {
                      message: '价格不能空！'
                  }
              }
      	  },
      	  goodsId: {
              message: '商品编号不能空',
              validators: {
                  notEmpty: {
                      message: '商品编号不能空！'
                  }
              }
      	  },
      	  origin: {
              message: '国家不能空',
              validators: {
                  notEmpty: {
                      message: '国家不能空！'
                  }
              }
      	  },
      	  title: {
              message: '标题不能空',
              validators: {
                  notEmpty: {
                      message: '标题不能空！'
                  }
              }
      	  }
      }
  });
	

	</script>
</body>
</html>
