$(function() {
	$(document).on('click', "#navTab a",function() {
		$(this).parent().tab('show');
		var width = "100%";
		var height = "100%";
		$("#page-wrapper").empty();
		var newIframeObject = document.createElement("IFRAME");
		newIframeObject.src = this.href;
		newIframeObject.scrolling = "no";
		newIframeObject.frameBorder = 0;
		newIframeObject.width = width;
		newIframeObject.height = height;
		$("#page-wrapper").append(newIframeObject);
		return false;
	});
})