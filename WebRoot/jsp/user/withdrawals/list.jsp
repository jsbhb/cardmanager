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
<section class="content-wrapper query">
	<section class="content-header">
	      <ol class="breadcrumb">
	        <li><a href="javascript:void(0);">首页</a></li>
	        <li>个人中心</li>
	        <li class="active">提现申请</li>
	      </ol>
	      <div class="search">
	      	<input type="text" name="payNo" placeholder="请输入交易流水号">
	      	<div class="searchBtn"><i class="fa fa-search fa-fw"></i></div>
	      	<div class="moreSearchBtn">高级搜索</div>
		  </div>
    </section>
	<section class="content">
		<div id="image" style="width:100%;height:100%;display: none;background:rgba(0,0,0,0.5);margin-left:-25px;margin-top:-62px;">
			<img alt="loading..." src="${wmsUrl}/img/loader.gif" style="position:fixed;top:50%;left:50%;margin-left:-16px;margin-top:-16px;" />
		</div>
		<div class="moreSearchContent">
			<div class="row form-horizontal list-content">
				<div class="col-xs-3">
					<div class="searchItem">
						<select class="form-control" name="status" id="status">
	                   		<option value="">--请选择申请状态--</option>
               	  			<option selected="selected" value="1">待处理</option>
               	  			<option value="2">已同意</option>
               	  			<option value="3">已拒绝</option>
		              	</select>
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
	                  	<input type="text" class="form-control" name="hidPayNo" placeholder="请输入交易流水号">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
	                  	<input type="text" class="form-control" name="outMoney" placeholder="请输入提现金额">
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
				<div class="col-md-12 list-btns">
					<button type="button" onclick="toAdd()">新增提现申请</button>
				</div>
			</div>
			<div class="row content-container">
				<div class="col-md-12 container-right active">
					<table id="orderTable" class="table table-hover myClass">
						<thead>
							<tr>
								<th>角色名称</th>
								<th>提现时余额</th>
								<th>提现金额</th>
								<th>申请状态</th>
								<th>银行名称</th>
								<th>银行卡号</th>
								<th>持卡人姓名</th>
								<th>转账流水号</th>
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
<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
<script type="text/javascript">
//点击搜索按钮
$('.searchBtn').on('click',function(){
	$("#querybtns").click();
});

/**
 * 初始化分页信息
 */
var options = {
	queryForm : ".query",
	url :  "${wmsUrl}/admin/user/userWithdrawalsMng/dataList.shtml",
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
	$("#orderTable tbody").html("");

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
		str += "<td>" + (list[i].operatorName == null ? "" : list[i].operatorName);
		str += "</td><td>" + list[i].startMoney;
		str += "</td><td>" + list[i].outMoney;

		var status = list[i].status;
		switch(status){
			case 1:str += "</td><td>待处理";break;
			case 2:str += "</td><td>已同意";break;
			case 3:str += "</td><td>已拒绝";break;
			default:str += "</td><td>状态异常";
		}
		str += "</td><td>" + list[i].cardBank;
		str += "</td><td>" + list[i].cardNo;
		str += "</td><td>" + list[i].cardName;
		str += "</td><td>" + (list[i].payNo == null ? "" : list[i].payNo);
// 		str += "</td><td>" + (list[i].updateTime == null ? "" : list[i].updateTime);
// 		str += "</td><td>" + (list[i].opt == null ? "" : list[i].opt);
		str += "</td></tr>";
	}
	$("#orderTable tbody").html(str);
}


function toAdd(){
	
	var index = layer.open({
		  type: 2,
		  content: '${wmsUrl}/admin/user/userWithdrawalsMng/toAdd.shtml',
		  area: ['320px', '195px'],
		  maxmin: true
		});
		layer.full(index);
}
</script>
</body>
</html>
