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
<%@include file="../../resource.jsp"%>
</head>

<body>
	<section class="content">
        <div class="main-content">
			<div class="row">
				<div class="col-xs-12" >
					<form class="form-horizontal" role="form" id="goodsRebateForm" >
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"><h4>商品信息</h4></label>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">商品编号</label>
							<div class="col-sm-5">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-user-o"></i>
				                  </div>
<%-- 		                  			<input type="hidden" class="form-control" name="id" id="id" value="${goods.id}"> --%>
		                  			<input type="text" readonly class="form-control" name="goodsId" id="goodsId" value="${goods.goodsId}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">商品名称</label>
							<div class="col-sm-5">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-address-book"></i>
				                  </div>
				                  <input type="text" class="form-control" name="goodsName" id="goodsName" value="${goods.goodsName}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">区域返佣比例</label>
							<div class="col-sm-5">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-address-book"></i>
				                  </div>
				                  <input type="text" class="form-control" name="first" id="first" value="${goods.first}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">店铺返佣比例</label>
							<div class="col-sm-5">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-address-book"></i>
				                  </div>
				                  <input type="text" class="form-control" name="second" id="second" value="${goods.second}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">推手返佣比例</label>
							<div class="col-sm-5">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-address-book"></i>
				                  </div>
				                  <input type="text" class="form-control" name="third" id="third" value="${goods.third}">
				                </div>
							</div>
						</div>
						<div class="col-md-offset-3 col-md-9">
							<div class="form-group">
	                            <button type="button" class="btn btn-primary" id="submitBtn">保存</button>
	                        </div>
                       </div>
					</form>
				</div>
			</div>
		</div>
	</section>
	<%@ include file="../../footer.jsp"%>
	<script type="text/javascript">
	
	$("#submitBtn").click(function(){
		var first = $("#first").val();
		if (first > 1) {
			layer.alert("区域返佣比例大于1，请用小数设置！");
			return;
		}
		var second = $("#second").val();
		if (second > 1) {
			layer.alert("店铺返佣比例大于1，请用小数设置！");
			return;
		}
		var third = $("#third").val();
		if (third > 1) {
			layer.alert("推手返佣比例大于1，请用小数设置！");
			return;
		}
		 $.ajax({
			 url:"${wmsUrl}/admin/goods/goodsRebateMng/update.shtml",
			 type:'post',
			 data:JSON.stringify(sy.serializeObject($('#goodsRebateForm'))),
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){	
					 layer.alert("保存成功");
					 parent.layer.closeAll();
					 parent.location.reload();
				 }else{
					 layer.alert(data.msg);
				 }
			 },
			 error:function(){
				 layer.alert("提交失败，请联系客服处理");
			 }
		 });
	 });
	</script>
</body>
</html>
