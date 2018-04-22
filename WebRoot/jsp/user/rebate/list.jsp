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
	<section class="content-wrapper query content-iframe">
		<section class="content-header">
		      <ol class="breadcrumb">
		        <li><a href="javascript:void(0);">财务管理</a></li>
		        <li class="active">返佣查看</li>
		      </ol>
		      <div class="search">
		      	<input type="text"  name="gradeName" id="gradeName" readonly style="background:#fff;width:200px;" placeholder="选择分级" value = "${list[0].name}">
				<input type="hidden" class="form-control" name="gradeId" id="gradeId" value = "${list[0].id}">
		      	<div class="searchBtn" ><i class="fa fa-search fa-fw" id="querybtns"></i></div>
			  </div>
	    </section>
		 <div class="select-content">
            <ul class="first-ul" style="margin-left:10px;">
           		<c:forEach var="menu" items="${list}">
           			<c:set var="menu" value="${menu}" scope="request" />
           			<%@include file="recursive.jsp"%>  
				</c:forEach>
           	</ul>
       	</div>
        <div class="main-content">
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
				                    <i class="glyphicon glyphicon-user"></i>
				                  </div>
		                  			<input type="text" readonly class="form-control" name="gradeName_1" id = "gradeName_1" value="" style="background:#fff;">
				                </div>
							</div>
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">可提现金额</label>
							<div class="col-sm-3">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-cny fa-fw"></i>
				                  </div>
				                  <input type="text" readonly class="form-control" name="canBePresented" id = "canBePresented" value="" style="background:#fff;">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">已提现金额</label>
							<div class="col-sm-3">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-cny fa-fw"></i>
				                  </div>
				                  <input type="text" readonly class="form-control" name="alreadyPresented" id = "alreadyPresented" value="" style="background:#fff;">
				                </div>
							</div>
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">待到账金额</label>
							<div class="col-sm-3">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-cny fa-fw"></i>
				                  </div>
				                  <input type="text" readonly class="form-control" name="stayToAccount" id = "stayToAccount" value="" style="background:#fff;">
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
	<script src="${wmsUrl}/js/jquery.picker.min.js"></script>
	<%@include file="../../resourceScript.jsp"%>
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
		var gradeName = $("#gradeName").val();
		$("#gradeName_1").val(gradeName);
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
	$('#gradeName').click(function(){
		$('.select-content').css('width',$(this).outerWidth());
		$('.select-content').css('left',$(this).offset().left);
		$('.select-content').css('top',$(this).offset().top + $(this).height());
		$('.select-content').stop();
		$('.select-content').slideDown(300);
	});
	
	//点击空白隐藏下拉列表
	$('html').click(function(event){
		var el = event.target || event.srcelement;
		if(!$(el).parents('.select-content').length > 0 && $(el).attr('id') != "gradeName"){
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
			$('#gradeName').val(name);
			$('#gradeId').val(id);
			$('.select-content').stop();
			$('.select-content').slideUp(300);
		}
	});
	</script>
</body>
</html>
