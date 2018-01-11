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
<script src="${wmsUrl}/plugins/ckeditor/ckeditor.js"></script>

</head>

<body >
<section class="content-wrapper" style="height:900px">
	<section class="content">
		<form class="form-horizontal" role="form" id="itemForm" >
			<div class="col-md-6">
	        	<div class="box box-warning">
	        		<div class="box-header with-border">
						<div class="box-header with-border">
			            	<h5 class="box-title">绑定基础商品<font style="color:red">*</font> <a href="#" onclick="showBaseGoods()" style="margin-left:10px"><i class="fa fa-plus"></i></a></h5>
			            	<div class="box-tools pull-right">
			                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			              	</div>
			            </div>
					</div>
					<div class="box-body" id="baseInfo" hidden>
				            <div class="form-group"  >
								<label class="col-sm-3 control-label no-padding-right" for="form-field-1">基础编码</label>
								<div class="col-sm-3">
									<div class="input-group">
			                  			<input type="text" readonly class="form-control" name="baseId" id="baseId">
					                </div>
								</div>
								<label class="col-sm-2 control-label no-padding-right" for="form-field-1">名称</label>
								<div class="col-sm-3">
									<div class="input-group">
			                  			<input type="text" readonly class="form-control" id="baseName">
					                </div>
								</div>
							</div>
							<div class="form-group" >
								<label class="col-sm-3 control-label no-padding-right" for="form-field-1">品牌</label>
								<div class="col-sm-3">
									<div class="input-group">
			                  			<input type="text" readonly class="form-control" id="brand">
					                </div>
								</div>
								<label class="col-sm-2 control-label no-padding-right" for="form-field-1">分类</label>
								<div class="col-sm-3">
									<div class="input-group">
			                  			<input type="text" readonly class="form-control" id="catalog">
					                </div>
								</div>
							</div>
			            </div>
				</div>
			</div>
			<div class="col-md-6">
	        	<div class="box box-primary">
	        		<div class="box-header with-border">
						<div class="box-header with-border">
			            	<h5 class="box-title">规格模板<font style="color:red">(非必需)</font> <a href="#" onclick="showSpaceGoods()" style="margin-left:10px"><i class="fa fa-plus"></i></a></h5>
			            	<div class="box-tools pull-right">
			                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			              	</div>
			            </div>
					</div>
					<div class="box-body" id="specsInfo" hidden>
			            <div class="form-group"  >
							<label class="col-sm-3 control-label no-padding-right" id="specsName" for="form-field-1"></label>
							<input type="hidden" readonly class="form-control" id="templateId" name="templateId">
							<div class="col-sm-6">
								<div class="input-group" id="specsTemplate">
				                </div>
							</div>
						</div>
		            </div>
				</div>
			</div>
			<div class="col-md-12">
	        	<div class="box box-info">
	        		<div class="box-header with-border">
						<div class="box-header with-border">
			            	<h5 class="box-title">新增明细信息</h5>
			            	<div class="box-tools pull-right">
			                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			              	</div>
			            </div>
					</div>
		            <div class="box-body">
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">商家</label>
							<div class="col-sm-6">
								<div class="input-group">
									<c:choose>
										<c:when test="${third!=null}">
											<div class="input-group-addon">
							                    <i class="fa fa-pencil"></i>
							                </div>
				                  			<input type="hidden" class="form-control" name="supplierId" value="${third.supplierId}">
				                  			<input type="hidden" class="form-control" name="type" value="sync">
				                  			<input type="hidden" class="form-control" name="thirdId" value="${third.id}">
				                  			<input type="text" readonly class="form-control" name="supplierName" value="${third.supplierName}">
										</c:when>
										<c:otherwise>
											<select class="form-control" name="supplierId" id="supplierId" style="width: 100%;">
						                   	  <option selected="selected" value="-1">未选择</option>
						                   	  <c:forEach var="supplier" items="${suppliers}">
						                   	  	<option value="${supplier.id}">${supplier.supplierName}</option>
						                   	  </c:forEach>
							                </select>
							               <input type="hidden" class="form-control" name="supplierName" id="supplierName"/>
							               <input type="hidden" class="form-control" name="type" value="normal">
										</c:otherwise>
									</c:choose>
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">商家编码(itemCode)</label>
							<div class="col-sm-6">
								<div class="input-group">
				                  	<div class="input-group-addon">
				                    	<i class="fa fa-pencil"></i>
				                  	</div>
				                  	<c:choose>
					                  	<c:when test="${third != null}">
			                  				<input type="text" class="form-control" name="itemCode" value="${third.itemCode}">
									  	</c:when>
										<c:otherwise>
				                  			<input type="text" class="form-control" name="itemCode">
										</c:otherwise>
									</c:choose>
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">货号(sku)</label>
							<div class="col-sm-6">
								<div class="input-group">
				                  	<div class="input-group-addon">
				                    	<i class="fa fa-pencil"></i>
				                  	</div>
				                  	<c:choose>
					                  	<c:when test="${third != null}">
			                  				<input type="text" class="form-control" name="sku" value="${third.sku}">
									  	</c:when>
										<c:otherwise>
			                  				<input type="text" class="form-control" name="sku">
										</c:otherwise>
									</c:choose>
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">商品名称</label>
							<div class="col-sm-6">
								<div class="input-group">
				                  	<div class="input-group-addon">
				                    	<i class="fa fa-pencil"></i>
				                  	</div>
				                  	<c:choose>
					                  	<c:when test="${third != null}">
			                  				<input type="text" class="form-control" name="name" value="${third.goodsName}">
									  	</c:when>
										<c:otherwise>
			                  				<input type="text" class="form-control" name="name">
										</c:otherwise>
									</c:choose>
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">原产国</label>
							<div class="col-sm-6">
								<div class="input-group">
				                  	<div class="input-group-addon">
				                    	<i class="fa fa-pencil"></i>
				                  	</div>
				                  	<c:choose>
					                  	<c:when test="${third != null}">
			                  				<input type="text" class="form-control" name="origin" value="${third.origin}">
									  	</c:when>
										<c:otherwise>
			                  				<input type="text" class="form-control" name="origin">
										</c:otherwise>
									</c:choose>
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">重量</label>
							<div class="col-sm-6">
								<div class="input-group">
				                  	<div class="input-group-addon">
				                    	<i class="fa fa-pencil"></i>
				                  	</div>
				                  	<c:choose>
					                  	<c:when test="${third != null}">
			                  				<input type="text" class="form-control" name="weight" value="${third.weight}">
									  	</c:when>
										<c:otherwise>
			                  				<input type="text" class="form-control" name="weight">
										</c:otherwise>
									</c:choose>
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">成本价格</label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
		                  			<input type="text" class="form-control" name="proxyPrice">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">分销价</label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
		                  			<input type="text" class="form-control" name="fxPrice">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">消费税</label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
		                  			<input type="text" class="form-control" name="exciseFax">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">零售价</label>
							<div class="col-sm-6">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
		                  			<input type="text" class="form-control" name="retailPrice">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">最小限购数量</label>
							<div class="col-sm-2">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
				                  <c:choose>
					                  	<c:when test="${third != null}">
			                  				<input type="text" class="form-control" name="min" value="${third.min}">
									  	</c:when>
										<c:otherwise>
			                  				<input type="text" class="form-control" name="min">
										</c:otherwise>
									</c:choose>
				                </div>
							</div>
							<label class="col-sm-2 control-label no-padding-right">最大限购数量</label>
							<div class="col-sm-2">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-pencil"></i>
				                  </div>
		                  			<c:choose>
					                  	<c:when test="${third != null}">
			                  				<input type="text" class="form-control" name="max" value="${third.max}">
									  	</c:when>
										<c:otherwise>
			                  				<input type="text" class="form-control" name="max">
										</c:otherwise>
									</c:choose>
				                </div>
							</div>
						</div>
	            	</div>
          		</div>
			</div>
			<div class="col-md-12">
				<div class="col-lg-3 col-xs-3">
					<div class="sbox-body">
						<div class="form-group">
							<img src="" id="img1" width="120px" height="160px" alt="添加主图">
						</div>
						<div class="form-group">
							<div class="input-group">
								<input type="hidden" class="form-control" name="picPath" id="picPath1"> 
								<input type="file" name="pic" id="pic1" />
								<button type="button" class="btn btn-info" onclick="uploadFile(1)">上传</button>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-xs-3">
					<div class="sbox-body">
						<div class="form-group">
							<img src="" id="img2" width="120px" height="160px" alt="添加主图">
						</div>
						<div class="form-group">
							<div class="input-group">
								<input type="hidden" class="form-control" name="picPath" id="picPath2"> 
								<input type="file" name="pic" id="pic2" />
								<button type="button" class="btn btn-info" onclick="uploadFile(2)">上传</button>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-xs-3">
					<div class="sbox-body">
						<div class="form-group">
							<img src="" id="img3" width="120px" height="160px" alt="添加主图">
						</div>
						<div class="form-group">
							<div class="input-group">
								<input type="hidden" class="form-control" name="picPath" id="picPath3"> 
								<input type="file" name="pic" id="pic3" />
								<button type="button" class="btn btn-info" onclick="uploadFile(3)">上传</button>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-xs-3">
					<div class="sbox-body">
						<div class="form-group">
							<img src="" id="img4" width="120px" height="160px" alt="添加主图">
						</div>
						<div class="form-group">
							<div class="input-group">
								<input type="hidden" class="form-control" name="picPath" id="picPath4"> 
								<input type="file" name="pic" id="pic4" />
								<button type="button" class="btn btn-info" onclick="uploadFile(4)">上传</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-12">
	        	<div class="box box-error">
	        		<div class="box-header with-border">
						<div class="box-header with-border">
			            	<h5 class="box-title">商品详情编辑</h5>
			            	<div class="box-tools pull-right">
			                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			              	</div>
			            </div>
					</div>
					<div class="box-body pad">
						<textarea id="editor1" rows="10" cols="80">
                    	</textarea>
					</div>
				</div>
			</div>
			<div class="col-md-offset-1 col-md-9">
				<div class="form-group">
                     <button type="button" class="btn btn-primary" id="submitBtn">提交</button>
                 </div>
            </div>
		</form>
	</section>
</section>
	<script type="text/javascript" src="${wmsUrl}/js/ajaxfileupload.js"></script>
	<script type="text/javascript">
	 $(function () {
	     CKEDITOR.replace('editor1');
	     $(".textarea").wysihtml5();
	 });
	 
	 
	 function uploadFile(id) {
			$.ajaxFileUpload({
				url : '${wmsUrl}/admin/uploadFile.shtml', //你处理上传文件的服务端
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
	 
	 function refresh(){
			parent.location.reload();
	 }
	 
	 $("#supplierId").change(function(){
			$("#supplierName").val($("#supplierId").find("option:selected").text());
	});
	 
	 $("#submitBtn").click(function(){
		 $('#itemForm').data("bootstrapValidator").validate();
		 if($('#itemForm').data("bootstrapValidator").isValid()){
			 
			 var url = "${wmsUrl}/admin/goods/goodsMng/save.shtml";
			 var templateId = $("#templateId").val();
			 
			 var formData = sy.serializeObject($('#itemForm'));
			 
			 var newFormData;
			 if(templateId!= null && templateId!=""){
				 var key = "";
				 var value = "";
				 
				 newFormData={};
				 for(var json in formData){
					 if(json.indexOf(":")!=-1){
						 key +=json+";"
						 value += formData[json]+";"
					 }else{
						 newFormData[json] = formData[json];
					 }
				}
				 
				 if(key == ""||value == ""){
					 layer.alert("没选择规格信息！");
					 return;
				 }
				 
				 newFormData["keys"] = key;
				 newFormData["values"] = value;
			 }else{
				 newFormData = formData;
			 }
		
			 $.ajax({
				 url:url,
				 type:'post',
				 data:JSON.stringify(newFormData),
				 contentType: "application/json; charset=utf-8",
				 dataType:'json',
				 success:function(data){
					 if(data.success){
						 refresh();
						 layer.alert("插入成功");
						 
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
	 
		function showBaseGoods(){
			var index = layer.open({
				  title:"查看基础商品",	
				  area: ['70%', '80%'],
				  type: 2,
				  content: '${wmsUrl}/admin/goods/baseMng/listForAdd.shtml',
				  maxmin: true
				});
		}
		
		function showSpaceGoods(){
			var index = layer.open({
				  title:"查看基础商品",	
				  area: ['70%', '80%'],
				  type: 2,
				  content: '${wmsUrl}/admin/goods/specsMng/listForAdd.shtml',
				  maxmin: true
				});
		}
		
		function createSpecs(id){
			 $.ajax({
				 url:"${wmsUrl}/admin/goods/specsMng/queryById.shtml?id="+id,
				 type:'post',
				 contentType: "application/json; charset=utf-8",
				 dataType:'json',
				 success:function(data){
					 if(data.id == null){
						 layer.alert("同步模板失败！");
					 }else{
						 $("#specsName").html("");
						 $("#specsTemplate").html("");
						 $("#specsName").html(data.name);
						 var specs = data.specs;
						 
						 for(var i = 0 ;i<specs.length;i++){
							 var spec = specs[i];
							 var label = $("<label></label");
							 label.addClass="col-sm-12 control-label no-padding-right";
							 label.append(spec.name+": ");
							 $("#specsTemplate").append(label);
							 $("#templateId").val(data.id);
							 
							 var values = spec.values;
							 var radio;
							 for(var j =0;j<values.length;j++){
								 radio = document.createElement("input");
								 radio.setAttribute("type","radio");
								 radio.setAttribute("name",spec.id+":"+spec.name);
								 radio.setAttribute("value", values[j].id+":"+values[j].value);
								 $("#specsTemplate").append(radio);
								 $("#specsTemplate").append(values[j].value+" ");
							 }
							 $("#specsTemplate").append("<br/>");
						 }
						
						 $("#specsInfo").show();
					 }
					 
				 },
				 error:function(){
					 layer.alert("提交失败，请联系客服处理");
				 }
			 });
		}
		
		$('#itemForm').bootstrapValidator({
		//   live: 'disabled',
		   message: 'This value is not valid',
		   feedbackIcons: {
		       valid: 'glyphicon glyphicon-ok',
		       invalid: 'glyphicon glyphicon-remove',
		       validating: 'glyphicon glyphicon-refresh'
		   },
		   fields: {
			   baseId: {
			 		trigger:"change",
		          	message: '基础商品未添加',
		          	validators: {
			               notEmpty: {
			                   message: '基础商品未添加！'
			               }
			           }
			   	  },
		 	  origin: {
		 		trigger:"change",
	          	message: '国家不正确',
	          	validators: {
		               notEmpty: {
		                   message: '国家不能为空！'
		               }
		           }
		   	  },
			  itemCode: {
				   trigger:"change",
		           message: '商家编码不正确',
		           validators: {
		               notEmpty: {
		                   message: '商家编码不能为空！'
		               }
		           }
		   	  },
			  goodsName: {
				    trigger:"change",
			        message: '商品名称不正确',
			        validators: {
			            notEmpty: {
			                message: '商品名称不能为空！'
			            }
			        }
			  },
		   	 weight: {
		   		trigger:"change",
		        message: '重量不正确',
		        validators: {
		            notEmpty: {
		                message: '重量不能为空！'
		            },
				   regexp: {
	                   regexp: /^\d+(\.\d+)?$/,
	                   message: '消费税格式有误'
	               }
		        }
	   		},
		   proxyPrice:{
			   trigger:"change",
			   message:"成本价格有误",
			   validators: {
				   notEmpty: {
                          message: '成本价格不能为空'
                      },
				   regexp: {
	                   regexp: /^\d+(\.\d+)?$/,
	                   message: '成本价格格式有误'
	               }
		   		}
		   },
		   fxPrice:{
			   trigger:"change",
			   message:"分销价格有误",
			   validators: {
				   regexp: {
	                   regexp: /^\d+(\.\d+)?$/,
	                   message: '成本价格格式有误'
	               }
			   }
		   },
		   retailPrice:{
			   message: '零售价有误',
			   validators: {
				   notEmpty: {
                       message: '零售价不能为空'
                   },
				   regexp: {
	                   regexp: /^\d+(\.\d+)?$/,
	                   message: '消费税格式有误'
	               }
			   }
		   },
		   exciseFax:{
			   message: '消费税有无',
			   validators: {
				   notEmpty: {
                       message: '消费税不能为空'
                   },
				   regexp: {
	                   regexp: /^\d+(\.\d+)?$/,
	                   message: '消费税格式有误'
	               }
			   }
		   },
		   min:{
			   message: '最小限购数量有误',
			   validators: {
				   regexp: {
	                   regexp: /^\d+(\.\d+)?$/,
	                   message: '最小限购数量格式有误'
	               }
			   }
		   },
		   max:{
			   message: '最大限购数量有误',
			   validators: {
				   regexp: {
	                   regexp: /^\d+(\.\d+)?$/,
	                   message: '最大限购数量格式有误'
	               }
			   }
		   }
		}});
		
		
		function toList(){
				$("#list",window.parent.document).trigger("click");
		}
	</script>
</body>
</html>
