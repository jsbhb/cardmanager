
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!-- 公共资源CSS,JS  -->
<!--Css -->
<link rel="stylesheet" href="${wmsUrl}/layer/layer.css">
<link rel="stylesheet" href="${wmsUrl}/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${wmsUrl}/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="${wmsUrl}/css/mainpage.css">
<link rel="stylesheet" href="${wmsUrl}/css/tree.css">
<link rel="stylesheet" href="${wmsUrl}/adminLTE/css/AdminLTE.css">
<link rel="stylesheet" href="${wmsUrl}/adminLTE/css/skins/_all-skins.css">
<link rel="stylesheet" href="${wmsUrl}/adminLTE/css/skins/_all-skins.css">
<script src="${wmsUrl}/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="${wmsUrl}/plugins/jQueryUI/jquery-ui.js"></script>
<script src="${wmsUrl}/js/manager.js"></script>
<script src="${wmsUrl}/layer/layer.js"></script>
<script src="${wmsUrl}/js/syExtJquery.js"></script>
<script src="${wmsUrl}/bootstrap/js/bootstrap.min.js"></script>
<script src="${wmsUrl}/adminLTE/js/app.js"></script>

<script>
$(function(){
	 $.ajaxSetup({
			timeout: 300000,
			dataType: 'html',
			complete: function (xhr, status) {
				var sessionstatus=xhr.getResponseHeader("sessionstatus");
				
				if(sessionstatus == "timeout"){
					var top = getTopWindow();
					top.location.href = '${wmsUrl}/admin/toLogin.shtml';
				}
			}
	 })
})

/**
 * 在页面中任何嵌套层次的窗口中获取顶层窗口
 * @return 当前页面的顶层窗口对象
 */
function getTopWindow(){
    var p = window;
   while(p != p.parent){
       p = p.parent;
    }
    return p;
}
</script>

