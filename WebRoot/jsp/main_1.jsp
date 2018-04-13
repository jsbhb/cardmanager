<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>

<!DOCTYPE HTML>
<html lang="en">
	<head>	
    <meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=no">
	 <title>正正电子跨境仓储系统</title>	 
	 	<link href="${wmsUrl}/bootstrap/css/bootstrap.min.css" rel="stylesheet"> 
		<link href="${wmsUrl}/metisMenu/css/metisMenu.min.css" rel="stylesheet">
		<link href="${wmsUrl}/font-awesome/css/font-awesome.min.css" rel="stylesheet"> 
		<link href="${wmsUrl}/css/mainpage.css" rel="stylesheet">    
	</head>
	<body>
		<nav class="navbar navbar-default navbar-static-top mainNavTop" role="navigation" style="margin-bottom: 0">
			<div class="navbar-header">
	                <button type="button" class="navbar-toggle mainNavBtn" data-toggle="collapse" data-target=".navbar-collapse">
	                    <span class="sr-only">Toggle navigation</span>
	                    <span class="icon-bar"></span>
	                    <span class="icon-bar"></span>
	                    <span class="icon-bar"></span>
	                </button>
	                
                    <div class="header-1">
                      <a href="${wmsUrl}/admin/main.shtml">
                      <img src="${wmsUrl}/img/backgrounds/1.png"/>
                      </a>
                    </div>
                    <div class="header-2">
                      <a href="${wmsUrl}/admin/main.shtml">
                        <span>WMS跨境仓储系统</span>
                      </a>
                    </div>
	                
	            </div>
	            <ul class="nav navbar-top-links navbar-right">
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);">
                        <i class="fa fa-envelope fa-fw"></i>  <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-messages">
                        <li>
                            <a href="javascript:void(0);">
                                    <strong>John Smith</strong>
                                    <span class="pull-right text-muted">
                                        <em>Yesterday</em>
                                    </span>
                            </a>
                        </li>
                        <li class="divider"></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);">
                        <i class="fa fa-bell fa-fw"></i>  <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-alerts">
                        <li>
                            <a href="javascript:void(0);">
                                    <i class="fa fa-comment fa-fw"></i> New Comment
                                    <span class="pull-right text-muted small">4 minutes ago</span>
                            </a>
                        </li>
                        <li class="divider"></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);">
                        <i class="fa fa-user fa-fw"></i>${operator.optName} <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <li><a href="${wmsUrl}/admin/individual/mngTab.shtml"><i class="fa fa-user fa-fw"></i> 个人管理</a>
                        </li>
                        <li><a href="javascript:void(0);"><i class="fa fa-gear fa-fw"></i> 设置</a>
                        </li>
                        <li class="divider"></li>
                        <li><a href="${wmsUrl}/admin/logout.shtml"><i class="fa fa-sign-out fa-fw"></i> 退出</a>
                        </li>
                    </ul>
                </li>
            </ul>
            
            <div class="Kbar-default sidebar mainNavLeft" role="navigation">
            	<div  class="sidebar-nav navbar-collapse">
            		<ul class="nav in" id="side-menu">
            			<c:forEach var="item" items="${menuList}">
            				<li>
	            				<a href="javascript:void(0);"><i class="fa ${item.tag} fa-fw"></i> ${item.name}<span class="fa arrow"></span></a>
	            				<ul class="nav nav-second-level">
		            				<c:forEach var="node" items="${item.children}">
			            				<li>
			            				<c:choose>
			            					<c:when test="${node.url==null}">${node.name}</c:when>
			            					<c:otherwise> <a href="${wmsUrl}${node.url}?privilege=${node.privilege}"  onclick="navbarCollapseDisplay()">${node.name}</a></c:otherwise>
		                                </c:choose>
		                                </li>
									</c:forEach>
	            				</ul>
            				</li>
						</c:forEach>
            		</ul>
            	</div>
            </div>
		</nav>
		<div id="page-wrapper" class="iframePage">
		</div>
		
		<script type="text/javascript" src="${wmsUrl}/js/jquery.min.js"></script>
	    <script type="text/javascript" src="${wmsUrl}/bootstrap/js/bootstrap.min.js"></script>
	    <script type="text/javascript" src="${wmsUrl}/metisMenu/js/metisMenu.min.js"></script>
	    <script type="text/javascript" src="${wmsUrl}/js/mainpage.js"></script>
        <script type="text/javascript" src="${wmsUrl}/js/mainPageNav.js"></script>
	    
	</body>
</html>
