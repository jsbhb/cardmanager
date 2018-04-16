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
					<form class="form-horizontal" role="form" id="userBindCardForm" >
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1"><h4>银行卡信息</h4></label>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">银行卡号</label>
							<div class="col-sm-5">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-address-book"></i>
				                  </div>
				                  <input type="text" readonly class="form-control" name="cardNo" id="cardNo" value="${card.cardNo}">
				                  <input type="hidden" class="form-control" name="id" id="id" value="${card.id}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">银行名称</label>
							<div class="col-sm-5">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-user-o"></i>
				                  </div>
		                  			<input type="text" readonly class="form-control" name="cardBank" id="cardBank" value="${card.cardBank}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">持卡人姓名</label>
							<div class="col-sm-5">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-address-book"></i>
				                  </div>
				                  <input type="text" readonly class="form-control" name="cardName" id="cardName" value="${card.cardName}">
				                </div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right" for="form-field-1">预留电话</label>
							<div class="col-sm-5">
								<div class="input-group">
				                  <div class="input-group-addon">
				                    <i class="fa fa-address-book"></i>
				                  </div>
				                  <input type="text" readonly class="form-control" name="cardMobile" id="cardMobile" value="${card.cardMobile}">
				                </div>
							</div>
						</div>
						<div class="col-md-offset-3 col-md-9">
							<div class="form-group">
	                            <button type="button" class="btn btn-primary" id="submitBtn">解绑</button>
	                        </div>
                       </div>
					</form>
				</div>
			</div>
		</div>
	</section>
	<script type="text/javascript">	
	$("#submitBtn").click(function(){
		 $.ajax({
			 url:"${wmsUrl}/admin/user/userCardMng/delete.shtml",
			 type:'post',
			 data:JSON.stringify(sy.serializeObject($('#userBindCardForm'))),
			 contentType: "application/json; charset=utf-8",
			 dataType:'json',
			 success:function(data){
				 if(data.success){	
					 layer.alert("解绑成功");
					 parent.layer.closeAll();
					 parent.reloadTable();
				 }else{
					 layer.alert(data.msg);
				 }
			 },
			 error:function(){
				 layer.alert("解绑失败，请联系客服处理");
			 }
		 });
	 });
	</script>
</body>
</html>
