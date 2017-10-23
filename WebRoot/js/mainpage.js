//Loads the correct sidebar on window load,
//collapses the sidebar on window resize.
// Sets the min-height of #page-wrapper to window size
$(function() {
	
	var newIframeObject=document.createElement("IFRAME");
	
    $(window).bind("load resize", function() {
        topOffset = 54; 
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
    	var height = window.innerHeight-topOffset+40;
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
