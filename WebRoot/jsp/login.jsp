<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>中国商贸城</title>
<link rel="stylesheet" href="${wmsUrl}/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${wmsUrl}/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="${wmsUrl}/css/style.css">
<link rel="stylesheet" href="${wmsUrl}/css/form-elements.css">

</head>

<body>
	<!-- Top content -->
        <div class="top-content">
            <div class="inner-bg">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-8 col-sm-offset-2 text">
                            <h1><strong>中国商贸城后台管理系统</strong></h1>
                            <div class="description">
                            	<p></p>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6 col-sm-offset-3 form-box">
                        	<div class="form-top">
                        		<div class="form-top-left">
                        			<h3>登录</h3>
                            		<p>请输入您的员工号和密码登陆：</p>
                        		</div>
                        		<div class="form-top-right">
                        			<i class="fa fa-key"></i>
                        		</div>
                            </div>
                            <div class="form-bottom">
			                    <form action="" class="login-form">
			                    	<div class="form-group">
			                    		<label class="sr-only" for="form-username">Username</label>
			                        	<input type="text" name="form-username" placeholder="Badge..." class="form-username form-control" id="form-username">
			                        </div>
			                        <div class="form-group">
			                        	<label class="sr-only" for="form-password">Password</label>
			                        	<input type="password" name="form-password" placeholder="Password..." class="form-password form-control" id="form-password">
			                        </div>
			                    	<button id="submitBtn" type="button" class="btn">登录</button>
			                    </form>
		                    </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
    
	<script src="${wmsUrl}/js/jquery.min.js" type='text/javascript'></script>
	<script src="${wmsUrl}/bootstrap/js/bootstrap.min.js"></script>
	<script src="${wmsUrl}/js/jquery.backstretch.min.js"></script>
	<script src="${wmsUrl}/js/login.js"></script>
	<script type="text/javascript" src="${wmsUrl}/js/manager.js"></script>
	<script type="text/javascript">
	
	jQuery(document).ready(function() {
		
	    /*
	        Fullscreen background
	    */
	    $.backstretch("${wmsUrl}/img/backgrounds/1.jpg");
	    
	    /*
	        Form validation
	    */
	    $('.login-form input[type="text"], .login-form input[type="password"], .login-form textarea').on('focus', function() {
	    	$(this).removeClass('input-error');
	    });
	    
	    $('#submitBtn').on('click', function(e) {
	    	
	    	var userName = $("#form-username").val();
	    	var pwd = $("#form-password").val();
	    	
	    	if(userName==""){
	    		$("#form-username").addClass('input-error');
	    		return;
	    	}
	    	
	    	if(pwd==""){
	    		$("#form-password").addClass('input-error');
	    		return;
	    	}
	    	
    		$.ajax(
    				{
    		            type:"post",  //提交方式  
    		            dataType:"json", //数据类型  
    		            url:encodeURI("${wmsUrl}/admin/login.shtml"), //请求url  
    		            data:{'userName':userName,'pwd':pwd},
    		            success:function(data){ //提交成功的回调函数  
    		            	if(data.success){
    		            		window.location.href = "${wmsUrl}/admin/main.shtml";
    		            	}else{
    		            		alert(data.msg);
    			            	$(".login_err").html(data.msg);	
    		            	}
	    		         } ,
	    		         error : function(data) {   
	    		            	$(".login_err").html("网络异常，请稍后登录");	
	    		       	 }
    				}
    			)
	    });
	});
	</script>
	
</body>
</html>
