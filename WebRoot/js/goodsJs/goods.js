
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