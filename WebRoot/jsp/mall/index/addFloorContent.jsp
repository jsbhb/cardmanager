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
<%@include file="../../resource.jsp"%>

<link rel="stylesheet"
	href="${wmsUrl}/validator/css/bootstrapValidator.min.css">
<script src="${wmsUrl}/validator/js/bootstrapValidator.min.js"></script>
<script src="${wmsUrl}/plugins/ckeditor/ckeditor.js"></script>
</head>

<body>
	<section class="content-wrapper" style="height: 900px">
		<section class="content">
				<form class="form-horizontal" role="form" id="floorContentForm">
					<div class="col-md-12">
						<div class="box box-info">
							<div class="box-header with-border">
								<div class="box-header with-border">
									<h5 class="box-title">楼层内容添加</h5>
									<div class="box-tools pull-right">
										<button type="button" class="btn btn-box-tool"
											data-widget="collapse">
											<i class="fa fa-minus"></i>
										</button>
									</div>
								</div>
							</div>
							<div class="box-body">
								<div class="form-group">
									<label class="col-sm-2 control-label no-padding-right">楼层编号</label>
									<div class="col-sm-6">
										<div class="input-group">
											<input type="text" class="form-control" readonly name="dictId" value="${id}"> 
										</div>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label no-padding-right">标题</label>
									<div class="col-sm-6">
										<div class="input-group">
											<input type="text" class="form-control" name="title"> 
										</div>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label no-padding-right">国家</label>
									<div class="col-sm-6">
										<div class="input-group">
											<input type="text" class="form-control" name="origin"> 
										</div>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label no-padding-right">价格</label>
									<div class="col-sm-6">
										<div class="input-group">
											<input type="text" class="form-control" name="price"> 
										</div>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label no-padding-right">跳转链接</label>
									<div class="col-sm-6">
										<div class="input-group">
											<input type="text" class="form-control" name="href" value=""> 
										</div>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label no-padding-right">描述</label>
									<div class="col-sm-6">
										<div class="input-group">
											<input type="text" class="form-control" name="description"  value="${data.description}"> 
										</div>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label no-padding-right">大图</label>
									<div class="col-sm-6">
										<div class="input-group">
											<input type="text" class="form-control" name="picPath" id="picPath">H5:(224*224px)PC： (309*148px)
											<input type="file" name="pic" id="pic" />
											<button type="button" class="btn btn-info" onclick="uploadFile()">上传</button>
										</div>
									</div>
								</div>
								<div class="col-md-offset-1 col-md-9">
									<div class="form-group">
											<button type="button" class="btn btn-info" onclick="save()">添加</button>
					                 </div>
					            </div>
							</div>
						</div>
					</div>
				</form>
		</section>
	</section>
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
      	  }
      }
  });
	

	</script>
</body>
</html>
