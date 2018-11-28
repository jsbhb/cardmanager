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
<section class="content-wrapper">
	<section class="content-header">
	      <ol class="breadcrumb">
	        <li><a href="javascript:void(0);">供应商管理</a></li>
	        <li class="active">供应商列表</li>
	      </ol>
	      <div class="search">
	      	<input type="text" name="supplierName" placeholder="输入供应商名称" >
	      	<div class="searchBtn"><i class="fa fa-search fa-fw"></i></div>
	      	<div class="moreSearchBtn">高级搜索</div>
		  </div>
    </section>
	<section class="content content-iframe">
		<div id="image" style="width:100%;height:100%;display: none;background:rgba(0,0,0,0.5);margin-left:-25px;margin-top:-62px;">
			<img alt="loading..." src="${wmsUrl}/img/loader.gif" style="position:fixed;top:50%;left:50%;margin-left:-16px;margin-top:-16px;" />
		</div>
		<div class="moreSearchContent">
			<div class="row form-horizontal list-content">
				<div class="col-xs-3">
					<div class="searchItem">
						<input type="text" class="form-control" name="supplierName" placeholder="请输入供应商名称">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
						<input type="text" class="form-control" name="supplierCode" placeholder="请输入供应商代码">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
						<input type="text" class="form-control" name="country" placeholder="请输入公司名称">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
			            <select class="form-control" name="contractType" id="contractType">
	                   	  <option selected="selected" value="0">合同类型</option>
	                   	  <option value="1">一件代发</option>
	                   	  <option value="2">长期供货</option>
	                   	  <option value="3">框架合同</option>
	                   	  <option value="4">其他</option>
		                </select>
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
			            <select class="form-control" name="payType" id="payType">
	                   	  <option selected="selected" value="0">付款方式</option>
	                   	  <option value="1">预付款</option>
	                   	  <option value="2">现付</option>
	                   	  <option value="3">账期</option>
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
					<button type="button" onclick="toAdd()">新增供应商</button>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<table id="baseTable" class="table table-hover myClass">
						<thead>
							<tr>
								<th>供应商名称</th>
								<th>供应商代码</th>
								<th>公司名称</th>
								<th>地址</th>
								<th>合同类型</th>
								<th>付款方式</th>
								<th>采购负责人</th>
								<th>电话</th>
								<th>邮箱</th>
								<th>传真</th>
								<th>创建时间</th>
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
	
<%@include file="../resourceScript.jsp"%>
<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
<script type="text/javascript">


/**
 * 初始化分页信息
 */
var options = {
	queryForm : ".query",
	url :  "${wmsUrl}/admin/supplier/supplierMng/dataList.shtml",
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
		str = "<tr style='text-align:center'><td colspan=9><h5>没有查到数据</h5></td></tr>";
		$("#baseTable tbody").html(str);
		return;
	}

	for (var i = 0; i < list.length; i++) {
		str += "<tr><td>";
		str += list[i].supplierName;
		str += "</td><td>" + (list[i].supplierCode == null ? "" : list[i].supplierCode);
		str += "</td><td>" + (list[i].country == null ? "" : list[i].country);
		str += "</td><td>" + (list[i].province == null ? "" : list[i].province)+" "+(list[i].city == null ? "" : list[i].city)+" "+(list[i].area == null ? "" : list[i].area)+" "+(list[i].address == null ? "" : list[i].address);
		var contractType = list[i].contractType;
		switch (contractType) {
			case 1:str += "</td><td>一件代发";break;
			case 2:str += "</td><td>长期供货";break;
			case 3:str += "</td><td>框架合同";break;
			case 4:str += "</td><td>其他";break;
			default:str += "</td><td>状态错误";
		}
		var payType = list[i].payType;
		switch (payType) {
			case 1:str += "</td><td>预付款";break;
			case 2:str += "</td><td>现付";break;
			case 3:str += "</td><td>账期";break;
			default:str += "</td><td>状态错误";
		}
		str += "</td><td>" + (list[i].operator == null ? "" : list[i].operator);
		str += "</td><td>" + (list[i].phone == null ? "" : list[i].phone);
		str += "</td><td>" + (list[i].email == null ? "" : list[i].email);
		str += "</td><td>" + (list[i].fax == null ? "" : list[i].fax);
		str += "</td><td>" + (list[i].enterTime==null ? "" : list[i].enterTime);
		str += "</td><td>";
		str += "<a href='javascript:void(0);' class='table-btns' onclick='toEdit("+list[i].id+")' >编辑</a>";
		str += "</td></tr>";
	}
		

	$("#baseTable tbody").html(str);
}
	
function toEdit(id){
	var index = layer.open({
		  title:"供应商查看",		
		  type: 2,
		  content: '${wmsUrl}/admin/supplier/supplierMng/toEdit.shtml?supplierId='+id,
		  maxmin: true
		});
		layer.full(index);
}


function toAdd(){
	var index = layer.open({
		  title:"新增供应商",		
		  type: 2,
		  content: '${wmsUrl}/admin/supplier/supplierMng/toAdd.shtml',
		  maxmin: true
		});
		layer.full(index);
}

</script>
</body>
</html>
