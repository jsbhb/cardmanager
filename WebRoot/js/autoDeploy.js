
function bugRepair(){
	var p = window.parent;
	var $pDocument = $(window.parent.document);

	if(window.document!=window.top.document){
		$pDocument.find("iframe").each(function(){
			$(this).attr({"height":"99.9%","width":"100%","frameBorder":"0","scrolling":"no"})

			var pWidth = $(this).parents(".iframePage").width();
			var pHeight = $(this).parents(".iframePage").height();

			if($(this).parent().hasClass("modal-body")){
				if($(this).prop('contentWindow').document==window.document){
					modalDialogWidth = $pDocument.find(".modal").width()*0.96;
					modalDialogHeight = $pDocument.find(".modal").height()*0.96;
					pWidth = modalDialogWidth-16;
					pHeight = modalDialogHeight-96;

					$(document).find(".iframePage").prevAll().each(function(){
						pHeight = pHeight-$(this).get(0).offsetHeight;
						if($(this).hasClass("row")){pHeight = pHeight-10;}
					})

					$(document).find(".iframePage").css("width",pWidth+"px");
					$(document).find(".iframePage").css("height",pHeight+"px");
					$(document).find(".iframePage").css("-webkit-overflow-scrolling","touch");
					$(document).find(".iframePage").css("overflow","auto");
				}
			}
			else{

				$(document).find(".iframePage").prevAll().each(function(){
					pHeight = pHeight-$(this).get(0).offsetHeight;
					if($(this).hasClass("row")){pHeight = pHeight-10;}
				})

				$(document).find(".iframePage").css("width",pWidth+"px");
				$(document).find(".iframePage").css("height",pHeight+"px");
				$(document).find(".iframePage").css("-webkit-overflow-scrolling","touch");
				$(document).find(".iframePage").css("overflow","auto");
			}
		})
	}
	else{
		var pWidth = window.top.innerWidth;
		var pHeight = window.top.innerHeight-3;

		$(document).find(".iframePage").prevAll().each(function(){
			pHeight = pHeight-$(this).get(0).offsetHeight;
			if($(this).hasClass("row")){pHeight = pHeight-10;}
		})

		if($(document).find(".mainNavLeft").length>0){
			pWidth = pWidth -$(document).find(".mainNavLeft").get(0).offsetWidth;
		}

		$(document).find(".iframePage").css("width",pWidth+"px");
		$(document).find(".iframePage").css("height",pHeight+"px");
		$(document).find(".iframePage").css("-webkit-overflow-scrolling","touch");
		$(document).find(".iframePage").css("overflow","auto");
	}
}


function tableTermWidthAuto(){
	$(".tableTerm").find("table").each(function(){
		if($(".tableTerm").find(".showExpressDiv,embed,[id='expressPdf'],[name='expressPdf']").length==0){
			if($(this).parents(".panel").length==0){
				var $x = $(this);
				var $y = $x.find("tr");
				var $xClone = $x.clone();
				$xClone.find("tr").has("td[colspan]").remove()
				$yClone= $xClone.find("tr") ;
				var $m;
				var $n;
				$x.html("");
				$y.each(function(i){
					if($(this).find("td[colspan]").attr("colspan")>1){
						$x.append($(this));
					}
					else{
						var $z = $yClone.find("td");
						$z.each(function(i){
							if(document.body.clientWidth<=560){
								if(i%2==0){
									$m = $("<tr></tr>");
									$x.append($m);
									$n= $x.find($m);
								}
								$n.append($(this));
							}
							else {
								if(i%4==0){
									$m = $("<tr></tr>");
									$x.append($m);
									$n= $x.find($m);
								}
								$n.append($(this));
							}
						})
					}
				})
			}
		}
	})
	
	$("table .dataPicker").each(function(){
	  var time = $(this).attr("format")||"yyyy-mm-dd hh:ii:ss";
	  var view = $(this).attr("minView")||"hour";
	  $(this).datetimepicker({
		  container:$(this).parents("div:first"),
		  language: "zh-CN",
		  startView:"month",
		  format:time,
		  minView:view,
		  pickerPosition:"bottom-left",
		  autoclose:true
	 })
  })
}





function Content(){
	var $queryTerm = $(document).find(".queryTerm");
	var $tablePanel = $(document).find(".tablePanel");
	var $panelBtn = $(document).find(".btn[forTable]");
	var $tablePanelBtn = $(document).find(".tablePanel .btn");
	var $tableTerm = $(document).find(".tableTerm");



	// --- 面包屑导航 -----------------------------------------------------------------------------------------
	var $i = $(".breadcrumb").find("li:eq(0)>i");
	$text = $(".breadcrumb").find("li:eq(0)").text();
	$(".breadcrumb").find("li:eq(0)").html("");
	$(".breadcrumb").find("li:eq(0)").append($i);
	$(".breadcrumb").find("li:eq(0)").append(" "+$text);
	$(".breadcrumb").find("li:gt(0)>i").remove();
	$(".breadcrumb").find("li:gt(0)").text($(".breadcrumb").find("li:gt(0)").text().trim());



	// --- 查询组件 ------------------------------------------------------------------------------------------
	var c1 = '<div class="col-sm-6 col-md-4 col-lg-3 form-group col-set">'+
		'<label class="label-text"></label>'+
		'</div>';


	var c2 = '<div class="col-sm-6 col-md-4 col-lg-3 form-group col-set">'+
		'<label class="label-text"></label>'+
		'<div class="input-group input-width input-append date form_datetime">'+
		'<span class="input-group-addon add-on"><i class="fa fa-calendar fa-fw"></i></span>'+
		'</div>'+
		'</div>';


	var c3 = '<div class="col-sm-6 col-md-4 col-lg-3 form-group col-set">'+
		'<label class="label-text"></label>'+
		'<div class="input-group input-width">'+
		'<span class="input-group-btn">'+
		'</span>'+
		'</div>'+
		'</div>';

	var btnBox = '<hr class="termHr"/>'+
		'<div class="termBtnBox">'+
		'<button type="button" class="btn btn-primary termBtn btn-reset">重置</button>'+
		'</div>';

	var $btnBox = $(btnBox);

	$queryTerm.each(function(){
		if(!$(this).hasClass("queryTerm-Ok")){
			var $this = $(this);
			var $thisClone = $this.clone();
			var $queryTermContent = $thisClone.find(".form-group,.col-set");
			$this.addClass("resetBox");
			$this.html('<div class="row"></div>');
			$queryTermContent.each(function(f){
				if(!$(this).hasClass("col-set")){
					var $this2 = $(this);
					var $x = $(this).find("input:not([type='hidden']),select");
					var $xHidden = $(this).find("input[type='hidden']");
					var $xBtn = $(this).find(".btn").clone();
					$xBtn.html("<span class='glyphicon glyphicon-search'></span>");

					if($(this).find("input.dataPicker").length>0){
						$(this).find("input.dataPicker").addClass("calendar");
						var k = "dataBox_"+(f+1);
						$x.each(function(i){
							var $c2 = $(c2);
							$c2.addClass(k);
							var label = $this2.find("label").eq(0).text();
							label = label.replace(/\s/gi,"");
							label = label.replace(/:$/gi,"");
							var m = label;
							if($x.length==1){
								var m = label.substring(0,label.length-1);
								var n = label.substring(label.length-1);
								$c2.find("label.label-text").html('<span class="textLength'+label.length+'">'+m+'</span><span>'+n+":"+'</span>');
							}
							if($x.length==2){
								if(i==0){var n = "/始"; $(this).addClass("startTime");}
								if(i==1){var n = "/终"; $(this).addClass("endTime"); }
								$c2.find("label.label-text").html('<span class="textLength'+(m.length+2)+'">'+m+'</span><span>'+n+":"+'</span>');
							}
							$c2.find(".date.form_datetime").find(".input-group-addon.add-on").before($(this));
							$this.find(">.row").append($c2);
							$c2.find(".date.form_datetime").find(".input-group-addon.add-on").before($xHidden);
						})
					}
					else if($(this).find("input[forBtn],select[forBtn]").length>0){
						var y = $(this).find("input[forBtn],select[forBtn]").eq(0).attr("forBtn").trim();
						var $yHidden = $thisClone.find("[btnId="+y+"]").parents(".form-group").eq(0).find("input[type='hidden']");
						var $yBtn = $thisClone.find("[btnId="+y+"]").parents(".form-group").eq(0).find(".btn").clone();
						$yBtn.html("<span class='glyphicon glyphicon-search'></span>");
						$x.each(function(i){
							var $c3 = $(c3);
							var label = $this2.find("label").eq(i).text();
							label = label.replace(/\s/gi,"");
							label = label.replace(/:$/gi,"");
							var m = label.substring(0,label.length-1);
							var n = label.substring(label.length-1);
							$c3.find("label.label-text").html('<span class="textLength'+label.length+'">'+m+'</span><span>'+n+":"+'</span>');
							$(this).addClass("input-width");
							$c3.find(".input-group-btn").before($(this));
							$c3.find(".input-group-btn").append($yBtn);
							$this.find(">.row").append($c3);
							$c3.find(".input-group-btn").before($xHidden);
							$c3.find(".input-group-btn").before($yHidden);
						})
					}
					else{
						$x.each(function(i){
							var $c1 = $(c1);
							var $c3 = $(c3);
							var label = $this2.find("label").eq(i).text();
							label = label.replace(/\s/gi,"");
							label = label.replace(/:$/gi,"");
							var m = label.substring(0,label.length-1);
							var n = label.substring(label.length-1);
							$c1.find("label.label-text").html('<span class="textLength'+label.length+'">'+m+'</span><span>'+n+":"+'</span>');
							$c3.find("label.label-text").html('<span class="textLength'+label.length+'">'+m+'</span><span>'+n+":"+'</span>');
							$(this).addClass("input-width");
							if($xBtn.length>0){
								$(this).addClass("input-width");
								$c3.find(".input-group-btn").before($(this));
								$c3.find(".input-group-btn").append($xBtn);
								$this.find(">.row").append($c3);
								$c3.find(".input-group-btn").before($xHidden);
							}
							else{
								$c1.find("label.label-text").after($(this));
								$this.find(">.row").append($c1);
								$c1.append($xHidden);
							}
						})
					}
				}
				else{
					$this.find(">.row").append($(this));
					$(this).find(".datetimepicker").remove();
				}
			})
			$this.find("[class*='dataBox_']").each(function(){
				var cText = $(this).attr("class").match(/dataBox_[0-9]+/g)[0];
				$(this).find(".calendar").each(function(){
					var time = $(this).attr("format")||"yyyy-mm-dd hh:ii:ss";
					var view = $(this).attr("minView")||"hour";
					if($(this).hasClass("startTime")){
						$(this).parent().datetimepicker({
							container:$(this).parents("."+cText),
							language: "zh-CN",
							startView:"month",
							format:time,
							minView:view,
							pickerPosition:"bottom-left",
							autoclose:true
						}).on("click",function(ev){ $(this).datetimepicker("setEndDate", $this.find("."+cText).find(".endTime").val())});
					}
					else if($(this).hasClass("endTime")){
						$(this).parent().datetimepicker({
							container:$(this).parents("."+cText),
							language: "zh-CN",
							startView:"month",
							format:time,
							minView:view,
							pickerPosition:"bottom-left",
							autoclose:true
						}).on("click",function(ev){ $(this).datetimepicker("setStartDate", $this.find("."+cText).find(".startTime").val())});
					}
					else{
						$(this).parent().datetimepicker({
							container:$(this).parents("."+cText),
							language: "zh-CN",
							startView:"month",
							format:time,
							minView:view,
							pickerPosition:"bottom-left",
							autoclose:true
						})
					}
				})
			})
			$this.append($btnBox);
			$thisClone.find(".termBtn").not(".btn-reset").not("[id='clearbtns']").not("[id='reset']").each(function(){
				$this.find($btnBox).find(".btn-reset").after($(this));
			})
			$this.find(">.row").append($thisClone.find("input[type='hidden']"));
			$this.find(">.row").append($thisClone.find(".btn:not([BtnId]):not([id='clearbtns']):not([id='reset']):not([class*='btn-reset'])"));
			$this.resetFunction();
			$this.addClass("queryTerm-Ok");
		}
	})




	// --- 表格1组件 ------------------------------------------------------------------------------------------

	var tableHead = '<div class="panel-btn-div">'+
		'</div>'+
		'<div class="panel-heading">'+
		'<h3 class="panel-title panel-h3">'+
		'<i class="fa fa-table fa-fw"></i><span>明细列表</span>'+
		'</h3>'+
		'</div>';


	var tableBody = '<div class="panel-body table-responsive">'+
		'</div>';


	var paginationNav = '<div class="pagination-nav">'+
		'<ul id="pagination" class="pagination">'+
		'</ul>'+
		'</div>';


	$tablePanel.each(function(){
		if(!$(this).hasClass("Panel-Ok")){
			var $this = $(this);
			var $thisClone = $this.clone();
			var $thisBtn = $this.clone().find(".btn:not([forTable])");
			$thisBtn.each(function(){
				if($(this).parents("table")){
					$(this).remove();
				}
			})
			var panelTitle = $this.find(".panel-title").text().trim();
			$this.html("");
			var $tableHead = $(tableHead);
			var $tableBody = $(tableBody);
			var $paginationNav = $(paginationNav);
			$this.append($tableHead);
			$this.append($tableBody);
			if(panelTitle && panelTitle!=""){
				$tableHead.find(".panel-title>span").text(panelTitle);
			}
			$thisClone.find("table").each(function(i){
				if($(this).hasClass("nofilter")){
					var filterText = "nofilter";
				}
				$(this).removeClass();
				$(this).addClass("table table-bordered table-hover")
				if(filterText&&filterText!=""){ $(this).addClass(filterText); }
				$this.find($tableBody).append($(this));
				$thisClone.find(".pagination-nav").each(function(){
					$this.append($(this));
				})
				$(this).parents(".panel").filterControlLoad();
				$(this).parents(".panel").tableWidthAutoEnable();
			})
			$thisBtn.addClass("panel-btn");
			$this.find(".panel-btn-div").append($thisBtn);
			$this.addClass("Panel-Ok");
		}
	})
	$panelBtn.each(function(){
		if($(this).parents(".Panel-Ok").length==0){
			var text = $(this).attr("forTable").trim();
			$(this).addClass("panel-btn");
			$("#"+text).parents(".tablePanel").find(".panel-btn-div").append($(this));
		}
	})





	// --- 表格2组件 ------------------------------------------------------------------------------------------

	$tableTerm.each(function(i){
		var bool = $(this).find(".showExpressDiv,embed,[id='expressPdf'],[name='expressPdf']").length>0;
		bool = bool || $(this).hasClass("tableTerm-Ok")
		if(!bool){
			var $this = $(this);
			var $table =  $this.find("table");
			$table.each(function(){
				if($(this).parents(".panel").length==0){
					$(this).addClass("termTable");
					$(this).addClass("resetBox");
					if($this.hasClass("row")){
						$this.append("<div class='col-lg-12'></div>");
						$this.find(".col-lg-12").append($(this));
					}
					else if(!$this.hasClass("row")&&$this.find("[class^='col-']").length==0){
						$this.append("<div class='row'><div class='col-lg-12'></div></div>");
						$this.find(".col-lg-12").append($(this));
					}
					$(this).find("tr").each(function(){
						$(this).find("td").each(function(i){
							$(this).addClass("table-minWidth");
							if(i%2==0 && !$(this).attr("colspan")){ $(this).css("width","15%"); }
							if($(this).find("input:not([type='file']),select").length>0&&$(this).find(".btn").length==0){
								$(this).find("input:not([type='file']),select").addClass("input-width");
							}
							else if($(this).find("input:not([type='file']),select").length==1&&$(this).find(".btn").length==1){
								var v = '<div class="input-group input-width">'+
									    '<span class="input-group-btn">'+
									    '</span>'+
									    '</div>';
								var $v = $(v);
								var $x = $(this).find("input:not([type='file']),select");
								var $y = $(this).find(".btn");
								$(this).append($v);
								$(this).find($v).find(".input-group-btn").before($x);
								$(this).find($v).find(".input-group-btn").append($y);
							}
						})
					})
				}
				if($(this).find("tr:last").find("td").length==1&&$(this).find("td:last").attr("colspan")>1&&$(this).find("td:last").find(".btn").length>0){
					var htmlContent = $(this).find("td:last").html();
					var resetBtn = '<button type="button" class="btn btn-primary btn-reset">重置</button>';
					if($(this).find("thead").length==0){
						$(this).find("td:last").html(resetBtn+htmlContent);
					}
				}
				else{
					var resetBtn = '<button type="button" class="btn btn-primary btn-reset">重置</button>';
					if($(this).find("thead").length==0){
						$(this).append('<tr><td colspan="4">'+resetBtn+'</td></tr>');
					}
				}
				$(this).resetFunction();
			})
			$this.addClass("tableTerm-Ok");
			tableTermWidthAuto()
		}
	})

}



window.onresize=function(){
	if(window.screen.width>=768){
		bugRepair();
	}
	tableTermWidthAuto();
}


$(function(){
	$(".queryTerm-Ok,.Panel-Ok,.tableTerm-Ok").removeClass("queryTerm-Ok Panel-Ok tableTerm-Ok");
	$(".mainPageIframe,.navPageIframe,.navContentPageIframe,.modalPageIframe").removeClass("mainPageIframe navPageIframe navContentPageIframe modalPageIframe");
	$("#sending").css({"position":"absolute","height":"81px","width":"225px","top":"50%","left":"50%","margin-left":"-113px","margin-top":"-41px","z-index":"10","visibility":"hidden"});
	$("#sending").find("td").each(function(){ if($(this).html()==""){ $(this).remove(); } })
	$("#page-wrapper").addClass("iframePage");
	$(".modal>.modal-dialog>.modal-content>.modal-body").each(function(){
		if($(this).find(">iframe").length==0){
			$(this).css({"overflow":"auto","-webkit-overflow-scrolling":"touch"});
		}
	})

	$(".query").each(function(){
		$(this).has(".form-group,.col-set").addClass("queryTerm");
		$(".queryTerm").find(".btn[id='querybtns']").addClass("termBtn");
	})

	var t_i = 0;
	$("table").each(function(){
		if($(this).find("thead").length>0){
			if($(this).parents(".panel").length>0){
				$(this).parents(".panel").addClass("tablePanel");
			}
			else if($(this).parents(".datetimepicker").length==0){
				$(this).wrap("<div class='panel panel-default tablePanel'></div>")
				var $paginationNav = $(document).find(".pagination-nav");
				var $panelPaginationNav = $(document).find(".panel .pagination-nav");
				$paginationNav.find($panelPaginationNav).remove();
				$(this).parent().append($paginationNav.eq(t_i));
				t_i++;
			}
		}
		else if($(this).parents("#sending,.panel").length==0){
			$(this).wrap("<div class='tableTerm'></div>");
		}
	})

	bugRepair();
	Content();
	tableTermWidthAuto();

	
	// ----------手机端隐藏或显示 --------------------------------------------------------------------
	if($(document).find(".queryTerm,.tableTerm").length>0){
		$(document).find(".tablePanel").addClass("row-768-visible");
		var btnSearch = '<button type="button" class="btn btn-primary btn-768-search">'+
			'<i class="fa fa-search fa-fw"></i>'+
			'</button>';
		$(document).find(".tablePanel").find(".panel-heading").append($(btnSearch));
	}
	if($(document).find(".row-768-visible").length>0){
		$(document).find(".queryTerm,.tableTerm").addClass("row-768-hidden");
		var btnCancel = '<button type="button" class="btn btn-primary termBtn btn-768-cancel">取消</button>';
		$(document).find(".queryTerm .termBtnBox,.tableTerm td:last").append($(btnCancel));
		$(document).find(".queryTerm .btn[id='querybtns'],.tableTerm .btn[id='querybtns']").addClass("btn-768-sure");
	}

	$(document).on("click",".btn-768-search,.btn-768-cancel,.btn-768-sure",function(){
		$(".row-768-hidden").addClass("row-768-visible");
		$(".row-768-hidden").removeClass("row-768-hidden");
		$(this).parents(".row-768-visible").addClass("row-768-hidden");
		$(this).parents(".row-768-visible").removeClass("row-768-visible");
	})

})
    
