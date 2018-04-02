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
					<div class="col-xs-4">
						<div class="form-group">
							<label class="col-sm-4 control-label no-padding-right" for="form-field-1">角色类型</label>
							<div class="col-sm-8">
								<div class="input-group">
									<select class="form-control" name="operatorType" id="operatorType" style="width: 160px;">
		                   	  			<option value="0">区域中心</option>
		                   	  			<option value="1">门店</option>
		                   	  			<option value="2">推手</option>
				                   	    <option selected="selected" value="">未选择</option>
					              	</select>
				                </div>
							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label class="col-sm-4 control-label no-padding-right" for="form-field-1">提现金额</label>
							<div class="col-sm-8">
								<div class="input-group">
		                  			<input type="text" class="form-control" name="outMoney">
				                </div>
							</div>
						</div>
					</div><div class="col-xs-4">
						<div class="form-group">
							<label class="col-sm-4 control-label no-padding-right" for="form-field-1">申请状态</label>
							<div class="col-sm-8">
								<div class="input-group">
									<select class="form-control" name="status" id="status" style="width: 160px;">
				                   		<option value="">未选择</option>
		                   	  			<option selected="selected" value="1">待处理</option>
		                   	  			<option value="2">已同意</option>
		                   	  			<option value="3">已拒绝</option>
					              	</select>
				                </div>
							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label class="col-sm-4 control-label no-padding-right" for="form-field-1">交易流水号</label>
							<div class="col-sm-8">
								<div class="input-group">
		                  			<input type="text" class="form-control" name="payNo">
				                </div>
							</div>
						</div>
					</div>
					<div class="col-xs-4" style="display: none">
						<div class="form-group">
							<label class="col-sm-4 control-label no-padding-right" for="form-field-1">区域中心</label>
							<div class="col-sm-8">
								<div class="input-group">
									<select class="form-control" name="centerId" id="centerId" style="width: 160px;">
				                   	  <option selected="selected" value="">未选择</option>
				                   	  <c:forEach var="center" items="${centerId}">
		                   	  			<option value="${center.gradeId}">${center.gradeName}</option>
				                   	  </c:forEach>
					              	</select>
				                </div>
							</div>
						</div>
					</div>
					<div class="col-xs-4" style="display: none">
						<div class="form-group">
							<label class="col-sm-4 control-label no-padding-right" for="form-field-1">门店</label>
							<div class="col-sm-8">
								<div class="input-group">
									<select class="form-control" name="shopId" id="shopId" style="width: 150px;">
				                   	  <option selected="selected" value="">未选择</option>
				                   	  <c:forEach var="shop" items="${shopId}">
		                   	  			<option value="${shop.gradeId}">${shop.gradeName}</option>
				                   	  </c:forEach>
					              	</select>
				                </div>
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
							<table id="orderTable" class="table table-hover">
								<thead>
									<tr>
										<th>角色名称</th>
										<th>角色类型</th>
										<th>提现时余额</th>
										<th>提现金额</th>
										<th>申请状态</th>
										<th>银行名称</th>
										<th>银行卡号</th>
										<th>持卡人姓名</th>
										<th>转账流水号</th>
										<th>操作</th>
<!-- 										<th>最后操作时间</th> -->
<!-- 										<th>最后操作者</th> -->
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
	
	<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
<script type="text/javascript">


/**
 * 初始化分页信息
 */
var options = {
			queryForm : ".query",
			url :  "${wmsUrl}/admin/finance/withdrawalsMng/dataList.shtml",
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
		
		var tmpType = list[i].operatorType;
		var tmpId = list[i].operatorId;
		if (tmpType == 0) {
			var tmpCenterName = "";
			var centerSelect = document.getElementById("centerId");
			var centerOptions = centerSelect.options;
			for(var j=0;j<centerOptions.length;j++){
				if (tmpId==centerOptions[j].value) {
					tmpCenterName = centerOptions[j].text;
					break;
				}
			}
			str += "<td>" + (tmpCenterName == "" ? "" : tmpCenterName);
		} else if (tmpType == 1) {
			var tmpShopName = "";
			var shopSelect = document.getElementById("shopId");
			var shooOptions = shopSelect.options;
			for(var j=0;j<shooOptions.length;j++){
				if (tmpId==shooOptions[j].value) {
					tmpShopName = shooOptions[j].text;
					break;
				}
			}
			str += "<td>" + (tmpShopName == "" ? "" : tmpShopName);
		} else if (tmpType == 2) {
			str += "<td>" + (list[i].operatorName == null ? "" : list[i].operatorName);
		}
		
		var tmpOperatorName = "";
		var typeSelect = document.getElementById("operatorType");
		var typeOptions = typeSelect.options;
		for(var j=0;j<typeOptions.length;j++){
			if (tmpType==typeOptions[j].value) {
				tmpOperatorName = typeOptions[j].text;
				break;
			}
		}
		str += "</td><td>" + tmpOperatorName;
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
		str += "</td><td align='left'>";
		if (status == 1) {
			str += "<button type='button' class='btn btn-danger' onclick='toShow(\""+list[i].id+"\")' >审核处理</button>";
		}
		str += "</td></tr>";
	}
		

	$("#orderTable tbody").html(str);
}
	

function toShow(id){
	var index = layer.open({
		  title:"提现审批",		
		  type: 2,
		  content: '${wmsUrl}/admin/finance/withdrawalsMng/toShow.shtml?id='+id
		});
		layer.full(index);
}

</script>
</body>
</html>
