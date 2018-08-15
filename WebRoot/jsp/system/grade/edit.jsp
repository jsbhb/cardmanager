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
<%@include file="../../resourceLink.jsp"%>
</head>

<body>
	<section class="content-iframe content">
		<form class="form-horizontal" role="form" id="form">
			<div class="title">
	       		<h1>基础信息</h1>
	       	</div>
			<div class="list-item">
				<label class="col-sm-3 item-left" >分级名称<font style="color:red">*</font> </label>
				<div class="col-sm-9 item-right">
            		<input type="text" class="form-control" name="gradeName" value="${grade.gradeName}">
            		<input type="hidden" class="form-control" name="id" value="${grade.id}">
            		<input type="hidden" class="form-control" name="gradeLevel" value="${grade.gradeLevel}">
            		<input type="hidden" class="form-control" name="personInChargeId" value="${grade.personInChargeId}">
	                <div class="item-content">
		             	（例：XX的店）
		            </div>
				</div>
			</div>
			<div class="list-item">
				<label class="col-sm-3 item-left" >公司名称<font style="color:red">*</font> </label>
				<div class="col-sm-9 item-right">
	                  <input type="text" class="form-control" name="company" value="${grade.company}">
	                  <div class="item-content">
						（请填写营业执照上的公司名称或法人姓名）
		              </div>
				</div>
			</div>
			<div class="list-item">
				<label class="col-sm-3 item-left" >上级机构<font style="color:red">*</font> </label>
				<div class="col-sm-9 item-right">
	                  <input type="text" readonly class="form-control" name="parentGradeName" value="${grade.parentGradeName}">
				</div>
			</div>
			<div class="list-item">
				<label class="col-sm-3 item-left" >分级类型<font style="color:red">*</font> </label>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" id="gradeTypeId" readonly style="background:#fff;" value="${gradeType.name}">
	                <input type="hidden" readonly class="form-control" name="gradeType" id="gradeType" value="${grade.gradeType}">
	                <input type="hidden" readonly class="form-control" id="parentGradeId" value="${gradeType.parentId}">
				</div>
			</div>
			<div class="select-content" style="width: 420px;top: 219px;">
           		<ul class="first-ul" style="margin-left:10px;">
           			<c:forEach var="menu" items="${gradeList}">
           				<c:set var="menu" value="${menu}" scope="request" />
           				<%@include file="recursive.jsp"%>  
					</c:forEach>
           		</ul>
           	</div>
			<div class="list-item" id="customType" style="display: none">
				<label class="col-sm-3 item-left" >客户类型<font style="color:red">*</font> </label>
				<div class="col-sm-9 item-right">
					<select class="form-control" name="type" id="type" disabled>
	           			<c:forEach var="customerType" items="${customerTypeList}">
	           				<c:choose>
							   <c:when test="${grade.type == customerType.typeId}">
							   		<option value="${customerType.typeId}" selected="selected">${customerType.typeName}</option>
							   </c:when>
							   <c:otherwise>
                	    			<option value="${customerType.typeId}">${customerType.typeName}</option>
							   </c:otherwise>
							</c:choose> 
						</c:forEach>
	                </select>
				</div>
			</div>
			<div class="list-item" id="key" style="display: none">
				<label class="col-sm-3 item-left" >appKey<font style="color:red">*</font> </label>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" id="appKey" name="appKey" value="${grade.appKey}" readonly>
					<div class="item-content">
		             	（对接appKey,问技术部拿）
		            </div>
				</div>
			</div>
			<div class="list-item" id="secret" style="display: none">
				<label class="col-sm-3 item-left" >appSecret<font style="color:red">*</font> </label>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" id="appSecret" name="appSecret" value="${grade.appSecret}" readonly>
					<div class="item-content">
		             	（对接appSecret，问技术部拿）
		            </div>
				</div>
			</div>
			<div class="list-item" id="welfare" style="display: none">
				<label class="col-sm-3 item-left" >福利比例<font style="color:red">*</font> </label>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" id="welfareRebate" name="welfareRebate" value="${grade.welfareRebate}" readonly>
					<div class="item-content">
		             	（福利网站商品的比例，例：0.17）
		            </div>
				</div>
			</div>
			<div class="title">
	       		<h1>负责人信息</h1>
	       	</div>
			<div class="list-item">
				<label class="col-sm-3 item-left" >上级负责人<font style="color:red">*</font> </label>
				<div class="col-sm-9 item-right">
	                  <select class="form-control" name="gradePersonInCharge" id="gradePersonInCharge">
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
				</div>
			</div>
			<div class="list-item">
				<label class="col-sm-3 item-left" >负责人名称<font style="color:red">*</font> </label>
				<div class="col-sm-9 item-right">
	                  <input type="text" class="form-control" name="personInCharge" value="${grade.personInCharge}">
				</div>
			</div>
			<div class="list-item">
				<label class="col-sm-3 item-left" >负责人电话<font style="color:red">*</font> </label>
				<div class="col-sm-9 item-right">
	                  <input type="text" class="form-control" readonly name="phone" id="phone" value="${grade.phone}">
				</div>
			</div>
			<div class="title">
	       		<h1>分级域名信息</h1>
	       	</div>
			<div class="list-item">
				<label class="col-sm-3 item-left" >电脑商城域名<font style="color:red"></font> </label>
				<div class="col-sm-9 item-right">
	                  <input type="text" class="form-control" name="redirectUrl" value="${grade.redirectUrl}">
				</div>
			</div>
			<div class="list-item">
				<label class="col-sm-3 item-left" >手机商城域名<font style="color:red"></font> </label>
				<div class="col-sm-9 item-right">
	                  <input type="text" class="form-control" name="mobileUrl" value="${grade.mobileUrl}">
				</div>
			</div>
			<div class="title">
	       		<h1>注册信息</h1>
	       	</div>
			<div class="list-item">
				<label class="col-sm-3 item-left" >门店名称<font style="color:red">*</font> </label>
				<div class="col-sm-9 item-right">
	                  <input type="text" class="form-control" name="storeName" value="${grade.storeName}">
	                  <div class="item-content">
						（请填写门店的实际名称）
		              </div>
				</div>
			</div>
			<div class="list-item">
				<label class="col-sm-3 item-left" >门店联系人<font style="color:red">*</font> </label>
				<div class="col-sm-9 item-right">
	                  <input type="text" class="form-control" name="contacts" value="${grade.contacts}">
	                  <div class="item-content">
						（请填写门店联系人姓名）
		              </div>
				</div>
			</div>
			<div class="list-item">
				<label class="col-sm-3 item-left" >联系人电话<font style="color:red">*</font> </label>
				<div class="col-sm-9 item-right">
	                  <input type="text" class="form-control" name="contactsPhone" value="${grade.contactsPhone}">
				</div>
			</div>
			<div class="list-item picker-country">
				<label class="col-sm-3 item-left" >门店地区<font style="color:red">*</font> </label>
				<div class="col-sm-9 item-right">
					<div class="right-items">
						  <select class="form-control picker-province" name="province" id="province" data-name="${grade.province}"></select>
					</div>
					<div class="right-items">
						  <select class="form-control picker-city" name="city" id="city" data-name="${grade.city}"></select>
					</div>
					<div class="right-items">
						  <select class="form-control picker-district" name="district" id="district" data-name="${grade.district}"></select>
					</div>
				</div>
			</div>
			<div class="list-item">
				<label class="col-sm-3 item-left" >门店地址<font style="color:red">*</font> </label>
				<div class="col-sm-9 item-right">
	                  <input type="text" class="form-control" name="address" value="${grade.address}">
				</div>
			</div>
			<div class="list-item">
				<label class="col-sm-3 item-left" >门店经营者<font style="color:red">*</font> </label>
				<div class="col-sm-9 item-right">
	                  <input type="text" class="form-control" name="storeOperator" value="${grade.storeOperator}">
	                  <div class="item-content">
						（请填写门店经营者姓名）
		              </div>
				</div>
			</div>
			<div class="list-item">
				<label class="col-sm-3 item-left" >经营者身份证号<font style="color:red">*</font> </label>
				<div class="col-sm-9 item-right">
	                  <input type="text" class="form-control" name="operatorIDNum" value="${grade.operatorIDNum}">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">身份证正面照</div>
				<div class="col-sm-9 item-right addContent">
					<c:choose>
					   <c:when test="${grade.picPath1 != null && grade.picPath1 != ''}">
               	  			<div class="item-img choose" id="content1" data-id="1">
								<img src="${grade.picPath1}">
								<div class="bgColor"><i class="fa fa-trash fa-fw"></i></div>
								<input value="${grade.picPath1}" type="hidden" name="picPath1" id="picPath1">
							</div>
					   </c:when>
					   <c:otherwise>
                	  		<div class="item-img" id="content1" data-id="1">
								+
								<input type="file" id="pic1" name="pic" />
								<input type="hidden" class="form-control" name="picPath1" id="picPath1"> 
							</div>
					   </c:otherwise>
					</c:choose> 
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">营业执照</div>
				<div class="col-sm-9 item-right addContent">
				<c:choose>
					   <c:when test="${grade.picPath2 != null && grade.picPath2 != ''}">
               	  			<div class="item-img choose" id="content2" data-id="2">
								<img src="${grade.picPath2}">
								<div class="bgColor"><i class="fa fa-trash fa-fw"></i></div>
								<input value="${grade.picPath2}" type="hidden" name="picPath2" id="picPath2">
							</div>
					   </c:when>
					   <c:otherwise>
                	  		<div class="item-img" id="content2" data-id="2">
								+
								<input type="file" id="pic2" name="pic" />
								<input type="hidden" class="form-control" name="picPath2" id="picPath2"> 
							</div>
					   </c:otherwise>
					</c:choose> 
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">门店照片</div>
				<div class="col-sm-9 item-right addContent">
				<c:choose>
					   <c:when test="${grade.picPath3 != null && grade.picPath3 != ''}">
               	  			<div class="item-img choose" id="content3" data-id="3">
								<img src="${grade.picPath3}">
								<div class="bgColor"><i class="fa fa-trash fa-fw"></i></div>
								<input value="${grade.picPath3}" type="hidden" name="picPath3" id="picPath3">
							</div>
					   </c:when>
					   <c:otherwise>
                	  		<div class="item-img" id="content3" data-id="3">
								+
								<input type="file" id="pic3" name="pic" />
								<input type="hidden" class="form-control" name="picPath3" id="picPath3"> 
							</div>
					   </c:otherwise>
					</c:choose> 
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">供销货架图片</div>
				<div class="col-sm-9 item-right addContent">
				<c:choose>
					   <c:when test="${grade.picPath4 != null && grade.picPath4 != ''}">
               	  			<div class="item-img choose" id="content2" data-id="4">
								<img src="${grade.picPath4}">
								<div class="bgColor"><i class="fa fa-trash fa-fw"></i></div>
								<input value="${grade.picPath4}" type="hidden" name="picPath4" id="picPath4">
							</div>
					   </c:when>
					   <c:otherwise>
                	  		<div class="item-img" id="content4" data-id="4">
								+
								<input type="file" id="pic4" name="pic" />
								<input type="hidden" class="form-control" name="picPath4" id="picPath4"> 
							</div>
					   </c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="submit-btn">
           			 <button type="button" class="btn btn-primary" id="submitBtn">保存</button>
                  	<button type="button" class="btn btn-info" id="closeBtn">关闭</button>
       		</div>
            <div class="title">
	       		<h1>员工列表</h1>
	       	</div>
	       	
	       	<div class="list-content">
		       	<div class="row">
					<div class="col-md-10 list-btns">
						<button type="button" id="syncStaff" onclick="getStaff()" class="btn btn-warning">同步员工</button>
					</div>
				</div>
				<div class="col-md-12">
					<table id="staffTable" class="table table-hover myClass">
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
		</form>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script src="${wmsUrl}/validator/js/bootstrapValidator.min.js"></script>
	<script src="${wmsUrl}/js/pagination.js"></script>
	<script src="${wmsUrl}/js/jquery.picker.js"></script>
	<script type="text/javascript" src="${wmsUrl}/js/ajaxfileupload.js"></script>
	<script type="text/javascript">
	$(".picker-country").picker();
	
	//点击上传图片
	$('.item-right').on('change','.item-img input[type=file]',function(){
		var id = $(this).parent().attr('data-id'); 
		var imagSize = document.getElementById("pic"+id).files[0].size;
		if(imagSize>1024*1024*3) {
			layer.alert("图片大小请控制在3M以内，当前图片为："+(imagSize/(1024*1024)).toFixed(2)+"M");
			return true;
		}
		$.ajaxFileUpload({
			url : '${wmsUrl}/admin/uploadFileForGrade.shtml', //你处理上传文件的服务端
			secureuri : false,
			fileElementId : "pic"+id,
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					var imgHt = '<img src="'+data.msg+'"><div class="bgColor"><i class="fa fa-trash fa-fw"></i></div>';
					var imgPath = imgHt+ '<input type="hidden" value='+data.msg+' id="picPath'+id+'" name="picPath'+id+'">'
					$("#content"+id).html(imgPath);
					$("#content"+id).addClass('choose');
				} else {
					layer.alert(data.msg);
				}
			}
		})
	});
	//删除主图
	$('.item-right').on('click','.bgColor i',function(){
		var id = $(this).parent().parent().attr("data-id");
		var ht = '<div class="item-img" id="content'+id+'" data-id="'+id+'">+<input type="file" id="pic'+id+'" name="pic"/><input type="hidden" name="picPath'+id+'" id="picPath'+id+'" value=""></div>';
		$(this).parent().parent().removeClass("choose");
		$(this).parent().parent().parent().html(ht);
	});
	
	 $('#closeBtn').click(function() {
		 parent.layer.closeAll();
	   });
	
	/**
	 * 初始化分页信息
	 */
	var options = {
				queryForm : ".query",
				url :  "${wmsUrl}/admin/system/gradeMng/dataListForGrade.shtml?gradeId="+"${grade.id}",
				numPerPage:"10",
				currentPage:"",
				index:"1",
				callback:rebuildTable
	}


	$(function(){
		if ($("#parentGradeId").val() == 1) {
			$('#customType').stop();
			$('#customType').slideDown(300);
		}
		if ($("#type").val() == 2) {
			$('#key').stop();
			$('#key').slideDown(300);
			$('#secret').stop();
			$('#secret').slideDown(300);
		} else if ($("#type").val() == 3) {
			$('#welfare').stop();
			$('#welfare').slideDown(300);
		}
		$(".pagination-nav").pagination(options);
	})
	
	
	$("#submitBtn").click(function(){
		 $('#form').data("bootstrapValidator").validate();
		 if($('#form').data("bootstrapValidator").isValid()){
			 var reg = /^1[3|4|5|7|8][0-9]\d{4,8}$/;
			 if(!reg.test($("#phone").val())) 
			 { 
				 layer.alert("请输入有效的负责人手机号码！");
			     return false; 
			 }
			 var tmpWelfareRebate = $('#welfareRebate').val();
			 if(tmpWelfareRebate >= 1){
				 layer.alert("福利比例填写有误，请重新填写！");
				 return;
			 }
			 $("#type").attr("disabled", false);
			 $.ajax({
				 url:"${wmsUrl}/admin/system/gradeMng/update.shtml",
				 type:'post',
				 data:JSON.stringify(sy.serializeObject($('#form'))),
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
			 url:"${wmsUrl}/admin/system/gradeMng/syncStaff.shtml?gradeId="+"${grade.id}",
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
	
	$('#form').bootstrapValidator({
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
	  	  },
	  	  welfareRebate:{
			   message: '福利比例不正确',
			   validators: {
				   notEmpty: {
					   message: '福利比例不能为空'
				   },
				   numeric: {
					   message: '福利比例只能输入数字'
				   }
			   }
		  }
      }
  });
	
	//点击展开
	$('.select-content').on('click','li span i:not(active)',function(){
		$(this).addClass('active');
		$(this).parent().next().stop();
		$(this).parent().next().slideDown(300);
	});
	//点击收缩
	$('.select-content').on('click','li span i.active',function(){
		$(this).removeClass('active');
		$(this).parent().next().stop();
		$(this).parent().next().slideUp(300);
	});
	
	//点击展开下拉列表
	$('#gradeTypeId').click(function(){
		$('.select-content').stop();
		$('.select-content').slideDown(300);
	});
	
	//点击空白隐藏下拉列表
	$('html').click(function(event){
		var el = event.target || event.srcelement;
		if(!$(el).parents('.select-content').length > 0 && $(el).attr('id') != "gradeTypeId"){
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
			var parId = $(this).attr('data-par-id');
			$('#gradeTypeId').val(name);
			$('#gradeType').val(id);
			$('.select-content').stop();
			$('.select-content').slideUp(300);
			if (parId != 1) {
				$('#customType').stop();
				$('#customType').slideUp(300);
			} else {
				$('#customType').stop();
				$('#customType').slideDown(300);
			}
		}
	});
	
	$("#customType").change(function(){
		if ($("#type").val() == 1) {
			$('#key').stop();
			$('#key').slideUp(300);
			$('#secret').stop();
			$('#secret').slideUp(300);
			$('#welfare').stop();
			$('#welfare').slideUp(300);
		} else if ($("#type").val() == 2) {
			$('#key').stop();
			$('#key').slideDown(300);
			$('#secret').stop();
			$('#secret').slideDown(300);
			$('#welfare').stop();
			$('#welfare').slideUp(300);
		} else if ($("#type").val() == 3) {
			$('#key').stop();
			$('#key').slideUp(300);
			$('#secret').stop();
			$('#secret').slideUp(300);
			$('#welfare').stop();
			$('#welfare').slideDown(300);
		}
	});
	
	</script>
</body>
</html>
