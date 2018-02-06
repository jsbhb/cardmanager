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
<%@include file="../resource.jsp"%>
</head>

<body>
	<section class="content">
        <div class="main-content">
			<div class="row">
				<div class="col-xs-12" >
					<form class="form-horizontal" role="form" id="gradeConfigForm" >
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"><h4>微店信息</h4></label>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">店铺编号</label>
							<div class="col-sm-5">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-user-o"></i>
				                  </div>
		                  			<input type="text" readonly class="form-control" name="shopId" value="${opt.shopId}">
		                  			<input type="hidden" class="form-control" name="id" value="${shop.id}">
		                  			<input type="hidden" class="form-control" name="gradeId" value="${shop.gradeId}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">店铺名称</label>
							<div class="col-sm-5">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-address-book"></i>
				                  </div>
				                  <input type="text" class="form-control" name="name" value="${shop.name}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">店铺简介</label>
							<div class="col-sm-5">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-address-book"></i>
				                  </div>
				                  <input type="text" class="form-control" name="aboutUs" value="${shop.aboutUs}">
				                </div>
							</div>
						</div>
						<div class="col-lg-3 col-xs-3">
							<div class="sbox-body">
								<div class="form-group">
									<img src="${shop.headImg}" id="img1" width="120px" height="160px" alt="添加证件正面照">
								</div>
								<div class="form-group">
									<div class="input-group">
										<input type="hidden" class="form-control" name="headImg" id="headImg" value="${shop.headImg}"> 
										<input type="file" name="pic1" id="pic1" />
										<button type="button" class="btn btn-info" onclick="uploadFile()">上传</button>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-offset-3 col-md-9">
							<div class="form-group">
	                            <button type="button" class="btn btn-primary" id="submitBtn">保存</button>
	                        </div>
                       </div>
					</form>
				</div>
			</div>
		</div>
	</section>
	<%@ include file="../footer.jsp"%>
	<script type="text/javascript" src="${wmsUrl}/js/ajaxfileupload.js"></script>
	<script type="text/javascript">
	function uploadFile() {
		$.ajaxFileUpload({
			url : '${wmsUrl}/admin/uploadFileForShop.shtml', //你处理上传文件的服务端
			secureuri : false,
			fileElementId : "pic1",
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					$("#headImg").val(data.msg);
					$("#img1").attr("src",data.msg);
				} else {
					layer.alert(data.msg);
				}
			}
		})
	}
	
	$("#submitBtn").click(function(){
		 $.ajax({
			 url:"${wmsUrl}/admin/shop/shopMng/update.shtml",
			 type:'post',
			 data:JSON.stringify(sy.serializeObject($('#gradeConfigForm'))),
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){	
					 layer.alert("保存成功");
				 }else{
					 layer.alert(data.msg);
				 }
			 },
			 error:function(){
				 layer.alert("提交失败，请联系客服处理");
			 }
		 });
	 });
	</script>
</body>
</html>
