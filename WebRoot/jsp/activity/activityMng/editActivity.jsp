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
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@include file="../../resourceLink.jsp"%>
<%-- <script src="${wmsUrl}/plugins/laydate/laydate.js"></script> --%>
</head>
<body>
	<section class="content-iframe content">
		<form class="form-horizontal" role="form" id="itemForm">
			<div class="list-content">
				<div class="title">
		       		<h1>活动信息</h1>
		       	</div>
		       	<div class="list-item">
					<div class="col-sm-3 item-left">活动类型</div>
					<div class="col-sm-9 item-right">
		                <select class="form-control" name="type" id="type" disabled>
	                   	  <option selected="selected" value="1">砍价活动</option>
		                </select>
					</div>
				</div>
		       	<div class="list-item">
					<div class="col-sm-3 item-left">活动名称</div>
					<div class="col-sm-9 item-right">
	                	<input type="text" class="form-control" name="name" id="name" value="${bargainInfo.name}"/>
	                	<input type="hidden" class="form-control" name="id" id="id" value="${bargainInfo.id}"/>
	                	<input type="hidden" class="form-control" id="selectItem"/>
						<div class="item-content">
			             	（请输入活动名称，例：双12砍价活动）
			            </div>
					</div>
				</div>
		       	<div class="list-item">
					<div class="col-sm-3 item-left">活动描述</div>
					<div class="col-sm-9 item-right">
	                	<input type="text" class="form-control" name="description" id="description" value="${bargainInfo.description}"/>
						<div class="item-content">
			             	（请输入活动描述，例：迎接双12，特惠砍价活动）
			            </div>
					</div>
				</div>
		       	<div class="list-item">
					<div class="col-sm-3 item-left">活动状态</div>
					<div class="col-sm-9 item-right">
		                <select class="form-control" name="status" id="status">
		                	<c:choose>
								<c:when test="${bargainInfo.status==0}">
									<option selected="selected" value="0">未开始</option>
				                   	<option value="1">开始</option>
								</c:when>
								<c:otherwise>
				                   	<option value="0">未开始</option>
				                   	<option selected="selected" value="1">开始</option>
								</c:otherwise>
							</c:choose>
		                </select>
					</div>
				</div>
	<!-- 	       	<div class="list-item"> -->
	<!-- 				<div class="col-sm-3 item-left">活动时间</div> -->
	<!-- 				<div class="col-sm-9 item-right"> -->
	<!-- 					<input type="text" class="form-control" id="activityTime" name="activityTime" placeholder="请选择活动时间" readonly> -->
	<!-- 				</div> -->
	<!-- 			</div> -->
				<div class="row">
					<div class="col-md-12 list-btns" style="margin-left:5px">
						<button type="button" onclick="showGoodsList()">添加活动商品</button>
					</div>
				</div>
				<div id="goodsList" style="padding:0 20px;">
					<div class="list-item" id="goodsItem" style="width:100%;">
						<div class="list-all">
							<table class="dynamic-table" id="dynamicTable">
								<caption>活动商品列表</caption>
								<thead id="dynamic-thead">
								<tr>
								<th style='width: 7%;'>商品编号</th>
								<th style='width: 10%;'>商品名称</th>
								<th style='width: 6%;'>商品原价</th>
								<th style='width: 6%;'><font style='color:red'>*</font>商品底价</th>
								<th style='width: 7%;'><font style='color:red'>*</font>最多砍价次数</th>
								<th colspan='2' style='width: 10%;'><font style='color:red'>*</font>发起人砍价区间(%)</th>
								<th colspan='2' style='width: 10%;'><font style='color:red'>*</font>邀请人砍价区间(%)</th>
								<th style='width: 7%;'><font style='color:red'>*</font>砍价结束金额</th>
								<th style='width: 6%;'><font style='color:red'>*</font>购买类型</th>
	<!-- 							<th style='width: 6%;'><font style='color:red'>*</font>开始时间</th> -->
	<!-- 							<th style='width: 6%;'><font style='color:red'>*</font>结束时间</th> -->
								<th style='width: 6%;'><font style='color:red'>*</font>持续小时</th>
								<th style='width: 5%;'><font style='color:red'>*</font>活动状态</th>
								<th style='width: 7%;'>操作</th>
								</tr>
								</thead>
								<tbody id="dynamic-table">
									<c:forEach var="item" items="${bargainInfo.itemList}">
										<tr>
											<td><input type="text" class="form-control" name="itemId" value="${item.itemId}" readonly></td>
											<td>${item.goodsName}</td>
											<td><input type="text" class="form-control" name="initPrice" value="${item.initPrice}" readonly></td>
											<td><input type="text" class="form-control" name="floorPrice" onkeyup="clearNoNum(this)" onafterpaste="clearNoNum(this)" value="${item.floorPrice}"></td>
											<td><input type="text" class="form-control" name="maxCount" onkeyup="this.value=this.value.replace(/[^?\d]/g,'')" onafterpaste="this.value=this.value.replace(/[^?\d]/g,'')"  value="${item.maxCount}"></td>
											<td colspan="2"><input type="text" class="form-control" name="firstMinRatio" style="display:inline-block;width:45px;" onkeyup="this.value=this.value.replace(/[^?\d]/g,'')" onafterpaste="this.value=this.value.replace(/[^?\d]/g,'')" onBlur="compareNum('min',this)" value="${item.firstMinRatio}"> ~<input type="text" class="form-control" name="firstMaxRatio" style="display:inline-block;width:45px;" onkeyup="this.value=this.value.replace(/[^?\d]/g,'')" onafterpaste="this.value=this.value.replace(/[^?\d]/g,'')" onBlur="compareNum('max',this)" value="${item.firstMaxRatio}"></td>
											<td colspan="2"><input type="text" class="form-control" name="minRatio" style="display:inline-block;width:45px;" onkeyup="this.value=this.value.replace(/[^?\d]/g,'')" onafterpaste="this.value=this.value.replace(/[^?\d]/g,'')" onBlur="compareNum('min',this)" value="${item.minRatio}"> ~<input type="text" class="form-control" name="maxRatio" style="display:inline-block;width:45px;" onkeyup="this.value=this.value.replace(/[^?\d]/g,'')" onafterpaste="this.value=this.value.replace(/[^?\d]/g,'')" onBlur="compareNum('max',this)" value="${item.maxRatio}"></td>
											<td><input type="text" class="form-control" name="lessMinPrice" onkeyup="clearNoNum(this)" onafterpaste="clearNoNum(this)" value="${item.lessMinPrice}"></td>
											<td><select name="type" style="width:60px"><option selected="selected" value="1">普通</option></select></td>
											<td><input type="text" class="form-control" name="duration" onkeyup="this.value=this.value.replace(/[^?\d]/g,'')" onafterpaste="this.value=this.value.replace(/[^?\d]/g,'')"  value="${item.duration}"></td>
											<td><select name="status" style="width:70px">
													<c:choose>
														<c:when test="${item.status==0}">
															<option selected="selected" value="0">未开始</option>
										                   	<option value="1">开始</option>
														</c:when>
														<c:otherwise>
										                   	<option value="0">未开始</option>
										                   	<option selected="selected" value="1">开始</option>
														</c:otherwise>
													</c:choose>
												</select>
											</td>
											<td><a href="javascript:void(0);" class="table-btns" onclick="removeItemInfo(${item.itemId})" >移除商品</a></td>
										</tr>
									</c:forEach>
								</tbody>
								<tfoot>
									<tr>
										<td colspan="13">
											<span>批量设置 ： </span>
											<span>
<!-- 												<a href="javascript:void(0)" onclick="batchSetTableItem('initPrice')">商品原价</a> -->
												<a href="javascript:void(0)" onclick="batchSetTableItem('floorPrice')">商品底价</a>
												<a href="javascript:void(0)" onclick="batchSetTableItem('maxCount')">砍价次数</a>
												<a href="javascript:void(0)" onclick="batchSetTableItem('firstMinRatio')">发起人砍价(min)</a>
												<a href="javascript:void(0)" onclick="batchSetTableItem('firstMaxRatio')">发起人砍价(max)</a>
												<a href="javascript:void(0)" onclick="batchSetTableItem('minRatio')">邀请人砍价(min)</a>
												<a href="javascript:void(0)" onclick="batchSetTableItem('maxRatio')">邀请人砍价(max)</a>
												<a href="javascript:void(0)" onclick="batchSetTableItem('lessMinPrice')">结束金额</a>
	<!-- 											<a href="javascript:void(0)" onclick="batchSetTableItem('startTime')">开始时间</a> -->
	<!-- 											<a href="javascript:void(0)" onclick="batchSetTableItem('endTime')">结束时间</a> -->
												<a href="javascript:void(0)" onclick="batchSetTableItem('duration')">持续小时</a>
											</span>
											<div id="batchSetting" class="batchSetting" style="width:850px;">
												<input type="text" class="inline-input" id="batchInput"/>
												<a href="javascript:void(0)" onclick="batchSaveTableItem()">保存</a>
												<a href="javascript:void(0)" onclick="batchSetedTableItem()">取消</a>
											</div>
										</td>
									</tr>
								</tfoot>
							</table>
						</div>
					</div>
				</div>
				
		        <div class="submit-btn">
		           	<button type="button" id="submitBtn">保存信息</button>
		       	</div>
	       	</div>
		</form>
	</section>
	<%@include file="../../resourceScript.jsp"%>
	<script type="text/javascript">
	var allItem=[];
	var saveItemList=[];
	
	$(function(){
		<c:forEach var="item" items="${bargainInfo.itemList}">
			var selectItemInfo={};
			selectItemInfo["itemId"] = "${item.itemId}";
		 	selectItemInfo["goodsName"] = "${item.goodsName}";
		 	selectItemInfo["price"] = eval("${item.initPrice}");
		 	selectItemInfo["stock"] = 0;
		 	allItem.push(selectItemInfo);
	 	</c:forEach>
	})
	
	function getSelectItemInfo(){
		var itemInfo = $("#selectItem").val().split("|");
	 	var selectItemInfo={};
	 	selectItemInfo["itemId"] = itemInfo[0].trim();
	 	selectItemInfo["goodsName"] = itemInfo[1].trim();
	 	selectItemInfo["price"] = itemInfo[2].trim();
	 	selectItemInfo["stock"] = itemInfo[3].trim();
		if (allItem.length>0) {
			var existFlg = false;
			for(var item in allItem) {
				var tmpItem = allItem[item];
				if (tmpItem["itemId"] == selectItemInfo["itemId"]) {
					existFlg = true;
				}
			}
			if (!existFlg) {
				allItem.push(selectItemInfo);
				addItemToTable(selectItemInfo);
			}
		} else {
			allItem.push(selectItemInfo);
			addItemToTable(selectItemInfo);
		}
	}
	
	function removeItemInfo(itemId){
		for(var item in allItem) {
			var tmpItem = allItem[item];
			if (tmpItem["itemId"] == itemId) {
				allItem.splice(item,1);
				delItemToTable(itemId);
			}
		}
	}
	
// 	laydate.render({
// 		elem: '#activityTime', //指定元素
// 		type: 'datetime',
// 	    range: '~',
// 		value: null
// 	});
	
	function showGoodsList(){
		var index = layer.open({
			title:"查看商品信息",	
			area: ['90%', '90%'],
			type: 2,
			content: '${wmsUrl}/admin/activity/activityMng/listForAdd.shtml',
			maxmin: false
		});
	}
	$("#submitBtn").click(function(){
// 		var formData = sy.serializeObject($('#itemForm'));
		var formData = {};
		var tmpType = $('#type option:selected').val();
		formData["type"]=tmpType;
		formData["id"]=$('#id').val();
		formData["name"]=$('#name').val();
		formData["description"]=$('#description').val();
		formData["status"]=$('#status option:selected').val();
		
		if ($('#dynamicTable tbody tr').length <1) {
			layer.alert("请添加活动商品！");
			return;
		}
		if (!checkTableInfo()) {
			saveItemList=[];
			return; 
		} else {
			formData["itemList"]=saveItemList;
		}
// 		console.log(formData);
// 		return;
		var url = "";
		if (tmpType == "1") {
			url = "${wmsUrl}/admin/activity/bargainMng/changeBargainActivity.shtml";
		}
		if (url == "") {
			layer.alert("活动类型选择异常，请重新选择！");
			return;
		}
		$.ajax({
			url:url,
			type:'post',
			data:JSON.stringify(formData),
			contentType: "application/json; charset=utf-8",
			dataType:'json',
			success:function(data){
				if(data.success){
					parent.layer.closeAll();
					parent.location.reload();
				}else{
					layer.alert(data.msg);
				}
			},
			error:function(){
				layer.alert("提交失败，请联系客服处理");
			}
		});
	});
	function batchSetTableItem(itemName){
		$("#batchSetting").addClass("active");
		$("#batchSetting").attr("data-id",itemName);
	}

	function batchSaveTableItem(){
		var tmpItem = $("#batchSetting").attr("data-id");
		var tmpItemInput = $("#batchInput").val();
		$.each($('#dynamicTable tbody tr'),function(r_index,r_obj){
			var obj_name="";
			$.each($(r_obj).find('td'),function(c_index,c_obj){
				obj_name = $(c_obj.firstChild).attr('name');
				if (obj_name == tmpItem) {
					$(c_obj.firstChild).val(tmpItemInput);
				}
				obj_name = $(c_obj.lastChild).attr('name');
				if (obj_name == tmpItem) {
					$(c_obj.lastChild).val(tmpItemInput);
				}
			});
		});
		$("#batchInput").val("");
		$("#batchSetting").removeAttr("data-id");
		batchSetedTableItem();
	}

	function batchSetedTableItem(){
		$("#batchSetting").removeClass("active");
	}

	function checkTableInfo(){
		var retFlg = true;
		var e_index = "";
		var e_msg;
		saveItemList=[];
		$.each($('#dynamicTable tbody tr'),function(r_index,r_obj){
			var obj_name="";
			var obj_value="";
			var tdItemInfo={};
			$.each($(r_obj).find('td'),function(c_index,c_obj){
				obj_name = $(c_obj.firstChild).attr('name');
				var type = c_obj.firstChild.nodeName;
				//给每条记录赋值activityId
				tdItemInfo["activityId"] = $('#id').val();
				if(type == 'INPUT'){
					obj_value = $(c_obj.firstChild).val();
					if (obj_name == "itemId" || obj_name == "initPrice" ||
						obj_name == "floorPrice" || obj_name == "maxCount" ||
						obj_name == "firstMinRatio" || obj_name == "minRatio" ||
						obj_name == "lessMinPrice" || obj_name == "duration") {
						if (obj_value == "") {
							e_index = e_index + (r_index+1) + ",";
							retFlg = false;
							return false;
						}
						tdItemInfo[obj_name] = obj_value;
					}
				} else if (type == 'SELECT') {
					obj_value = $(c_obj.firstChild).val();
					tdItemInfo[obj_name] = obj_value;
				}
				obj_name = $(c_obj.lastChild).attr('name');
				type = c_obj.lastChild.nodeName;
				if(type == 'INPUT'){
					obj_value = $(c_obj.lastChild).val();
					if (obj_name == "firstMaxRatio" || obj_name == "maxRatio") {
						if (obj_value == "") {
							e_index = e_index + (r_index+1) + ",";
							retFlg = false;
							return false;
						}
						tdItemInfo[obj_name] = obj_value;
					}
				}
			});
			saveItemList.push(tdItemInfo);
		});
		if (!retFlg) {
			e_index = e_index.substring(0,e_index.length-1);
			e_msg = "第"+(e_index)+"条商品信息填写有误，请确认！";
			layer.alert(e_msg);
			return retFlg;
		}
	  	return retFlg;
	}
	  
	function addItemToTable(selectItemInfo){
		var trHtml = "";
		trHtml += "<tr>";
		trHtml += "<td><input type=\"text\" class=\"form-control\" name=\"itemId\" value=\""+selectItemInfo["itemId"]+"\" readonly></td>";
		trHtml += "<td>"+selectItemInfo["goodsName"]+"</td>";
		trHtml += "<td><input type=\"text\" class=\"form-control\" name=\"initPrice\" value=\""+selectItemInfo["price"]+"\" readonly></td>";
		trHtml += "<td><input type=\"text\" class=\"form-control\" name=\"floorPrice\" onkeyup=\"clearNoNum(this)\" onafterpaste=\"clearNoNum(this)\"></td>";
		trHtml += "<td><input type=\"text\" class=\"form-control\" name=\"maxCount\" onkeyup=\"this.value=this.value.replace(/[^?\\d]/g,'')\" onafterpaste=\"this.value=this.value.replace(/[^?\\d]/g,'')\" ></td>";
		trHtml += "<td colspan='2'><input type=\"text\" class=\"form-control\" name=\"firstMinRatio\" style=\"display:inline-block;width:45px;\" onkeyup=\"this.value=this.value.replace(/[^?\\d]/g,'')\" onafterpaste=\"this.value=this.value.replace(/[^?\\d]/g,'')\" onBlur=\"compareNum('min',this)\" > ~<input type=\"text\" class=\"form-control\" name=\"firstMaxRatio\" style=\"display:inline-block;width:45px;\" onkeyup=\"this.value=this.value.replace(/[^?\\d]/g,'')\" onafterpaste=\"this.value=this.value.replace(/[^?\\d]/g,'')\" onBlur=\"compareNum('max',this)\" ></td>";
		trHtml += "<td colspan='2'><input type=\"text\" class=\"form-control\" name=\"minRatio\" style=\"display:inline-block;width:45px;\" onkeyup=\"this.value=this.value.replace(/[^?\\d]/g,'')\" onafterpaste=\"this.value=this.value.replace(/[^?\\d]/g,'')\" onBlur=\"compareNum('min',this)\" > ~<input type=\"text\" class=\"form-control\" name=\"maxRatio\" style=\"display:inline-block;width:45px;\" onkeyup=\"this.value=this.value.replace(/[^?\\d]/g,'')\" onafterpaste=\"this.value=this.value.replace(/[^?\\d]/g,'')\" onBlur=\"compareNum('max',this)\" ></td>";
		trHtml += "<td><input type=\"text\" class=\"form-control\" name=\"lessMinPrice\" onkeyup=\"clearNoNum(this)\" onafterpaste=\"clearNoNum(this)\"></td>";
		trHtml += "<td><select name=\"type\" style=\"width:60px\"><option value=\"1\">普通</option></select></td>";
// 		trHtml += "<td><input type=\"text\" class=\"form-control\" name=\"startTime\"></td>";
// 		trHtml += "<td><input type=\"text\" class=\"form-control\" name=\"endTime\"></td>";
		trHtml += "<td><input type=\"text\" class=\"form-control\" name=\"duration\" onkeyup=\"this.value=this.value.replace(/[^?\\d]/g,'')\" onafterpaste=\"this.value=this.value.replace(/[^?\\d]/g,'')\" ></td>";
		trHtml += "<td><select name=\"status\" style=\"width:70px\"><option value=\"0\">未开始</option><option selected=\"selected\" value=\"1\">开始</option></select></td>";
		trHtml += "<td><a href='javascript:void(0);' class='table-btns' onclick='removeItemInfo("+selectItemInfo["itemId"]+")' >移除商品</a></td>";
		trHtml += "</tr>"
		$("#dynamic-table").append(trHtml);
	}
	
	function delItemToTable(itemId){
		$.each($('#dynamicTable tbody tr'),function(r_index,r_obj){
			var obj_name="";
			var obj_value="";
			var delFlg = false;
			$.each($(r_obj).find('td'),function(c_index,c_obj){
				obj_name = $(c_obj.firstChild).attr('name');
				var type = c_obj.firstChild.nodeName;
				if(type == 'INPUT'){
					obj_value = $(c_obj.firstChild).val();
					if (obj_name == "itemId") {
						if (obj_value == itemId) {
							delFlg = true;
							return false;
						}
					}
				}
			});
			if (delFlg) {
				removeRow(r_obj);
				return false;
			}
		});
	}
	
	function clearNoNum(obj) {    
	    //先把非数字的都替换掉，除了数字和.    
	    obj.value = obj.value.replace(/[^\d.]/g,"");    
	    //保证只有出现一个.而没有多个.    
	    obj.value = obj.value.replace(/\.{2,}/g,".");    
	    //必须保证第一个为数字而不是.    
	    obj.value = obj.value.replace(/^\./g,"");    
	    //保证.只出现一次，而不能出现两次以上    
	    obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");    
	    //只能输入两个小数  
	    obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3');   
	}
	//删除行
	function removeRow(obj){
		var tr = this.getRowObj(obj);
		if(tr != null){
			tr.parentNode.removeChild(tr);
		}
	}
	 
	//得到行对象
	function getRowObj(obj){
		var i = 0;
		while(obj.tagName.toLowerCase() != "tr"){
			obj = obj.parentNode;
			if(obj.tagName.toLowerCase() == "table")return null;
		}
		return obj;
	}
	
	function compareNum(type,obj){
		if (obj.value > 100) {
			obj.value = obj.value % 100;
		}
		var compareValue;
		if (type == "min") {
			compareValue = $(obj).next().val();
			if (compareValue != "" && compareValue != undefined) {
				if (obj.value > compareValue) {
					$(obj).next().val(obj.value);
					obj.value = compareValue;
				}
			}
		} else if (type = "max") {
			compareValue = $(obj).prev().val();
			if (compareValue != "" && compareValue != undefined) {
				if (obj.value < compareValue) {
					$(obj).prev().val(obj.value);
					obj.value = compareValue;
				}
			}
		}
	}
	</script>
</body>
</html>
