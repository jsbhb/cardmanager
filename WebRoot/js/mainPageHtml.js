	
  //页面加载时执行
	 function loadMainPage(){	 
		  // 获取页面宽高
	      var pageWidth = (window.top.innerWidth > 0) ? window.top.innerWidth : window.screen.width;
	      var pageHeight = (window.top.innerHeight > 0) ? window.top.innerHeight : window.screen.height; 
	      // 判断是否为电脑端
	      var isPC = pageWidth>768||pageWidth==768;
          //非电脑端左侧导航默认显示
	      if(!isPC){ $("#mainLeftNav>div").addClass("in"); } 
          //页面左侧导航以及右侧内容，两者高度自适应
	      main_height()
	      // 获取页面顶部导航的高度(电脑端为60,非电脑端为82)
	      var mainTopNavHeight = isPC?60:82;  
          // 右侧标签模块(ul元素)内边距
		  var ulPaddingLeft = 7; 
	      // 右侧标签模块(ul元素)宽度初始值
		  var ulWidth = ulPaddingLeft;	  
	      // 设置右侧标签模块(ul元素)宽度
		  $("#mainNavTabs>ul>li").each(function(){ ulWidth+=$(this).width()+6; })
		  $("#mainNavTabs>ul").css("width",ulWidth+"px");     
	 }

	 
	
  //页面左侧导航以及右侧内容，两者高度自适应
	 function main_height(){
	  // 获取页面宽高
	     var pageWidth = (window.top.innerWidth > 0) ? window.top.innerWidth : window.screen.width;
	     var pageHeight = (window.top.innerHeight > 0) ? window.top.innerHeight : window.screen.height; 
	     // 判断是否为电脑端
	     var isPC = pageWidth>768||pageWidth==768; 
	     // 获取页面顶部导航的高度(电脑端为60,非电脑端为82)
	     var mainTopNavHeight = isPC?60:82;   
	     // 判断页面左侧导航是否显示
	     var mainLeftNav_IsShow = $("#mainLeftNav").height()>0;   
	     // 设置页面左侧导航以及右侧内容的高度,
	     if(isPC){
	     	 $("#mainLeftNav").css("height",(pageHeight-mainTopNavHeight)+"px");  
	         $("#mainContainer").css("height",(pageHeight-mainTopNavHeight)+"px");  
	     }
	     else if(mainLeftNav_IsShow){
		     $("#mainLeftNav").css("height",(pageHeight-mainTopNavHeight)+"px"); 
		     $("#mainLeftNav>div").addClass("in"); 
	         $("#mainContainer").css("height","0px");  
	     }
	  }   

	      
  //加载子页面
	 function loadIframePage(e,$this,title,path,target){ // $this:单击时的a元素，title:页面标题，path:页面路径，target:页面打开方式	 
		 //事件
		 var e=window.event||e; 
	     // 标签元素以及页面 iframe元素
	     var li = '<li class="active"><a data-toggle="tab" aria-expanded="true"><span class="fa fa-remove fa-fw"></span></a></li>';    				
	     var div ='<div class="tab-pane fade active in" style="height:100%"><iframe height="100%" width="100%" scrolling="yes" frameborder="0"></iframe></div>'; 
	     // 获取所单击的元素
	     var $this = $this || $(this);     
	     // 页面标题
	     var title= title || $this.text().trim();    	 
	     // 页面路径
	     var path = path || $this.attr("href");	   
	     // 页面打开方式
	     var target = target || $this.attr("target");     
	     // 是否已有该标签所对应的页面
	     var pageExist = $("#mainNavTabs a[path='"+path+"']").length>0;  
	     // 如果是退出路径，则返回到登录界面
	     if($this.hasClass("sign-out")||$this.hasClass("mainHomePage")){
	    	 window.location.href = path;
	         return false;		 
	     }    
	     // 页面切换、刷新、打开
	 	 if(pageExist&&target!="new"){	
	        //所单击的元素对应的页面ID值
			var pageId = $("#mainNavTabs a[path='"+path+"']").attr("href");
	 		//设置相应标签为选中状态，对应页面显示
			$("#mainNavTabs>ul.nav-tabs>li").removeClass("active");
			$("#mainNavTabs>ul.nav-tabs>li>a[href^='"+pageId+"']").parent().addClass("active");
			$("#mainContent>.tab-content>.tab-pane").removeClass("active in");
			$("#mainContent>.tab-content>"+pageId).addClass("active"); 
			$("#mainContent>.tab-content>"+pageId).addClass("in");

	 		//页面刷新,否则页面查询数据
			if(target=="refresh"){  
	         	 $("#mainContent>.tab-content>"+pageId+">iframe").attr("src",path); 
			}
			else{
				//重新查询 
				if($("#mainContent>.tab-content>"+pageId).find(">iframe")[0].contentWindow.$(".jconfirm").length==0){
					$("#mainContent>.tab-content>"+pageId).find(">iframe")[0].contentWindow.$("body>div").each(function(){
						if($(this).css("display")!="none"){
							$(this).find(".query #querybtns").each(function(){
								$(this).click();
							})
						}
					});
				}
			}
		 }
		 else{
			//页面新建
			 var i = 1; 
			 while($("#mainNavTabs a[href=#tabMenu"+i+"]").length==1){ i++; }
			 var $li = $(li); 
			 $li.find(">a").attr("href","#tabMenu"+i); 
			 $li.find(">a").attr("path",path); 
			 $li.find(">a").html(title+$li.find(">a").html());
		     $("#mainNavTabs>ul.nav-tabs").append($li);   
			 var $div = $(div); 
			 $div.attr("id","tabMenu"+i); 
			 $("#mainContent>.tab-content").append($div);
         	 $("#mainContent>.tab-content>#tabMenu"+i+">iframe").attr("src",path);  	 
			 $("#mainNavTabs>ul.nav-tabs>li").removeClass("active");
			 $("#mainNavTabs>ul.nav-tabs>li>a[href^='#tabMenu"+i+"']").parent().addClass("active");
			 $("#mainContent>.tab-content>[id^='tabMenu']").removeClass("active in");
			 $("#mainContent>.tab-content>#tabMenu"+i).addClass("active"); 
			 $("#mainContent>.tab-content>#tabMenu"+i).addClass("in");  
		 } 
         //延时关闭刷新图标旋转
	 	 setTimeout(function(){$("#mainRefresh>span.fa-refresh").removeClass("rotate")},400); 
         // 右侧标签模块(ul元素)内边距
		 var ulPaddingLeft = 7;	 
	     // 右侧标签模块(ul元素)宽度初始值
		 var ulWidth = ulPaddingLeft;  
	     // 设置右侧标签模块(ul元素)宽度
		 $("#mainNavTabs>ul>li").each(function(){ ulWidth+=$(this).width()+6; })
		 $("#mainNavTabs>ul").css("width",ulWidth+"px");  	 
		 //取消游览器默认事件
		 e.preventDefault(); 
	 }
	 
	
   //左侧导航项单击事件
	 function mainLeftNav_click(e){	 
	     // 获取页面宽高
	     var pageWidth = (window.top.innerWidth > 0) ? window.top.innerWidth : window.screen.width;
	     var pageHeight = (window.top.innerHeight > 0) ? window.top.innerHeight : window.screen.height;   
	     // 判断是否为电脑端
	     var isPC = pageWidth>768||pageWidth==768;
	     // 获取页面顶部导航的高度(电脑端为60,非电脑端为82)
	     var topOffset = isPC?60:82;     
	     // 非手机端左侧导航项隐藏,右侧内容显示
		 if(!isPC){
	    	$("#mainLeftNav").find(".in").removeClass("in");
	        $("#mainLeftNav .active").removeClass("active");
	        $("#mainLeftNav").animate({height:'0px'},300);
	        $("#mainContainer").animate({height:(pageHeight-topOffset)+'px'},300);
	     }	 
		 // 加载iframe元素(在捕捉元素时，发现首先捕捉到的是window，故需要进行过滤)
		 if(this!=window){loadIframePage(e,$(this));}
	 }
	      
	     
	 
   //顶部切换按钮单击事件
	 function mainTopNav_click(){ 
	     // 获取页面宽高
	     var pageWidth = (window.top.innerWidth > 0) ? window.top.innerWidth : window.screen.width;
	     var pageHeight = (window.top.innerHeight > 0) ? window.top.innerHeight : window.screen.height;    
	     // 判断是否为电脑端
	     var isPC = pageWidth>768||pageWidth==768;
	     // 获取页面顶部导航的高度(电脑端为60,非电脑端为82)
	     var topOffset = isPC?60:82;     
	     // 判断页面左侧导航是否显示
	     var mainLeftNav_IsShow = $("#mainLeftNav").height()>0;       
	     // 判断页面右侧所引用的页面是否显示
	     var mainContainer_IsShow = $("#mainContainer").height()>0;    
	     // 左侧导航以及右侧内容高度设置
	     if(mainContainer_IsShow&&!mainLeftNav_IsShow){ 
	         $("#mainLeftNav").animate({height:(pageHeight-topOffset)+'px'},300);
	         $("#mainContainer").animate({height:0+'px'},300);
	     }
	     if(!mainContainer_IsShow&&mainLeftNav_IsShow){
	         $("#mainLeftNav").animate({height:'0px'},300);
	         $("#mainContainer").animate({height:(pageHeight-topOffset)+'px'},300);
	     }
	 }

 
  //页面刷新事件
	 function mainNavTabsRefreshBtn_click(){ 	 
		 //获取当前页面路径
		 var path = $("#mainContent>.tab-content>.tab-pane.active.in>iframe").attr("src");
		 //设置页面路径
		 $("#mainContent>.tab-content>.tab-pane.active.in>iframe").attr("src",path);	 
         //延时关闭刷新图标旋转
		 setTimeout(function(){$("#mainRefresh>span.fa-refresh").removeClass("rotate")},400); 
     }
	 
	 
  //标签切换事件
	 function mainNavTabsLi_click(){	 
		 //获取所点击的标签对应页面的id
		 var pageId = $(this).attr("href");
		 //重新查询 
		 if($("#mainContent>.tab-content>"+pageId).find(">iframe")[0].contentWindow.$(".jconfirm").length==0){
			 $("#mainContent>.tab-content>"+pageId).find(">iframe")[0].contentWindow.$("body>div").each(function(){
				 if($(this).css("display")!="none"){
					 $(this).find(".query #querybtns").each(function(){
						 $(this).click();
					 })
				 }
			 });
		 }
	 }
	 
 
  //页面关闭事件
	 function mainNavTabsRemoveBtn_click(){

    	 var thisPageId = $(this).parent().attr("href"); // 获取所要关闭标签对应页面ID值
    	 var $thisLi = $(this).parent().parent();  // 获取标签元素
    	 var childPage_IsShow = $(this).parents("li:first").hasClass("active");// 判断所要关闭的页面是否为显示状态
    	 
    	 // 关闭标签页、对应的页面，相邻的页面、标签页为显示状态
    	 if(childPage_IsShow){	   
    		 //获取前一个、后一个标签元素   
        	 var $prevLi = $thisLi.prev();
        	 var $nextLi = $thisLi.next();
        	 //关闭页面时，设定前一个或后一个标签及其对应页面显示
        	 if($prevLi.length>0){	 
        		//获取前一个标签内a元素所对应的页面Id 
        		var prevPageId = $thisLi.prev().find(">a[href]").attr("href");
                // 前一个标签以及所对应的页面为显示状态
        		$prevLi.addClass("active");
        		$("#mainContent>.tab-content>"+prevPageId).addClass("active");
        		$("#mainContent>.tab-content>"+prevPageId).addClass("in");	 
        		
        	 }
        	 else if($nextLi.length>0){ 
         		//获取后一个标签内a元素所对应的页面Id 
         		var nextPageId = $thisLi.next().find(">a[href]").attr("href");	
                // 后一个标签以及所对应的页面为显示状态
         		$thisLi.next().addClass("active");
         		$("#mainContent>.tab-content>"+nextPageId).addClass("active");
         		$("#mainContent>.tab-content>"+nextPageId).addClass("in");	 	 
        	 }
         } 	 
    	 // 关闭所单击的页面
    	 $thisLi.remove();
    	 $("#mainContent>.tab-content>"+thisPageId).remove();	 
         // 右侧标签模块(ul元素)内边距
		 var ulPaddingLeft = 7; 
	     // 右侧标签模块(ul元素)宽度初始值
		 var ulWidth = ulPaddingLeft;  
	     // 设置右侧标签模块(ul元素)宽度
		 $("#mainNavTabs>ul>li").each(function(){ ulWidth+=$(this).width()+6; })
		 $("#mainNavTabs>ul").css("width",ulWidth+"px");  
     }
	 
	 
	 
  //页面标签滑动事件
	 function main_mousewheel(e){	    
		 //对象代表事件的状态
	     var e = window.event||e;
	     // 右侧标签模块(ul元素)当前偏移量以及最大左偏移量(注意该值为负值)
	     var ulMarginLef =  parseInt($("#mainNavTabs>ul").css("margin-left"))||0;
	     var ulMaxMgrinLeft = $("#mainNavTabs").width()-$("#mainNavTabs>ul").width()-7;  
	     // 根据鼠标每次滑动方向，设置其值为100或-100
	     var range = (e.wheelDeltaY>0?100:e.wheelDeltaY<0?-100:0)||(Math.abs(e.deltaY)==1?(e.deltaY>0?100:e.deltaY<0?-100:0):(e.deltaY>0?-100:e.deltaY<0?100:0));   
	     // 右侧标签模块(ul元素)偏移量设置
	     if(ulMarginLef+range>0){
	    	 $("#mainNavTabs>ul").css("margin-left","0");
	     }
	     else if(ulMarginLef+range<ulMaxMgrinLeft){
	    	 $("#mainNavTabs>ul").css("margin-left",ulMaxMgrinLeft+"px");
	     }
	     else{
	    	 $("#mainNavTabs>ul").css("margin-left",(ulMarginLef+range)+"px");
	     }
	 }
		 
	 
	 $(function(e){
	
	     // 折叠菜单功能,允许自动折叠效果   
	        $('#side-menu').metisMenu();
	
	  	 // 页面加载执行
	        loadMainPage();

	        
    //----------- 以下是一些事件 -------------------------------        
	            
	     // 左侧导航条单击事件
	        $(document).on("click","#mainLeftNav a[href!='javascript:void(0);'][href!='#'],#mainTopNav a[href!='javascript:void(0);'][href!='#']",mainLeftNav_click);

	     // 刷新图标旋转
	        $(document).on("mousedown","#mainRefresh>span.fa-refresh",function(){ 
	        	$(this).addClass("rotate"); 
	        });

		 // 页面刷新(刷新图标单击)	        
	        $(document).on("mousedown","#mainRefresh>span.fa-refresh",mainNavTabsRefreshBtn_click);
	        
	     // 标签切换时的事件	        
	        $(document).on('show.bs.tab','#mainNavTabs a[data-toggle="tab"]',mainNavTabsLi_click);

	     // 页面关闭事件，对应页面关闭
	        $(document).on("click","#mainNavTabs span.fa-remove",mainNavTabsRemoveBtn_click);  
	           
	     // 鼠标滚动事件,标签页滑动
		    $(document).on("mousewheel","#mainNavTabs",main_mousewheel);
		    
		 // 触摸事件（触摸设备,如手机）
	        var touchX = 0;//定义X轴的初始值（全局）
	        $("#mainNavTabs").on("touchstart",function(e){
	            var e = window.event||e;
	            touchX = e.changedTouches[0].clientX;
	        })
	        
	     // 触摸滑动事件（触摸设备,如手机） 
	        $("#mainNavTabs").on("touchmove",function(e){
	        	//事件
	            var e = window.event||e;      
	            //获取当前偏移量（左偏移）
	            var ulMarginLeft =  parseInt($("#mainNavTabs>ul").css("margin-left"))||0;
	            //设定最大偏移量
	         	var maxMarginLeft = $("#mainNavTabs").innerWidth()-$("#mainNavTabs>ul").innerWidth();
	         	//滑动时，实时的X轴位置
	            var thisTouchX = e.changedTouches[0].clientX;
	            //获取在X轴方向上滑动的距离
	            var range = thisTouchX - touchX;
	            //标签滑动方向及距离设定
	            if((ulMarginLeft+range)>0){$("#mainNavTabs>ul").css("margin-left","0");}
	            else if((ulMarginLeft+range)<maxMarginLeft){$("#mainNavTabs>ul").css("margin-left",maxMarginLeft+"px");}
	            else{$("#mainNavTabs>ul").css("margin-left",(ulMarginLeft+range)+"px");}
	            return false;
	        })

		 // 改变窗口大小执行   
	        window.onresize=function(){ main_height(); }
	 })
	
