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

<link rel="stylesheet" href="${wmsUrl}/validator/css/bootstrapValidator.min.css">
<script src="${wmsUrl}/validator/js/bootstrapValidator.min.js"></script>
<script src="${wmsUrl}/js/pagination.js"></script>

</head>

<body>
	<section class="content-wrapper">
		<section class="content">
			<div class="box box-info">
				<div class="box-header with-border">
					<div class="box-header with-border">
						<h5 class="box-title">楼层编辑</h5>
						<div class="box-tools pull-right">
							<button type="button" class="btn btn-box-tool"
								data-widget="collapse">
								<i class="fa fa-minus"></i>
							</button>
						</div>
					</div>
				</div>
				<div class="box-body">
					<form class="form-horizontal" role="form" id="floorForm">
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">编号</label>
							<div class="col-sm-6">
								<div class="input-group">
									<div class="input-group-addon">
					                    <i class="fa fa-pencil"></i>
					                </div>
									<input type="text" class="form-control" readonly name="id" value="${dict.id}"> 
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">分类选择</label>
							<div class="col-sm-6">
								<div class="input-group">
									<select class="form-control" name="firstCategory" id="firstCategory" style="width: 100%;">
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
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">名称</label>
							<div class="col-sm-6">
								<div class="input-group">
									<div class="input-group-addon">
					                    <i class="fa fa-pencil"></i>
					                </div>
									<input type="text" class="form-control" name="name" value="${dict.name}"> 
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">别称</label>
							<div class="col-sm-6">
								<div class="input-group">
									<div class="input-group-addon">
					                    <i class="fa fa-pencil"></i>
					                </div>
									<input type="text" class="form-control"  name="enname" value="${dict.enname}"> 
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">描述</label>
							<div class="col-sm-6">
								<div class="input-group">
									<div class="input-group-addon">
					                    <i class="fa fa-pencil"></i>
					                </div>
									<input type="text" class="form-control" name="description" value="${dict.description}"> 
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">大图(1240*345px)</label>
							<div class="col-sm-6">
								<div class="input-group">
									<div class="input-group-addon">
					                    <i class="fa fa-pencil"></i>
					                </div>
									<input type="text" class="form-control" readonly name="picPath1" id="picPath1" value="${dict.picPath1}"> 
									<input type="file" name="pic" id="pic" />
									<button type="button" class="btn btn-info" onclick="uploadFile()">上传</button>
								</div>
							</div>
						</div>
						<div class="col-md-offset-1 col-md-9">
							<div class="form-group">
									<button type="button" class="btn btn-info" onclick="save(${dict.id})">保存</button>
			                 </div>
			            </div>
			        </form>
				</div>
			</div>
			<div class="box box-warning">
				<div class="box-body">
					<div class="row">
						<div class="col-md-12">
							<button type="button" class="btn btn-primary" onclick="toAdd()">新增商品</button>
						</div>
						<div class="col-md-12">
							<div class="panel panel-default">
								<table id="floorGoodsTable" class="table table-hover">
									<thead>
										<tr>
											<th>编号</th>
											<th>图片地址</th>
											<th>跳转地址</th>
											<th>title</th>
											<th>国家</th>
											<th>价格</th>
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
			  maxmin: true
			});
			layer.full(index);
	}
	
	
	function toEdit(id){
		var index = layer.open({
			  title:"内容编辑",		
			  type: 2,
			  content: '${wmsUrl}/admin/mall/indexMng/toEditContent.shtml?id='+id,
			  maxmin: true
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
			
			if (true) {
				str += "<td align='left'>";
				str += "<a href='#' onclick='toEdit("+list[i].id+")'><i class='fa fa-pencil' style='font-size:20px'></i></a>";
				str += "</td>";
			}
			
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

	function uploadFile() {
		$.ajaxFileUpload({
			url : '${wmsUrl}/admin/uploadFile.shtml', //你处理上传文件的服务端
			secureuri : false,
			fileElementId : "pic",
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					$("#picPath1").val(data.msg);
				} else {
					layer.alert(data.msg);
				}
			}
		})
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
    	  picPath1: {
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
