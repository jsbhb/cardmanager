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
							<div class="col-sm-3">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-user-o"></i>
				                  </div>
		                  			<input type="text" readonly class="form-control" name="gradeName" value="${grade.gradeName}">
				                </div>
							</div>
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">公司名称<font style="color:red">*</font> </label>
							<div class="col-sm-3">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-address-book"></i>
				                  </div>
				                  <input type="text" readonly class="form-control" name="company" value="${grade.company}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">上级机构<font style="color:red">*</font> </label>
							<div class="col-sm-3">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-address-book"></i>
				                  </div>
				                  <input type="text" readonly class="form-control" name="parentGradeName" value="${grade.gradeName}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"><h4>业务信息</h4></label>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">业务类型<font style="color:red">*</font> </label>
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
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">负责人<font style="color:red">*</font> </label>
							<div class="col-sm-3">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-phone"></i>
				                  </div>
				                  <input type="text" readonly class="form-control" name="personInCharge" value="${grade.personInCharge}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">上级负责人<font style="color:red">*</font> </label>
							<div class="col-sm-3">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-address-book"></i>
				                  </div>
				                   <input type="text" readonly class="form-control" name="gradePersonInCharge" value="${grade.gradePersonInCharge}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"><h4>联系方式</h4></label>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">负责人电话<font style="color:red">*</font> </label>
							<div class="col-sm-3">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-phone"></i>
				                  </div>
				                  <input type="text" readonly class="form-control" name="phone" value="${grade.phone}">
				                </div>
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
	<script type="text/javascript">
	
	/**
	 * 初始化分页信息
	 */
	var options = {
				queryForm : ".query",
				url :  "${wmsUrl}/admin/system/staffMng/dataList.shtml?gradeId="+${grade.id},
				numPerPage:"20",
				currentPage:"",
				index:"1",
				callback:rebuildTable
	}


	$(function(){
		 $(".pagination-nav").pagination(options);
	})


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
					reloadTable();
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
              message: '名字不正确',
              validators: {
                  notEmpty: {
                      message: '用户名不能为空！'
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
	      address: {
	          message: '地址不能为空',
	          validators: {
	              notEmpty: {
	                  message: '地址不能为空！'
	              }
	          }
	  	  },
	  	gradePersonInCharge: {
	          message: '负责人不能为空',
	          validators: {
	              notEmpty: {
	                  message: '负责人不能为空！'
	              }
	          }
	  	  },
	  	phone: {
	          message: '电话不能为空',
	          validators: {
	              notEmpty: {
	                  message: '电话不能为空！'
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
	  	  }
      }
  });
	
	
	
	</script>
</body>
</html>
