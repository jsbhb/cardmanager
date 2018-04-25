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
  <link rel="icon" href="${wmsUrl}/img/logo_1.png" type="image/x-icon"/>
  <%@include file="resourceLink.jsp"%>


</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper" style="overflow:hidden">
  <header class="main-header">
    <a href="javascript:void(0);" onclick="location.reload()" class="logo">
      <span class="logo-mini">ERP</span>
      <span class="logo-lg">供销贸易后台</span>
    </a>
    <nav class="navbar navbar-static-top">
      <a href="javascript:void(0);" class="sidebar-toggle" data-toggle="offcanvas" role="button">
        <span class="sr-only">Toggle navigation</span>
      </a>

      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
          <li class="dropdown user user-menu">
            <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown">
              <img src="${wmsUrl}/adminLTE/img/user2-160x160.jpg" class="user-image" alt="User Image">
              <span class="hidden-xs">${operator.optName}</span>
            </a>
            <ul class="dropdown-menu">
              <li class="user-header">
                <img src="${wmsUrl}/adminLTE/img/user2-160x160.jpg" class="img-circle" alt="User Image">
                <p>
                  ${operator.optName}
                </p>
              </li>
              <li class="user-footer">
                <div class="pull-left">
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
      <ul class="sidebar-menu">
        <c:forEach var="item" items="${childList}">
        <li class="treeview">
          <a href="javascript:void(0);">
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
	<div class="default-content">
		<div class="today-orders">
			<h1>当日统计</h1>
			<c:if test="${id!=35}">
				<c:forEach var="item" items="${title_data}">
					<div class="today-orders-item">
						<a href="javascript:void(0);">${item.value}</a>
						<p>${item.name}</p>
					</div>
				</c:forEach>
			</c:if>
		</div>
		<div class="week-line">
			<div class="timer-btns">
				<ul>
					<li class="active">周统计</li>
					<li>月统计</li>
					<li>年统计</li>
				</ul>
			</div>
			<div class="week-line-content" id="week-line-content"></div>
		</div>
	</div>
   </div>
</div>
<div class="customer-service">
	<ul>
		<li>
			<a href="http://wpa.qq.com/msgrd?v=3&uin=610139553&site=qq&menu=yes"><img src="${wmsUrl}/img/kf_01.png"/></a>
			<span>在线客服1</span>
		</li>
		<li>
			<a href="http://wpa.qq.com/msgrd?v=3&uin=1990002080&site=qq&menu=yes"><img src="${wmsUrl}/img/kf_01.png"/></a>
			<span>在线客服2</span>
		</li>
		<li>
			<a href="http://wpa.qq.com/msgrd?v=3&uin=281388429&site=qq&menu=yes"><img src="${wmsUrl}/img/kf_01.png"/></a>
			<span>在线客服3</span>
		</li>
	</ul>
</div>

<%@include file="resourceScript.jsp"%>
<script src="${wmsUrl}/js/mainpage.js"></script>
<script src="${wmsUrl}/js/mainPageNav.js"></script>
<script src="${wmsUrl}/adminLTE/js/app.js"></script>
<script>

$.widget.bridge('uibutton', $.ui.button);

var option = {
	title : {
		 text: '一周订单销售量变化',
	//       subtext: '纯属虚构'
	},
	tooltip : {
		 trigger: 'axis'
	},
	legend: {
		 data:['销售量']
	},
	toolbox: {
		show : true,
		feature : {
			mark : {show: false},
			dataView : {show: true, readOnly: false},
			magicType : {show: true, type: ['line', 'bar']},
			selfButtons: {//自定义按钮 danielinbiti,这里增加，selfbuttons可以随便取名字
				show:true,//是否显示
				title:'饼状图切换', //鼠标移动上去显示的文字
				icon:'${wmsUrl}/img/icon_pie.png', //图标
				option:{},
				onclick:function() {//点击事件,这里的option1是chart的option信息
					//这里可以加入自己的处理代码，切换不同的图形
					setCharts('week-line-content',option2);
				}
			},
			restore : {show: true},
			saveAsImage : {show: false}
		}
	},
	calculable : true,
	xAxis : [
		{
			type : 'category',
			boundaryGap : false,
			data : ['周一','周二','周三','周四','周五','周六','周日']
		}
	],
	yAxis : [
		{
			type : 'value',
			axisLabel : {
				formatter: '{value} 件'
			}
		}
	],
	series : [
		{
			name:'销售量',
			type:'line',
			data:[5, 8, 2, 18, 12, 13, 4],
			markPoint : {
				data : [
							{type : 'max', name: '最大值'},
							{type : 'min', name: '最小值'}
						]
			},
			markLine : {
				data : [
					{type : 'average', name: '平均值'}
						]
					}
			}
	]
};

var option2 = {
	title : {
		text: '某站点用户访问来源',
	//	subtext: '纯属虚构',
		x:'center'
	},
	tooltip : {
		trigger: 'item',
		formatter: "{a} <br/>{b} : {c} ({d}%)"
	},
	legend: {
		orient : 'vertical',
		x : 'left',
		data:['周一','周二','周三','周四','周五','周六','周日']
	},
	toolbox: {
		show : true,
		feature : {
			mark : {show: false},
			dataView : {show: true, readOnly: false},
			magicType : {
				show: true,
				type: ['pie', 'funnel'],
				option: {
					funnel: {
						x: '25%',
						width: '50%',
						funnelAlign: 'left',
						max: 1548
					}
				}
			},
			selfButtons: {//自定义按钮 danielinbiti,这里增加，selfbuttons可以随便取名字
				show:true,//是否显示
				title:'折线图切换', //鼠标移动上去显示的文字
				icon:'${wmsUrl}/img/icon_line.png', //图标
				option:{},
				onclick:function() {//点击事件,这里的option1是chart的option信息
					//这里可以加入自己的处理代码，切换不同的图形
					setCharts('week-line-content',option);
				}
			},
			restore : {show: true},
			saveAsImage : {show: false}
		}
	},
	calculable : true,
	series : [
		{
			name:'访问来源',
			type:'pie',
			radius : '55%',
			center: ['50%', '60%'],
			data:[
				{value:5, name:'周一'},
				{value:8, name:'周二'},
				{value:2, name:'周三'},
				{value:18, name:'周四'},
				{value:12, name:'周五'},
				{value:13, name:'周六'},
				{value:4, name:'周日'}
			]
		}
	]
};

setCharts('week-line-content',option);

$('.timer-btns').on('click','li',function(){
	$(this).addClass('active').siblings('.active').removeClass('active');
	//重新绘制图表

});

function modifyPwd(){
    var index = layer.open({
        title:"修改密码",
        type: 2,
        area:['50%','40%'],
        content: '${wmsUrl}/admin/modifyPwd.shtml',
        maxmin: false
    });
}

</script>
</body>
</html>

