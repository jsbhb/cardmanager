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
<link rel="stylesheet" href="${wmsUrl}/css/component/broadcast.css">
<%@include file="../../resourceLink.jsp"%>
</head>

<body>
	<section class="content-iframe">
       	<form class="form-horizontal" role="form" id="brandForm" style="margin-top:20px;">
			<div class="list-item">
				<div class="col-xs-3 item-left">品牌名称<font style="color:red">*</font> </div>
				<div class="col-xs-9 item-right">
					<input type="hidden" class="form-control" name="brandId" readonly value="${brandId}">
					<input type="text" class="form-control" id="brand" name="brand" readonly>
	            	<div class="item-content">
	             		（由品牌英文名和品牌中文名组合而成，限1-40字）
	             	</div>
				</div>
			</div>
			<div class="list-item">
				<div class="col-xs-3 item-left">品牌英文名</div>
				<div class="col-xs-9 item-right">
					<input type="text" class="form-control" id="brandNameEn" name="brandNameEn" onkeyup="joinName()">
	            	<div class="item-content">
	             		（请输入数字或英文，限0-20字）
	             	</div>
				</div>
			</div>
			<div class="list-item">
				<div class="col-xs-3 item-left">品牌中文名</div>
				<div class="col-xs-9 item-right">
					<input type="text" class="form-control" id="brandNameCn" name="brandNameCn" onkeyup="joinName()">
	            	<div class="item-content">
	             		（请输入数字或汉字，限0-20字）
	             	</div>
				</div>
			</div>
			<div class="list-item">
				<div class="col-xs-3 item-left">品牌国家<font style="color:red">*</font> </div>
				<div class="col-xs-9 item-right">
					<input type="text" class="form-control" name="country">
	            	<div class="item-content">
	             		（品牌归属的国家，请输入汉字，限1-20字）
	             	</div>
				</div>
			</div>
	      	<div class="list-item">
				<div class="col-xs-3 item-left">品牌简介</div>
				<div class="col-xs-9 item-right">
					<textarea class="form-control" name="brandSynopsis"></textarea>
             		<div class="item-content">
		             	（请输入品牌简介）
		            </div>
				</div>
			</div>
			<div class="list-item">
				<div class="col-xs-3 item-left">品牌LOGO</div>
				<div class="col-xs-9 item-right addContent">
					<div class="item-img" id="content" >
						+
						<input type="file" id="pic" name="pic" />
						<input type="hidden" class="form-control" name="brandLogo" id="brandLogo">
					</div>
				</div>
			</div>
			<div class="submit-btn">
                <button type="button" class="btn btn-primary" id="submitBtn">确定</button>
            </div>
		</form>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script src="${wmsUrl}/js/component/broadcast.js"></script>
	<script type="text/javascript" src="${wmsUrl}/js/ajaxfileupload.js"></script>
	<script type="text/javascript">
	
	 $("#submitBtn").click(function(){
		 if($('#brandForm').data("bootstrapValidator").isValid()){
			 $.ajax({
				 url:"${wmsUrl}/admin/goods/brandMng/addBrand.shtml",
				 type:'post',
				 data:JSON.stringify(sy.serializeObject($('#brandForm'))),
				 contentType: "application/json; charset=utf-8",
				 dataType:'json',
				 success:function(data){
					 if(data.success){	
						 parent.location.reload();
					 }else{
						 layer.alert(data.msg);
					 }
				 },
				 error:function(){
					 layer.alert("新增品牌失败，请联系客服处理");
				 }
			 });
		 }else{
			 layer.alert("信息填写有误");
		 }
	 });
	
	 $('#resetBtn').click(function() {
        $('#brandForm').data('bootstrapValidator').resetForm(true);
     });
	
	$('#brandForm').bootstrapValidator({
//      live: 'disabled',
      message: 'This value is not valid',
      feedbackIcons: {
          valid: 'glyphicon glyphicon-ok',
          invalid: 'glyphicon glyphicon-remove',
          validating: 'glyphicon glyphicon-refresh'
      },
      fields: {
    	  brand: {
              message: '品牌名称不正确',
              validators: {
                  notEmpty: {
                      message: '品牌名称不能为空！'
                  },
                  stringLength: {
                	  min: 1,
                	  max: 40,
                	  message: '品牌名称长度请控制在1-40字'
                  }
              }
      	  },
      	  brandNameEn: {
            message: '品牌英文名不正确',
            validators: {
                stringLength: {
              	  min: 0,
              	  max: 20,
              	  message: '品牌英文名长度请控制在0-20字'
                }
            }
    	  },
      	  brandNameCn: {
              message: '品牌中文名不正确',
              validators: {
                  stringLength: {
                	  min: 0,
                	  max: 20,
                	  message: '品牌中文名长度请控制在0-20字'
                  }
              }
      	  },
      	  country: {
              message: '品牌国家不正确',
              validators: {
                  notEmpty: {
                      message: '品牌国家不能为空！'
                  },
                  stringLength: {
                	  min: 1,
                	  max: 20,
                	  message: '品牌国家长度请控制在1-20字'
                  }
              }
      	  },
      	  brandLogo: {
              validators: {
                  notEmpty: {
                      message: '品牌LOGO不能为空！'
                  },
                  file: {
                	  extension: 'png,jpg,jpeg',
                	  type: 'image/png,image/jpg,image/jpeg',
                	  message: '请重新上传品牌LOGO'
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
			url : '${wmsUrl}/admin/uploadFileWithType.shtml?type=goodsBrand&key='+"${brandId}", //你处理上传文件的服务端
			secureuri : false,
			fileElementId : "pic",
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					var imgHt = '<img src="'+data.msg+'"><div class="bgColor"><i class="fa fa-trash fa-fw"></i><i class="fa fa-search fa-fw"></i></div>';
					var imgPath = imgHt+ '<input type="hidden" value='+data.msg+' id="brandLogo" name="brandLogo">'
					$("#content").html(imgPath);
					$("#content").addClass('choose');
				} else {
					layer.alert(data.msg);
				}
			}
		})
	});
	//删除主图
	$('.item-right').on('click','.bgColor i.fa-trash',function(){
		var ht = '<div class="item-img" id="content" >+<input type="file" id="pic" name="pic"/><input type="hidden" name="brandLogo" id="brandLogo" value=""></div>';
		$(this).parent().parent().removeClass("choose");
		$(this).parent().parent().parent().html(ht);
	});
	function setPicImgListData() {
		var valArr = new Array;
		var tmpPicPath = "";
		tmpPicPath = $("#brandLogo").val();
		if (tmpPicPath != null && tmpPicPath != "") {
			valArr.push(tmpPicPath);
		}
		if (valArr != undefined && valArr.length > 0) {
			var data = {
		        imgList: valArr,
		        imgWidth: 500,
		        imgHeight: 500,
		        activeIndex: 0,
		        host: "${wmsUrl}"
		    };
		    setImgScroll('broadcast',data);
		} else {
			layer.alert("请先上传图片！");
		}
	}
	//图片放大
	$('.item-right').on('click','.bgColor i.fa-search',function(){
		setPicImgListData();
	});
	
	function joinName(){
		var tmpNameEn = $("#brandNameEn").val();
		tmpNameEn = $.trim(tmpNameEn);
		var tmpNameCn = $("#brandNameCn").val();
		tmpNameCn = $.trim(tmpNameCn);
		$("#brand").val(tmpNameEn + " " + tmpNameCn);
	}
	</script>
</body>
</html>
