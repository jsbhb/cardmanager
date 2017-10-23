$(function(){
    $('.tree li:has(ul)').addClass('parent_li').find(' > span').attr('title', 'Collapse this branch');
    $('.tree li.parent_li > span').on('click', function (e) {
        var children = $(this).parent('li.parent_li').find(' > ul > li');
        if (children.is(":visible")) {
            children.hide('fast');
            $(this).attr('title', 'Expand this branch').find(' > i').addClass('fa-folder').removeClass('fa-folder-open');
        } else {
            children.show('fast');
            $(this).attr('title', 'Collapse this branch').find(' > i').addClass('fa-folder-open').removeClass('fa-folder');
        }
        e.stopPropagation();
    });
    
    
    $('.tree input[type="checkbox"]').change(function (e) {
    	
    	if($(this).parent().hasClass('parent_li')){
    		dealParent($(this));
    	}else{
    		dealChild($(this));
    	}
    	
        e.stopPropagation();
    });
    
    function dealParent(node){
    	if(node.is(':checked')){
    		node.parent('li.parent_li').find("ul input[type='checkbox']").each(function(){
            	$(this).prop("checked",true);
            });
    	}else{
    		node.parent('li.parent_li').find("ul input[type='checkbox']").each(function(){
            	$(this).prop("checked",false);
            });
    	}
    }
    
    function dealChild(node){
    	if(node.is(':checked')){
    		node.parent().parent().parent().parent('li.parent_li').find(".pcheck").prop("checked",true);
    	}
    }
});