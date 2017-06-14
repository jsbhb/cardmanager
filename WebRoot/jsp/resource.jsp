
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!-- 公共资源CSS,JS  -->
<!--Css -->
<link rel="stylesheet" href="${wmsUrl}/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${wmsUrl}/bootstrap/css/bootstrap-datetimepicker.min.css">
<link rel="stylesheet" href="${wmsUrl}/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="${wmsUrl}/css/jquery-confirm.css">
<link rel="stylesheet" href="${wmsUrl}/css/core.css">
<link rel="stylesheet" href="${wmsUrl}/css/zoom.css">
<link rel="stylesheet" href="${wmsUrl}/tableControl/tableControl.css">
<link rel="stylesheet" href="${wmsUrl}/css/exportTool.css">
<script type="text/javascript" src="${wmsUrl}/js/jquery.min.js"></script>
<script type="text/javascript" src="${wmsUrl}/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${wmsUrl}/bootstrap/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="${wmsUrl}/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script type="text/javascript" src="${wmsUrl}/js/pagination.js"></script>
<script type="text/javascript" src="${wmsUrl}/js/pageInit.js"></script>
<script type="text/javascript" src="${wmsUrl}/js/jquery-confirm.js"></script>
<script type="text/javascript" src="${wmsUrl}/js/manager.js"></script>
<script type="text/javascript" src="${wmsUrl}/js/syExtJquery.js"></script>
<script type="text/javascript" src="${wmsUrl}/js/zoom.min.js"></script>
<script type="text/javascript" src="${wmsUrl}/js/transition.js"></script>
<script type="text/javascript" src="${wmsUrl}/js/resetFunction.js"></script>
<script type="text/javascript" src="${wmsUrl}/tableControl/tableControl.js"></script>
<script type="text/javascript" src="${wmsUrl}/js/autoDeploy.js"></script>
<script type="text/javascript" src="${wmsUrl}/js/exportTool.js"></script>

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

