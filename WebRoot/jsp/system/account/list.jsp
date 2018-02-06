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
<script src="${wmsUrl}/js/pagination.js"></script>

</head>
<body>
<section class="content-wrapper">
	<section class="content-header">
	      <h1><i class="fa fa-street-view"></i>账号管理</h1>
	      <ol class="breadcrumb">
	        <li><a href="#"><i class="fa fa-dashboard"></i> 首页</a></li>
	        <li class="active">账号管理</li>
	      </ol>
    </section>	
	<section class="content">
		<div class="box box-warning">
			<div class="box-header">
				<div class="row form-horizontal">
				</div>
			</div>
			<div class="box-body">
				<div class="row">
					<div class="col-md-12">
						<div class="panel panel-default">
							<table id="staffTable" class="table table-hover">
								<thead>
									<tr>
										<th>badge</th>
										<th>名称</th>
										<th>分级机构</th>
										<th>登录账号</th>
										<th>订货平台状态</th>
										<th>微店平台状态</th>
										<th>创建时间</th>
										<th>更新时间</th>
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
	
	<%@ include file="../../footer.jsp"%>
	
<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
<script type="text/javascript">

/**
 * 初始化分页信息
 */
var options = {
			queryForm : ".query",
			url :  "${wmsUrl}/admin/system/accountMng/dataList.shtml",
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
	
	if (list == null || list.length == 0) {
		layer.alert("没有查到数据");
		return;
	}

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
		str += "</td><td>" + (list[i].phone == null ? "" : list[i].phone);

		var status = list[i].status;
		var tbFlg = list[i].tbFlg;
		var tsFlg = list[i].tsFlg;
		var roleId = list[i].roleId;
		//未开通订货账号
		if(tbFlg == 0){
			//分级是区域中心管理员或门店管理员
			if (roleId == 2 || roleId == 3) {
				//账号状态是已同步
				if(status == 1){
					str += "</td><td>待开通" ;
					str += "<a href='#' onclick='sync2B("+list[i].userCenterId+")'><i class='fa  fa-refresh' style='font-size:20px;margin-left:5px'></i></a>";
				} else {
					str += "</td><td>待开通" ;
				}
			} else {
				str += "</td><td>待开通" ;
			}
		}else if(tbFlg == 1){
			str += "</td><td>已开通" ;
		}
		//未开通微店账号
		if(tsFlg == 0){
			//分级是区域中心管理员或门店管理员
			//if (roleId == 2 || roleId == 3) {
			if (roleId == 3) {
				//账号状态是已同步
				if(status == 1){
					str += "</td><td>待开通" ;
					str += "<a href='#' onclick='sync2S("+list[i].userCenterId+")'><i class='fa  fa-refresh' style='font-size:20px;margin-left:5px'></i></a>";
				} else {
					str += "</td><td>待开通" ;
				}
			} else {
				str += "</td><td>待开通" ;
			}
		}else if(tsFlg == 1){
			str += "</td><td>已开通" ;
		}

		str += "</td><td>" + (list[i].createTime == null ? "" : list[i].createTime);
		if(list[i].updateTime == null){
			str += "</td><td>无";
		}else{
			str += "</td><td>" + list[i].updateTime;
		}
		str += "</td></tr>";
	}

	$("#staffTable tbody").html(str);
}

function sync2S(id){
	if(id == 0 || id == null){
		layer.alert("信息不全，请联系技术人员！");
		return;
	}
	$.ajax({
		 url:"${wmsUrl}/admin/system/accountMng/sync2S.shtml?optid="+id,
		 type:'post',
	     contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 success:function(data){
			 layer.closeAll();
			 if(data.success){	
				 reloadTable();
			 }else{
				  layer.alert(data.msg);
			 }
		 },
		 error:function(){
			 layer.closeAll();
			 layer.alert("系统出现问题啦，快叫技术人员处理");
		 }
	 });
}

function sync2B(id){
	if(id == 0 || id == null){
		layer.alert("信息不全，请联系技术人员！");
		return;
	}
	$.ajax({
		 url:"${wmsUrl}/admin/system/accountMng/sync2B.shtml?optid="+id,
		 type:'post',
	     contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 success:function(data){
			 layer.closeAll();
			 if(data.success){	
				 reloadTable();
			 }else{
				  layer.alert(data.msg);
			 }
		 },
		 error:function(){
			 layer.closeAll();
			 layer.alert("系统出现问题啦，快叫技术人员处理");
		 }
	 });
}
</script>
</body>
</html>
