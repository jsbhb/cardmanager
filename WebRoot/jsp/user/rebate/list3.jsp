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
<%@include file="../../resourceLink.jsp"%>
</head>

<body>
<section class="content-wrapper">
	<section class="content">
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
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">区域中心</label>
							<div class="col-sm-2">
								<div class="input-group">
									 <select class="form-control" name="firstCatalogId" id="firstCatalogId" style="width: 100%;">
				                   	  <option value="">全选择</option>
				                   	  <c:forEach var="center" items="${centerId}">
		                   	  			<option value="${center.gradeId}">${center.gradeName}</option>
				                   	  </c:forEach>
					                </select>
				                </div>
							</div>
							<label class="col-sm-1 control-label no-padding-right" for="form-field-1">所属店铺</label>
							<div class="col-sm-2">
								<div class="input-group">
									 <select class="form-control" name="secondCatalogId" id="secondCatalogId" style="width: 100%;">
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
		
	
		<div class="box box-warning">
			<div class="box-body">
				<div class="row">
					<div class="col-md-12">
						<div class="panel panel-default">
							<table id="rebateRecordTable" class="table table-hover">
								<thead>
									<tr>
										<th>返佣名称</th>
										<th>可提现金额</th>
										<th>已提现金额</th>
										<th>待到账金额</th>
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
			</div>
		</div>	
	</section>
	</section>
	
<!-- 	<section class="content"> -->
<!--         <div class="main-content"> -->
<!-- 			<div class="row"> -->
<!-- 				<div class="col-xs-12" > -->
<!-- 					<form class="form-horizontal" role="form" id="baseForm" > -->
<!-- 						<div class="form-group"> -->
<!-- 							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"><h4>返佣明细</h4></label> -->
<!-- 						</div> -->
<!-- 						<div class="form-group"> -->
<!-- 							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">区域中心</label> -->
<!-- 							<div class="col-sm-2"> -->
<!-- 								<div class="input-group"> -->
<!-- 									 <select class="form-control" name="firstCatalogId" id="firstCatalogId" style="width: 100%;"> -->
<!-- 				                   	  <option value="">全选择</option> -->
<%-- 				                   	  <c:forEach var="center" items="${centerId}"> --%>
<%-- 		                   	  			<option value="${center.gradeId}">${center.gradeName}</option> --%>
<%-- 				                   	  </c:forEach> --%>
<!-- 					                </select> -->
<!-- 				                </div> -->
<!-- 							</div> -->
<!-- 							<label class="col-sm-1 control-label no-padding-right" for="form-field-1">所属店铺</label> -->
<!-- 							<div class="col-sm-2"> -->
<!-- 								<div class="input-group"> -->
<!-- 									 <select class="form-control" name="secondCatalogId" id="secondCatalogId" style="width: 100%;"> -->
<!-- 					                </select> -->
<!-- 				                </div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="col-md-offset-3 col-md-9"> -->
<!-- 	                        <div class="form-group"> -->
<!--                                 <button type="button" class="btn btn-primary" id="querybtns">提交</button> -->
<!--                         	</div> -->
<!--                        </div> -->
<!--                        <div class="form-group"> -->
<!-- 							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"><h4>明细列表</h4></label> -->
<!-- 						</div> -->
<!-- 						<div class="form-group"> -->
<!-- 							<label class="col-sm-1 control-label no-padding-right" for="form-field-1"></label> -->
<!-- 							<div class="col-sm-10"> -->
<!-- 								<div class="box box-warning"> -->
<!-- 									<table id="rebateRecordTable" class="table table-hover"> -->
<!-- 										<thead> -->
<!-- 											<tr> -->
<!-- 												<th>返佣名称</th> -->
<!-- 												<th>可提现金额</th> -->
<!-- 												<th>已提现金额</th> -->
<!-- 												<th>待到账金额</th> -->
<!-- 											</tr> -->
<!-- 										</thead> -->
<!-- 										<tbody> -->
<!-- 										</tbody> -->
<!-- 									</table> -->
<!-- 									<div class="pagination-nav"> -->
<!-- 										<ul id="pagination" class="pagination"> -->
<!-- 										</ul> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</form> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</section> -->
	<%@include file="../../resourceScript.jsp"%>
	<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
	<script type="text/javascript">	
	$("#firstCatalogId").change(function(){
		var firstId = $("#firstCatalogId").val();
		var secondSelect = $("#secondCatalogId");
		secondSelect.empty();
		if (firstId == "") {
			return;
		}
		$.ajax({
			 url:"${wmsUrl}/admin/user/rebateMng/querySecondCatalogByFirstId.shtml?firstId="+firstId,
			 type:'post',
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){
					 if (data == null || data.length == 0) {
							return;
						}
						
						var list = data.data;
						
						if (list == null || list.length == 0) {
							return;
						}
						var str = "";
						secondSelect.append("<option value='-1'>未选择</option>")
						secondSelect.append("<option value=''>全选择</option>")
						for (var i = 0; i < list.length; i++) {
							secondSelect.append("<option value='"+list[i].shopId+"'>"+list[i].gradeName+"</option>")
						}
				 }else{
					 layer.alert(data.msg);
				 }
			 },
			 error:function(){
				 layer.alert("提交失败，请联系客服处理");
			 }
		 });
	});
	

	/**
	 * 初始化分页信息
	 */
	var options = {
				queryForm : ".query",
				url :  "${wmsUrl}/admin/user/rebateMng/adminCheckDataList.shtml",
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
		$("#rebateRecordTable tbody").html("");

		if (data == null || data.length == 0) {
			return;
		}
		
		var list = data.obj;
		var str = "";
		
		if (list == null || list.length == 0) {
			str = "<tr style='text-align:center'><td colspan=4><h5>没有查到数据</h5></td></tr>";
			$("#rebateRecordTable tbody").html(str);
			return;
		}

		var optType = data.type;
		for (var i = 0; i < list.length; i++) {
			str += "<tr><td>";
			if (optType == "0") {
				var strCenterName = list[i].centerName;
				str += strCenterName;
			} else if (optType == "1") {
				var strShopName = list[i].shopName;
				str += strShopName;
			}
			str += "</td><td>" + (list[i].canBePresented == null ? "" : list[i].canBePresented);
			str += "</td><td>" + (list[i].alreadyPresented == null ? "" : list[i].alreadyPresented);
			str += "</td><td>" + (list[i].stayToAccount == null ? "" : list[i].stayToAccount);
			str += "</td></tr>";
		}
		$("#rebateRecordTable tbody").html(str);
	}
	
	</script>
</body>
</html>
