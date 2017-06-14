

  function ExportControl($thisTerms,$thisTable){ 
	  
	     $("#ExportModal").remove(); 

	     //模态框
	  	 var modalHtml = '<div class="modal fade" id="ExportModal" tabindex="-1" role="dialog" aria-hidden="true">'+
			              '<div class="modal-dialog">'+
		                   '<div class="modal-content">'+
		                     '<div class="modal-header">'+
		                       '<button type="button" class="close"  aria-hidden="true" data-dismiss="modal">&times;</button>'+
		         	           '<h4 class="modal-title">导出明细</h4>'+
		                     '</div>'+
		                     '<div class="modal-body">'+
		         	           '<div class="ExportFrame"></div>'+
		                     '</div>'+
		                     '<div class="modal-footer">'+
		                       '<button type="button" class="btn btn-info" data-dismiss="modal">返回 </button>'+
		                       '<button type="button" class="btn btn-primary ept-Confirm">确认 </button>'+
		                     '</div>'+
		                   '</div>'+
			              '</div>'+
		                 '</div>'; 
	     var $modalHtml = $(modalHtml);  
	     
	     //条件:
	     if($thisTerms){

	    	 var terms = '<div class="termsTitle">'+
	                     '<h4>条件:</h4>'+
	                     '</div>'+
	                     '<div class="termsContent"><ul></ul></div>'; 	          
             var $terms = $(terms);
		     $thisTerms.find(".form-group").each(function(){
		    	var labelText = $(this).find("label").text().trim();
	    	        labelText = labelText.substr(-1)==":"?labelText.substring(0,labelText.length-1):labelText;
		    	    labelText = labelText+":";
		        
                var valueText = $(this).find("input").val()||$(this).find("select>option:selected").text().trim();
                if(valueText&&valueText!=""){
                   var li ='<li><label>'+labelText+'</label><label>'+valueText+'</label></li>'  
  			       var $li = $(li);
                   $terms.find("ul").append($li);    
                }
		     })
	     }
	  	 $modalHtml.find(".ExportFrame").append($terms);
	     

	     //内容:
	     if($thisTable){

	    	 var table = '<div class="tableTitle">'+
                         '<h4>内容:</h4>'+
                         '<button type="button" class="btn btn-primary inputAllChecked">全选</button>'+
                         '<button type="button" class="btn btn-primary inputNoChecked">不选</button>'+
                         '</div>'+
                         '<div class="tableContent"><ul></ul></div>'; 	     
             var $table = $(table);  
    	  	 $thisTable.find("tr").not(".caption").find("th").each(function(i){
    	  		 var th_Text = $(this).text().trim();
    	  		 var th_x = $(this).attr("id")||$(this).attr("name");
    	  		 if(th_x){
    		  		 var li = '<li>'+
     			              '<input type="checkbox" checked="true" name="excelHeader" id="EHname_'+i+'" value="'+th_x+'"/>'+
     				          '<label for="EHname_'+i+'">'+th_Text+'</label>'+
     				          '</li>'; 
    		  		 var $li = $(li);
    	  		 }
    		  	 $table.find("ul").append($li)
    	  	 })	    	 
	     }
	  	 $modalHtml.find(".ExportFrame").append($table);

    	 var describeTitle = '<div class="describeTitle">'+
                             '<h4>文件描述:</h4>'+
                             '</div>'+
                             '<div class="describeContent">'+
                             '<textarea style="margin-left:20px;width:280px;height:150px;border:solid 1px #999" id="describeText">'+
                             '</textarea><font color="ff0000" size="3px">字数不超过100个</font></div>'; 	     
         var $describeTitle = $(describeTitle);  
	  	 $modalHtml.find(".ExportFrame").append($describeTitle);

	     
	  	 if(!$thisTerms&&!$thisTable){return false}
	  	 else{ $(document).find("body").append($modalHtml); }
	  	 
	  	 $("#describeText").val($("title").html());
  }
	  
  function exportData($url){
	  	var filterItems = "";
	  	var excelHeaders = "";
	  	var excelCols = "";
	  	var queryService = $("#exportTask").val();
	  	var describeText = $("#describeText").val();
	  	if(describeText.length>100){
	  		alert("文件描述字数不得超过100");
	  		return;
	  	}
		 $(".query").find(".form-group").each(function(){
         var valueText = $(this).find("input").val()||$(this).find("select>option:selected").val();
         if(valueText&&valueText!=""){
         	valueName = $(this).find("input").attr("name")||$(this).find("select").attr("name");
         	filterItems += valueName+"@"+valueText+",";
         }
	     })
	     
	     $(".tableContent").find("li").each(function(){
	    	 var excelCol = $(this).find("input[name='excelHeader']:checked").val();
	    	 if(typeof(excelCol)!="undefined"){
	    		 excelCols += excelCol+"@";
	    		 var excelHeader= $(this).find("label").text();
	    		 excelHeaders += excelHeader+"@";
	    	 }
	     })
	     if(filterItems.length>0){
	    	 filterItems = filterItems.substring(0, filterItems.length-1);
	     }
		 if(excelHeaders.length<=0){
			 alert("未选择内容，请先选择");
			 return;
		 }
		 if(excelHeaders.length>0){
			 excelHeaders = excelHeaders.substring(0, excelHeaders.length-1);
	     }
		 if(excelCols.length>0){
			 excelCols = excelCols.substring(0, excelCols.length-1);
	     }
		 
	     $.ajax({
			 url:$url+"/admin/taskRecord/exportExcel.shtml",
			 type:'post',
			 data:{
				 "filterItems":filterItems,
				 "excelHeaders":excelHeaders,
				 "excelCols":excelCols,
				 "queryService":queryService,
				 "description":describeText
			 },
			 dataType:'json',
			 success:function(data){
				 if(data.success){	
					 $.zzComfirm.alertSuccess(data.msg);
					 if(confirm("是否跳转到下载页面")){
						 parent.location.href=$url+"/admin/taskRecord/list.shtml";
					 }
				 }else{
					 $.zzComfirm.alertError(data.msg);
				 }
			 },
			 error:function(){
				 $.zzComfirm.alertError("系统出现问题啦，快叫技术人员处理");
			 }
		 }); 
	     
	 	$('#ExportModal').modal('hide');
  }

   
   //------------ 加载控件初始界面,启用过滤控件的功能 -------------------------------
     $.fn.ExportControl = function(opt) {

	     var $thisTerms = opt.terms;
	     var $thisTable = opt.table;
	     var $thisButtonBox = opt.buttonBox;
	     var $url = opt.url;
 
	     
	     
	     
	     //导出按钮
	     var btnExport = '<button type="button" class="btn btn-primary btnModalExport" style="float:right;margin-right:1%;">导出</button>';
	     var $btnExport = $(btnExport);
	  	 if($thisButtonBox&&$thisButtonBox.length>0&&$thisButtonBox!=""){$thisButtonBox.append($btnExport);}
	  	 
	  	 $(document).on("click",".btnModalExport",function(){
	  		ExportControl($thisTerms,$thisTable);
	  		$('#ExportModal').modal({ show: true, backdrop: 'static' });
	  	 })
	  	 
	  	 
	  	 $(document).on("click",".inputAllChecked",function(){
	  	       $(this).parents(".ExportFrame").find(".tableContent>ul>li>input").each(function(){
		  	       this.checked=true;
	           });  
	  	 })
	  	 
	     $(document).on("click",".inputNoChecked",function(){
	  	       $(this).parents(".ExportFrame").find(".tableContent>ul>li>input").each(function(){
		  	       this.checked=false;
	           });  
	  	 })
	  	  
	  	 $(document).on("click",".ept-Confirm",function(){
	  		exportData($url);
	  	 })
     }
   
     
   