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
<%@include file="../resourceLink.jsp"%>
</head>
<body>
<section class="content-wrapper query">
	<section class="content-header">
	      <ol class="breadcrumb">
	        <li>物流管理</li>
	        <li class="active">运费模板</li>
	      </ol>
	      <div class="search">
	      	<input type="text" name="templateName" placeholder="请输入模板名称">
	      	<div class="searchBtn"><i class="fa fa-search fa-fw"></i></div>
	      	<div class="moreSearchBtn">高级搜索</div>
		  </div>
    </section>	
	<section class="content">
		<div class="moreSearchContent">
			<div class="row form-horizontal list-content">
				<div class="col-xs-3">
					<div class="searchItem">
			           <input type="text" class="form-control" name="templateName" placeholder="请输入模板名称">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
			            <select class="form-control" name="supplierId" id="supplierId">
		                	<option selected="selected" value="">---供应商---</option>
		                	<c:forEach var="supplier" items="${supplier}">
			                <option value="${supplier.id}">${supplier.supplierName}</option>
			                </c:forEach>
			            </select>
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
			            <select class="form-control" name="enable" id="enable">
		                	<option selected="selected" value="">全部状态</option>
		                	<option value="0">未使用</option>
		                	<option value="1">使用中</option>
			            </select>
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchBtns">
						 <div class="lessSearchBtn">简易搜索</div>
                         <button type="button" class="query" id="querybtns" name="signup">提交</button>
                         <button type="button" class="clear">清除选项</button>
                    </div>
                </div>
            </div>
		</div>
		<div class="list-content">
			<div class="row">
				<div class="col-md-10 list-btns">
					<button type="button" onclick="toEdit(-1)">新增模板</button>
				</div>
			</div>
			<div class="row content-container">
				<div class="col-md-12 container-right active">
					<table id="itemTable" class="table table-hover myClass">
						<thead>
							<tr>
								<th width="10%">供应商名称</th>
								<th width="20%">模板名称</th>
								<th width="10%">是否包邮</th>
								<th width="10%">是否包税</th>
								<th width="20%">模板规则</th>
								<th width="10%">是否使用</th>
								<th width="20%">操作</th>
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
	
<%@include file="../resourceScript.jsp"%>
<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
<script type="text/javascript">


/**
 * 初始化分页信息
 */
var options = {
	queryForm : ".query",
	url :  "${wmsUrl}/admin/expressMng/dataList.shtml",
	numPerPage:"10",
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
	$("#itemTable tbody").html("");

	if (data == null || data.length == 0) {
		return;
	}
	
	var list = data.obj;
	var str = "";
	
	if (list == null || list.length == 0) {
		str = "<tr style='text-align:center'><td colspan=7><h4>没有查到数据</h4></td></tr>";
		$("#itemTable tbody").html(str);
		return;
	}

	for (var i = 0; i < list.length; i++) {
		str += "<tr>";
		str += "<td>" + list[i].supplierName;
		str += "</td><td>" + list[i].templateName;
		var freePost = list[i].freePost;
		switch(freePost){
			case 0:str += "</td><td>不包邮";break;
			case 1:str += "</td><td>包邮";break;
			default:str += "</td><td>未知："+freePost;
		}
		var freeTax = list[i].freeTax;
		switch(freeTax){
			case 0:str += "</td><td>不包税";break;
			case 1:str += "</td><td>包税";break;
			default:str += "</td><td>未知："+freeTax;
		}
		str += "</td><td>" + (list[i].ruleName == null || list[i].ruleName == '' ? "无" : list[i].ruleName);
		var status = list[i].enable;
		switch(status){
			case 0:str += "</td><td>停用";break;
			case 1:str += "</td><td>使用中";break;
			default:str += "</td><td>未知："+status;
		}
		str += "</td><td>";
		if (status == 0) {
			str += "<a href='javascript:void(0);' onclick='enable("+list[i].id+")' >启用</a>&nbsp;&nbsp;";
		} 
		str += "<a href='javascript:void(0);' onclick='toEdit("+list[i].id+")' >编辑</a>";
		str += "</td></tr>";
	}
	$("#itemTable tbody").html(str);
}

function enable(id){
	$.ajax({
		 url:"${wmsUrl}/admin/expressMng/enable.shtml?id="+id,
		 type:'post',
		 contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 success:function(data){
			 if(data.success){	
				 layer.alert("设置成功");
				 reloadTable();
			 }else{
				 layer.alert(data.msg);
			 }
		 },
		 error:function(){
			 layer.alert("设置失败，请联系客服处理");
		 }
	 });
}

function toEdit(id){
	var path = '${wmsUrl}/admin/expressMng/toEdit.shtml';
	if("-1" != id){
		path += '?id=';
		path += id;
	}
	var index = layer.open({
		  title:"运费设置",		
		  type: 2,
		  content: path,
		  maxmin: false
		});
		layer.full(index);
}
</script>
</body>
</html>
