<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

</head>
<body>
<section class="content-wrapper">
	<section class="content-header">
	      <ol class="breadcrumb">
	        <li><a href="javascript:void(0);">首页</a></li>
	        <li>商品管理</li>
	        <li class="active">基础商品</li>
	      </ol>
	      <div class="search">
	      	<input type="text" name="id" placeholder="请输入商品名称">
	      	<div class="searchBtn"><i class="fa fa-search fa-fw"></i></div>
	      	<div class="moreSearchBtn">高级搜索</div>
		  </div>
    </section>	
	<section class="content">
		<div id="image" style="width:100%;height:100%;display: none;background:rgba(0,0,0,0.5);margin-left:-25px;margin-top:-62px;">
			<img alt="loading..." src="${wmsUrl}/img/loader.gif" style="position:fixed;top:50%;left:50%;margin-left:-16px;margin-top:-16px;" />
		</div>
		<div class="moreSearchContent">
			<div class="row form-horizontal query">
				<div class="col-xs-3">
					<div class="searchItem">
			            <select class="form-control" name="brandId" id="brandId">
		                	<option selected="selected" value="">--请选择商品品牌--</option>
			                <c:forEach var="brand" items="${brands}">
			                <option value="${brand.brandId}">${brand.brand}</option>
			                </c:forEach>
			            </select>
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
	                  	<input type="text" class="form-control" name="id" placeholder="请输入商品编码">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchItem">
			           <input type="text" class="form-control" name="goodsName" placeholder="请输入商品名称">
					</div>
				</div>
				<div class="col-xs-3">
					<div class="searchBtns">
						 <div class="lessSearchBtn">简易搜索</div>
                         <button type="button" class="query" id="querybtns" name="signup">提交</button>
                         <button type="button" class="clear">清除选项</button>
                    </div>
                </div>
            </div>
		</div>
	
		<div class="list-tabBar">
			<ul>
				<li class="active">在售中</li>
				<li>已售罄</li>
				<li>已下架</li>
			</ul>
		</div>
	
		<div class="list-content">
			<div class="row">
				<div class="col-md-2 goods-classify">
					<span>商品分类</span>
					<i class="fa fa-list fa-fw"></i>
				</div>
				<div class="col-md-10 list-btns">
					<button type="button" onclick="toAdd()">新增基础商品</button>
				</div>
			</div>
			<div class="row content-container">
				<div class="col-md-2 container-left">
					<ul class="first-classfiy">
						<li>
							<span>母婴用品</span>
							<i class="fa fa-angle-right fa-fw"></i>
							<ul class="second-classfiy">
								<li>
									<span>纸尿裤湿巾</span>
									<i class="fa fa-angle-right fa-fw"></i>
									<ul class="third-classfiy">
										<li><span>纸尿裤</span></li>
										<li><span>拉拉裤</span></li>
										<li><span>婴幼儿湿巾</span></li>
									</ul>
								</li>
							</ul>
						</li>
						<li>
							<span>母婴用品</span>
							<i class="fa fa-angle-right fa-fw"></i>
							<ul class="second-classfiy">
								<li>
									<span>纸尿裤湿巾</span>
									<i class="fa fa-angle-right fa-fw"></i>
									<ul class="third-classfiy">
										<li><span>纸尿裤</span></li>
										<li><span>拉拉裤</span></li>
										<li><span>婴幼儿湿巾</span></li>
									</ul>
								</li>
							</ul>
						</li>
						<li>
							<span>母婴用品</span>
							<i class="fa fa-angle-right fa-fw"></i>
							<ul class="second-classfiy">
								<li>
									<span>纸尿裤湿巾</span>
									<i class="fa fa-angle-right fa-fw"></i>
									<ul class="third-classfiy">
										<li><span>纸尿裤</span></li>
										<li><span>拉拉裤</span></li>
										<li><span>婴幼儿湿巾</span></li>
									</ul>
								</li>
							</ul>
						</li>
						<li>
							<span>母婴用品</span>
							<i class="fa fa-angle-right fa-fw"></i>
							<ul class="second-classfiy">
								<li>
									<span>纸尿裤湿巾</span>
									<i class="fa fa-angle-right fa-fw"></i>
									<ul class="third-classfiy">
										<li><span>纸尿裤</span></li>
										<li><span>拉拉裤</span></li>
										<li><span>婴幼儿湿巾</span></li>
									</ul>
								</li>
							</ul>
						</li>
					</ul>
				</div>
				<div class="col-md-10 container-right">
					<table id="baseTable" class="table table-hover myClass">
						<thead>
							<tr>
								<th width="3%"><input type="checkbox" id="theadInp"></th>
								<th width="23%">商品名称</th>
								<th width="12%">品牌名称</th>
								<th width="6%">增值税</th>
								<th width="6%">关税</th>
								<!-- <th>单位</th>
								<th>hscode</th> -->
								<th width="10%">条码</th>
								<th width="18%">分类</th>
								<th width="7%">所属机构</th>
								<th width="9%">创建时间</th>
								<th width="8%">操作</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
					<div class="pagination-nav" style="float:right;margin-bottom:15px;">
						<ul id="pagination" class="pagination">
						</ul>
					</div>
				</div>
			</div>
		</div>	
	</section>
</section>
	
<%@include file="../../resource.jsp"%>
<script src="${wmsUrl}/plugins/fastclick/fastclick.js"></script>
<script type="text/javascript">


/**
 * 初始化分页信息
 */
var options = {
			queryForm : ".query",
			url :  "${wmsUrl}/admin/goods/baseMng/dataList.shtml",
			numPerPage:"20",
			currentPage:"",
			index:"1",
			callback:rebuildTable
}


$(function(){
	 $(".pagination-nav").pagination(options);
	 var top = getTopWindow();
	$('.breadcrumb').on('click','a',function(){
		top.location.reload();
	});
})


function reloadTable(){
	$.page.loadData(options);
}


/**
 * 重构table
 */
function rebuildTable(data){
	$("#baseTable tbody").html("");

	if (data == null || data.length == 0) {
		return;
	}
	
	var list = data.obj;
	
	if (list == null || list.length == 0) {
		layer.alert("没有查到数据");
		return;
	}

	var str = "";
	for (var i = 0; i < list.length; i++) {
		str += "<tr>";
		//if ("${privilege>=2}") {
		str += "<td><input type='checkbox'/>"
		str += "</td><td>" + list[i].goodsName;
		str += "</td><td>" + list[i].brand;
		str += "</td><td>" + list[i].incrementTax;
		str += "</td><td>" + list[i].tariff;
		//str += "</td><td>" + list[i].unit;
		//str += "</td><td>" + (list[i].hscode == null ? "" : list[i].hscode);
		str += "</td><td>" + list[i].encode;
		str += "</td><td>" + list[i].firstCatalogId+"-"+list[i].secondCatalogId+"-"+list[i].thirdCatalogId;
		str += "</td><td>" + list[i].centerId;
		str += "</td><td>" + list[i].createTime;
		if (true) {
			str += "<td align='left'>";
			str += "<a href='javascript:void(0);' onclick='toEdit("+list[i].id+")'><i class='fa fa-pencil' style='font-size:20px'></i></a>";
			str += "</td>";
		}
		str += "</td></tr>";
	}
		

	$("#baseTable tbody").html(str);
}
	
function toEdit(id){
	var index = layer.open({
		  title:"基础商品编辑",		
		  type: 2,
		  content: '${wmsUrl}/admin/goods/baseMng/toEdit.shtml?baseId='+id,
		  maxmin: true
		});
		layer.full(index);
}


function toAdd(){
	var index = layer.open({
		  title:"新增基础商品",		
		  type: 2,
		  content: '${wmsUrl}/admin/goods/baseMng/toAdd.shtml',
		  maxmin: true
		});
		layer.full(index);
}

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
	document.getElementById("brandId").options[0].selected="selected";
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
});

//点击展开分类列表
$('.container-left').on('click','i.fa-angle-right',function(){
	$(this).next().stop();
	$(this).next().slideDown(300);
	$(this).removeClass('fa-angle-right').addClass('fa-angle-down');
});

//点击收缩分类列表
$('.container-left').on('click','i.fa-angle-down',function(){
	$(this).next().stop();
	$(this).next().slideUp(300);
	$(this).removeClass('fa-angle-down').addClass('fa-angle-right');
	$('.container-left span.active').removeClass('active');
});

//点击分类
$('.container-left').on('click','span',function(){
	$('.container-left span.active').removeClass('active');
	$(this).addClass('active');	
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

</script>
</body>
</html>
