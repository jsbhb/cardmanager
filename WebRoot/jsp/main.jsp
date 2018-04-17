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
  <style>
  	.iframePage{
  		background: #f9f9f9;
  		padding: 10px;
  		color: #333;
  		overflow: auto;
  		width: calc(100% - 136px);
  	}
  	.today-orders{
  		background: #fff;
  		padding: 15px;
  		overflow: hidden;
  	}
  	.today-orders h1{
  		font-size: 14px;
	    margin: 10px 0;
	    white-space: nowrap;
	    text-overflow: ellipsis;
	    overflow: hidden;
  	}
  	.today-orders .today-orders-item{
  		float: left;
  		width: calc(100% / 3);
  		height: 80px;
	    padding: 10px 20px;
	    text-align: center;
	    border-right: 1px dashed #e9e9e9;
  	}
  	.today-orders .today-orders-item:last-child{
  		border-right:none;
  	}
  	.today-orders .today-orders-item a{
	  	font-size: 22px;
	    line-height: 35px;
	    font-weight: normal;
	    color: #f47162;
  	}
  	.today-orders .today-orders-item p{
  		margin-top: 5px;
  	}
  	.today-pie,
  	.week-line{
  		padding: 10px;
  		margin-top: 10px;
  		background: #fff;
  		width: 100%;
  	}
  	.today-pie .today-pie-content{
  		width: 100%;
  		height: 250px;
  	}
  	.week-line .week-line-content{
  		width: 100%;
  		height: 500px;
  	}
  </style>
  

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
	<div class="today-orders">
		<h1>当日统计</h1>
		<div class="today-orders-item">
			<a href="javascript:void(0);">0</a>
			<p>出库单数</p>
		</div>
		<div class="today-orders-item">
			<a href="javascript:void(0);">0</a>
			<p>入库单数</p>
		</div>
		<div class="today-orders-item">
			<a href="javascript:void(0);">0</a>
			<p>销售额</p>
		</div>
	</div>
<!-- 	<div class="today-pie"> -->
<!-- 		<div class="today-pie-content" id="today-pie-content"></div> -->
<!-- 	</div> -->
	<div class="week-line">
		<div class="week-line-content" id="week-line-content"></div>
	</div>
   </div>
</div>

<!-- jQuery 2.2.3 -->
<script src="${wmsUrl}/jquery/jquery.js"></script>
<script type="text/javascript" src="${wmsUrl}/js/mainpage.js"></script>
<script type="text/javascript" src="${wmsUrl}/js/mainPageNav.js"></script>
<script src="${wmsUrl}/plugins/jQueryUI/jquery-ui.js"></script>
<script src="${wmsUrl}/layer/layer.js"></script>
<script src="${wmsUrl}/build/dist/echarts.js"></script>
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
  //创建图表
  require.config({
        paths: {
            echarts: '${wmsUrl}/build/dist'
        }
    });
    require(
        [
            'echarts',
            'echarts/chart/pie',//饼图
            'echarts/chart/line',//折线图
            'echarts/chart/bar',//柱状图
            'echarts/chart/funnel'//d
        ],
        function (ec) {
//             var myChart1 = ec.init(document.getElementById('today-pie-content'));
            var myChart2 = ec.init(document.getElementById('week-line-content'));
//             var option1 = {
//                 title : {
//                     text: '某站点用户访问来源',
//                     subtext: '纯属虚构',
//                     x:'center'
//                 },
//                 tooltip : {
//                     trigger: 'item',
//                     formatter: "{a} <br/>{b} : {c} ({d}%)"
//                 },
//                 legend: {
//                     orient : 'vertical',
//                     x : 'left',
//                     data:['直接访问','邮件营销','联盟广告','视频广告','搜索引擎']
//                 },
//                 toolbox: {
//                     show : true,
//                     feature : {
//                         mark : {show: true},
//                         dataView : {show: true, readOnly: false},
//                         magicType : {
//                             show: true,
//                             type: ['pie', 'funnel'],
//                             option: {
//                                 funnel: {
//                                     x: '25%',
//                                     width: '50%',
//                                     funnelAlign: 'left',
//                                     max: 1548
//                                 }
//                             }
//                         },
//                         restore : {show: true},
//                         saveAsImage : {show: true}
//                     }
//                 },
//                 calculable : true,
//                 series : [
//                     {
//                         name:'访问来源',
//                         type:'pie',
//                         radius : '55%',
//                         center: ['50%', '60%'],
//                         data:[
//                             {value:335, name:'直接访问'},
//                             {value:310, name:'邮件营销'},
//                             {value:234, name:'联盟广告'},
//                             {value:135, name:'视频广告'},
//                             {value:1548, name:'搜索引擎'}
//                         ]
//                     }
//                 ]
//             };
            
            option2 = {
           	    title : {
           	        text: '一周订单销售量变化',
//            	        subtext: '纯属虚构'
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
           	            mark : {show: true},
           	            dataView : {show: true, readOnly: false},
           	            magicType : {show: true, type: ['line', 'bar']},
           	            restore : {show: true},
           	            saveAsImage : {show: true}
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
           	        },
//            	        {
//            	            name:'最低气温',
//            	            type:'line',
//            	            data:[1, -2, 2, 5, 3, 2, 0],
//            	            markPoint : {
//            	                data : [
//            	                    {name : '周最低', value : -2, xAxis: 1, yAxis: -1.5}
//            	                ]
//            	            },
//            	            markLine : {
//            	                data : [
//            	                    {type : 'average', name : '平均值'}
//            	                ]
//            	            }
//            	        }
           	    ]
           	};
            
//             myChart1.setOption(option1);
            myChart2.setOption(option2);
            
        }
    );
  
</script>
<!-- Bootstrap 3.3.6 -->
<script src="${wmsUrl}/bootstrap/js/bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="${wmsUrl}/adminLTE/js/app.js"></script>
</body>
</html>

