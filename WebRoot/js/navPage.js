$(function() {
	$(document).on('click', "#navTab a",function() {
		$(this).parent().tab('show');
		var width = "100%";
		var height = window.innerHeight-115;
		$("#page-wrapper").empty();
		var newIframeObject = document.createElement("IFRAME");
		newIframeObject.src = this.href;
		newIframeObject.scrolling = "yes";
		newIframeObject.frameBorder = 0;
		newIframeObject.width = width;
		newIframeObject.height = height;
		$("#page-wrapper").append(newIframeObject);
		return false;
	});
})