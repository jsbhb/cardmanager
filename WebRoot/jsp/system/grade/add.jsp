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
	<div id="image" style="width:100%;height:100%;display: none;background:rgba(0,0,0,0.5);">
		<img alt="loading..." src="${wmsUrl}/img/loader.gif" style="position:fixed;top:50%;left:50%;margin-left:-16px;margin-top:-16px;" />
	</div>
	<section class="content-iframe content">
		<form class="form-horizontal" role="form" id="form">
			<div class="title">
	       		<h1>基础信息</h1>
	       	</div>
			<div class="list-item">
				<label class="col-sm-3 item-left">分级名称<font style="color:red">*</font></label>
				<div class="col-sm-9 item-right">
                 	<input type="text" class="form-control" name="gradeName">
	                <div class="item-content">
		             	（例：XX的店）
		            </div>
				</div>
			</div>
			<div class="list-item">
				<label class="col-sm-3 item-left" >公司名称<font style="color:red">*</font> </label>
				<div class="col-sm-9 item-right">
                  <input type="text" class="form-control" name="company">
                  <div class="item-content">
					（请填写营业执照上的公司名称或法人姓名）
	              </div>
				</div>
			</div>
			<div class="list-item">
				<label class="col-sm-3 item-left" >上级机构<font style="color:red">*</font> </label>
				<div class="col-sm-9 item-right">
	                  <input type="text" readonly class="form-control" name="parentGradeName" value="${opt.gradeName}">
	                  <input type="hidden" readonly class="form-control" name="parentId" value="${opt.gradeId}">
	                  <input type="hidden" readonly class="form-control" name="gradeLevel" value="${opt.gradeLevel+1}">
				</div>
			</div>
			<div class="list-item">
				<label class="col-sm-3 item-left" >分级类型<font style="color:red">*</font> </label>
				<div class="col-sm-9 item-right">
					<input type="text" readonly class="form-control" id="gradeTypeId" style="background:#fff;">
	                <input type="hidden" readonly class="form-control" name="gradeType" id="gradeType">
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
					<select class="form-control" name="type" id="type">
						<c:forEach var="customerType" items="${customerTypeList}">
       	    				<option value="${customerType.typeId}">${customerType.typeName}</option>
						</c:forEach>
	                </select>
				</div>
			</div>
			<div class="list-item" id="key" style="display: none">
				<label class="col-sm-3 item-left" >appKey<font style="color:red">*</font> </label>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" id="appKey" name="appKey">
					<div class="item-content">
		             	（对接appKey,问技术部拿）
		            </div>
				</div>
			</div>
			<div class="list-item" id="secret" style="display: none">
				<label class="col-sm-3 item-left" >appSecret<font style="color:red">*</font> </label>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" id="appSecret" name="appSecret">
					<div class="item-content">
		             	（对接appSecret，问技术部拿）
		            </div>
				</div>
			</div>
			<div class="list-item" id="welfare" style="display: none">
				<label class="col-sm-3 item-left" >福利比例<font style="color:red">*</font> </label>
				<div class="col-sm-9 item-right">
					<input type="text" class="form-control" id="welfareRebate" name="welfareRebate" value="0">
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
						           <c:when test="${charge.userCenterId=='8001'}">
	                   	  		   	<option value="${charge.userCenterId}" selected>${charge.optName}</option>
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
	                  <input type="text" class="form-control" name="personInCharge">
				</div>
			</div>
			<div class="list-item">
				<label class="col-sm-3 item-left" >负责人电话<font style="color:red">*</font> </label>
				<div class="col-sm-9 item-right">
	                  <input type="text" class="form-control" name="phone" id="phone">
				</div>
			</div>
			<div class="title">
	       		<h1>分级域名信息</h1>
	       	</div>
			<div class="list-item">
				<label class="col-sm-3 item-left" >电脑商城域名<font style="color:red"></font> </label>
				<div class="col-sm-9 item-right">
	                <input type="text" class="form-control" name="redirectUrl">
				</div>
			</div>
			<div class="list-item">
				<label class="col-sm-3 item-left" >手机商城域名<font style="color:red"></font> </label>
				<div class="col-sm-9 item-right">
                  <input type="text" class="form-control" name="mobileUrl">
				</div>
			</div>
			<div class="title">
	       		<h1>注册信息</h1>
	       	</div>
			<div class="list-item">
				<label class="col-sm-3 item-left" >门店名称<font style="color:red">*</font> </label>
				<div class="col-sm-9 item-right">
                  <input type="text" class="form-control" name="storeName">
                  <div class="item-content">
					（请填写门店的实际名称）
	              </div>
				</div>
			</div>
			<div class="list-item">
				<label class="col-sm-3 item-left" >门店联系人<font style="color:red">*</font> </label>
				<div class="col-sm-9 item-right">
                  <input type="text" class="form-control" name="contacts">
                  <div class="item-content">
					（请填写门店联系人姓名）
	              </div>
				</div>
			</div>
			<div class="list-item">
				<label class="col-sm-3 item-left" >联系人电话<font style="color:red">*</font> </label>
				<div class="col-sm-9 item-right">
                  <input type="text" class="form-control" name="contactsPhone">
				</div>
			</div>
			<div class="list-item picker-country">
				<label class="col-sm-3 item-left" >门店地区<font style="color:red">*</font> </label>
				<div class="col-sm-9 item-right">
					<div class="right-items">
						  <select class="form-control picker-province" name="province" id="province"></select>
					</div>
					<div class="right-items">
						  <select class="form-control picker-city" name="city" id="city"></select>
					</div>
					<div class="right-items">
						  <select class="form-control picker-district" name="district" id="district"></select>
					</div>
				</div>
			</div>
			<div class="list-item">
				<label class="col-sm-3 item-left" >门店地址<font style="color:red">*</font> </label>
				<div class="col-sm-9 item-right">
	                  <input type="text" class="form-control" name="address">
				</div>
			</div>
			<div class="list-item">
				<label class="col-sm-3 item-left" >门店经营者<font style="color:red">*</font> </label>
				<div class="col-sm-9 item-right">
	                  <input type="text" class="form-control" name="storeOperator">
	                  <div class="item-content">
						（请填写门店经营者姓名）
		              </div>
				</div>
			</div>
			<div class="list-item">
				<label class="col-sm-3 item-left" >经营者身份证号<font style="color:red">*</font> </label>
				<div class="col-sm-9 item-right">
	                  <input type="text" class="form-control" name="operatorIDNum">
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">身份证正面照</div>
				<div class="col-sm-9 item-right addContent">
					<div class="item-img" id="content1" data-id="1">
						+
						<input type="file" id="pic1" name="pic" />
						<input type="hidden" class="form-control" name="picPath1" id="picPath1"> 
					</div>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">营业执照</div>
				<div class="col-sm-9 item-right addContent">
					<div class="item-img" id="content2" data-id="2">
						+
						<input type="file" id="pic2" name="pic" />
						<input type="hidden" class="form-control" name="picPath2" id="picPath2"> 
					</div>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">门店照片</div>
				<div class="col-sm-9 item-right addContent">
					<div class="item-img" id="content3" data-id="3">
						+
						<input type="file" id="pic3" name="pic" />
						<input type="hidden" class="form-control" name="picPath3" id="picPath3"> 
					</div>
				</div>
			</div>
			<div class="list-item">
				<div class="col-sm-3 item-left">供销货架图片</div>
				<div class="col-sm-9 item-right addContent">
					<div class="item-img" id="content4" data-id="4">
						+
						<input type="file" id="pic4" name="pic" />
						<input type="hidden" class="form-control" name="picPath4" id="picPath4"> 
					</div>
				</div>
			</div>
             <div class="submit-btn">
           			<button type="button" class="btn btn-primary" id="submitBtn">提交</button>
                    <button type="button" class="btn btn-info" id="resetBtn">重置</button>
                  	<button type="button" class="btn btn-info" id="closeBtn">关闭</button>
       		</div>
		</form>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script src="${wmsUrl}/validator/js/bootstrapValidator.min.js"></script>
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
	
	 $("#submitBtn").click(function(){
		 if($('#form').data("bootstrapValidator").isValid()){
			 var reg = /^1[3|4|5|7|8][0-9]\d{4,8}$/;
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
			 var tmpWelfareRebate = $('#welfareRebate').val();
			 if(tmpWelfareRebate >= 1){
				 layer.alert("福利比例填写有误，请重新填写！");
				 return;
			 }
			 $("#image").css({
					display : "block",
					position : "fixed",
					zIndex : 99,
				});
			 $.ajax({
				 url:"${wmsUrl}/admin/system/gradeMng/addGrade.shtml",
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
						 $("#image").hide();
					 }
				 },
				 error:function(){
					 layer.alert("提交失败，请联系客服处理");
					 $("#image").hide();
				 }
			 });
		 }else{
			 layer.alert("信息填写有误");
		 }
	 });
	
	 $('#resetBtn').click(function() {
	        $('#form').data('bootstrapValidator').resetForm(true);
	    });
	
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
	
	</script>
</body>
</html>
