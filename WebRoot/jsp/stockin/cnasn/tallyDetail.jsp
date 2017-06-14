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
<title>理货信息</title>
<%@include file="../../resource.jsp" %>
</head>

<body>
	<div id="page-wrapper">
		<div class="container-fluid">
			<div class="query">
			</div>
			<div class="row">
				<table id="tallyTable" class="table table-hover table-border">
					<thead>
						<tr>
							<th>商品编号</th>
							<th>商品编码</th>
							<th>商品名称</th>
							<th>货号</th>
							<th>计划入库</th>
							<th>理货状态</th>
							<th>良品数量</th>
							<th>次品数量</th>
							<th>本地图片</th>
							<th>菜鸟图片</th>
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
			<div class="modal fade" id="picModal" tabindex="-1" role="dialog" aria-hidden="true">
			   <div class="modal-dialog">
			      <div class="modal-content">
			         <div class="modal-header">
			         	<h4 class="modal-title" id="modelTitle">理货图片</h4>
			         </div>
			         <div class="modal-body">
			         <img id="pic" src="" class="img-rounded">
			         </div>
			         <div class="modal-footer">
			            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closePicModal()">取消 </button>
			         </div>
			      </div>
				</div>
			</div>
			<div class="modal fade" id="fileUploadModal" tabindex="-1" role="dialog" aria-hidden="true">
			   <div class="modal-dialog">
			      <div class="modal-content">
			         <div class="modal-header">
			         	<h4 class="modal-title" id="modelTitle">图片上传</h4>
			         </div>
			         <div class="modal-body">
			         	<input id="localFile" type="file" style="display:none" name="localFile">
						<div class="input-append">
							<input id="localFileName" readonly class="form-control" type="text" onclick="$('input[id=localFile]').click();">
							<button type="button" class="btn btn-info" id="uploadBtn">上传 </button>
						</div>
			         </div>
			         <div class="modal-footer">
			            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closePicModal()">取消 </button>
			         </div>
			      </div>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript" src="${wmsUrl}/js/ajaxfileupload.js"></script>
<script type="text/javascript">
/**
 * 初始化分页信息
 */
var options = {
			queryForm : ".query",
			url :  "${wmsUrl}/admin/stockIn/cnAsnMng/tallyInfoList.shtml?declNo=${declNo}",
			numPerPage:"10",
			currentPage:"",
			index:"1",
			callback:rebuildTable
}

$(function(){
	 $(".pagination-nav").pagination(options);
	 
	 $('#localFile').change(function() {
			$('#localFileName').val($(this).val());
	 });
})

/**
 * 重构table
 */
function rebuildTable(data){
	$("#tallyTable tbody").html("");
	if (data == null || data.length == 0) {
		return;
	}
	
	var list = data.obj;
	
	if (list == null || list.length == 0) {
		$.zzComfirm.alertError("没有理货信息！");
		return;
	}
	
	var str = "";
	var statusStr="";
	var needFileUpload = false;
	for (var i = 0; i < list.length; i++) {
		needFileUpload=false;
		str += "<tr><td>" + list[i].itemId;
		str += "</td><td>" + list[i].itemCode;
		str += "</td><td>" + list[i].itemName;
		str += "</td><td>" + list[i].sku;
		str += "</td><td>" + list[i].planQuantity;
		
		switch(list[i].status){
			case '0': statusStr = "<lable style='color:red'>未粗点</label>";break;
			case '1': statusStr = "<lable style='color:red'>已粗点</label>";break;
			case '2': statusStr = "<lable style='color:red'>已精点</label>";break;
			case '3': statusStr = "<lable style='color:red'>已上架</label>";break;
		}
		
		str += "</td><td>" + statusStr;
		str += "</td><td>" + list[i].qpQty;
		str += "</td><td>" + list[i].defQty;
		
		if(list[i].status=='2'||list[i].status == '3'||list[i].status == '5'){
			if(list[i].defQty >0||list[i].orderItemId==null){
				if(list[i].localFile!=null&&list[i].localFile!=""){
					str += "</td><td>"+getShowPicDiv(list[i].asnGoodsId,list[i].localFile);
					if(list[i].cnFile!=null&&list[i].cnFile!=""){
						str += "</td><td>"+list[i].cnFile;
					}else{
						str += "</td><td>"+getCnFileDiv(list[i].cnGoodsId,list[i].localFile);
					}
					
				}else{
					str += "</td><td>"+getFileUploadDiv(list[i].asnGoodsId);
					str += "</td><td>无";
				}
			}else{
				str += "</td><td>无";
				str += "</td><td>无";
			}
		}else{
			str += "</td><td></td><td>";
		}
		str += "</td></tr>";
	}
	$("#tallyTable tbody").htmlUpdate(str);
}

function getFileUploadDiv(asnGoodsId){
	var _fileDiv='<button type="button" class="btn btn-info"  onclick="showUploadModal('+asnGoodsId+')">上传图片 </button>';
	return _fileDiv;
}

function getCnFileDiv(cnGoodsId,fileName){
	var str = '<button type="button"  class="btn btn-info" onclick="uploadCnFile('+cnGoodsId+',\''+fileName+'\')">上传菜鸟 </button>';
	return str;
}

function uploadCnFile(cnGoodsId,fileName){
	$.ajax({
		 url:"${wmsUrl}/admin/stockIn/cnAsnMng/uploadCNPic.shtml",
		 type:'post',
		 data:{"cnGoodsId":cnGoodsId,"declNo":"${declNo}"},
		 dataType:'json',
		 success:function(data){
			 if(data.success){	
				 $.zzComfirm.alertSuccess("上传成功");
				 window.location.reload();
			 }else{
				 $.zzComfirm.alertError(data.msg);
			 }
		 },
		 error:function(){
			 $.zzComfirm.alertError("系统出现问题啦，快叫技术人员处理");
		 }
	 });
	
	clearModal();
}

function getShowPicDiv(asnGoodsId,fileName){
	var path = "/"+asnGoodsId+"/"+fileName;
	return '<button type="button"  class="btn btn-info" onclick="showPicModal(\''+path+'\')">查看图片 </button>';
}

function showUploadModal(id){
	 $('#fileUploadModal').modal({ show: true, backdrop: 'static' });
	 $("#uploadBtn").click(function(){
		 $.ajaxFileUpload
		    (
		      {
		           url:'${wmsUrl}/admin/stockIn/asnMng/uploadFile.shtml?asnGoodsId='+id, //你处理上传文件的服务端
		           secureuri:false,
		           fileElementId:"localFile",
		           dataType: 'json',
		           success: function (data)
		                 {
		                   if(data.success){
		                	   $.zzComfirm.alertSuccess("成功上传");
		                	   window.location.reload();
		                   }else{
		                	   $.zzComfirm.alertError(data.msg);
		                   }
		                 }
		              }
		        )

		      return false;
	 });
}

function showPicModal(path){
	 $("#pic").attr('src',"${wmsUrl}/upload/asn"+path); 
	 $('#picModal').modal({ show: true, backdrop: 'static' });
}

function closePicModal(path){
	$('#picModal').modal('hide');
}

</script>
</body>
</html>