//Loads the correct sidebar on window load,
//collapses the sidebar on window resize.
// Sets the min-height of #page-wrapper to window size
$(function() {
	
	var newIframeObject=document.createElement("IFRAME");
	
    $(window).bind("load resize", function() {
        topOffset = 68; 
        width = (this.window.innerWidth > 0) ? this.window.innerWidth : this.screen.width;
        if (width < 768) {
            $('div.navbar-collapse').addClass('collapse');
            topOffset = 84; // 2-row-menu
        } else {
            $('div.navbar-collapse').removeClass('collapse');
        }

        height = ((this.window.innerHeight > 0) ? this.window.innerHeight : this.screen.height);
        height = height - topOffset;
        if (height < 1) height = 1;
        if (height > topOffset) {
            $("#page-wrapper").css("height", (height) + "px");
        }

        //在电脑端允许onresize事件
        if (width >= 768) {
            var height = window.innerHeight-topOffset;
        	var width = "100%";
                newIframeObject.height=height; 
                newIframeObject.width=width;
        }
    });

    var url = window.location;
    var element = $('.treeview-menu a').filter(function() {
    	var flat = this.href == url || url.href.indexOf(this.href) == 0;
        return flat;
    }).addClass('active').parent().parent().addClass('in').parent();
    if (element.is('li')) {
        element.addClass('active');
    }
    $('.treeview-menu a').filter(function() {
    	var flat = this.href !=null||this.href!="#"||this.href!=""||this.href!=url+"#";
        return flat;
    }).bind('click',function(){
    	
    	if(this.href == "javascript:void(0);"){
    		return;
    	}
    	
    	var width = "100%";
    	var height = window.innerHeight-topOffset-10;
        newIframeObject.width=width;
        newIframeObject.height=height; 
        newIframeObject.src=this.href;
        newIframeObject.scrolling="yes";
        newIframeObject.frameBorder=0;
    	$("#page-wrapper").empty();
        $("#page-wrapper").append(newIframeObject);
        return false;
    });
});

//左侧导航栏超出滚动
var scrollFunc = function (e) {  
	var offsetHeight = $('.sidebar-menu').height();
    var height = $(window).height() - 68;
    e = e || window.event;  
    $('.sidebar-menu').stop();
    if(offsetHeight > height){
    	if (e.wheelDelta) {  //判断浏览器IE，谷歌滑轮事件               
            if (e.wheelDelta > 0) { //当滑轮向上滚动时  
            	$('.sidebar-menu').animate({
            		marginTop: 0
            	},300);
            	return false;
            }  
            if (e.wheelDelta < 0) { //当滑轮向下滚动时  
            	$('.sidebar-menu').animate({
            		marginTop: height - offsetHeight
            	},300);
            	return false;
            }  
        } else if (e.detail) {  //Firefox滑轮事件  
            if (e.detail < 0) { //当滑轮向上滚动时  
            	$('.sidebar-menu').animate({
            		marginTop: 0
            	},300);
            	return false;
            }  
            if (e.detail > 0) { //当滑轮向下滚动时  
            	$('.sidebar-menu').animate({
            		marginTop: height - offsetHeight
            	},300);
            	return false;
            }  
        }  
    }
}  
//给页面绑定滑轮滚动事件  
if (document.addEventListener) {  
    document.addEventListener('DOMMouseScroll', scrollFunc, false);  
}  
//滚动滑轮触发scrollFunc方法  
window.onmousewheel = document.onmousewheel = scrollFunc; 	

$('.sidebar-menu').on('click','.treeview',function(){
//	  var offsetHeight = $('.sidebar-menu').height();
//    var height = $(window).height() - 68;
	$('.sidebar-menu').stop();
	$('.sidebar-menu').animate({
		marginTop: 0
	},300);
//    if(offsetHeight > height){
//    	$('.sidebar-menu').animate({
//    		marginTop: height - offsetHeight
//    	},300);
//    }else if(offsetHeight <= height){
//    	$('.sidebar-menu').animate({
//    		marginTop: 0
//    	},300);
//    }
	
});
$('.sidebar-toggle').click(function(){
	if( $('body').hasClass('sidebar-collapse')){
		$('body').removeClass('sidebar-collapse');
	}else{
		$('body').addClass('sidebar-collapse');
	}
    setTimeout(function(){
        $("#page-wrapper").css("width",window.innerWidth - $('.main-sidebar').width());
        setCharts('week-line-content',option);
    },300);
});

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
