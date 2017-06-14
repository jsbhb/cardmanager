
//-------------------------- main.jsp 页面 --------------------------------------

    //---------------- 导航条高度自适应  ------------------
      function mainNavLeftHeight(){
          var width = (window.top.innerWidth > 0) ? window.top.innerWidth : window.screen.width;
          if (width < 768) { 
        	  topOffset = 84; 
          	  $(".mainNavLeft").css("min-height",""); 
          }
          else { 
        	  topOffset = 54; 
          	  $(".mainNavLeft").css("min-height",($("body").get(0).offsetHeight-topOffset)+"px");  
          }  
      }
      

    //---------------- 导航条单击事件  ------------------
      function navbarCollapseDisplay(){
    	$(".mainNavLeft>.navbar-collapse").removeClass("in");
    	if(window.top.innerWidth<768){
            $(".mainNavLeft>.navbar-collapse").find("ul.nav").removeClass("in");
            $(".mainNavLeft>.navbar-collapse .active").removeClass("active");
    	}
    	$(".iframePage").css("display","block"); 
      }
      
    
    //---------------- 首页在手机端显示时，默认只显示导航条 ------------------	
      function homePage($x,$y,$z) {
         $x.addClass("in");
    	 if(window.top.innerWidth<768){
             $y.css("display","none"); 
             $z.on("click",function(){
                if($(".iframePage").css("display")=="block"){ 
               	   $(".iframePage").css("display","none");  
                }
                else{
                   $(".iframePage").css("display","block"); 
                }
             })
    	 } 
      }

      
      window.onresize=function(){
          mainNavLeftHeight();
      }
    
      
      $(function(){
         homePage($(".mainNavLeft>.navbar-collapse"),$(".iframePage"),$(".mainNavBtn"));
         mainNavLeftHeight();
      })
      
    
    
    
    
    
    