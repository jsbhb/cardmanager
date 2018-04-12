(function(){

	//搜索类型切换
	$('.moreSearchBtn').click(function(){
		$('.moreSearchContent').slideDown(300);
		$('.search').hide();
	});
	$('.lessSearchBtn').click(function(){
		$('.moreSearchContent').slideUp(300);
		setTimeout(function(){
			$('.search').show();
		},300);
	});

	//清除筛选内容
	$('.searchBtns').on('click','.clear',function(){
		$('.searchItem input').val('');
		var allSelectList = document.querySelectorAll('.list-content .searchItem select');
		if(allSelectList){
			for(var a=0;a<allSelectList.length;a++){
				allSelectList[a].options[0].selected="selected";
			}
		}
	});

	//切换tabBar
	$('.list-tabBar').on('click','ul li:not(.active)',function(){
		$(this).addClass('active').siblings('.active').removeClass('active');
	});

	//点击收缩所有分类
	$('.goods-classify').on('click','i:not(.active)',function(){
		$(this).addClass('active');
		$('.container-left').stop();
		$('.container-left').slideUp(300);
		setTimeout(function(){
			$('.container-right').removeClass('col-md-10').addClass('col-md-12').addClass('active');
			$('.container-left').addClass('hideList');
		},300);
	});

	//点击展开所有分类
	$('.goods-classify').on('click','i.active',function(){
		$('.container-left').removeClass('hideList');
		$('.container-left').hide();
		$(this).removeClass('active');
		$('.container-left').stop();
		$('.container-right').removeClass('col-md-12').removeClass('active').addClass('col-md-10');
		$('.container-left').slideDown(300);
		$('.container-left').animate({
			'height': 'auto'
		},300);
	});

	//点击展开分类列表
	$('.container-left').on('click','i.fa-angle-right',function(){
		$(this).next().stop();
		$(this).next().slideDown(300);
		$(this).next().animate({
			'height': 'auto'
		},300);
		$(this).removeClass('fa-angle-right').addClass('fa-angle-down');
	});

	//点击收缩分类列表
	$('.container-left').on('click','i.fa-angle-down',function(){
		$(this).next().stop();
		$(this).next().slideUp(300);
		$(this).removeClass('fa-angle-down').addClass('fa-angle-right');
	});

	//点击分类
	$('.container-left').on('click','span:not(.active)',function(){
		$('.container-left span.active').removeClass('active');
		$(this).addClass('active');	
	});

	$('.container-left').on('click','span.active',function(){
		$(this).removeClass('active');	
	});
	
	var timer = null;


	//鼠标事件
	$('.goods-classify').on('mouseenter',function(){
		if($(this).find('i').hasClass('active')){
			$('.container-left').stop();
			$('.container-left').slideDown(300);
		}
	})

	$('.goods-classify').on('mouseleave',function(){
		if($(this).find('i').hasClass('active')){
			timer = setTimeout(function(){
		  		$('.container-left').stop();
		  		$('.container-left').slideUp(300);
		  	},100);
		}
	})

	$('.container-left').on('mouseenter',function(){
		if($(this).hasClass('hideList')){
			clearTimeout(timer);
		}
	})

	$('.container-left').on('mouseleave',function(){
		if($(this).hasClass('hideList')){
			$('.container-left').stop();
		  	$('.container-left').slideUp(300);
		}
	})

	//实现全选反选
	$("#theadInp").on('click', function() {
	    $("tbody input:checkbox").prop("checked", $(this).prop('checked'));
	})
	$("tbody input:checkbox").on('click', function() {
	    //当选中的长度等于checkbox的长度的时候,就让控制全选反选的checkbox设置为选中,否则就为未选中
	    if($("tbody input:checkbox").length === $("tbody input:checked").length) {
	        $("#theadInp").prop("checked", true);
	    } else {
	        $("#theadInp").prop("checked", false);
	    }
	})
	
	//点击分类选中
	$('.item-right').on('click','.label-content li:not(active)',function(){
		$(this).addClass('active').siblings('.active').removeClass('active');
	});
	//点击分类取消
	$('.item-right').on('click','.label-content li.active',function(){
		$(this).removeClass('active');
	});
})();