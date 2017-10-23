$.fn.pagination = function(o) {

	var options = {
		queryForm : "",
		url : "",
		numPerPage : "",
		currentPage : "",
		index : "",
		callback : function() {
			return false
		}
	}

	$.extend(options, o);

	return this.each(function() {
		$.page.loadData(o);
		$(document).on("click","#querybtns", function() {
			$.page.loadData(o);
		})
	})

}


$.page = {

	setLine : function(totalPages, o,totalRows) {
		var that = this;

		$("#pagination li").remove();

		var currentPage = Number(o.currentPage);
		var paginationHtml = "";

		if (currentPage != 1) {
			var a = $('<a/>').html("<span aria-hidden='true'>上一页</span>").bind(
					"click", function() {
						o.index = 'p';
						that.loadData(o);
					});
			var li = $('<li/>').append(a);
			$("#pagination").append(li);
		}

		if (currentPage == 0) {
			return;
		}

		if (totalPages <= 5) {
			for (var i = 1; i < totalPages + 1; i++) {
				var a = $('<a/>').html(i).bind('click', i, function() {
					o.index = $(this).text();
					that.loadData(o);
				});
				var li = $('<li/>').append(a);
				if (i == currentPage) {
					li.addClass("active");
				}
				$("#pagination").append(li);
			}
		} else if (currentPage > 3) {

			var sumIndex = 0;
			var startIndex = 0;
			if (totalPages < currentPage + 3) {
				startIndex = totalPages - 4;
				sumIndex = totalPages + 1;
			} else {
				startIndex = currentPage - 2;
				sumIndex = currentPage + 3;
			}

			for (var i = startIndex; i < sumIndex; i++) {
				var a = $('<a/>').html(i).bind('click', function() {
					o.index = $(this).text();
					that.loadData(o);
				});
				var li = $('<li/>').append(a);
				if (i == currentPage) {
					li.addClass("active");
				}
				$("#pagination").append(li);
			}
		} else {
			for (var i = 1; i < 6; i++) {
				var a = $('<a/>').html(i).bind('click', function() {
					o.index = $(this).text();
					that.loadData(o);
				});

				var li = $('<li/>').append(a);
				if (i == currentPage) {
					li.addClass("active");
				}
				$("#pagination").append(li);
			}
		}

		if (currentPage < totalPages) {

			var a = $('<a/>').html("<span aria-hidden='true'>下一页</span>").bind(
					"click", function() {
						o.index = 'n';
						that.loadData(o);
					});
			var li = $('<li/>').append(a);
			$("#pagination").append(li);
		}

		var a = $('<a/>').html(
				"<span aria-hidden='true'>" + "共" + totalPages + "页--"+totalRows+"条"
						+ "</span>");
		
		var selectStr = '';
		if (o.numPerPage == 20){
			 selectStr = "<option>10</option><option selected>20</option><option>50</option><option>100</option><option>500</option><option>1000</option>"
		}else if (o.numPerPage == 50){
			 selectStr = "<option>10</option><option>20</option><option selected>50</option><option>100</option><option>500</option><option>1000</option>"
		}else if (o.numPerPage == 100){
			 selectStr = "<option selected>10</option><option>20</option><option>50</option><option selected>100</option><option>500</option><option>1000</option>"
		}else if (o.numPerPage == 500){
			 selectStr = "<option selected>10</option><option>20</option><option>50</option><option>100</option><option selected>500</option><option>1000</option>"
		}else if (o.numPerPage == 1000){
			 selectStr = "<option selected>10</option><option>20</option><option>50</option><option>100</option><option>500</option><option selected>1000</option>"
		}else if(o.numPerPage == 10){
			 selectStr = "<option selected>10</option><option>20</option><option>50</option><option>100</option><option>500</option><option>1000</option>"
		} 
		
		
		var numPerPageSelect = $('<select id="numPerPageSelect"/>').html(selectStr).bind('change',function(){
			o.numPerPage = $("#numPerPageSelect option:selected").text();
			that.loadData(o);
		});
		
		var dataSpan = $('<span/>').html(numPerPageSelect);
		a.append(dataSpan);
		
		var li = $('<li/>').append(a);
		$("#pagination").append(li);
	},
	
	generateData : function(o) {
		var pData = $.extend({}, {
			currentPage : o.currentPage,
			numPerPage : o.numPerPage
		});
		var sData = $.extend({}, $.jsonObj(o.queryForm,true), pData);
		return sData;
	},

	loadData : function(o) {
		if (o.index == null || o.currentPage == 0 || o.currentPage.trim() == "") {
			o.currentPage = 1;
		} else if (o.index == "p") {
			o.currentPage = o.currentPage * 1 - 1;
			o.index = o.currentPage;
		} else if (o.index == "n") {
			o.currentPage = o.currentPage * 1 + 1;
			o.index = o.currentPage;
		} else {
			o.currentPage = o.index;
		}

		var that = this;
		var data = that.generateData(o);
		$.ajax({
			url : o.url,
			data : data,
			type : "post",
			dataType : 'json',
			success : function(data) {
				if (!data.success) {
					layer.alert(data.errTrace);
					return;
				}

				var pagination = data.pagination;
				o.currentPage = pagination.currentPage + "";
				o.callback(data);
				that.setLine(pagination.totalPages, o,pagination.totalRows);
			},
			error:function(){
				layer.alert("分页查询失败，请联系客服！");
			}
		});
	}

}

$.jsonObj = function(form,canNull) {
	// 判断是否有序列化的东东
	if (!$(form).html() || $(form).html() == null
			|| $.trim($(form).html()) == "") {
		return null;
	}
	var formEl = $(form).find('input');
	var formselect = $(form).find('select');
	var json = "{";
	for (var i = 0; i < formEl.length; i++) {
		var name = formEl.eq(i).attr('name');
		var val = "'" + formEl.eq(i).val() + "'";

		if (val.trim() == "''") {
			if(canNull){
				continue;
			}else{
				if(formEl.eq(i).prop('disabled')){
					continue;
				}else{
					alert("表单数据不全");
					return;
				}
			}
			
		}
		json += name;
		json += ":";
		json += val;
		json += ",";
	}

	if (json.charAt(json.length - 1) == ',') {
		json = json.substring(0, json.length - 1);
	}

	if (formselect) {

		if (json != "{") {
			json += ",";
		}

		for (var i = 0; i < formselect.length; i++) {
			var name = formselect.eq(i).attr('name');
			var val = "'" + formselect.eq(i).val() + "'";
			if (val == null || val.trim() == "" || val == -1) {
				if(canNull){
					continue;
				}else{
					
					var f =  formselect.eq(i).parent();
					var b = f.prop('disabled');
					if(formselect.eq(i).parent().css('display')=="none"){
						continue;
					}else{
						alert("表单数据不全");
						return;
					}
				}
			}
			json += name;
			json += ":";
			json += val;
			json += ",";
		}

		if (json.charAt(json.length - 1) == ',') {
			json = json.substring(0, json.length - 1);
		}
	}
	json += "}";
	var jsonObj = eval("(" + json + ")")
	return jsonObj;
}