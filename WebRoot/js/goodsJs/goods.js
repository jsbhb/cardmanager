
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
	}else if(typeId == 1){
		$('#noSpecs').hide();
		$('#specs').show();
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

//重构table
function rebuildTable(){
	  $("#dynamic-table").empty();
	  $("#dynamic-thead").empty();
	  
	  var valueIdArray = new Array();
	  var valueTextArray = new Array();
	  var keyText = new Array();
	  var keyId = new Array();
	  
	  $(".select-key option:selected").each(function(){
		  if($(this).text()==''||$(this).val()==-1){		
			  return;
		  }
		  
		  keyText.push($(this).text());
		  keyId.push($(this).val());
		  
		  
		  var idArray = new Array();
		  var textArray = new Array();
		  
		  $(this).parent().parent().parent().parent().parent().find(".select-value option:selected").each(function(){
			  if($(this).text()==''||$(this).val()==-1){		
				  return;
			  }
			  
			  idArray.push($(this).val())
			  textArray.push($(this).text())
		  });
		  
		  if(idArray.length > 0){
			  valueIdArray.push(idArray);
			  valueTextArray.push(textArray);
		  }
		 
	  })
	  
	  
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
					  thead += "<td>"+keyText[i]+"</td>"
				  }
			  }
			  thead += "<td>1</td>";
			  thead += "<td>2</td>";
			  thead += "<td>3</td>";
			  thead += "<td>4</td>";
			  thead += "<td>5</td>";
			  thead +="</tr>";
			  
			  $("#dynamic-thead").html(thead);
		  }
	  }
}

function rebuildTd(text,valueTextArray,valueIdArray,index,htmlArray){
	var num = index;
	var rowSpanNum = 1;
	for(var j = num + 1;j < valueIdArray.length;j++){
		if(valueTextArray[j].length>0){
		 	rowSpanNum = rowSpanNum * valueIdArray[j].length;
		}
	}
	
	htmlArray.push("<td rowspan=\""+rowSpanNum+"\">"+text+"</td>");
	
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
	  	htmlArray.push("<td><input type=\"text\"></td>");
		htmlArray.push("<td><input type=\"text\"></td>");
		htmlArray.push("<td><input type=\"text\"></td>");
		htmlArray.push("<td><input type=\"text\"></td>");
		htmlArray.push("<td><input type=\"text\"></td>");
	}
} 

