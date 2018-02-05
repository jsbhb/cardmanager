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
<!-- 				<div class="col-xs-4"> -->
<!-- 					<div class="form-group"> -->
<!-- 						<label class="col-sm-4 control-label no-padding-right" for="form-field-1">供应商</label> -->
<!-- 						<div class="col-sm-8"> -->
<!-- 							<div class="input-group"> -->
<!-- 			                  <select class="form-control" name="supplierId" id="supplierId" style="width: 100%;"> -->
<!-- 		                   	  <option selected="selected" value="">未选择</option> -->
<%-- 		                   	  <c:forEach var="supplier" items="${suppliers}"> --%>
<%-- 		                   	  	<option value="${supplier.id}">${supplier.supplierName}</option> --%>
<%-- 		                   	  </c:forEach> --%>
<!-- 			                </select> -->
<!-- 			                </div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
				<div class="col-xs-4">
					<div class="form-group">
						<label class="col-sm-4 control-label no-padding-right" for="form-field-1">商品编码</label>
						<div class="col-sm-8">
							<div class="input-group">
	                  			<input type="text" class="form-control" name="goodsId">
			                </div>
						</div>
					</div>
				</div>
<!-- 				<div class="col-xs-4"> -->
<!-- 					<div class="form-group"> -->
<!-- 						<label class="col-sm-4 control-label no-padding-right" for="form-field-1">明细编码</label> -->
<!-- 						<div class="col-sm-8"> -->
<!-- 							<div class="input-group"> -->
<!-- 			                  <input type="text" class="form-control" name="itemId"> -->
<!-- 			                </div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 				<div class="col-xs-4"> -->
<!-- 					<div class="form-group"> -->
<!-- 						<label class="col-sm-4 control-label no-padding-right" for="form-field-1">itemCode</label> -->
<!-- 						<div class="col-sm-8"> -->
<!-- 							<div class="input-group"> -->
<!-- 			                  <input type="text" class="form-control" name="itemCode"> -->
<!-- 			                </div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 				<div class="col-xs-4"> -->
<!-- 					<div class="form-group"> -->
<!-- 						<label class="col-sm-4 control-label no-padding-right" for="form-field-1">sku</label> -->
<!-- 						<div class="col-sm-8"> -->
<!-- 							<div class="input-group"> -->
<!-- 			                  <input type="text" class="form-control" name="sku"> -->
<!-- 			                </div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
				<div class="col-xs-4">
					<div class="form-group">
						<label class="col-sm-4 control-label no-padding-right" for="form-field-1">商品名称</label>
						<div class="col-sm-8">
							<div class="input-group">
			                  <input type="text" class="form-control" name="goodsName">
			                </div>
						</div>
					</div>
				</div>
				<div class="col-md-offset-10 col-md-12">
					<div class="form-group">
                         <button type="button" class="btn btn-primary" id="querybtns" name="signup">提交</button>
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
							<table id="itemTable" class="table table-hover">
								<thead>
									<tr>
										<th>商品编码</th>
										<th>商品名称</th>
<!-- 										<th>sku</th> -->
<!-- 										<th>itemCode</th> -->
<!-- 										<th>明细编号</th> -->
<!-- 										<th>供应商</th> -->
										<th>商品链接</th>
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
			url :  "${wmsUrl}/admin/label/goodsQRMng/dataList.shtml",
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
	$("#itemTable tbody").html("");

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
		str += "</td><td>" + list[i].goodsId;
		str += "</td><td>" + list[i].goodsName;
// 		str += "</td><td>" + list[i].sku;
// 		str += "</td><td>" + list[i].itemCode;
// 		str += "</td><td>" + list[i].itemId;
// 		str += "</td><td>" + list[i].supplierName;
		str += "</td><td>" + list[i].detailPath;
		str += "</td><td>";
		if (list[i].detailPath == "") {
			str += "";
		} else {
			str += "<button type='button' class='btn btn-primary' onclick='downLoadFile(\"";
			str += list[i].goodsId + "\",\"" + list[i].detailPath.replace("&","%26")
			str += "\")'>下载</button>";
		}
		str += "</td></tr>";
	}
	$("#itemTable tbody").html(str);
}
	
// function downLoadFile(id,path){
// 	$.ajax({
// 		 url:"${wmsUrl}/admin/label/goodsQRMng/downLoadFile.shtml?goodsId="+id+"&path="+path,
// 		 type:'post',
// 		 contentType: "application/json; charset=utf-8",
// 		 dataType:'json',
// 		 success:function(data){
// 		 },
// 		 error:function(){
// 			 layer.alert("下载失败，请重试");
// 		 }
// 	 });
// }

function downLoadFile(id,path){
// 	var left1 = 300;
// 	var top1 = 200;
	location.href="${wmsUrl}/admin/label/goodsQRMng/downLoadFile.shtml?goodsId="+id+"&path="+path;
// 	window.open('${wmsUrl}/admin/label/goodsQRMng/downLoadFile.shtml?goodsId='+id+'&path='+path, "", "width=750,height=700,resizable=yes,location=no,scrollbars=yes,left=" + left1.toString() + ",top=" + top1.toString());
}

</script>
</body>
</html>
