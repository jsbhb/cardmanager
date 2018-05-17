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
		<c:choose>
		<c:when test="${id==35}">
			<div class="use-center">
				<div class="use-center-left">
					<ul>
						<li>18405817534</li>
						<li>已实名认证</li>
					</ul>
				</div>
				<div class="use-center-right">
					<ul>
						<li>推广收益</li>
						<li>￥0</li>
					</ul>
				</div>
			</div>
		</c:when>
		<c:when test="${id==51}">
			<div class="use-center">
				
			</div>
		</c:when>
		<c:otherwise>
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
					<li id="week" class="active">周统计</li>
					<li id="month">月统计</li>
				</ul>
			</div>
			<div class="week-line-content" id="week-line-content"></div>
		</div>
		</c:otherwise>
		</c:choose>
		
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

var option_week = {
	title : {
		
		 text: <c:if test="${id==1||id==17}">"周统计订单"</c:if><c:if test="${id==22}">"周统计销售额"</c:if>,
		
	//       subtext: '纯属虚构'
	},
	tooltip : {
		 trigger: 'axis'
	},
	legend: {
		 data:[<c:if test="${id==1||id==17}">"订单数量"</c:if><c:if test="${id==22}">"销售额"</c:if>]
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
					setCharts('week-line-content',option_chart_week);
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
			data : [
			<c:if test="${id==1||id==17}"><c:forEach var="node" items="${order_diagram_data_week.diagramData}" varStatus="index">"${node.name}"<c:if test="${index.last==false}">,</c:if></c:forEach></c:if>
			<c:if test="${id==22}"><c:forEach var="node" items="${finance_diagram_data_week.diagramData}" varStatus="index">"${node.name}"<c:if test="${index.last==false}">,</c:if></c:forEach></c:if>]
		}
	],
	yAxis : [
		{
			type : 'value',
			axisLabel : {
				formatter: '{value}'
			}
		}
	],
	series : [
		{
			name:'<c:if test="${id==1||id==17}">订单数量</c:if><c:if test="${id==22}">销售额</c:if>',
			type:'line',
			data:[
			<c:if test="${id==1||id==17}"><c:forEach var="node" items="${order_diagram_data_week.diagramData}" varStatus="index">"${node.value}"<c:if test="${index.last==false}">,</c:if></c:forEach></c:if>
			<c:if test="${id==22}"><c:forEach var="node" items="${finance_diagram_data_week.diagramData}" varStatus="index">"${node.value}"<c:if test="${index.last==false}">,</c:if></c:forEach></c:if>
			],
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

var option_month = {
		title : {
			
			 text: <c:if test="${id==1||id==17}">"月统计订单"</c:if><c:if test="${id==22}">"月统计销售额"</c:if>,
			
		//       subtext: '纯属虚构'
		},
		tooltip : {
			 trigger: 'axis'
		},
		legend: {
			 data:[<c:if test="${id==1||id==17}">"订单数量"</c:if><c:if test="${id==22}">"销售额"</c:if>]
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
						setCharts('week-line-content',option_chart_month);
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
				data : [
				      <c:if test="${id==1||id==17}"><c:forEach var="node" items="${order_diagram_data_month.diagramData}" varStatus="index">"${node.name}"<c:if test="${index.last==false}">,</c:if></c:forEach></c:if>
				      <c:if test="${id==22}"><c:forEach var="node" items="${finance_diagram_data_month.diagramData}" varStatus="index">"${node.name}"<c:if test="${index.last==false}">,</c:if></c:forEach></c:if>
				      ]
			}
		],
		yAxis : [
			{
				type : 'value',
				axisLabel : {
					formatter: '{value}'
				}
			}
		],
		series : [
			{
				name:'<c:if test="${id==1||id==17}">订单数量</c:if><c:if test="${id==22}">销售额</c:if>',
				type:'line',
				data:[
				     <c:if test="${id==1||id==17}"><c:forEach var="node" items="${order_diagram_data_month.diagramData}" varStatus="index">"${node.value}"<c:if test="${index.last==false}">,</c:if></c:forEach></c:if>
					<c:if test="${id==22}"><c:forEach var="node" items="${finance_diagram_data_month.diagramData}" varStatus="index">"${node.value}"<c:if test="${index.last==false}">,</c:if></c:forEach></c:if>],
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

var option_chart_week = {
	title : {
		text: '<c:if test="${id==1||id==17||id==22}">分区统计</c:if>',
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
		data:[
		 	<c:if test="${id==1||id==17}"><c:forEach var="node" items="${order_diagram_data_week.chartData}" varStatus="index">"${node.name}"<c:if test="${index.last==false}">,</c:if></c:forEach></c:if>
			<c:if test="${id==22}"><c:forEach var="node" items="${finance_diagram_data_week.chartData}" varStatus="index">"${node.name}"<c:if test="${index.last==false}">,</c:if></c:forEach></c:if>
			]
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
					setCharts('week-line-content',option_week);
				}
			},
			restore : {show: true},
			saveAsImage : {show: false}
		}
	},
	calculable : true,
	series : [
		{
			name:'<c:if test="${id==1||id==17||id==22}">统计来源</c:if>',
			type:'pie',
			radius : '55%',
			center: ['50%', '60%'],
			data:[
				<c:if test="${id==1||id==17}"><c:forEach var="node" items="${order_diagram_data_week.chartData}" varStatus="index">{value:"${node.value}",name:"${node.name}"}<c:if test="${index.last==false}">,</c:if></c:forEach></c:if>
				<c:if test="${id==22}"><c:forEach var="node" items="${finance_diagram_data_week.chartData}" varStatus="index">{value:"${node.value}",name:"${node.name}"}<c:if test="${index.last==false}">,</c:if></c:forEach></c:if>
			]
		}
	]
};

var option_chart_month = {
		title : {
			text: '<c:if test="${id==1||id==17||id==22}">分区统计</c:if>',
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
			data:[
			 	<c:if test="${id==1||id==17}"><c:forEach var="node" items="${order_diagram_data_month.chartData}" varStatus="index">"${node.name}"<c:if test="${index.last==false}">,</c:if></c:forEach></c:if>
				<c:if test="${id==22}"><c:forEach var="node" items="${finance_diagram_data_month.chartData}" varStatus="index">"${node.name}"<c:if test="${index.last==false}">,</c:if></c:forEach></c:if>
				]
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
						setCharts('week-line-content',option_month);
					}
				},
				restore : {show: true},
				saveAsImage : {show: false}
			}
		},
		calculable : true,
		series : [
			{
				name:'<c:if test="${id==1||id==17||id==22}">统计来源</c:if>',
				type:'pie',
				radius : '55%',
				center: ['50%', '60%'],
				data:[
					<c:if test="${id==1||id==17}"><c:forEach var="node" items="${order_diagram_data_month.chartData}" varStatus="index">{value:"${node.value}",name:"${node.name}"}<c:if test="${index.last==false}">,</c:if></c:forEach></c:if>
					<c:if test="${id==22}"><c:forEach var="node" items="${finance_diagram_data_month.chartData}" varStatus="index">{value:"${node.value}",name:"${node.name}"}<c:if test="${index.last==false}">,</c:if></c:forEach></c:if>
				]
			}
		]
	};



setCharts('week-line-content',option_week);

$('.timer-btns').on('click','li',function(){
	$(this).addClass('active').siblings('.active').removeClass('active');
	//重新绘制图表
	var id = $(this).attr('id');
	if(id == "week"){
		setCharts('week-line-content',option_week);
	}
	
	if(id == "month"){
		setCharts('week-line-content',option_month);
	}
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

