
	if (window.top != window.self) {
		window.top.location = window.self.location;
	}

	function createCode(obj) {
		//验证码
		var srctime = new Date().getTime();
		obj.src = "${wmsUrl}/servlet/GetYzm?time=" + srctime + "&state=0";

	}

	function validate_yzm() {
		var yzm = $("#yzm").val();
		if (yzm == "") {
			$("#yzmMes").html(
					"<font style='font-size:12px' color='red'>验证码不能为空</font>");
			return;
		} else {
			$("#yzmMes").html("");
			return;
		}
	}
	$(document).ready(function() {
		$("#submitlogin").click(function(e) {
			if ($("#userName").val() == "" || $("#userName").val() == "用户名") {
				$(".login_err").html("请填写：用户名 ");
				return;
			}
			if ($("#password").val() == "") {
				$(".login_err").html("请填写密码！");
				return;
			}

			var yzm = $("#yzm").val();
			if (yzm == "") {
				$(".login_err").html("请填写：验证码");
				return;
			}
			$.ajax({
				type : "post", //提交方式  
				dataType : "json", //数据类型  
				url : encodeURI("${wmsUrl}/admin/login.shtml"), //请求url  
				data : {
					'userName' : $("#userName").val(),
					'pwd' : $("#password").val(),
					'verifyCode' : yzm
				},
				success : function(data) { //提交成功的回调函数  
					if (data.success) {
						window.location.href = "${wmsUrl}/admin/main.shtml";
					} else {
						$(".login_err").html(data.msg);
					}
				},
				error : function(data) {
					$(".login_err").html("网络异常，请稍后登录");
				}
			})

		});
	});
