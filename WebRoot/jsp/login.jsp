<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->
<meta content="width=device-width,initial-scale=1,user-scalable=no" name="viewport">
<title>供销贸易后台</title>
<link rel="icon" href="${wmsUrl}/img/logo_1.png" type="image/x-icon"/>
<link rel="stylesheet" href="${wmsUrl}/plugins/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${wmsUrl}/css/business/login.css">
</head>

<body>
	<!-- Top content -->
	<div class="login-header">
		<img src="${wmsUrl}/img/logo.png"/>
		<span>登录</span>
	</div>
	<div class="login-desc">
		「供销贸易后台」，更便捷、更优质的体验都在这里
	</div>
    <div class="inner-bg">
        <div class="container">
            <div class="row">
                <div class="form-box login-content">
                	<div class="form-top">
                		<h3>帐号登录</h3>
                    </div>
                    <div class="form-bottom">
		                 <form action="" class="login-form">
		                 	<div>
		                 		<label for="form-username">员工号</label>
		                     	<input type="text" name="form-username" placeholder="请输入绑定的员工号" id="form-username">
		                     </div>
		                     <div>
		                     	<label for="form-password">密码</label>
		                     	<input type="password" name="form-password" placeholder="请输入登录密码" id="form-password">
		                     </div>
		                 	<button id="submitBtn" type="button" class="btn">登录</button>
		                 </form>	
                	</div>
                </div>
            </div>
        </div>
    </div>
        
    
	<script src="${wmsUrl}/plugins/jQuery/jquery-2.2.3.min.js"></script>
	<script src="${wmsUrl}/js/business/login.js"></script>
	<script>
	
	var options = {
			userNameId:"#form-username",
			passwordId:"#form-password",
			url:"${wmsUrl}/admin/login.shtml",
			mainUrl:"${wmsUrl}/admin/main.shtml",
			submitBtnId:"#submitBtn",
			errorMsgId:""
		}

	
	$(function(){
		 $("#submitBtn").login(options);
	})
	
	</script>
	
</body>
</html>
