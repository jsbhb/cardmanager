$.fn.pageInit = function(o) {

	var options = {
		queryForm : "",
		url : "",
		index : "",
		callback : function() {
			return false;
		}
	}

	$.extend(options, o);

	return this.each(function() {
		$.normalPage.loadData(o);
		$(document).on("click", "#querybtns", function() {
			$.normalPage.loadData(o);
		});
	})
}

$.normalPage = {
	generateData : function(o) {
		var sData = $.extend({}, $.jsonObj(o.queryForm, true));
		return sData;
	},

	loadData : function(o) {
		var that = this;
		var data = that.generateData(o);
		$.zzComfirm.startMask();
		$.ajax({
			url : o.url,
			data : data,
			type : "post",
			dataType : 'json',
			success : function(data) {
				if (!data.success) {
					$.zzComfirm.alertError(data.errTrace);
					$.zzComfirm.endMask();
					return data;
				}
				o.callback(data);
			}
		});
	}
}