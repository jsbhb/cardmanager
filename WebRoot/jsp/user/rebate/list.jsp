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
        <div class="box box-info">
			<div class="box-header with-border">
				<div class="box-header with-border">
	            	<h5 class="box-title">搜索</h5>
	            	<div class="box-tools pull-right">
	                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
	              	</div>
	            </div>
			</div>
		    <div class="box-body">
				<div class="row form-horizontal query">
					<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">分级名称</label>
							<div class="col-sm-2">
								<div class="input-group">
									 <select class="form-control" name="gradeId" id="gradeId" style="width: 100%;">
				                   	  <c:forEach var="grade" items="${list}">
		                   	  			<option value="${grade.id}">${grade.name}</option>
				                   	  </c:forEach>
					                </select>
				                </div>
							</div>
						</div>
						<div class="col-md-offset-10 col-md-12">
	                        <div class="form-group">
                                <button type="button" class="btn btn-primary" id="querybtns">提交</button>
                        	</div>
                	</div>
				</div>
			</div>
		</div>
			<div class="row">
				<div class="col-xs-12" >
					<form class="form-horizontal" role="form" id="gradeForm" >
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"><h4>返佣明细</h4></label>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">分级名称</label>
							<div class="col-sm-3">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-user-o"></i>
				                  </div>
		                  			<input type="text" readonly class="form-control" name="gradeName" id = "gradeName" value="">
				                </div>
							</div>
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">可提现金额</label>
							<div class="col-sm-3">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-address-book"></i>
				                  </div>
				                  <input type="text" readonly class="form-control" name="canBePresented" id = "canBePresented" value="">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">已提现金额</label>
							<div class="col-sm-3">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-address-book"></i>
				                  </div>
				                  <input type="text" readonly class="form-control" name="alreadyPresented" id = "alreadyPresented" value="">
				                </div>
							</div>
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">待到账金额</label>
							<div class="col-sm-3">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-address-book"></i>
				                  </div>
				                  <input type="text" readonly class="form-control" name="stayToAccount" id = "stayToAccount" value="">
				                </div>
							</div>
						</div>
                       <div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"><h4>明细列表</h4></label>
						</div>
						<div class="form-group">
							<label class="col-sm-1 control-label no-padding-right" for="form-field-1"></label>
							<div class="col-sm-10">
							<div class="box box-warning">
									<table id="staffTable" class="table table-hover">
										<thead>
											<tr>
												<th>订单号</th>
												<th>返佣金额</th>
												<th>完成时间</th>
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
				url :  "${wmsUrl}/admin/user/rebateMng/dataList.shtml",
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

	/**
	 * 重构table
	 */
	function rebuildTable(data){
		$("#staffTable tbody").html("");

		if (data == null || data.length == 0) {
			return;
		}
		
		var list = data.obj;
		
		var rebate = data.object;
		var gradeName = $("#gradeId").find("option:selected").text();
		$("#gradeName").val(gradeName);
		if(rebate != null){
			$("#canBePresented").val(rebate.canBePresented == null ? 0 : rebate.canBePresented);
			$("#alreadyPresented").val(rebate.alreadyPresented == null ? 0 : rebate.alreadyPresented);
			$("#stayToAccount").val(rebate.stayToAccount == null ? 0 : rebate.stayToAccount);
		} else {
			$("#canBePresented").val(0);
			$("#alreadyPresented").val(0);
			$("#stayToAccount").val(0);
		}
		
		if (list == null || list.length == 0) {
			layer.alert("没有查到数据");
			return;
		}

		var str = "";
		for (var i = 0; i < list.length; i++) {
			str += "<tr>";
			str += "<td>" + list[i].orderId;
			str += "</td><td>" + list[i].rebateMoney;
			str += "</td><td>" + list[i].createTime;
			str += "</td></tr>";
		}

		$("#staffTable tbody").html(str);
	 }
	</script>
</body>
</html>
