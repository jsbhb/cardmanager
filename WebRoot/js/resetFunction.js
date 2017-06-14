

 //记录初始值	
  function getValue($x){ 
     var t=[],s=[];
	 $x.find("input").each(function(i){
	     t[i] = $(this).val();
	 })
	 $x.find("select").each(function(i){
	     s[i] = $(this).val();
	 })	
	 return {inputText:t,selectText:s}
  }
 
 
  
  $.fn.resetFunction = function(t) {
    	
  	   var o;
  	   var $this = $(this);
	   	    
	  //重置功能  ---- 延时执行记录初始值功能，可以确保有足够的时间，记录从ajax传过来的初始值
  	    if(t>600){
  		    setTimeout(function(){o=getValue($this);},t); 
  	    }
  	    else{
  		    setTimeout(function(){o=getValue($this);},600); 
  	    }
	     
	  //重置功能  ---- 进行重置
	    $this.on("click",".btn-reset",function(){
		   $this.find("input").each(function(i){
		  	   $(this).val(o.inputText[i]);
		   })
		   $this.find("select").each(function(i){
		  	   $(this).val(o.selectText[i]); 
		   })
	    })  	 
   }
  
  
  