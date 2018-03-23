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
	      <h1><i class="fa fa-street-view"></i>绑定银行卡</h1>
	      <ol class="breadcrumb">
	        <li><a href="#"><i class="fa fa-dashboard"></i>个人中心</a></li>
	        <li class="active">绑定卡号</li>
	      </ol>
    </section>	
	<section class="content">
		<div class="box box-warning">
			<div class="box-body">
				<div class="row">
					<div class="col-md-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">
								<button type="button" onclick="toAdd()" class="btn btn-primary">新增银行卡</button>
								</h3>
							</div>
							<table id="cardTable" class="table table-hover">
								<thead>
									<tr>
										<th>银行卡号</th>
										<th>银行名称</th>
										<th>持卡人姓名</th>
										<th>预留电话</th>
										<th>修改</th>
										<th>解绑</th>
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
			url :  "${wmsUrl}/admin/user/userCardMng/dataList.shtml",
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
	$("#cardTable tbody").html("");

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
		str += "<td>" + list[i].cardNo;
		str += "</td><td>" + list[i].cardBank;
		str += "</td><td>" + list[i].cardName;
		str += "</td><td>" + list[i].cardMobile;
		str += "</td><td>" ;
		str += "<a href='#' onclick='toEdit("+list[i].id+")'><i class='fa  fa-pencil' style='font-size:20px;margin-left:5px'></i></a>";
		str += "</td><td>" ;
		str += "<button type='button' class='btn btn-danger' onclick='toDelete(\""+list[i].id+"\")' >解绑</button>";
		str += "</td></tr>";
	}

	$("#cardTable tbody").html(str);
}
	
function toAdd(){
	
	var index = layer.open({
		  type: 2,
		  content: '${wmsUrl}/admin/user/userCardMng/toAdd.shtml',
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
		  content: '${wmsUrl}/admin/user/userCardMng/toEdit.shtml?cardId='+id,
		  area: ['320px', '195px'],
		  maxmin: true
		});
		layer.full(index);
}
	
function toDelete(id){
	if(id == 0 || id == null){
		layer.alert("信息不全，请联系技术人员！");
		return;
	}
	
	var index = layer.open({
		  type: 2,
		  content: '${wmsUrl}/admin/user/userCardMng/toDelete.shtml?cardId='+id,
		  area: ['320px', '195px'],
		  maxmin: true
		});
		layer.full(index);
}
</script>
</body>
</html>
