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
	<section class="content-header">
	      <ol class="breadcrumb">
	        <li><a href="javascript:void(0);">系统管理</a></li>
	        <li class="active">员工管理</li>
	      </ol>
    </section>
    <section class="content">
			 <div id="image" style="width:100%;height:100%;display: none;background:rgba(0,0,0,0.5);margin-left:-25px;margin-top:-62px;">
				<img alt="loading..." src="${wmsUrl}/img/loader.gif" style="position:fixed;top:50%;left:50%;margin-left:-16px;margin-top:-16px;" />
			</div>
			
			<div class="list-content">
				<div class="row">
					<div class="col-md-10 list-btns">
						<button type="button" onclick="toAdd()">新增员工</button>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<table id="baseTable" class="table table-hover myClass">
							<thead>
								<tr>
									<th>badge</th>
									<th>名称</th>
									<th>状态</th>
									<th>分级机构</th>
									<th>用户中心编号</th>
									<th>角色</th>
									<th>创建时间</th>
									<th>更新时间</th>
									<th>操作</th>
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
		</section>
	</section>
	
<%@include file="../../resourceScript.jsp"%>
<script src="${wmsUrl}/js/pagination.js"></script>
<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
<script type="text/javascript">

/**
 * 初始化分页信息
 */
var options = {
			queryForm : ".query",
			url :  "${wmsUrl}/admin/system/staffMng/dataList.shtml",
			numPerPage:"10",
			currentPage:"",
			index:"1",
			callback:rebuildTable
}


$(function(){
	 $(".pagination-nav").pagination(options);
	 var top = getTopWindow();
		$('.breadcrumb').on('click','a',function(){
			top.location.reload();
		});
})


function reloadTable(){
	$.page.loadData(options);
}


/**
 * 重构table
 */
function rebuildTable(data){
	$("#baseTable tbody").html("");

	if (data == null || data.length == 0) {
		return;
	}
	
	var list = data.obj;
	var str = "";
	
	if (list == null || list.length == 0) {
		str = "<tr style='text-align:center'><td colspan=8><h5>没有查到数据</h5></td></tr>";
		$("#baseTable tbody").html(str);
		return;
	}

	for (var i = 0; i < list.length; i++) {
		str += "<tr>";
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
		
// 		var tbFlg = list[i].tbFlg;
// 		var roleId = list[i].roleId;
// 		//未开通订货账号
// 		if(tbFlg == 0){
// 			//分级是区域中心管理员或门店管理员
// 			if (roleId == 2 || roleId == 3) {
// 				//账号状态是已同步
// 				if(status == 1){
// 					str += "</td><td>待开通" ;
// 					str += "<a href='#' onclick='sync2B("+list[i].userCenterId+")'><i class='fa  fa-refresh' style='font-size:20px;margin-left:5px'></i></a>";
// 				} else {
// 					str += "</td><td>待开通" ;
// 				}
// 			} else {
// 				str += "</td><td>待开通" ;
// 			}
// 		}else if(tbFlg == 1){
// 			str += "</td><td>已开通" ;
// 		}

// 		str += "</td><td>" + (list[i].phone == null ? "" : list[i].phone);
		str += "</td><td>" + (list[i].createTime == null ? "" : list[i].createTime);
		if(list[i].updateTime == null){
			str += "</td><td>无";
		}else{
			str += "</td><td>" + list[i].updateTime;
		}
		str += "<td><a href='javascript:void(0);' onclick='reSetPwd("+list[i].optid+")'>重置密码</a>";
// 		str += "<a href='#' onclick='toEdit("+list[i].optid+")'><i class='fa fa-pencil' style='font-size:20px'></i></a>";
		str += "</td></tr>";
	}

	$("#baseTable tbody").html(str);
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

function reSetPwd(id){
	if(id == 0 || id == null){
		layer.alert("信息不全，请联系技术人员！");
		return;
	}
	
	layer.confirm('确定要重置该员工的密码吗？', {
	  btn: ['确认重置','取消'] //按钮
	}, function(){
		$.ajax({
			 url:"${wmsUrl}/admin/system/staffMng/reSetOpeartorPwd.shtml?optid="+id,
			 type:'post',
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){
					 location.reload();
				 }else{
					layer.alert(data.msg);
					return;
				 }
			 },
			 error:function(){
				 layer.alert("重置员工密码失败，请重试！");
				 return;
			 }
		});
	}, function(){
	  layer.close();
	});
}

</script>
</body>
</html>
