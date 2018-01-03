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
		<div class="box box-warning">
			<div class="box-header">
				<div class="row form-horizontal"><!--
				<div class="col-xs-4">
						<div class="form-group">
							<label class="col-sm-4 control-label no-padding-right" for="form-field-1">分级编号<font style="color:red">*</font> </label>
							<div class="col-sm-8">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-user-o"></i>
				                  </div>
		                  			<input type="text" class="form-control" name="id">
				                </div>
							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label class="col-sm-4 control-label no-padding-right" for="form-field-1">分级名称<font style="color:red">*</font> </label>
							<div class="col-sm-8">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-user-o"></i>
				                  </div>
		                  			<input type="text" class="form-control" name="brandName">
				                </div>
							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<div class="form-group">
							<label class="col-sm-4 control-label no-padding-right" for="form-field-1">公司名称<font style="color:red">*</font> </label>
							<div class="col-sm-8">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-address-book"></i>
				                  </div>
				                  <input type="text" class="form-control" name="company">
				                </div>
							</div>
						</div>
					</div>
					<div class="col-md-offset-10 col-md-12">
						<div class="form-group">
                                <button type="button" class="btn btn-primary" id="submitBtn" name="signup">提交</button>
                                <button type="button" class="btn btn-info" id="resetBtn">重置</button>
                        </div>
                     </div>-->
				</div> 
			</div>
			<div class="box-body">
				<div class="row">
					<div class="col-md-12">
						<div class="panel panel-default">
							<table id="baseTable" class="table table-hover">
								<thead>
									<tr>
										<th>基础编码</th>
										<th>品牌名称</th>
										<th>商品名称</th>
										<th>分类</th>
										<th>所属机构</th>
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
			url :  "${wmsUrl}/admin/goods/baseMng/dataList.shtml",
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
	$("#baseTable tbody").html("");

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
		str += "<td align='left'>" + list[i].id + "</td>";
		str += "</td><td>" + list[i].brand;
		str += "</td><td>" + list[i].goodsName;
		str += "</td><td>" + list[i].firstCatalogId+"-"+list[i].secondCatalogId+"-"+list[i].thirdCatalogId;
		str += "</td><td>" + list[i].centerId;
		
		str += "</td></tr>";
	}
		

	$("#baseTable tbody").html(str);
	trBind();
}
	
/**
 * 数据字典tr绑定选中事件
 */
function trBind() {
	$("#baseTable tr").dblclick(sureSup);
};

function sureSup(){
		var selectTr = $(this);

		if ($(selectTr).parent().is('thead')) {
			return;
		}
	
		$('#baseId', window.parent.document).val(selectTr.children("td").eq(0).text());
		$('#brand', window.parent.document).val(selectTr.children("td").eq(1).text());
		$('#baseName', window.parent.document).val(selectTr.children("td").eq(2).text());
		$('#catalog', window.parent.document).val(selectTr.children("td").eq(3).text());
		
		
		$('#baseInfo', window.parent.document).show();
		
		
		parent.layer.closeAll();
}

</script>
</body>
</html>
