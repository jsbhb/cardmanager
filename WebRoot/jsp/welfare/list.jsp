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
<%@include file="../resourceLink.jsp"%>
</head>
<body>
<section class="content-wrapper query">
	<section class="content-header">
	      <ol class="breadcrumb">
	        <li><a href="javascript:void(0);">首页</a></li>
	        <li>福利模块</li>
	        <li class="active">邀请人列表</li>
	      </ol>
	      <div class="search">
	      	<input type="text"  name="gradeName" id="gradeName" readonly style="background:#fff;width:200px;" placeholder="选择分级" value = "">
			<input type="hidden" class="form-control" name="gradeId" id="gradeId">
	      	<div class="searchBtn"><i class="fa fa-search fa-fw"></i></div>
	      	<div class="moreSearchBtn">高级搜索</div>
		  </div>
    </section>	
    <div class="select-content">
        <ul class="first-ul" style="margin-left:10px;">
			<c:forEach var="menu" items="${gradeList}">
				<c:set var="menu" value="${menu}" scope="request" />
				<%@include file="recursive.jsp"%>  
			</c:forEach>
	   	</ul>
	</div>
	<section class="content">
		<div id="image" style="width:100%;height:100%;display: none;background:rgba(0,0,0,0.5);margin-left:-25px;margin-top:-62px;">
			<img alt="loading..." src="${wmsUrl}/img/loader.gif" style="position:fixed;top:50%;left:50%;margin-left:-16px;margin-top:-16px;" />
		</div>
		
		<div class="moreSearchContent">
			<div class="row form-horizontal list-content">
				<div class="col-xs-3">
					<div class="searchItem">
			            <select class="form-control" name="status" id="status">
		                	<option selected="selected" value="-1">--请选择邀请码状态--</option>
			                <option value="0">未生成</option>
			                <option value="1">未发送</option>
			                <option value="2">已发送</option>
			                <option value="3">绑定</option>
			                <option value="4">作废</option>
			                <option value="5">发送失败</option>
			            </select>
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
			           <input type="text" class="form-control" name="name" placeholder="请输入邀请人名称">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
	                  	<input type="text" class="form-control" name="phone" placeholder="请输入邀请人手机号">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
	                  	<input type="text" class="form-control" name="invitationCode" placeholder="请输入邀请码">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
	                  	<input type="text" class="form-control" name="bindName" placeholder="请输入绑定人名称">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
	                  	<input type="text" class="form-control" name="bindPhone" placeholder="请输入绑定人手机号">
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
		
		<div class="default-content">
			<div class="today-orders">
				<div class="today-orders-item">
					<a href="javascript:void(0);" id="-1" onclick="listByStatus(-1)">${total}</a>
					<p>总共</p>
				</div>
				<c:forEach var="item" items="${list}">
					<div class="today-orders-item">
						<a href="javascript:void(0);" id="${item.status}" onclick="listByStatus(${item.status})">${item.count}</a>
						<c:if test="${item.status == 1}">
							<p>未发送</p>
						</c:if>
						<c:if test="${item.status == 2}">
							<p>已发送</p>
						</c:if>
						<c:if test="${item.status == 3}">
							<p>已绑定</p>
						</c:if>
						<c:if test="${item.status == 4}">
							<p>已作废</p>
						</c:if>
						<c:if test="${item.status == 5}">
							<p>发送失败</p>
						</c:if>
					</div>
				</c:forEach>
			</div>
		</div>

		<div class="list-content">
			<div class="row">
				<div class="col-md-12 list-btns">
                   	<button type="button" onclick="toAddInviter()">添加邀请人</button>
<!-- 					<button type="button" onclick = "toProduceCode()">生成邀请码</button> -->
					<button type="button" onclick = "toSendProduceCode()">发送邀请码</button>
				</div>
			</div>
			<div class="row content-container">
				<div class="col-md-12 container-right active">
					<table id="baseTable" class="table table-hover myClass">
						<thead>
							<tr>
								<th width="5%"><input type="checkbox" id="theadInp"></th>
								<th width="15%">分级名称</th>
								<th width="7%">邀请人名称</th>
								<th width="8%">邀请人手机号</th>
								<th width="10%">邀请码</th>
								<th width="10%">邀请码状态</th>
								<th width="10%">备注</th>
								<th width="10%">创建时间</th>
								<th width="7%">绑定人名称</th>
								<th width="8%">绑定人手机号</th>
<%-- 								<c:if test="${prilvl == 1}"> --%>
<!-- 									<th width="10%">操作</th> -->
<%-- 								</c:if> --%>
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
	
<%@include file="../resourceScript.jsp"%>
<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
<script src="${wmsUrl}/js/mainpage.js"></script>
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
	url :  "${wmsUrl}/admin/welfare/welfareMng/dataList.shtml",
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

function clearStatistic(){
	$("#1").text(0);
	$("#2").text(0);
	$("#3").text(0);
	$("#4").text(0);
	$("#5").text(0);
}

/**
 * 重构table
 */
function rebuildTable(data){
	var total = 0;
	var statisticList = data.object;
	
	clearStatistic();
	if(statisticList != null && statisticList.length > 0){
		for (var i = 0; i < statisticList.length; i++){
			$("#" + statisticList[i].status).text(statisticList[i].count);
			total = Number(total) + Number(statisticList[i].count) 
		}
	}
	$("#-1").text(total);
	$("#baseTable tbody").html("");

	if (data == null || data.length == 0) {
		return;
	}
	
	var list = data.obj;
	var str = "";
	
	if (list == null || list.length == 0) {
		str = "<tr style='text-align:center'><td colspan=14><h5>没有查到数据</h5></td></tr>";
		$("#baseTable tbody").html(str);
		return;
	}

	for (var i = 0; i < list.length; i++) {
		str += "<tr>";
		str += "<td><input type='checkbox' name='check' value='" + list[i].id + "'/>"
		str += "</td><td>" + list[i].gradeName;
		str += "</td><td>" + list[i].name;
		str += "</td><td>" + list[i].phone;
		str += "</td><td>" + (list[i].invitationCode == null ? "" : list[i].invitationCode);
		var status = list[i].status;
		switch(status){
			case 0:str += "</td><td>未生成";break;
			case 1:str += "</td><td>未发送";break;
			case 2:str += "</td><td>已发送";break;
			case 3:str += "</td><td>绑定";break;
			case 4:str += "</td><td>作废";break;
			case 5:str += "</td><td>发送失败";break;
			default:str += "</td><td>状态错误："+status;
		}
		str += "</td><td>" + (list[i].remark == null ? "" : list[i].remark);
		str += "</td><td>" + (list[i].createTime == null ? "" : list[i].createTime);
		str += "</td><td>" + (list[i].bindName == null ? "" : list[i].bindName);
		str += "</td><td>" + (list[i].bindPhone == null ? "" : list[i].bindPhone);
// 		var prilvl = "${prilvl}";
// 		if(prilvl == 1){
// 			if (status == 0) {
// 				str += "</td><td><a href='javascript:void(0);' class='table-btns' onclick='toEditInviter("+list[i].id+',"'+list[i].name+'","'+list[i].phone+"\")'>编辑</a>";
// 				str += "<a href='javascript:void(0);'  onclick='toDelInviter("+list[i].id+")'>作废</a>";
// 			} else if (status == 4) {
// 				str += "</td><td>";
// 			} else {
// 				str += "</td><td><a href='javascript:void(0);'  onclick='toDelInviter("+list[i].id+")'>作废</a>";
// 			}
// 		}
		str += "</td></tr>";
	}
	$("#baseTable tbody").html(str);
}

function toAddInviter(){
	var index = layer.open({
	  title:"添加邀请人信息",		
	  type: 2,
  	  area: ['60%','50%'],
	  content: '${wmsUrl}/admin/welfare/welfareMng/toAddInviter.shtml',
	  maxmin: false
	});
}

function toEditInviter(id,name,phone){
	var index = layer.open({
	  title:"编辑邀请人信息",		
	  type: 2,
  	  area: ['60%','50%'],
	  content: encodeURI(encodeURI('${wmsUrl}/admin/welfare/welfareMng/toEditInviter.shtml?id='+id+'&name='+name+'&phone='+phone)),
	  maxmin: false
	});
}

function toDelInviter(id){
	$.ajax({
		 url:"${wmsUrl}/admin/welfare/welfareMng/delInviterInfo.shtml?id="+id,
		 type:'post',
		 contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 success:function(data){
			 if(data.success){	
				 layer.alert("操作成功");
				 reloadTable();
			 }else{
				 layer.alert(data.msg);
			 }
		 },
		 error:function(data){
			 layer.alert("提交失败，请联系客服处理");
		 }
	 });
}

// function toProduceCode(){
// 	var ids;
// 	var valArr = new Array; 
//     $("[name='check']:checked").each(function(i){
//     	if ($(this).parent().siblings().eq(4).text() == "未生成") {
//  	        valArr[i] = $(this).val(); 
//     	}
//     }); 
// 	ids = valArr.join(',');//转换为逗号隔开的字符串 
//     if (valArr == undefined || valArr.length == 0) {
//     	layer.confirm('确定要为所有邀请人(未生成状态)生成邀请码吗？', {
//   		  btn: ['确认','取消'] //按钮
//   		}, function(){
//   			layer.closeAll('dialog');
//   			postToProduceCode(ids);
//   		}, function(){
//   		  	layer.close();
//   		});
//     } else {
// 		postToProduceCode(ids);
//     }
// }

// function postToProduceCode(ids) {
// 	$.ajax({
// 		 url:"${wmsUrl}/admin/welfare/welfareMng/produceCode.shtml?ids="+ids,
// 		 type:'post',
// 		 contentType: "application/json; charset=utf-8",
// 		 dataType:'json',
// 		 success:function(data){
// 			 if(data.success){	
// 				 layer.alert("操作成功");
// 				 reloadTable();
// 				 $("#theadInp").prop("checked", false);
// 			 }else{
// 				 layer.alert(data.msg);
// 			 }
// 		 },
// 		 error:function(data){
// 			 layer.alert("提交失败，请联系客服处理");
// 		 }
// 	 });
// }

function toSendProduceCode(){
	var ids;
	var valArr = new Array; 
    $("[name='check']:checked").each(function(i){
    	if ($(this).parent().siblings().eq(4).text() == "未发送" 
    		|| $(this).parent().siblings().eq(4).text() == "已发送"
    		|| $(this).parent().siblings().eq(4).text() == "发送失败") {
 	        valArr[i] = $(this).val(); 
    	}
    }); 
	ids = valArr.join(',');//转换为逗号隔开的字符串 
    if (valArr == undefined || valArr.length == 0) {
    	layer.confirm('确定要为所有邀请人(未发送状态)发送邀请码吗？', {
  		  btn: ['确认','取消'] //按钮
  		}, function(){
  			layer.closeAll('dialog');
  			postToSendProduceCode(ids)
  		}, function(){
  		  	layer.close();
  		});
    } else {
    	postToSendProduceCode(ids)
    }
}

function postToSendProduceCode(ids) {
	$.ajax({
		 url:"${wmsUrl}/admin/welfare/welfareMng/sendProduceCode.shtml?ids="+ids,
		 type:'post',
		 contentType: "application/json; charset=utf-8",
		 dataType:'json',
		 success:function(data){
			 if(data.success){	
				 layer.alert("操作成功");
				 reloadTable();
				 $("#theadInp").prop("checked", false);
			 }else{
				 layer.alert(data.msg);
			 }
		 },
		 error:function(data){
			 layer.alert("提交失败，请联系客服处理");
		 }
	 });
}

//点击展开
$('.select-content').on('click','li span i:not(active)',function(){
	$(this).addClass('active');
	$(this).parent().next().stop();
	$(this).parent().next().slideDown(300);
});
//点击收缩
$('.select-content').on('click','li span i.active',function(){
	$(this).removeClass('active');
	$(this).parent().next().stop();
	$(this).parent().next().slideUp(300);
});

//点击展开下拉列表
$('#gradeName').click(function(){
	$('.select-content').css('width',$(this).outerWidth());
	$('.select-content').css('left',$(this).offset().left);
	$('.select-content').css('top',$(this).offset().top + $(this).height());
	$('.select-content').stop();
	$('.select-content').slideDown(300);
});

//点击空白隐藏下拉列表
$('html').click(function(event){
	var el = event.target || event.srcelement;
	if(!$(el).parents('.select-content').length > 0 && $(el).attr('id') != "gradeName"){
		$('.select-content').stop();
		$('.select-content').slideUp(300);
	}
});
//点击选择分类
$('.select-content').on('click','span',function(event){
	var el = event.target || event.srcelement;
	if(el.nodeName != 'I'){
		var name = $(this).attr('data-name');
		var id = $(this).attr('data-id');
		$('#gradeName').val(name);
		$('#gradeId').val(id);
		$('.select-content').stop();
		$('.select-content').slideUp(300);
	}
});

function listByStatus(status){
	$("#status").val(status);
	$("#querybtns").click();
}
function isJSON(str) {
    if (typeof str == 'string') {
        try {
            var obj=JSON.parse(str);
            if(typeof obj == 'object' && obj ){
                return true;
            }else{
                return false;
            }

        } catch(e) {
            return false;
        }
    }
    return false;
}
</script>
</body>
</html>
