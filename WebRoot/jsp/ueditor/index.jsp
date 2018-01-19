<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <script type="text/javascript" charset="utf-8" src="${wmsUrl}/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${wmsUrl}/ueditor/ueditor.all.min.js"> </script>
    <%@include file="../resource.jsp"%>
    
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script type="text/javascript" charset="utf-8" src="lang/zh-cn/zh-cn.js"></script>

    <style type="text/css">
        div{
            width:100%;
        }
    </style>
</head>
<body>
<section class="content-wrapper">
	<section class="content">
		<div class="box box-info">
		 	<div class="box-body">
 				<form class="form-horizontal" role="form" id="itemForm" >
		 		<div>
			        <button type="button" class="btn btn-primary" onclick="saveHtml()">保存</button>
			    </div>
		 		<div>
				    <script id="editor" type="text/plain" name="ueditor" style="width:100%;height:500px;" align=center></script>
				</div>
				</form>
			</div>
		</div>
	</section>
</section>


<script type="text/javascript">

    //实例化编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
    var ue = UE.getEditor('editor');
    
    
    function sleep(numberMillis) { 
    	var now = new Date(); 
    	var exitTime = now.getTime() + numberMillis; 
    	while (true) { 
	    	now = new Date(); 
	    	if (now.getTime() > exitTime) 
	    	return; 
    	} 
   	}
    
    $(function(){
    	
    	var html = "${html}";
    	if(html == ""||html == "null"){
    		return;
    	}
    	$.ajax({
			 url:"${wmsUrl}/admin/goods/goodsMng/getDetailHtml.shtml",
			 type:'post',
			 data:{"html":html},
			 dataType:'json',
			 success:function(data){
				 if(data.success){	
				    ue.execCommand('insertHtml', data.msg);
				 }else{
					 layer.alert(data.msg);
				 }
			 },
			 error:function(){
				 layer.alert("提交失败，请联系客服处理");
			 }
		 });
    });
    
    function saveHtml(){
    	
    	var context = ue.getContent();
    	if(context == ''){
    		layer.alert("没有内容！");
    		return;
    	}
    	
    	$.ajax({
			 url:"${wmsUrl}/admin/goods/goodsMng/saveHtml.shtml",
			 type:'post',
			 data:{"html":context,"goodsId":${goodsId}},
			 dataType:'json',
			 success:function(data){
				 if(data.success){	
					 layer.alert("保存成功");
					 parent.reloadTable();
				 }else{
					 layer.alert(data.msg);
				 }
			 },
			 error:function(){
				 layer.alert("提交失败，请联系客服处理");
			 }
		 });
    }


    function isFocus(e){
        alert(UE.getEditor('editor').isFocus());
        UE.dom.domUtils.preventDefault(e)
    }
    function setblur(e){
        UE.getEditor('editor').blur();
        UE.dom.domUtils.preventDefault(e)
    }
    function insertHtml() {
        var value = prompt('插入html代码', '');
        UE.getEditor('editor').execCommand('insertHtml', value)
    }
    function createEditor() {
        enableBtn();
        UE.getEditor('editor');
    }
    function getAllHtml() {
        alert(UE.getEditor('editor').getAllHtml())
    }
    function getContent() {
        var arr = [];
        arr.push("使用editor.getContent()方法可以获得编辑器的内容");
        arr.push("内容为：");
        arr.push(UE.getEditor('editor').getContent());
        alert(arr.join("\n"));
    }
    function getPlainTxt() {
        var arr = [];
        arr.push("使用editor.getPlainTxt()方法可以获得编辑器的带格式的纯文本内容");
        arr.push("内容为：");
        arr.push(UE.getEditor('editor').getPlainTxt());
        alert(arr.join('\n'))
    }
    function setContent(isAppendTo) {
        var arr = [];
        arr.push("使用editor.setContent('欢迎使用ueditor')方法可以设置编辑器的内容");
        UE.getEditor('editor').setContent('欢迎使用ueditor', isAppendTo);
        alert(arr.join("\n"));
    }
    function setDisabled() {
        UE.getEditor('editor').setDisabled('fullscreen');
        disableBtn("enable");
    }

    function setEnabled() {
        UE.getEditor('editor').setEnabled();
        enableBtn();
    }

    function getText() {
        //当你点击按钮时编辑区域已经失去了焦点，如果直接用getText将不会得到内容，所以要在选回来，然后取得内容
        var range = UE.getEditor('editor').selection.getRange();
        range.select();
        var txt = UE.getEditor('editor').selection.getText();
        alert(txt)
    }

    function getContentTxt() {
        var arr = [];
        arr.push("使用editor.getContentTxt()方法可以获得编辑器的纯文本内容");
        arr.push("编辑器的纯文本内容为：");
        arr.push(UE.getEditor('editor').getContentTxt());
        alert(arr.join("\n"));
    }
    function hasContent() {
        var arr = [];
        arr.push("使用editor.hasContents()方法判断编辑器里是否有内容");
        arr.push("判断结果为：");
        arr.push(UE.getEditor('editor').hasContents());
        alert(arr.join("\n"));
    }
    function setFocus() {
        UE.getEditor('editor').focus();
    }
    function deleteEditor() {
        disableBtn();
        UE.getEditor('editor').destroy();
    }
    function disableBtn(str) {
        var div = document.getElementById('btns');
        var btns = UE.dom.domUtils.getElementsByTagName(div, "button");
        for (var i = 0, btn; btn = btns[i++];) {
            if (btn.id == str) {
                UE.dom.domUtils.removeAttributes(btn, ["disabled"]);
            } else {
                btn.setAttribute("disabled", "true");
            }
        }
    }
    function enableBtn() {
        var div = document.getElementById('btns');
        var btns = UE.dom.domUtils.getElementsByTagName(div, "button");
        for (var i = 0, btn; btn = btns[i++];) {
            UE.dom.domUtils.removeAttributes(btn, ["disabled"]);
        }
    }

    function getLocalData () {
        alert(UE.getEditor('editor').execCommand( "getlocaldata" ));
    }

    function clearLocalData () {
        UE.getEditor('editor').execCommand( "clearlocaldata" );
        alert("已清空草稿箱")
    }
</script>
</body>
</html>