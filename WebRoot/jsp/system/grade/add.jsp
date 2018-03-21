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

<link rel="stylesheet" href="${wmsUrl}/validator/css/bootstrapValidator.min.css">
<script src="${wmsUrl}/validator/js/bootstrapValidator.min.js"></script>
<script src="${wmsUrl}/js/jquery.picker.min.js"></script>
</head>

<body>
	<section class="content">
        <div class="main-content">
			<div class="row">
				<div class="col-xs-12" >
					<form class="form-horizontal" role="form" id="gradeForm" >
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"><h4>基本信息</h4></label>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">分级名称<font style="color:red">*</font> </label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
		                  			<input type="text" class="form-control" name="gradeName">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">公司名称<font style="color:red">*</font> </label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
				                  <input type="text" class="form-control" name="company" placeholder="请输入...">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">上级机构<font style="color:red">*</font> </label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
				                  <input type="text" readonly class="form-control" name="parentGradeName" value="${opt.gradeName}">
				                  <input type="hidden" readonly class="form-control" name="parentId" value="${opt.gradeId}">
				                  <input type="hidden" readonly class="form-control" name="gradeLevel" value="${opt.gradeLevel+1}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"><h4>业务信息</h4></label>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">业务类型<font style="color:red">*</font> </label>
							<div class="col-sm-2">
		                   		<label>
				                  	跨境<input type="radio" name="gradeType" value="1" class="flat-red" checked>
				                </label>
				                <label>
				                  	大贸<input type="radio" name="gradeType" value="0" class="flat-red">
				                </label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">负责人<font style="color:red">*</font> </label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-phone"></i>
				                  </div>
				                  <input type="text" class="form-control" name="personInCharge" placeholder="请输入负责人名称">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">上级负责人<font style="color:red">*</font> </label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
				                  <select class="form-control" name="gradePersonInCharge" id="gradePersonInCharge" style="width: 100%;">
<!-- 				                   	  <option selected="selected" value="">未选择</option> -->
				                   	  <c:forEach var="charge" items="${charges}">
					                   	  	<c:choose>
									           <c:when test="${charge.userCenterId=='8001'}">
				                   	  		   	<option value="${charge.userCenterId}" selected>${charge.optName}</option>
									           </c:when>
									           <c:otherwise>
				                   	  			<option value="${charge.userCenterId}">${charge.optName}</option>
									           </c:otherwise>
									        </c:choose> 
				                   	  </c:forEach>
					              </select>
<!-- 				                   <input type="text" class="form-control" name="gradePersonInCharge" placeholder="请选择"> -->
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"><h4>联系方式</h4></label>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">负责人电话<font style="color:red">*</font> </label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
				                  <input type="text" class="form-control" name="phone" id="phone" placeholder="请输入...">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"><h4>区域中心域名信息</h4></label>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">电脑商城域名<font style="color:red"></font> </label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
				                  <input type="text" class="form-control" name="redirectUrl">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">手机商城域名<font style="color:red"></font> </label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
				                  <input type="text" class="form-control" name="mobileUrl">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"><h4>注册信息</h4></label>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">门店名称<font style="color:red">*</font> </label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
				                  <input type="text" class="form-control" name="storeName">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">门店联系人<font style="color:red">*</font> </label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
				                  <input type="text" class="form-control" name="contacts">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">联系人电话<font style="color:red">*</font> </label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
				                  <input type="text" class="form-control" name="contactsPhone">
				                </div>
							</div>
						</div>
						<div class="form-group picker-country">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">门店地区<font style="color:red">*</font> </label>
							<div class="col-sm-2">
								<div class="input-group">
								  <select class="form-control picker-province" name="province" id="province"></select>
				                </div>
							</div>
							<div class="col-sm-2">
								<div class="input-group">
								  <select class="form-control picker-city" name="city" id="city"></select>
				                </div>
							</div>
							<div class="col-sm-2">
								<div class="input-group">
								  <select class="form-control picker-district" name="district" id="district"></select>
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">门店地址<font style="color:red">*</font> </label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
				                  <input type="text" class="form-control" name="address">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">门店经营者<font style="color:red">*</font> </label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
				                  <input type="text" class="form-control" name="storeOperator">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">经营者证件号<font style="color:red">*</font> </label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
				                  <input type="text" class="form-control" name="operatorIDNum">
				                </div>
							</div>
						</div>
						<div class="col-lg-3 col-xs-3">
							<div class="sbox-body">
								<div class="form-group">
									<img id="img1" width="120px" height="160px" alt="添加证件正面照">
								</div>
								<div class="form-group">
									<div class="input-group">
										<input type="hidden" class="form-control" name="picPath1" id="picPath1"> 
										<input type="file" name="pic" id="pic1" />
										<button type="button" class="btn btn-info" onclick="uploadFile(1)">上传</button>
									</div>
								</div>
							</div>
						</div>
						<div class="col-lg-3 col-xs-3">
							<div class="sbox-body">
								<div class="form-group">
									<img id="img2" width="120px" height="160px" alt="添加营业执照">
								</div>
								<div class="form-group">
									<div class="input-group">
										<input type="hidden" class="form-control" name="picPath2" id="picPath2"> 
										<input type="file" name="pic" id="pic2" />
										<button type="button" class="btn btn-info" onclick="uploadFile(2)">上传</button>
									</div>
								</div>
							</div>
						</div>
						<div class="col-lg-3 col-xs-3">
							<div class="sbox-body">
								<div class="form-group">
									<img id="img3" width="120px" height="160px" alt="添加门店照片">
								</div>
								<div class="form-group">
									<div class="input-group">
										<input type="hidden" class="form-control" name="picPath3" id="picPath3"> 
										<input type="file" name="pic" id="pic3" />
										<button type="button" class="btn btn-info" onclick="uploadFile(3)">上传</button>
									</div>
								</div>
							</div>
						</div>
						<div class="col-lg-3 col-xs-3">
							<div class="sbox-body">
								<div class="form-group">
									<img id="img4" width="120px" height="160px" alt="添加供销货架图片">
								</div>
								<div class="form-group">
									<div class="input-group">
										<input type="hidden" class="form-control" name="picPath4" id="picPath4"> 
										<input type="file" name="pic" id="pic4" />
										<button type="button" class="btn btn-info" onclick="uploadFile(4)">上传</button>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-offset-3 col-md-9">
							<div class="form-group">
	                            <button type="button" class="btn btn-primary" id="submitBtn">提交</button>
	                            <button type="button" class="btn btn-info" id="resetBtn">重置</button>
	                        </div>
                       </div>
					</form>
				</div>
			</div>
		</div>
	</section>
	<%@ include file="../../footer.jsp"%>
	<script type="text/javascript" src="${wmsUrl}/js/ajaxfileupload.js"></script>
	<script type="text/javascript">
	$(".picker-country").picker();
	
	function uploadFile(id) {
		$.ajaxFileUpload({
			url : '${wmsUrl}/admin/uploadFileForGrade.shtml', //你处理上传文件的服务端
			secureuri : false,
			fileElementId : "pic"+id,
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					$("#picPath"+id).val(data.msg);
					$("#img"+id).attr("src",data.msg);
				} else {
					layer.alert(data.msg);
				}
			}
		})
	}
	
	 $("#submitBtn").click(function(){
		 if($('#gradeForm').data("bootstrapValidator").isValid()){
			 var reg = /^1(3|4|5|7|8)\d{9}$/;
			 if(!reg.test($("#phone").val())) 
			 { 
				 layer.alert("请输入有效的负责人手机号码！");
			     return false; 
			 }
			 var tmpPath1 = $('#picPath1').val();
			 if (tmpPath1 == "") {
				 layer.alert("门店经营者证件照不能为空！");
				 return;
			 }
			 var tmpPath2 = $('#picPath2').val();
			 if (tmpPath2 == "") {
				 layer.alert("门店营业执照不能为空！");
				 return;
			 }
			 var tmpPath3 = $('#picPath3').val();
			 if (tmpPath3 == "") {
				 layer.alert("门店照片不能为空！");
				 return;
			 }
			 var tmpPath4 = $('#picPath4').val();
			 if (tmpPath4 == "") {
				 layer.alert("供销货架图片不能为空！");
				 return;
			 }
			 $.ajax({
				 url:"${wmsUrl}/admin/system/gradeMng/addGrade.shtml",
				 type:'post',
				 data:JSON.stringify(sy.serializeObject($('#gradeForm'))),
				 contentType: "application/json; charset=utf-8",
				 dataType:'json',
				 success:function(data){
					 if(data.success){	
						 layer.alert("插入成功");
						 parent.layer.closeAll();
						 parent.reloadTable();
					 }else{
						 parent.reloadTable();
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
	
	 $('#resetBtn').click(function() {
	        $('#gradeForm').data('bootstrapValidator').resetForm(true);
	    });
	
	$('#gradeForm').bootstrapValidator({
//      live: 'disabled',
      message: 'This value is not valid',
      feedbackIcons: {
          valid: 'glyphicon glyphicon-ok',
          invalid: 'glyphicon glyphicon-remove',
          validating: 'glyphicon glyphicon-refresh'
      },
      fields: {
    	  gradeName: {
              message: '分级名称不正确',
              validators: {
                  notEmpty: {
                      message: '分级名称不能为空'
                  },
                  stringLength: {
                      min: 4,
                      max: 30,
                      message: '分级名称必须在4-30位字符'
                  },
              }
      	  },
      	  personInCharge: {
	          message: '负责人不能为空',
	          validators: {
	              notEmpty: {
	                  message: '负责人不能为空！'
	              }
	          }
	  	  },
	  	  phone: {
	          message: '负责人电话不能为空',
	          validators: {
	              notEmpty: {
	                  message: '负责人电话不能为空！'
	              }
	          }
	  	  },
	  	  company: {
	          message: '公司不能为空',
	          validators: {
	              notEmpty: {
	                  message: '公司不能为空！'
	              }
	          }
	  	  },
	  	  storeName: {
	          message: '门店名称不能为空',
	          validators: {
	              notEmpty: {
	                  message: '门店名称不能为空！'
	              }
	          }
	  	  },
	  	  contacts: {
	          message: '门店联系人不能为空',
	          validators: {
	              notEmpty: {
	                  message: '门店联系人不能为空！'
	              }
	          }
	  	  },
	  	  contactsPhone: {
	          message: '门店联系人电话不能为空',
	          validators: {
	              notEmpty: {
	                  message: '门店联系人电话不能为空！'
	              }
	          }
	  	  },
	      address: {
	          message: '门店地址不能为空',
	          validators: {
	              notEmpty: {
	                  message: '门店地址不能为空！'
	              }
	          }
	  	  },
	  	  storeOperator: {
	          message: '门店经营者不能为空',
	          validators: {
	              notEmpty: {
	                  message: '门店经营者不能为空！'
	              }
	          }
	  	  },
	  	  operatorIDNum: {
	          message: '门店经营者证件号不能为空',
	          validators: {
	              notEmpty: {
	                  message: '门店经营者证件号不能为空！'
	              }
	          }
	  	  },
	  	  picPath1: {
	          message: '门店经营者证件照不能为空',
	          validators: {
	              notEmpty: {
	                  message: '门店经营者证件照不能为空！'
	              }
	          }
	  	  },
	  	  picPath2: {
	          message: '门店营业执照不能为空',
	          validators: {
	              notEmpty: {
	                  message: '门店营业执照不能为空！'
	              }
	          }
	  	  },
	  	  picPath3: {
	          message: '门店照片不能为空',
	          validators: {
	              notEmpty: {
	                  message: '门店照片不能为空！'
	              }
	          }
	  	  },
	  	  picPath4: {
	          message: '供销货架图片不能为空',
	          validators: {
	              notEmpty: {
	                  message: '供销货架图片不能为空！'
	              }
	          }
	  	  }
      }
  });
	
	
	
	</script>
</body>
</html>
