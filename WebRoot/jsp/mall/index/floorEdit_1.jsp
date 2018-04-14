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
<link rel="stylesheet" href="${wmsUrl}/validator/css/bootstrapValidator.min.css">
</head>

<body>
	<section class="content-wrapper">
		<section class="content-iframe content">
			<form class="form-horizontal" role="form" id="floorForm">
				<div class="list-item">
					<div class="col-sm-3 item-left">楼层编号</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" readonly name="id" value="${dict.id}"> 
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left">楼层分类</div>
					<div class="col-sm-9 item-right">
						<select class="form-control" name="firstCategory" id="firstCategory">
	                   	  <c:forEach var="first" items="${firsts}">
	                   	  	<c:if test="${dict.firstCategory == first.firstId}">
	                   	  		<option value="${first.firstId}" selected>${first.name}</option>
	                   	  	</c:if>
	                   	  	<c:if test="${dict.firstCategory != first.firstId}">
	                   	  		<option value="${first.firstId}">${first.name}</option>
	                   	  	</c:if>
	                   	  </c:forEach>
		                </select>
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left">楼层名称</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="name" value="${dict.name}"> 
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left">楼层别称</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="enname" value="${dict.enname}"> 
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left">楼层描述</div>
					<div class="col-sm-9 item-right">
						<input type="text" class="form-control" name="description" value="${dict.description}"> 
					</div>
				</div>
				<div class="list-item">
					<div class="col-sm-3 item-left">楼层大图</div>
					<div class="col-sm-9 item-right addContent">
						<div class="item-img">
							+
							<input type="file" id="pic1"/>
						</div>
					</div>
				</div>
		        <div class="submit-btn">
		           	<button type="button" id="submitBtn">提交</button>
		       	</div>
	        </form>
	        <div class="list-content">
				<div class="row">
					<div class="col-md-12 list-btns">
						<button type="button" onclick="toAdd()">新增楼层商品</button>
					</div>
				</div>
				<div class="row content-container">
					<div class="col-md-12 container-right active">
						<table id="floorGoodsTable" class="table table-hover myClass">
							<thead>
								<tr>
									<th width="10%">编号</th>
									<th width="30%">图片地址</th>
									<th width="7%">跳转地址</th>
									<th width="30%">商品标题</th>
									<th width="7%">国家</th>
									<th width="7%">价格</th>
									<th width="9%">操作</th>
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
	<%@include file="../../resource.jsp"%>
	<script src="${wmsUrl}/validator/js/bootstrapValidator.min.js"></script>
	<script src="${wmsUrl}/js/pagination.js"></script>
	<script type="text/javascript" src="${wmsUrl}/js/ajaxfileupload.js"></script>
	<script type="text/javascript">
	
	/**
	 * 初始化分页信息
	 */
	var options = {
				queryForm : ".query",
				url :  "${wmsUrl}/admin/mall/indexMng/dataListForData.shtml?dictId=${dict.id}",
				numPerPage:"20",
				currentPage:"",
				index:"1",
				callback:rebuildTable
	}
	
	function toAdd(){
		var index = layer.open({
			  title:"新增内容编辑",		
			  type: 2,
			  content: '${wmsUrl}/admin/mall/indexMng/toAddFloorContent.shtml?id=${dict.id}',
			  maxmin: false
			});
			layer.full(index);
	}
	
	function toEdit(id){
		var index = layer.open({
			  title:"内容编辑",		
			  type: 2,
			  content: '${wmsUrl}/admin/mall/indexMng/toEditContent.shtml?id='+id,
			  maxmin: false
			});
			layer.full(index);
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
		$("#floorGoodsTable tbody").html("");

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
			str += "</td><td>" + list[i].id;
			str += "</td><td>" + list[i].picPath;
			str += "</td><td>" + list[i].href;
			str += "</td><td>" + list[i].title;
			str += "</td><td>" + list[i].origin;
			str += "</td><td>" + list[i].price;
			str += "</td><td>";
			str += "<a href='javascript:void(0);' class='table-btns' onclick='toEdit("+list[i].id+")'>编辑</a>";
			str += "</td></tr>";
		}
		$("#floorGoodsTable tbody").html(str);
	}
	
	function save(){
		$('#floorForm').data("bootstrapValidator").validate();
		 if($('#floorForm').data("bootstrapValidator").isValid()){
			 $.ajax({
					url : '${wmsUrl}/admin/mall/indexMng/updateDict.shtml',
					type : 'post',
					contentType : "application/json; charset=utf-8",
					data : JSON.stringify(sy.serializeObject($('#floorForm'))),
					dataType : 'json',
					success : function(data) {
						if (data.success) {
							parent.location.reload();
							layer.alert("修改成功");
						} else {
							layer.alert(data.msg);
						}
					},
					error : function() {
						layer.alert("提交失败，请联系客服处理");
					}
				});
		 }else{
			 layer.alert("提交失败，请联系客服处理");
		 }
	}
	
	$('#floorForm').bootstrapValidator({
//      live: 'disabled',
      message: 'This value is not valid',
      feedbackIcons: {
          valid: 'glyphicon glyphicon-ok',
          invalid: 'glyphicon glyphicon-remove',
          validating: 'glyphicon glyphicon-refresh'
      },
      fields: {
    	  pic1: {
              message: '大图地址不能空',
              validators: {
                  notEmpty: {
                      message: '大图地址不能空！'
                  }
              }
      	  },
      	 name: {
            message: '楼层名称不能为空',
            validators: {
                notEmpty: {
                    message: '楼层名称不能为空！'
                }
            }
    	  }
      }
  });
	

	</script>
</body>
</html>
