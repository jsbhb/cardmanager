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
							<label class="col-sm-2 control-label no-padding-right">名称</label>
							<div class="col-sm-6">
								<div class="input-group">
									<div class="input-group-addon">
					                    <i class="fa fa-pencil"></i>
					                </div>
									<input type="text" class="form-control" readonly name="name" value="${dict.name}"> 
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
									<input type="text" class="form-control" readonly name="enname" value="${dict.enname}"> 
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
									<input type="text" class="form-control" readonly name="description" value="${dict.description}"> 
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
								</div>
							</div>
						</div>
						<div class="col-md-offset-1 col-md-9">
							<div class="form-group">
									<button type="button" class="btn btn-info" disabled onclick="save(${dict.id})">保存</button>
			                 </div>
			            </div>
			        </form>
				</div>
			</div>
			<div class="box box-warning">
				<div class="box-body">
					<div class="row">
						<div class="col-md-12">
								<button type="button" class="btn btn-primary" onclick="toAdd(${dict.firstCategory})">新增商品</button>
						</div>
						<div class="col-md-12">
							<div class="panel panel-default">
								<table id="floorGoodsTable" class="table table-hover">
									<thead>
										<tr>
											<th>商品编号</th>
											<th>图片地址</th>
											<th>title</th>
											<th>规格</th>
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
			//if ("${privilege>=2}") {
			
			str += "</td><td>" + list[i].id;
			str += "</td><td>" + list[i].goodId;
			str += "</td><td>" + list[i].picName;
			str += "</td><td>" + list[i].title;
			str += "</td><td>" + list[i].orginal;
			str += "</td><td>" + list[i].price;
			
			if (true) {
				str += "<td align='left'>";
				str += "<a href='#' onclick='toEditGoods("+list[i].id+")'><i class='fa fa-pencil' style='font-size:20px'></i></a>";
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
					url : '${wmsUrl}/admin/mall/indexMng/saveFloor.shtml',
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

	function uploadFile(id) {
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
