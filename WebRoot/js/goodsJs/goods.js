var keyId = new Array();
var keyText = new Array();
var valueIdArray = new Array();
var valueTextArray = new Array();

$('#specsSwitch').on('click','li',function(){
	var typeId = $(this).attr('data-type');
	if(typeId == 0){
		$('#noSpecs').show();
		$('#specs').hide();
		
		$("#itemCode").removeAttr("disabled");
		$("#encode").removeAttr("disabled");
		$("#encodeDiv").show();
		$("#unit").removeAttr("disabled");
		$("#weight").removeAttr("disabled");
		$("#specsDescription").removeAttr("disabled");
		$("#conversion").removeAttr("disabled");
		$("#conversion").val("1");
		$("#carTon").removeAttr("disabled");
		$("#shelfLife").removeAttr("disabled");
		$("#sku").removeAttr("disabled");
		$("#hsunit").removeAttr("disabled");
		$("#costPrice").removeAttr("disabled");
		$("#internalPrice").removeAttr("disabled");

		$('.list-all-parent').remove();
		$("#dynamic-table").empty();
		$("#dynamic-thead").empty();
		keyId = new Array();
		keyText = new Array();
		valueIdArray = new Array();
		valueTextArray = new Array();
	}else if(typeId == 1){
		$('#noSpecs').hide();		  
		$('#specs').show();
		
		$("#itemCode").attr("disabled", true);
		$("#itemCode").val("");
		$("#encode").attr("disabled", true);
		$("#encode").val("");
		$("#encodeDiv").hide();
		$("#unit").attr("disabled", true);
		$("#unit").val("");
		$("#weight").attr("disabled", true);
		$("#weight").val("");
		$("#specsDescription").attr("disabled", true);
		$("#specsDescription").val("");
		$("#conversion").attr("disabled", true);
		$("#conversion").val("1");
		$("#carTon").attr("disabled", true);
		$("#carTon").val("");
		$("#shelfLife").attr("disabled", true);
		$("#shelfLife").val("");
		$("#sku").attr("disabled", true);
		$("#sku").val("");
		$("#hsunit").attr("disabled", true);
		$("#hsunit").val("");
		$("#costPrice").attr("disabled", true);
		$("#costPrice").val("");
		$("#internalPrice").attr("disabled", true);
		$("#internalPrice").val("");

		$('.list-all-parent').remove();
		$("#dynamic-table").empty();
		$("#dynamic-thead").empty();
		keyId = new Array();
		keyText = new Array();
		valueIdArray = new Array();
		valueTextArray = new Array();
	}
});

$('.remove_value').on('click',function(){
	$(this).parent().remove();
	rebuildTable();
});

$('.remove_specs').on('click',function(){
	$(this).parent().remove();
	rebuildTable();
});

//新增规格值
function addSpecsValue(e){
	
	var selectValue = $(e).prev();
	if(selectValue.children("span").length>0){
		$(e).before($(e).prev().prop("outerHTML"))
	}else{
		var html = selectValue.prop("outerHTML");
		$(e).before(html.replace("</div>","<span class=\"remove_value\">&times</span></div>"))
	}
	
	$('.remove_value').on('click',function(){
		$(this).parent().remove();
		rebuildTable();
	});
}

//重新获取界面选择的值

function reGetSelectInfo(){
	keyId = [];
	keyText = [];
	valueIdArray = [];
	valueTextArray = [];
	$(".select-key option:selected").each(function(){
		  if($(this).text()==''||$(this).val()==-1){		
			  return;
		  }
		  
		  if (keyId.indexOf($(this).val()) == -1) {
			  keyText.push($(this).text());
			  keyId.push($(this).val());
		  } else {
			  return true;
		  }
		  
		  var idArray = new Array();
		  var textArray = new Array();
		  
		  $(this).parent().parent().parent().parent().parent().find(".select-value option:selected").each(function(){
			  if($(this).text()==''||$(this).val()==-1){		
				  return;
			  }
			  
			  if (idArray.indexOf($(this).val()) == -1) {
				  idArray.push($(this).val())
				  textArray.push($(this).text())
			  }
		  });
		  
		  if(idArray.length > 0){
			  valueIdArray.push(idArray);
			  valueTextArray.push(textArray);
		  }
	});
}

//重构table
function rebuildTable(){
	  $("#dynamic-table").empty();
	  $("#dynamic-thead").empty();
	  
	  reGetSelectInfo();
	  
	  var htmlArray = new Array();
	  if(valueIdArray.length>0){
		  if(valueTextArray[0].length>0){
			  var trHtml = "";
			  for(var k=0;k<valueTextArray[0].length;k++){
				  rebuildTd(valueTextArray[0][k],valueTextArray,valueIdArray,0,htmlArray);
				  
				  trHtml += "<tr>";
				  for(var i=0;i<htmlArray.length;i++){
					  trHtml += htmlArray[i];
				  }
				  trHtml += "</tr>"
				  htmlArray = new Array();
			  }
			  $("#dynamic-table").html(trHtml);
			  
			  var thead = "<tr>";
			  if(keyText.length>0){
				  for(var i = 0;i<keyText.length;i++){
					  thead += "<th style='width: 5%;'>"+keyText[i]+"</th>"
				  }
			  }
			  thead += "<th><font style='color:red'>*</font>条形码</th>";
			  thead += "<th><font style='color:red'>*</font>商品重量</th>";
			  thead += "<th><font style='color:red'>*</font>换算比例</th>";
			  thead += "<th><font style='color:red'>*</font>商品单位</th>";
			  thead += "<th>规格名称</th>";
			  thead += "<th>规格描述</th>";
			  thead += "<th>商品箱规</th>";
			  thead += "</tr>";
			  
			  $("#dynamic-thead").html(thead);
		  }
	  }
	  
//	  console.log("===valueIdArray===");
//	  console.log(valueIdArray);
//	  console.log("===valueTextArray===");
//	  console.log(valueTextArray);
//	  console.log("===keyText===");
//	  console.log(keyText);
//	  console.log("===keyId===");
//	  console.log(keyId);
	  
	  rebuildSupplierTable();
}

function rebuildTd(text,valueTextArray,valueIdArray,index,htmlArray){
	var num = index;
	var rowSpanNum = 1;
	for(var j = num + 1;j < valueIdArray.length;j++){
		if(valueTextArray[j].length>0){
		 	rowSpanNum = rowSpanNum * valueIdArray[j].length;
		}
	}
	
	htmlArray.push("<td rowspan=\""+rowSpanNum+"\"><span name=\"info\">"+text+"</span></td>");
	
    if(num + 1 < valueIdArray.length && valueIdArray[num + 1].length>0){
	  if(valueTextArray[num+1].length>0){
		  for(var k=0;k<valueTextArray[num+1].length;k++){
			  
			  if(k!=0){
				  htmlArray.push("<tr>");  
			  }
			  rebuildTd(valueTextArray[num+1][k],valueTextArray,valueIdArray,num+1,htmlArray);
			  if(k!=0){
				  htmlArray.push("</tr>");  
			  }
		  }
	  }
    }
   
    if(num + 1 == valueIdArray.length){
	  	htmlArray.push("<td><input type=\"text\" class=\"form-control\" name=\"encode\"></td>");
	  	htmlArray.push("<td><input type=\"text\" class=\"form-control\" name=\"weight\" onkeyup=\"clearNoNum(this)\" onafterpaste=\"clearNoNum(this)\"></td>");
	  	htmlArray.push("<td><input type=\"text\" class=\"form-control\" name=\"conversion\" onkeyup=\"this.value=this.value.replace(/[^?\\d]/g,'')\" onafterpaste=\"this.value=this.value.replace(/[^?\\d]/g,'')\" value=\"1\"></td>");
	  	htmlArray.push("<td><input type=\"text\" class=\"form-control\" name=\"unit\"></td>");
	  	htmlArray.push("<td><input type=\"text\" class=\"form-control\" name=\"specsGoodsName\"></td>");
	  	htmlArray.push("<td><input type=\"text\" class=\"form-control\" name=\"description\"></td>");
	  	htmlArray.push("<td><input type=\"text\" class=\"form-control\" name=\"carton\"></td>");
	}
} 

function getTableInfo(){
	
	 reGetSelectInfo();
	 var tmpDataTextList=doExchange(valueTextArray);
	 var tmpDataIdList=doExchange(valueIdArray);
	 
//	 console.log("---------");
//	 console.log(tmpDataTextList);
//	 console.log(tmpDataIdList);
//	 console.log("---------");
	 var itemDataList=[];
	 $.each($('#dynamicTable tbody tr'),function(r_index,r_obj){
		var itemData={};
//		var itemPriceData={};
		var obj_name="";
		var obj_value="";
		$.each($(r_obj).find('td'),function(c_index,c_obj){
			obj_name = $(c_obj.firstChild).attr('name');
			var type = c_obj.firstChild.nodeName;
			if(type == 'INPUT'){
				obj_value = $(c_obj.firstChild).val();
			}else if(type == 'SPAN'){
				var tmpSVKArr = tmpDataIdList[r_index].split(",");
				var tmpSVVArr = tmpDataTextList[r_index].split(",");
				var tmpSK="";
				var tmpSV="";
				var tmpInfo="";
				for(var i=0; i<keyText.length; i++){
					tmpSK = keyId[i];
					tmpSK = tmpSK + "|" + keyText[i];
					tmpSV = tmpSVKArr[i];
					tmpSV = tmpSV + "|" + tmpSVVArr[i];
					tmpInfo = tmpInfo + tmpSK + "&" + tmpSV + ";";
				}
				obj_value = tmpInfo;
//				console.log(obj_value);
			}
			itemData[obj_name] = obj_value;
		});
		itemDataList.push(itemData);
	 });
//	 console.log(itemDataList);
	 return itemDataList;
 }

function getSupplierTableInfo(){
	 reGetSelectInfo();
	 var tmpDataTextList=doExchange(valueTextArray);
	 var tmpDataIdList=doExchange(valueIdArray);
	 
	 var itemDataList=[];
	 $.each($('#dynamicSupplierTable tbody tr'),function(r_index,r_obj){
		var itemData={};
		var obj_name="";
		var obj_value="";
		$.each($(r_obj).find('td'),function(c_index,c_obj){
			obj_name = $(c_obj.firstChild).attr('name');
			var type = c_obj.firstChild.nodeName;
			if(type == 'INPUT'){
				obj_value = $(c_obj.firstChild).val();
			}else if(type == 'SPAN'){
				var tmpSVKArr = tmpDataIdList[r_index].split(",");
				var tmpSVVArr = tmpDataTextList[r_index].split(",");
				var tmpSK="";
				var tmpSV="";
				var tmpInfo="";
				for(var i=0; i<keyText.length; i++){
					tmpSK = keyId[i];
					tmpSK = tmpSK + "|" + keyText[i];
					tmpSV = tmpSVKArr[i];
					tmpSV = tmpSV + "|" + tmpSVVArr[i];
					tmpInfo = tmpInfo + tmpSK + "&" + tmpSV + ";";
				}
				obj_value = tmpInfo;
//				console.log(obj_value);
			}
			itemData[obj_name] = obj_value;
		});
		itemDataList.push(itemData);
	 });
//	 console.log(itemDataList);
	 return itemDataList;
}

//数组排列组合
function doExchange(arr){
	var len = arr.length;
	if (len >= 2) {
		var len1 = arr[0].length;
		var len2 = arr[1].length;
		var lenBoth = len1 * len2;
		var items = new Array(lenBoth);
		var index = 0;
		for (var i=0; i<len1; i++) {
			for (var j=0; j<len2; j++) {
				items[index] = arr[0][i]+","+arr[1][j];
				index++;
			}
		}
		var newArr = new Array(len - 1);
		for(var i=2; i<arr.length; i++) {
			newArr[i-1] = arr[i];
		}
		newArr[0] = items;
		return doExchange(newArr);
	} else {
		return arr[0];
	}
}

function clearNoNum(obj)    
{    
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

//重构table
function rebuildSupplierTable(){
	  $("#dynamicSupplier-table").empty();
	  $("#dynamicSupplier-head").empty();
	  
	  reGetSelectInfo();
	  
	  var htmlArray = new Array();
	  if(valueIdArray.length>0){
		  if(valueTextArray[0].length>0){
			  var trHtml = "";
			  for(var k=0;k<valueTextArray[0].length;k++){
				  rebuildSupplierTd(valueTextArray[0][k],valueTextArray,valueIdArray,0,htmlArray);
				  
				  trHtml += "<tr>";
				  for(var i=0;i<htmlArray.length;i++){
					  trHtml += htmlArray[i];
				  }
				  trHtml += "</tr>"
				  htmlArray = new Array();
			  }
			  $("#dynamicSupplier-table").html(trHtml);
			  
			  var thead = "<tr>";
			  if(keyText.length>0){
				  for(var i = 0;i<keyText.length;i++){
					  thead += "<th style='width: 5%;'>"+keyText[i]+"</th>"
				  }
			  }
			  thead += "<th><font style='color:red'>*</font>商家编码</th>";
			  thead += "<th>海关备案号</th>";
			  thead += "<th>海关备案单位</th>";
			  thead += "<th>保质期</th>";
			  thead += "<th><font style='color:red'>*</font>成本价</th>";
			  thead += "<th><font style='color:red'>*</font>供货价</th>";
			  thead += "<th><font style='color:red'>*</font>库存</th>";
			  thead += "</tr>";
			  
			  $("#dynamicSupplier-head").html(thead);
		  }
	  }
	  
//	  console.log("===valueIdArray===");
//	  console.log(valueIdArray);
//	  console.log("===valueTextArray===");
//	  console.log(valueTextArray);
//	  console.log("===keyText===");
//	  console.log(keyText);
//	  console.log("===keyId===");
//	  console.log(keyId);
}

function rebuildSupplierTd(text,valueTextArray,valueIdArray,index,htmlArray){
	var num = index;
	var rowSpanNum = 1;
	for(var j = num + 1;j < valueIdArray.length;j++){
		if(valueTextArray[j].length>0){
		 	rowSpanNum = rowSpanNum * valueIdArray[j].length;
		}
	}
	
	htmlArray.push("<td rowspan=\""+rowSpanNum+"\"><span name=\"info\">"+text+"</span></td>");
	
    if(num + 1 < valueIdArray.length && valueIdArray[num + 1].length>0){
		if(valueTextArray[num+1].length>0){
			for(var k=0;k<valueTextArray[num+1].length;k++){
				if(k!=0){
					htmlArray.push("<tr>");  
				}
				rebuildSupplierTd(valueTextArray[num+1][k],valueTextArray,valueIdArray,num+1,htmlArray);
				if(k!=0){
					htmlArray.push("</tr>");  
				}
			}
		}
	}
   
    if(num + 1 == valueIdArray.length){
	  	htmlArray.push("<td><input type=\"text\" class=\"form-control\" name=\"itemCode\"></td>");
	  	htmlArray.push("<td><input type=\"text\" class=\"form-control\" name=\"sku\"></td>");
	  	htmlArray.push("<td><input type=\"text\" class=\"form-control\" name=\"unit\"></td>");
	  	htmlArray.push("<td><input type=\"text\" class=\"form-control\" name=\"shelfLife\"></td>");
	  	htmlArray.push("<td><input type=\"text\" class=\"form-control\" name=\"costPrice\" onkeyup=\"clearNoNum(this)\" onafterpaste=\"clearNoNum(this)\"></td>");
	  	htmlArray.push("<td><input type=\"text\" class=\"form-control\" name=\"internalPrice\" onkeyup=\"clearNoNum(this)\" onafterpaste=\"clearNoNum(this)\"></td>");
	  	htmlArray.push("<td><input type=\"text\" class=\"form-control\" name=\"stockQty\" onkeyup=\"this.value=this.value.replace(/[^?\\d]/g,'')\" onafterpaste=\"this.value=this.value.replace(/[^?\\d]/g,'')\" value=\"100\"></td>");
	}
} 
