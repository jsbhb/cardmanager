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
	      <h1><i class="fa fa-street-view"></i>员工管理</h1>
	      <ol class="breadcrumb">
	        <li><a href="#"><i class="fa fa-dashboard"></i> 首页</a></li>
	        <li class="active">员工管理</li>
	      </ol>
    </section>	
	<section class="content">
		<div class="box box-warning">
			<div class="box-header">
				<div class="row form-horizontal"><!--
					<div class="col-xs-4">
						<div class="form-group">
							<label class="col-sm-4 control-label no-padding-right" for="form-field-1">badge </label>
							<div class="col-sm-8">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-user-o"></i>
				                  </div>
		                  			<input type="text" class="form-control" name="badge">
				                </div>
							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label class="col-sm-4 control-label no-padding-right" for="form-field-1">名称</label>
							<div class="col-sm-8">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-phone"></i>
				                  </div>
				                  <input type="text" class="form-control" name="phone">
				                </div>
							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label class="col-sm-4 control-label no-padding-right" for="form-field-1">角色</label>
							<div class="col-sm-8">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-address-book"></i>
				                  </div>
				                  <input type="text" class="form-control" name="roleName">
				                </div>
							</div>
						</div>
					</div>
					<div class="col-md-offset-10 col-md-12">
						<div class="form-group">
                                <button type="submit" class="btn btn-primary" id="submitBtn" name="signup">提交</button>
                                <button type="button" class="btn btn-info" id="resetBtn">重置</button>
                        </div>
                     </div> -->
				</div>
			</div>
			<div class="box-body">
				<div class="row">
					<div class="col-md-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">
								<button type="button" onclick="toAdd()" class="btn btn-primary">新增员工</button>
								</h3>
							</div>
							<table id="staffTable" class="table table-hover">
								<thead>
									<tr>
										<th>badge</th>
										<th>名称</th>
										<th>状态</th>
										<th>分级机构</th>
										<th>用户中心编号</th>
										<th>角色</th>
										<th>订货账号状态</th>
										<th>订货账号</th>
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
			url :  "${wmsUrl}/admin/system/staffMng/dataList.shtml",
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
		
		var status = list[i].status;
		
		str += "<td>" + list[i].badge;
		str += "<td>" + list[i].optName;
		
		if(status == 2){
			str += "</td><td>待同步" ;
			str += "<a href='#' onclick='sync("+list[i].optid+")'><i class='fa  fa-refresh' style='font-size:20px;margin-left:5px'></i></a>";
		}else if(status == 1){
			str += "</td><td>已同步" ;
		}else{
			str += "</td><td>error" ;
		}
		
		str += "</td><td>" + list[i].gradeName;
		str += "</td><td>" + list[i].userCenterId;
		str += "</td><td>" + list[i].roleName;
		
		var tbFlg = list[i].tbFlg;
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

		str += "</td><td>" + (list[i].phone == null ? "" : list[i].phone);
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
	
function toAdd(){
	
	var index = layer.open({
		  type: 2,
		  content: '${wmsUrl}/admin/system/staffMng/toAdd.shtml',
		  area: ['320px', '195px'],
		  maxmin: true
		});
		layer.full(index);
}
	
function toEdit(id){
	if(id == 0 || id == null){
		layer.alert("信息不全，请联系技术人员！");
		return;
	}
	
	var index = layer.open({
		  type: 2,
		  content: '${wmsUrl}/admin/system/staffMng/toEdit.shtml?optId='+id,
		  area: ['320px', '195px'],
		  maxmin: true
		});
		layer.full(index);
}

function sync(id){
	if(id == 0 || id == null){
		layer.alert("信息不全，请联系技术人员！");
		return;
	}
	
	layer.prompt({title: '输入该员工手机号', formType: 2}, function(phone, index){
		
		  $.ajax({
				 url:"${wmsUrl}/admin/system/staffMng/sync.shtml?phone="+phone+"&optid="+id,
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
		  
		});
}

function sync2B(id){
	if(id == 0 || id == null){
		layer.alert("信息不全，请联系技术人员！");
		return;
	}
	$.ajax({
		 url:"${wmsUrl}/admin/system/staffMng/sync2B.shtml?optid="+id,
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
