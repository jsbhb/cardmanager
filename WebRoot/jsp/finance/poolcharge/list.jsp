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
							<label class="col-sm-4 control-label no-padding-right" for="form-field-1">区域中心</label>
							<div class="col-sm-8">
								<div class="input-group">
									<select class="form-control" name="centerId" id="centerId" style="width: 160px;">
				                   	  <option selected="selected" value="">未选择</option>
				                   	  <c:forEach var="center" items="${centers}">
		                   	  			<option value="${center.gradeId}">${center.gradeName}</option>
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
										<th>区域中心名称</th>
										<th>账户可用金额</th>
										<th>冻结可用金额</th>
										<th>可用优惠金额</th>
										<th>冻结优惠金额</th>
										<th>账户使用金额</th>
										<th>使用优惠金额</th>
										<th>累计产生金额</th>
										<th>累计产生优惠</th>
										<th>区域中心状态</th>
<!-- 										<th>最后操作时间</th> -->
<!-- 										<th>最后操作者</th> -->
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
							<div class="pagination-nav">
<!-- 								<ul id="pagination" class="pagination"> -->
<!-- 								</ul> -->
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
			url :  "${wmsUrl}/admin/finance/capitalPoolMng/dataList.shtml",
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
		if (list[i].money < 1000) {
			str += "<tr style='color: #FF0000'>";
		} else {
			str += "<tr>";
		}
		var tmpCenterId = list[i].centerId;
		var tmpCenterName = "";
		var centerSelect = document.getElementById("centerId");
		var options = centerSelect.options;
		for(var j=0;j<options.length;j++){
			if (tmpCenterId==options[j].value) {
				tmpCenterName = options[j].text;
				break;
			}
		}
		str += "<td>" + (tmpCenterName == "" ? "" : tmpCenterName);
		str += "</td><td>" + list[i].money;
		str += "</td><td>" + list[i].frozenMoney;
		str += "</td><td>" + list[i].preferential;
		str += "</td><td>" + list[i].frozenPreferential;
		str += "</td><td>" + list[i].useMoney;
		str += "</td><td>" + list[i].usePreferential;
		str += "</td><td>" + list[i].countMoney;
		str += "</td><td>" + list[i].countPreferential;
		var status = list[i].status;
		switch(status){
			case 0:str += "</td><td>停用";break;
			case 1:str += "</td><td>启用";break;
			default:str += "</td><td>停用";
		}
// 		str += "</td><td>" + (list[i].updateTime == null ? "" : list[i].updateTime);
// 		str += "</td><td>" + (list[i].opt == null ? "" : list[i].opt);
		str += "</td><td align='left'>";
		str += "<button type='button' class='btn btn-danger' onclick='toShow(\""+list[i].centerId+"\")' >充值</button>";
		str += "</td></tr>";
	}
		

	$("#orderTable tbody").html(str);
}
	

function toShow(centerId){
	var index = layer.open({
		  title:"资金池充值",		
		  type: 2,
		  content: '${wmsUrl}/admin/finance/capitalPoolMng/toShow.shtml?centerId='+centerId
		});
		layer.full(index);
}

</script>
</body>
</html>
