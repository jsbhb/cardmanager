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

</head>
<body>
<section class="content-wrapper">
	<section class="content-header">
	      <h1><i class="fa fa-street-view"></i>功能管理</h1>
	      <ol class="breadcrumb">
	        <li><a href="#"><i class="fa fa-dashboard"></i> 首页</a></li>
	        <li class="active">功能管理</li>
	      </ol>
    </section>	
	<section class="content">
        <div class="box box-default">
			<div class="box-header">
				<div class="col-md-4">
					<div class="form-group">
		                <label class="col-md-4 control-label">分级名称:</label>
		                <div class="input-group  col-md-7">
		                  <input type="text" class="form-control" name="userName">
		                </div>
		              </div>
					<div class="form-group">
		                <label class="col-md-4 control-label">公司:</label>
		                <div class="input-group  col-md-7">
		                  <input type="text" class="form-control" name="userName">
		                </div>
		              </div>
	            </div>
	            <div class="col-md-4">
					<div class="form-group">
		                <label class="col-md-4 control-label">级别:</label>
		                <div class="input-group col-md-7">
		                  <input type="text" class="form-control" name="userName">
		                </div>
		              </div>
					<div class="form-group">
		                <label class="col-md-4 control-label">名称:</label>
		                <div class="input-group  col-md-7">
		                  <input type="text" class="form-control" name="userName">
		                </div>
		              </div>
		         </div>
		         <div class="col-md-4">
					<div class="form-group">
		                <label class="col-md-3 control-label">编号:</label>
		                <div class="input-group col-md-7">
		                  <input type="text" class="form-control" name="userName">
		                </div>
		              </div>
					<div class="form-group">
		                <label class="col-md-3 control-label">负责人:</label>
		                <div class="input-group  col-md-7">
		                  <input type="text" class="form-control" name="userName">
		                </div>
		              </div>
		         </div>
		         <div class="col-md-9">
					<div class="form-group">
                          <button type="submit" class="btn btn-primary" name="signup" value="提交">提交</button>
                          <button type="button" class="btn btn-info" id="resetBtn">重置</button>
                    </div>
                 </div>
			</div>
			<div class="box-body">
				<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">
								<i class="fa fa-bar-chart-o fa-fw"></i>分级列表
							</h3>
						</div>
						<div class="panel-body">
							<table id="asnTable" class="table table-hover">
								<thead>
									<tr>
										<th>操作</th>
										<th>等级编号</th>
										<th>名称</th>
										<th>电话</th>
										<th>公司</th>
										<th>传真</th>
										<th>负责人</th>
										<th>上级负责人</th>
										<th>创建时间</th>
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
		</div>
	</section>
	</section>
		<%@ include file="../../footer.jsp"%>
		<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-hidden="true">
	   <div class="modal-dialog">
	      <div class="modal-content">
	         <div class="modal-header">
	            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="closeAddModal()">&times;</button>
	         	<h4 class="modal-title" id="modelTitle">分类新增</h4>
	         </div>
	         <div class="modal-body">
	         	<iframe id="addIFrame" frameborder="0"></iframe>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeAddModal()">取消 </button>
	            <button type="button" class="btn btn-info" id="saveGradeBtn">新增 </button>
	         </div>
	      </div>
		</div>
	</div>
<script type="text/javascript">
function addGrade(){
	$(this).parent().tab('show');
	var width = "100%";
	var height = window.innerHeight-115;
	$("#page-wrapper",$(this).parent()).empty();
	var newIframeObject = document.createElement("IFRAME");
	newIframeObject.src = "${wmsUrl}/admin/system/gradeMng/add.shtml";
	newIframeObject.scrolling = "yes";
	newIframeObject.frameBorder = 0;
	newIframeObject.width = width;
	newIframeObject.height = height;
	$("#page-wrapper",$(this).parent()).append(newIframeObject);
	return false;
}

</script>
</body>
</html>
