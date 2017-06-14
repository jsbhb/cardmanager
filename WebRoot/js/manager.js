var _html = "<div id='loading' class='loading'>Loading pages...</div>";

$.zzComfirm = {
	alertInfo : function(title, content) {
		$.alert({
			title : title,
			content : content,
			confirmButton : 'Okay',
			confirmButtonClass : 'btn-primary',
			icon : 'fa fa-play-circle',
		});
	},

	alertSuccess : function(content) {
		$.alert({
			title : "成功啦！",
			content : content,
			confirmButton : 'Okay',
			confirmButtonClass : 'btn-primary',
			icon : 'fa fa-play',
		});
	},

	alertError : function(content) {
		$.alert({
			title : "出错啦！",
			content : content,
			confirmButton : 'Okay',
			confirmButtonClass : 'btn-primary',
			icon : 'fa fa-medkit',
		});
	},
	
	alertConfirm : function(content,cofirm) {
		$.confirm({
			title : "警告！",
			content : content,
			confirmButton : 'Okay',
			confirmButtonClass : 'btn-primary',
			icon : 'fa fa-medkit',
			confirm:cofirm,
			cancel:function(){
				return;
			}
		});
	},

	startMask : function() {
		$("#mask").html(_html);
	},

	endMask : function() {
		var _mask = $('#loading');
		if (_mask != null) {
			_mask.parent().html("");
		}
	},
}


