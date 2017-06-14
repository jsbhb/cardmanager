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
<title>密码修改</title>
<%@include file="../resource.jsp"%>
</head>
<body>
	<div id="page-wrapper">

		<div class="container-fluid">
			<div>
				<label>当前密码</label> <input type="password" class="form-control"
					name="oldPwd" id="oldPwd">
			</div><br/><br/>
			<div>
				<label>新密码&nbsp;&nbsp;&nbsp;&nbsp;</label> <input type="password" class="form-control"
					name="newPwd" id="newPwd" onchange="checkFormat()">
			</div><div id="formatErr" style="display: none;"></div>
			<br/><br/>
			<div>
				<label>确认密码</label> <input type="password" class="form-control"
					name="confirmPwd" id="confirmPwd" onchange="comparePwd()">
			</div><div id="pwdErr" style="display: none;" class="col-set"></div>
			<br/>
			<div>
				<button type="button" class="btn btn-warning" onclick="ConfirmChange()">保存</button>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function ConfirmChange() {
			if(!comparePwd()){
				return;
			}
			
			oldPwd = $("#oldPwd").val();
			newPwd = $("#newPwd").val();
			
			$.ajax({
				type : "post",
				data : {
					'oldPwd' : oldPwd,
					'newPwd' : newPwd
				},
				dataType : 'json',
				url : '${wmsUrl}/admin/individual/changePwd.shtml',
				success : function(data) {
					if (data.success) {
						alert(data.msg)
						window.location.href = "${wmsUrl}/admin/toLogin.shtml";
					} else {
						$.zzComfirm
								.alertError(data.msg);
					}
				},
				error : function(data) {
					$.zzComfirm
							.alertError("操作失败，请联系管理员！");
				}
			});
		}
		
		function comparePwd() {
			firstPwd = $("#newPwd").val();
			secondPwd = $("#confirmPwd").val();
			if(firstPwd != secondPwd){
				$("#pwdErr").attr("style","color: red;font-size: 20px;display: block;");
				$("#pwdErr").html("两次输入密码不一致");
				return false;
			}else{
				$("#pwdErr").attr("style","display: none;");
			}
			return true;
		}
		
		function checkFormat() {
			newPwd = $("#newPwd").val();
			var reg = /^[a-zA-Z]\w{5,17}$/;//以字母开头，长度在6~18之间，只能包含字符、数字和下划线
			if(reg.test(newPwd)!=true){
				$("#formatErr").attr("style","color: red;font-size: 20px;display: block;");
				$("#formatErr").html("密码必须以字母开头，长度在6~18之间，只能包含字符、数字和下划线");
				$("#newPwd").val("");
			}else{
				$("#formatErr").attr("style","display: none;");
			}
		}
	</script>
</body>
</html>
