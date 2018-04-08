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
<script src="${wmsUrl}/js/pagination.js"></script>
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
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">分级名称</label>
							<div class="col-sm-3">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-user-o"></i>
				                  </div>
		                  			<input type="text" class="form-control" name="gradeName" value="${grade.gradeName}">
		                  			<input type="hidden" class="form-control" name="id" value="${grade.id}">
		                  			<input type="hidden" class="form-control" name="gradeLevel" value="${grade.gradeLevel}">
				                </div>
							</div>
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">公司名称</label>
							<div class="col-sm-3">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-address-book"></i>
				                  </div>
				                  <input type="text" class="form-control" name="company" value="${grade.company}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">上级机构</label>
							<div class="col-sm-3">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-address-book"></i>
				                  </div>
				                  <input type="text" readonly class="form-control" name="parentGradeName" value="${grade.parentGradeName}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"><h4>业务信息</h4></label>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">业务类型</label>
							<div class="col-sm-3">
							<c:if test="${grade.gradeType==1}">
		                   		<label>
				                  	跨境<input type="radio" name="gradeType" value="1" class="flat-red" checked>
				                </label>
							</c:if>
							<c:if test="${grade.gradeType==0}">
				                <label>
				                  	大贸<input type="radio" name="gradeType" value="0" class="flat-red" checked>
				                </label>
							</c:if>
							</div>
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">负责人</label>
							<div class="col-sm-3">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-phone"></i>
				                  </div>
				                  <input type="text" class="form-control" name="personInCharge" value="${grade.personInCharge}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">上级负责人</label>
							<div class="col-sm-3">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-address-book"></i>
				                  </div>
				                  <select class="form-control" name="gradePersonInCharge" id="gradePersonInCharge" style="width: 100%;">
				                   	  <c:forEach var="charge" items="${charges}">
				                   	  	<c:choose>
										   <c:when test="${charge.userCenterId==grade.gradePersonInCharge}">
				                   	  			<option value="${charge.userCenterId}" selected="selected" >${charge.optName}</option>
										   </c:when>
										   <c:otherwise>
				                   	  			<option value="${charge.userCenterId}">${charge.optName}</option>
										   </c:otherwise>
										</c:choose> 
				                   	  </c:forEach>
					              </select>
<%-- 				                   <input type="text" class="form-control" name="gradePersonInCharge" value="${grade.gradePersonInCharge}"> --%>
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"><h4>联系方式</h4></label>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">负责人电话</label>
							<div class="col-sm-3">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-phone"></i>
				                  </div>
				                  <input type="text" class="form-control" readonly name="phone" id="phone" value="${grade.phone}">
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
				                  <input type="text" class="form-control" name="redirectUrl" value="${grade.redirectUrl}">
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
				                  <input type="text" class="form-control" name="mobileUrl" value="${grade.mobileUrl}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"><h4>注册信息</h4></label>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">门店名称</label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
				                  <input type="text" class="form-control" name="storeName" value="${grade.storeName}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">门店联系人</label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
				                  <input type="text" class="form-control" name="contacts" value="${grade.contacts}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">联系人电话</label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
				                  <input type="text" class="form-control" name="contactsPhone" value="${grade.contactsPhone}">
				                </div>
							</div>
						</div>
						<div class="form-group picker-country">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">门店地区</label>
							<div class="col-sm-2">
								<div class="input-group">
								  <select class="form-control picker-province" name="province" id="province" data-name="${grade.province}"></select>
				                </div>
							</div>
							<div class="col-sm-2">
								<div class="input-group">
								  <select class="form-control picker-city" name="city" id="city" data-name="${grade.city}"></select>
				                </div>
							</div>
							<div class="col-sm-2">
								<div class="input-group">
								  <select class="form-control picker-district" name="district" id="district" data-name="${grade.district}"></select>
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">门店地址</label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
				                  <input type="text" class="form-control" name="address" value="${grade.address}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">门店经营者</label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
				                  <input type="text" class="form-control" name="storeOperator" value="${grade.storeOperator}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">经营者证件号</label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
				                  <input type="text" class="form-control" name="operatorIDNum" value="${grade.operatorIDNum}">
				                </div>
							</div>
						</div>
						<div class="col-lg-3 col-xs-3">
							<div class="sbox-body">
								<div class="form-group">
									<img src="${grade.picPath1}" id="img1" width="120px" height="160px" alt="添加证件正面照">
								</div>
								<div class="form-group">
									<div class="input-group">
										<input type="hidden" class="form-control" name="picPath1" id="picPath1" value="${grade.picPath1}"> 
										<input type="file" name="pic" id="pic1" />
										<button type="button" class="btn btn-info" onclick="uploadFile(1)">上传</button>
									</div>
								</div>
							</div>
						</div>
						<div class="col-lg-3 col-xs-3">
							<div class="sbox-body">
								<div class="form-group">
									<img src="${grade.picPath2}" id="img2" width="120px" height="160px" alt="添加营业执照">
								</div>
								<div class="form-group">
									<div class="input-group">
										<input type="hidden" class="form-control" name="picPath2" id="picPath2" value="${grade.picPath2}"> 
										<input type="file" name="pic" id="pic2" />
										<button type="button" class="btn btn-info" onclick="uploadFile(2)">上传</button>
									</div>
								</div>
							</div>
						</div>
						<div class="col-lg-3 col-xs-3">
							<div class="sbox-body">
								<div class="form-group">
									<img src="${grade.picPath3}" id="img3" width="120px" height="160px" alt="添加门店照片">
								</div>
								<div class="form-group">
									<div class="input-group">
										<input type="hidden" class="form-control" name="picPath3" id="picPath3" value="${grade.picPath3}"> 
										<input type="file" name="pic" id="pic3" />
										<button type="button" class="btn btn-info" onclick="uploadFile(3)">上传</button>
									</div>
								</div>
							</div>
						</div>
						<div class="col-lg-3 col-xs-3">
							<div class="sbox-body">
								<div class="form-group">
									<img src="${grade.picPath4}" id="img4" width="120px" height="160px" alt="添加供销货架图片">
								</div>
								<div class="form-group">
									<div class="input-group">
										<input type="hidden" class="form-control" name="picPath4" id="picPath4" value="${grade.picPath4}"> 
										<input type="file" name="pic" id="pic4" />
										<button type="button" class="btn btn-info" onclick="uploadFile(4)">上传</button>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-offset-3 col-md-9">
							<div class="form-group">
	                            <button type="button" class="btn btn-primary" id="submitBtn">保存</button>
	                        </div>
                       </div>
                       <div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"><h4>员工列表</h4></label>
						</div>
						<div class="form-group" id="syncStaff" style="display:none;">
							<label class="col-sm-1 control-label no-padding-right" for="form-field-1"></label>
							<button type="button" id="syncStaff" onclick="getStaff()" class="btn btn-warning">同步员工</button>
						</div>
						<div class="form-group">
							<label class="col-sm-1 control-label no-padding-right" for="form-field-1"></label>
							<div class="col-sm-10">
							<div class="box box-warning">
									<table id="staffTable" class="table table-hover">
										<thead>
											<tr>
												<th>badge</th>
												<th>名称</th>
												<th>分级机构</th>
												<th>用户中心编号</th>
												<th>角色</th>
											</tr>
										</thead>
										<tbody>
										</tbody>
									</table>
									<div class="pagination-nav">
										<ul id="pagination" class="pagination">
										</ul>
									</div>
								</div>
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
	
	/**
	 * 初始化分页信息
	 */
	var options = {
				queryForm : ".query",
				url :  "${wmsUrl}/admin/system/gradeMng/dataListForGrade.shtml?gradeId="+${grade.id},
				numPerPage:"20",
				currentPage:"",
				index:"1",
				callback:rebuildTable
	}


	$(function(){
		 $(".pagination-nav").pagination(options);
	})
	
	
	$("#submitBtn").click(function(){
		 $('#gradeForm').data("bootstrapValidator").validate();
		 if($('#gradeForm').data("bootstrapValidator").isValid()){
			 var reg = /^1[3|4|5|7|8][0-9]\d{4,8}$/;
			 if(!reg.test($("#phone").val())) 
			 { 
				 layer.alert("请输入有效的负责人手机号码！");
			     return false; 
			 }
			 $.ajax({
				 url:"${wmsUrl}/admin/system/gradeMng/update.shtml",
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


	function reloadTable(){
		$.page.loadData(options);
	}
	
	function getStaff(){
		 $.ajax({
			 url:"${wmsUrl}/admin/system/gradeMng/syncStaff.shtml?gradeId="+${grade.id},
			 type:'post',
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){	
					window.reload();
				 }else{
					 layer.alert(data.msg);
				 }
			 },
			 error:function(){
				 layer.alert("提交失败，请联系客服处理");
			 }
		 });
	 }


	/**
	 * 重构table
	 */
	function rebuildTable(data){
		$("#staffTable tbody").html("");

		if (data == null || data.length == 0) {
			return;
		}
		
		var list = data.obj;
		
		if (list == null || list.length == 0) {
			layer.alert("没有员工信息！");
			$("#syncStaff").show();
			return;
		}
		
		$("#syncStaff").hide();

		var str = "";
		for (var i = 0; i < list.length; i++) {
			str += "<tr>";
			//if ("${privilege>=2}") {
			//if (true) {
				//str += "<td align='left'>";
				//str += "<a href='#' onclick='toEdit("+list[i].optid+")'><i class='fa fa-pencil' style='font-size:20px'></i></a>";
				//str += "</td>";
			//}
			
			
			str += "<td>" + list[i].badge;
			str += "<td>" + list[i].optName;
			
			
			str += "</td><td>" + list[i].gradeName;
			str += "</td><td>" + list[i].userCenterId;
			str += "</td><td>" + list[i].roleName;
			str += "</td></tr>";
		}

		$("#staffTable tbody").html(str);
	 }
	
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
	  	  gradePersonInCharge: {
	          message: '上级负责人不能为空',
	          validators: {
	              notEmpty: {
	                  message: '上级负责人不能为空！'
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
