
  /* 使用该控件说明
   * 
   *   可实现功能: 表格宽度自适应， 过滤功能。。。。。。。。。。。。。
   * 
   *   须有如下结构、标签及class类
   *   
   *     <div class="panel tableControlOne"> ------------------------------ 'tableControlOne'可自定义
   *       <div class="panel-heading">
   *          <h3 class="panel-title panel-h3"></h3> ---------------------- 可用来设置面板上的标题，可去除
   *       </div>
   *       <div class="panel-body table-responsive">
   *         <table class="table table-bordered table-hover">
   *           <thead>
   *             <tr class="caption"><th colspan="数值"></th></tr> --------- 可用来设置表格上的标题，可去除
   *             <tr><th></th><tr>
   *           </thead>
   *           <tbody>
   *             <tr><td></td></tr>
   *           </tbody>
   *         </table>
   *       </div>
   *     </div>         
   *         
   *     关联文件： 
   *           该控件关联的 ‘css文件’有 ：   bootstrap.min.css、          font-awesome.min.css、     TableControl.css
   *           该控件关联的 ‘js文件’ 有 ：   jquery.min.js、                         bootstrap.min.js、                  TableControl.js  
   *          
   *     使用方法：
   *           $(".tableControlOne").parents(".panel").tableWidthAutoEnable() ---------- table表格宽度自适应（一般写在最后）
   *           $(".tableControlOne").parents(".panel").filterControlLoad(); ------------ 加载控件初始界面,启用过滤控件的功能（!只能执行一次，即该代码只允许写一次）
   *           $(".tableControlOne").parents(".panel").filterControlUpdate(); ---------- 更新过滤控件，（一般是在数据更新情况下）
   *           
   *       
   *        
   */






   //--------------表格宽度自适应功能-------------------------------
     function tableWidthAuto($x){ 
        $x.each(function(){
    	   $this = $(this); 
  		   $this.find(">thead>tr>th,>tbody>tr>td").removeClass("maxWidth");
	 	   var parentWidth = $this.parent().innerWidth();	
		   var allWidth = 0;
		   $this.find("thead>tr").not(".caption").find(">th").each(function(){
               if($(this).innerWidth()>(parentWidth/2+50)){
        	      classText=$(this).attr("class");
        	      thisWidth=parentWidth/2+50; 
        	      $this.find("."+classText).addClass("maxWidth");
        	      $this.find("."+classText).css("min-Width",thisWidth+"px");     	   
                }
		   })   	  
        })	 
     }



   //------------ 提示框显示与否  ------------------------------------------
     function filterMenu($x){
	    $this=$x;    
	    if($this.hasClass("tableControl")){
		    $(document).find(".tableControl").not($x).removeClass("open");
		    if($this.hasClass("open")){
			    $this.removeClass("open");
		    }
		    else if($x){
			     $this.addClass("open");	
		    }
	    }
	    else{
		    $(document).find(".tableControl").removeClass("open");
	    }
     }

   
     
   //------------ 过滤控件功能块 ------------------------------------------
     
	 //提示框显示与否
	  $(document).on("click",".btn,input,select",function(e){
		   var e=e||window.event;
		   var el = e.target||e.srcelement;
	       if($(el).parents(".filter-menu").length==0){
	    	   if($(el).parents(".tableControl").length>0){ filterMenu($(el).parents(".tableControl")) }
	    	   else{ filterMenu($(el))}
	       }
	  }) 
	  
	  
     function filterControl($this){   
		   
		  $this.on("click","ul.filter-menu>li>input[class^='control_level_']",function(e){
			   var e=e||window.event;
			   var classText = $(this).attr("class");
			   if($(this).get(0).checked){
				     $this.find(".panel-body>table ."+classText).removeClass("display_hidden");
			   }
			   if(!$(this).get(0).checked){ 
				     $this.find(".panel-body>table ."+classText).addClass("display_hidden");
			   }		  
		     //-------- 解决在iphone手机端上,页面部分元素莫名隐藏的问题------------------------
			   if($this.find(".panel-body").scrollLeft()<20){$this.find(".panel-body").scrollLeft(30);}
			   else{$this.find(".panel-body").scrollLeft($this.find(".panel-body").scrollLeft()-10);}  
			   e.cancelBubble = true ;
			   e.stopPropagation();
		  });
			  
		  $this.on("click","ul.filter-menu>li>.btn-allCheck",function(e){
			   var e=e||window.event;
			   $(this).parent().parent().find(">li>input[class^='control_level_']").each(function(){
				     this.checked=true;
			   });
			   $this.find(".panel-body>table th[class^='control_level_'],.panel-body>table td[class^='control_level_']").removeClass("display_hidden");
		  
		     //-------- 解决在iphone手机端上,页面部分元素莫名隐藏的问题 ------------------------
		       if($this.find(".panel-body").scrollLeft()<20){$(document).find(".panel-body").scrollLeft(30);}
		       else{$this.find(".panel-body").scrollLeft($(document).find(".panel-body").scrollLeft()-10);}  
			   e.cancelBubble = true ;
			   e.stopPropagation(); 
		  });
			 		 
		  $this.on("click","ul.filter-menu>li>.btn-allNoCheck",function(e){
			   var e=e||window.event;
			   $(this).parent().parent().find(">li>input[class^='control_level_']").each(function(){
			  	  this.checked=false;
		       });
			   $this.find(".panel-body>table th[class^='control_level_'],.panel-body>table td[class^='control_level_']").addClass("display_hidden");
		
		     //-------- 解决在iphone手机端上,页面部分元素莫名隐藏的问题 ------------------------
		       if($this.find(".panel-body").scrollLeft()<20){$(document).find(".panel-body").scrollLeft(30);}
		       else{$this.find(".panel-body").scrollLeft($(document).find(".panel-body").scrollLeft()-10);}  
		       e.cancelBubble = true ;
			   e.stopPropagation();
		  });      
      }
     


     
   
   //--------------启用表格宽度自适应功能-------------------------------
     $.fn.tableWidthAutoEnable = function() {
	     var $this = $(this).find("table");
	     tableWidthAuto($this);
     }
     

   
   //------------ 加载控件初始界面,启用过滤控件的功能 -------------------------------
     $.fn.filterControlLoad = function() {
	     var $this = $(this);
	     
	    //重新加载取消已有的界面
	     $this.find(".filter-control").remove();
	     
	    //加载过滤控件初始界面
	  	 var filterHtml = '<div class="btn-group tableControl filter-control">'+
	                      '<button type="button" class="btn btn-primary btn-tooltip btn-filter">'+
	                      '<i class="fa fa-filter fa-fw"></i>'+
	                      '</button>'+
	                      '<ul class="dropdown-menu tooltip-menu filter-menu">'+
	                      '<li class="checkBox">'+
	                      '<button type="button" class="btn btn-primary btn-allCheck" style="padding:2px 6px;margin-left:13px;">全选</button>'+
	                      '<button type="button" class="btn btn-primary btn-allNoCheck" style="padding:2px 6px;margin-left:20px;">不选</button>'+
	                      '</li>'+
	                      '</ul>'+
	                      '</div>'; 
	     var $filterHtml = $(filterHtml);    
	     
	  	 if($(this).find("table").not(".nofilter").length>0){ $this.find(".panel-heading").append($filterHtml);}  	 
	  	 
	  	 var m=0;
	  	 $tables = $(document).find("table");
	  	 $table = $this.find(".panel-body>table");	
	  	 	 
	  	 $tables.each(function(i){
	  		 $thisTable=$(this).get(0);  
	  		 $table.each(function(){
		  		 if($thisTable==this){
			  		  m=i+1
					  var n=0;
				  	  $th = $(this).find("thead>tr>th");	 
					  $th.each(function(){
					  	   if($(this).parent().hasClass("caption")){
					  		   var filterMenuTitle = '<li class="caption">'+
						                              '<label>'+$(this).text().trim()+'</label>'+
						                              '</li>';
					  		   $this.find(".panel-heading").find($filterHtml).find("ul.filter-menu").append($(filterMenuTitle));
					  	   }
					  	   else{
					  		   n=n+1;
						  	   var filterMenuLi = '<li>'+
						  					       '<input type="checkbox" class="control_level_'+m+'_'+n+'" checked="true" id="filter_'+m+'_'+n+'" name="filter_'+m+'_'+n+'"/>'+
						  					       '<label for="filter_'+m+'_'+n+'">'+$(this).text().trim()+'</label>'+
						  					       '</li>';
							   $(this).addClass("control_level_"+m+'_'+n); 
					  	       if($(this).text()&&$(this).text().trim()!=""){
					  	    	   $this.find(".panel-heading").find($filterHtml).find("ul.filter-menu").append($(filterMenuLi));	    	   
					  	       }
					  	   }
					   })  
					  	  
					   var arr = [];
					   var k = 0
					   $td_parent = $(this).find(">tbody>tr");
					   $td_parent.each(function(){
						      $(this).find(">td").each(function(i){
						    	  k = i;
	                              while(arr[k]>0){
	                            	  k++;
	                              } 
	                              if(k==i){$(this).addClass("control_level_"+m+'_'+(i+1)); }
	                              else{ $(this).addClass("control_level_"+m+'_'+(k+i+1)); }
	                              if($(this).attr("rowspan")){ arr[k] = ($(this).attr("rowspan"))*1; }  	  
						      })  
						      for(var n=0; n<=k; n++){
						    	  if(arr[n]>0){arr[n]--;}
						      }
					   })  	 
		  		 }	 
	  		 })
	  	 })
	  	  
	    //启用过滤功能
	     filterControl($this);
     }
   
     
   
   //------------更新过滤控件，（一般是在数据更新情况下）---------------------------------------
     $.fn.filterControlUpdate = function() {
  	     var $this = $(this);
  	     var classTexts = [];
  	     var labelTexts = [];
  	     var k=-1;
  	     
  	     
  	    //标记原先隐藏的选项
  		 var $input = $this.find(".panel-heading>.filter-control>.filter-menu>li>input[type='checkbox']");		
  		 $input.each(function(){
  			 if(!$(this).get(0).checked){
	  		     k=k+1;
  			     classTexts[k] = $(this).attr("class");
  			     labelTexts[k] = $(this).find("label").text().trim();
  			 }
  		 })	 
  		 
	    //取消已有的数据并重新加载
	     $this.find(".filter-control>ul.filter-menu").find("li").not(".checkBox").remove(); 

  		//更新数据 
	  	 var m=0;
	  	 $tables = $(document).find("table");
	  	 $table = $this.find(".panel-body>table");	
	  	 
	  	 $tables.each(function(i){
	  		 $thisTable=$(this).get(0);  
	  		 $table.each(function(){
		  		 if($thisTable==this){
			  		  m=i+1
					  var n=0;
				  	  $th = $(this).find("thead>tr>th");	 
					  $th.each(function(){
					  	   if($(this).parent().hasClass("caption")){
					  		   var filterMenuTitle = '<li class="caption">'+
						                              '<label>'+$(this).text().trim()+'</label>'+
						                              '</li>';
					  		   $this.find(".panel-heading").find(".filter-control>ul.filter-menu").append($(filterMenuTitle));
					  	   }
					  	   else{
					  		   n=n+1;
						  	   var filterMenuLi = '<li>'+
						  					       '<input type="checkbox" class="control_level_'+m+'_'+n+'" checked="true" id="filter_'+m+'_'+n+'" name="filter_'+m+'_'+n+'"/>'+
						  					       '<label for="filter_'+m+'_'+n+'">'+$(this).text().trim()+'</label>'+
						  					       '</li>';
						  	   $(this).addClass("control_level_"+m+'_'+n);
							   if($(this).text()&&$(this).text().trim()!=""){ 
								   $this.find(".panel-heading").find(".filter-control>ul.filter-menu").append($(filterMenuLi));
							   }
					  	   }
					   }) 
					   
					   var arr = [];
					   var k = 0  
					   $td_parent = $(this).find(">tbody>tr");
					   $td_parent.each(function(){
						      $(this).find(">td").each(function(i){
						    	  k = i;
	                              while(arr[k]>0){
	                            	  k++;
	                              } 
	                              if(k==i){$(this).addClass("control_level_"+m+'_'+(i+1)); }
	                              else{ $(this).addClass("control_level_"+m+'_'+(k+i+1)); }
	                              if($(this).attr("rowspan")){ arr[k] = ($(this).attr("rowspan"))*1; }  	  
						      }) 
						      for(var n=0; n<=k; n++){
						    	  if(arr[n]>0){arr[n]--;}
						      }
					   })  	  
		  		 }	 
	  		 })
	  	 })
 
  		 $.each(classTexts,function(i, data){
  			 var labelText = $this.find(".panel-heading").find(".filter-control>ul.filter-menu").find("."+data).find("label").text().trim();
  			 if(labelTexts[i]==labelText){
  				 $this.find(".panel-heading").find(".filter-control>ul.filter-menu").find("."+data).get(0).checked=false;
  			     $this.find(".panel-body>table ."+data).addClass("display_hidden");
  			 }	
  		 })
     }
     
     
     
     $.fn.htmlUpdate = function(str) {
  	     var $this = $(this);
  	         $this.html(str);
  	         $this.parents(".panel").filterControlUpdate(); 
  		     $this.parents(".panel").tableWidthAutoEnable();  
     }
     
     
     
   
