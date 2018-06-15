var keyId = new Array();
var keyText = new Array();
var valueIdArray = new Array();
var valueTextArray = new Array();
	  
// disabled单品样式
function disabledItemSingle() {
	$("#itemCode").attr("disabled", true);
}

// 恢复单品样式
function abledItemSingle() {
	$("#itemCode").removeAttr("disabled");
}

// 动态新增规格输入框
function addSpecsModule() {
	var module = "";
}

// 删除新增规格输入框
function removeSpecsModule() {

}
$('#specsSwitch').on('click','li',function(){
	var typeId = $(this).attr('data-type');
	if(typeId == 0){
		$('#noSpecs').show();
		$('#specs').hide();
		
		$("#itemCode").removeAttr("disabled");
		$("#sku").removeAttr("disabled");
		$("#encode").removeAttr("disabled");
		$("#weight").removeAttr("disabled");
		$("#conversion").removeAttr("disabled");
		$("#conversion").val("1");
		$("#exciseTax").removeAttr("disabled");
		$("#exciseTax").val("0");
		$("#shelfLife").removeAttr("disabled");
		$("#carTon").removeAttr("disabled");
		$("#proxyPrice").removeAttr("disabled");
		$("#fxPrice").removeAttr("disabled");
		$("#retailPrice").removeAttr("disabled");
		$("#min").removeAttr("disabled");
		$("#max").removeAttr("disabled");

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
		$("#sku").attr("disabled", true);
		$("#sku").val("");
		$("#encode").attr("disabled", true);
		$("#encode").val("");
		$("#weight").attr("disabled", true);
		$("#weight").val("");
		$("#conversion").attr("disabled", true);
		$("#conversion").val("1");
		$("#exciseTax").attr("disabled", true);
		$("#exciseTax").val("");
		$("#shelfLife").attr("disabled", true);
		$("#shelfLife").val("");
		$("#carTon").attr("disabled", true);
		$("#carTon").val("");
		$("#proxyPrice").attr("disabled", true);
		$("#proxyPrice").val("");
		$("#fxPrice").attr("disabled", true);
		$("#fxPrice").val("");
		$("#retailPrice").attr("disabled", true);
		$("#retailPrice").val("");
		$("#min").attr("disabled", true);
		$("#min").val("");
		$("#max").attr("disabled", true);
		$("#max").val("");

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
			  thead += "<th style='width: 12%;'><font style='color:red'>*</font>商家编码</th>";
			  thead += "<th style='width: 12%;'><font style='color:red'>*</font>自有编码</th>";
			  thead += "<th style='width: 10%;'>条形码</th>";
			  thead += "<th style='width: 7%;'><font style='color:red'>*</font>商品重量</th>";
			  thead += "<th style='width: 5%;'><font style='color:red'>*</font>换算比例</th>";
			  thead += "<th style='width: 5%;'>消费税率</th>";
			  thead += "<th style='width: 5%;'>保质期</th>";
			  thead += "<th style='width: 5%;'>箱规</th>";
			  thead += "<th style='width: 5%;'><font style='color:red'>*</font>成本价</th>";
			  thead += "<th style='width: 5%;'><font style='color:red'>*</font>分销价</th>";
			  thead += "<th style='width: 5%;'><font style='color:red'>*</font>零售价</th>";
			  thead += "<th style='width: 10%;' colspan='2'>限购数量</th>";
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
	  	htmlArray.push("<td><input type=\"text\" class=\"form-control\" name=\"itemCode\"></td>");
	  	htmlArray.push("<td><input type=\"text\" class=\"form-control\" name=\"sku\"></td>");
	  	htmlArray.push("<td><input type=\"text\" class=\"form-control\" name=\"encode\"></td>");
	  	htmlArray.push("<td><input type=\"text\" class=\"form-control\" name=\"weight\" onkeyup=\"clearNoNum(this)\" onafterpaste=\"clearNoNum(this)\"></td>");
	  	htmlArray.push("<td><input type=\"text\" class=\"form-control\" name=\"conversion\" onkeyup=\"this.value=this.value.replace(/[^?\\d]/g,'')\" onafterpaste=\"this.value=this.value.replace(/[^?\\d]/g,'')\" value=\"1\"></td>");
	  	htmlArray.push("<td><input type=\"text\" class=\"form-control\" name=\"exciseTax\" onkeyup=\"clearNoNum(this)\" onafterpaste=\"clearNoNum(this)\" value=\"0\"></td>");
	  	htmlArray.push("<td><input type=\"text\" class=\"form-control\" name=\"shelfLife\"></td>");
	  	htmlArray.push("<td><input type=\"text\" class=\"form-control\" name=\"carTon\"></td>");
	  	htmlArray.push("<td><input type=\"text\" class=\"form-control\" name=\"proxyPrice\" onkeyup=\"clearNoNum(this)\" onafterpaste=\"clearNoNum(this)\"></td>");
	  	htmlArray.push("<td><input type=\"text\" class=\"form-control\" name=\"fxPrice\" onkeyup=\"clearNoNum(this)\" onafterpaste=\"clearNoNum(this)\"></td>");
	  	htmlArray.push("<td><input type=\"text\" class=\"form-control\" name=\"retailPrice\" onkeyup=\"clearNoNum(this)\" onafterpaste=\"clearNoNum(this)\"></td>");
	  	htmlArray.push("<td><input type=\"text\" class=\"form-control\" name=\"min\" onkeyup=\"this.value=this.value.replace(/[^?\\d]/g,'')\" onafterpaste=\"this.value=this.value.replace(/[^?\\d]/g,'')\"></td>");
	  	htmlArray.push("<td><input type=\"text\" class=\"form-control\" name=\"max\" onkeyup=\"this.value=this.value.replace(/[^?\\d]/g,'')\" onafterpaste=\"this.value=this.value.replace(/[^?\\d]/g,'')\"></td>");
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
		var itemPriceData={};
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

			if (obj_name == "proxyPrice" || obj_name == "fxPrice" ||
				obj_name == "retailPrice" || obj_name == "min" ||
				obj_name == "max") {
				itemPriceData[obj_name] = obj_value;
			} else {
				itemData[obj_name] = obj_value;
			}
		});
		itemData["goodsPrice"] = itemPriceData;
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

