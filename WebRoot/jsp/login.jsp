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
<link rel="stylesheet" href="${wmsUrl}/plugins/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${wmsUrl}/plugins/font-awesome/css/font-awesome.min.css">
<link rel="icon" href="${wmsUrl}/img/logo_1.png" type="image/x-icon"/>
<style>
	body{
		background: url("${wmsUrl}/img/background.jpg") no-repeat ;
		background-size: cover;
	}
	input::-webkit-input-placeholder{
        color: #999;
    }
    input::-moz-placeholder{   /* Mozilla Firefox 19+ */
        color: #999;
    }
    input:-moz-placeholder{    /* Mozilla Firefox 4 to 18 */
        color: #999;
    }
    input:-ms-input-placeholder{  /* Internet Explorer 10-11 */ 
        color: #999;
    }
/* 	input:-webkit-autofill{ */
/* 	    -webkit-box-shadow: 0 0 0px 1000px white inset !important; */
/* 	    background-color: rgba(255,255,255,0.5) !important; */
/* 	    background-image: none !important; */
/* 	    color: #666 !important; */
/* 	    -webkit-tap-highlight-color:rgba(255,255,255,0.5) !important; */
/* 	} */
	.login-header{
		text-align: left;
    	padding: 14px 30px;
    	background: #fff;
	}
	.login-header span{
		vertical-align: middle;
	    margin-left: 30px;
	    padding-left: 30px;
	    font-size: 18px;
	    border-left: 1px solid #d9d9d9;
	    color: #666;
	}
	.login-desc{
		font-size: 16px;
	    color: #fff;
	    text-align: center;
	    line-height: 40px;
	    font-weight: 100;
	    padding: 5px;
	    background: #a8a3a7 url('${wmsUrl}/img/logo_1.png') no-repeat calc(50% - 205px) center;
	    background-size: 36px 36px;
	}
	.inner-bg{
		margin-top: 7%;
	}
	.form-top h3{
		font-size: 20px;
		font-weight: 600;
		padding-bottom: 30px;
		color: #333;
		margin: 0;
	}
	.form-bottom div{
		padding: 24px 0 12px 0;
	    border-bottom: 1px solid #e9e9e9;
	    margin-bottom: 10px;
	}
	.form-bottom div{
		overflow: hidden;
	}
	.form-bottom div label{
		float:left;
		width: 15%;
		font-size: 16px;
		line-height: 28px;
		color: #666;
		font-weight: normal;
	}
	.form-bottom div input{
		float: left;
		width: 85%;
	    font-size: 16px;
	    border: none;
	    padding-right: 0;
	    height: 28px;
	    line-height: 20px;
	    background: transparent;
	    outline: none;
	    color: #666;
	    padding-left: 20px;
	}
	.form-bottom button.btn{
		width: 100%;
	    height: 54px;
	    font-size: 18px;
	    -webkit-border-radius: 2px;
	    -moz-border-radius: 2px;
	    border-radius: 2px;
	   	color: #ffffff;
	    background-color: #5491de;
	    border-color: #5491de;
	    margin-top: 20px;
	}
	.login-content{
		width: 480px;
    	margin: auto;
    	padding: 40px 25px;
    	background: rgba(255,255,255,0.5);
	}
}
</style>
	<script type="text/javascript">
		function IsPC() {
		    var userAgentInfo = navigator.userAgent;
		    var Agents = ["Android", "iPhone",
		                "SymbianOS", "Windows Phone",
		                "iPad", "iPod"];
		    var flag = true;
		    for (var v = 0; v < Agents.length; v++) {
		        if (userAgentInfo.indexOf(Agents[v]) > 0) {
		            flag = false;
		            break;
		        }
		    }
		    return flag;
		}
		var flag = IsPC();//true为PC端，false为手机端
		if (!flag) {
			alert("请在电脑端使用火狐浏览器访问后台系统！");
		}
	</script>
</head>

<body onLoad="IsPC();">
	<!-- Top content -->
        <div class="top-content">
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
			                    	<div class="">
			                    		<label class="" for="form-username">员工号</label>
			                        	<input type="text" name="form-username" placeholder="请输入绑定的员工号" id="form-username">
			                        </div>
			                        <div class="">
			                        	<label class="" for="form-password">密码</label>
			                        	<input type="password" name="form-password" placeholder="请输入登录密码" id="form-password">
			                        </div>
			                    	<button id="submitBtn" type="button" class="btn">登录</button>
			                    </form>
		                    </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
    
	<script src="${wmsUrl}/plugins/jQuery/jquery-2.2.3.min.js"></script>
	<script src="${wmsUrl}/plugins/bootstrap/js/bootstrap.min.js"></script>
	<script src="${wmsUrl}/js/manager.js"></script>
	<script>
	
	jQuery(document).ready(function() {
		
		if (window != top) {
			top.location.href = location.href;
		}
	    
	    $('#submitBtn').on('click', function(e) {
	    	
	    	var userName = $("#form-username").val();
	    	var pwd = $("#form-password").val();
	    	
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
    		            	}
	    		         } ,
	    		         error : function(data) {
// 	    		        	 $('#submitBtn').click();
	    		         	alert("网络异常，请稍后登录");	
	    		       	 }
    				}
    			)
	    });
	    
		$('input').keyup(function(e) {
			
			if(e.keyCode == 13){
				var userName = $("#form-username").val();
		    	var pwd = $("#form-password").val();
		    	
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
	    		            	}
		    		         } ,
		    		         error : function(data) {
		    		        	 $('#submitBtn').click();
// 		    		            	alert("网络异常，请稍后登录");	
		    		       	 }
	    				}
	    			)
			}
	    });
	});
	</script>
	
</body>
</html>
