$.fn.model = function(o) {
	var options = {
		iframe : "",
		modal : "",
		title:"",
		btn : "",
		url : "",
		dialogWidth : "",
		contentHeght : "",
		index : "",
		clickFunc : function() {
			return false
		}
	}

	$.extend(options, o);

	
	return this.each(function() {
		$(iframe).attr("src", this.url);
		$("#modelTitle").text(this.title);
		$(this.modal).modal({
			show : true,
			backdrop : 'static'
		});
	})
}
