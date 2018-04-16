<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>供销贸易后台</title>
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.6 -->
  <link rel="stylesheet" href="${wmsUrl}/bootstrap/css/bootstrap.min.css">
  <link rel="stylesheet" href="${wmsUrl}/layer/layer.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="${wmsUrl}/font-awesome/css/font-awesome.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="${wmsUrl}/adminLTE/css/AdminLTE.css">
  <link rel="stylesheet" href="${wmsUrl}/adminLTE/css/skins/_all-skins.css">
  <!-- iCheck -->
  <link rel="stylesheet" href="${wmsUrl}/css/mainpage.css">
  <link rel="stylesheet" href="${wmsUrl}/css/google-font.css">
  

</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper" style="overflow:hidden">
  <header class="main-header">
    <a href="#" onclick="location.reload()" class="logo">
<!--     <a href="index2.html" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>ERP</span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg"><b>供销贸易后台</span>
    </a>
    <nav class="navbar navbar-static-top">
      <!-- Sidebar toggle button-->
      <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
        <span class="sr-only">Toggle navigation</span>
      </a>

      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
          <li class="dropdown user user-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <img src="${wmsUrl}/adminLTE/img/user2-160x160.jpg" class="user-image" alt="User Image">
              <span class="hidden-xs">${operator.optName}</span>
            </a>
            <ul class="dropdown-menu">
              <!-- User image -->
              <li class="user-header">
                <img src="${wmsUrl}/adminLTE/img/user2-160x160.jpg" class="img-circle" alt="User Image">
                <p>
                  ${operator.optName}
                </p>
              </li>
              <!-- Menu Body -->
              <!-- Menu Footer-->
              <li class="user-footer">
                <div class="pull-left">
                  <!-- <a href="modifyPwd()" class="btn btn-default btn-flat">修改密码</a> -->
                  <button type="button" onclick="modifyPwd()" class="btn btn-primary">修改密码</button>
                </div>
                <div class="pull-right">
                  <a href="${wmsUrl}/admin/logout.shtml" class="btn btn-default btn-flat">退出登录</a>
                </div>
              </li>
            </ul>
          </li>
        </ul>
      </div>
      <div class="type-bar">
      	<c:forEach var="item" items="${menuList}">
	  	<div class="type-bar-item" data-id="${item.funcId}">
	  		<i class="fa ${item.tag} fa-fw"></i>
	  		<p>${item.name}</p>
	  	</div>
	  	</c:forEach>
	  </div>
    </nav>
  </header>
  <aside class="main-sidebar">
    <section class="sidebar">
      <!-- Sidebar user panel -->
<!--       <div class="user-panel"> -->
<!--         <div class="pull-left image"> -->
<%--           <img src="${wmsUrl}/adminLTE/img/user2-160x160.jpg" class="img-circle" alt="User Image"> --%>
<!--         </div> -->
<!--         <div class="pull-left info"> -->
<%--           <p>${operator.optName}</p> --%>
<!--           <a href="#"><i class="fa fa-circle text-success"></i> Online</a> -->
<!--         </div> -->
<!--       </div> -->
      <!-- search form -->
      <!-- /.search form -->
      <!-- sidebar menu: : style can be found in sidebar.less -->
      <ul class="sidebar-menu">
        <c:forEach var="item" items="${childList}">
        <li class="treeview">
          <a href="#">
            <i class="fa ${item.tag}"></i> <span>${item.name}</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-right pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
          	<c:forEach var="node" items="${item.children}">
          	<li id="${node.funcId}">
          	<c:choose>
				<c:when test="${node.url==null}"><i class="fa fa-circle-o"></i>${node.name}</c:when>
				<c:otherwise> <a href="${wmsUrl}${node.url}?privilege=${node.privilege}"><i class="fa fa-circle-o" style="font-style:initial"></i>${node.name}</a></c:otherwise>
            </c:choose>
            </li>
            </c:forEach>
          </ul>
        </li>
        </c:forEach>
      </ul>
    </section>
  </aside>

   <div id="page-wrapper" class="iframePage">
   </div>
</div>

<!-- jQuery 2.2.3 -->
<script src="${wmsUrl}/jquery/jquery.js"></script>
<script type="text/javascript" src="${wmsUrl}/js/mainpage.js"></script>
<script type="text/javascript" src="${wmsUrl}/js/mainPageNav.js"></script>
<script src="${wmsUrl}/plugins/jQueryUI/jquery-ui.js"></script>
  <script src="${wmsUrl}/layer/layer.js"></script>
<script>
  $.widget.bridge('uibutton', $.ui.button);
  
  function modifyPwd(){
		var index = layer.open({
			  title:"修改密码",		
			  type: 2,
			  content: '${wmsUrl}/admin/modifyPwd.shtml',
			  maxmin: true
			});
			layer.full(index);
  }
  
  $('.type-bar').on('click','.type-bar-item',function(){
	  $('.type-bar .type-bar-item').removeClass('active');
	  $(this).addClass('active');
  });
  
  window.onload = function(){
	  var id = GetQueryString('id');
	  $('.type-bar-item[data-id='+id+']').addClass('active');
  }
  
  $('.type-bar').on('click','.type-bar-item',function(){
	  var id = $(this).attr('data-id');//获取id
	  var url = window.location.href;
	  if(url.indexOf('id') != -1){
		  url = url.split('?id')[0];
	  }
	  window.location.href = url + '?id=' + id;
	  
  });
  
  function GetQueryString(name){
      var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
      var r = window.location.search.substr(1).match(reg);
      if(r!=null)return  unescape(r[2]); return null;
 }
</script>
<!-- Bootstrap 3.3.6 -->
<script src="${wmsUrl}/bootstrap/js/bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="${wmsUrl}/adminLTE/js/app.js"></script>
</body>
</html>

