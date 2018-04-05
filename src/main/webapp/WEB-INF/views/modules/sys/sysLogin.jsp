<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>西安音乐学院附属中等音乐学校智慧校园管理系统</title>
	
 	<link rel="icon" type="image/png" href="${ctxStatic}/img/favicon.png">
	<meta name="decorator" content="blank"/>

    <link rel="stylesheet" href="${ctxStatic}/login/yyxyLogin.css">
    <script type="text/javascript">
		$(document).ready(function() {
		     $("#validateCode").css("width","150px"); 
		    $("#validateCode").addClass("ipt");
		    $("#validateCode").attr("placeholder","请输入验证码");
		    var i = 0;
			$("#loginForm").validate({
				rules: {
					 validateCode: {remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"} 
				},
				messages: {
					username: {required: "请填写用户名."},
					password: {required: "请填写密码."},
					validateCode: {remote: "验证码不正确.", reuired: "请填写验证码."}
				},
				errorLabelContainer: "#messageBox",
				errorPlacement: function(error, element) {
				   if(i==0){
				     error.appendTo(element.next().next());
				   }else if(i==2){ 
				     error.appendTo(element.next().next());
				   }else{
				     error.appendTo(element.next());
				   }
				   i = i+1; 
				} 
			});
		});
		// 如果在框架或在对话框中，则弹出提示并跳转到首页
		if(self.frameElement && self.frameElement.tagName == "IFRAME" || $('#left').length > 0 || $('.jbox').length > 0){
			/* alert('未登录或登录超时。请重新登录，谢谢！'); */
			top.location = "${ctx}";
		}
	</script>
	<style>
	.error{
		background-position: 0 16px !important;
		height: 45px;
		line-height: 45px;
		margin-bottom: 0;
	}
	.alert{
		width: 360px !important;
		padding: 0 !important;

	}
	.alert .close{
		right:0 !important;
	}
	</style>
</head>
<body onkeydown="enterlogin();">
<div class="login_top">
	<div class="min_width">
		<img class="logo" alt="logo" src="${ctxStatic}/images/logo.png">
	</div>
</div>

<!--  主体-->
<div class="login_cont">
	<div class="min_width">
		<div class="login_box">
			<form id="loginForm" class="loginbox" action="${ctx}/login" method="post">
				<h2>用 户 登 录
			  		<a href="#" class="ewm"></a>
					<a href="#" class="phone"></a> 		
			  	</h2>
			  	<div class="alert alert-error ${empty message ? 'hide' : ''}"><button data-dismiss="alert" class="close">×</button>
					<label class="error">${message}</label>
				</div>
				<label>			
					<input class="ipt" type="text" name="username" id='username' placeholder="请输入登录名" />
				</label>
				<label>
					<input class="ipt" type="password" name="password" id='password' placeholder="请输入密码" />
				</label>
				<%-- <label>
					<input class="ipt captcha" type="text" name="captcha" id='yzm' placeholder="请输入验证码"/>
					<img id="captcha" alt="验证码" src="${path }/captcha.jpg" data-src="${path }/captcha.jpg?t=">
				</label> --%>
				<label>
					<!-- <label class="mid" for="validateCode" class="login_label" style="display: block; float:left; line-height: 35px; margin-right: 10px;"></label> -->
			        <sys:validateCode name="validateCode" inputCssStyle="margin-bottom:0;"/>
			    </label>
				<label>
					<input class="login_btn" type="submit" id='login_btn' value="登 &nbsp;&nbsp;&nbsp;&nbsp; 录"/>				
				</label>			
			</form>
		</div>
	</div>
</div>

<!-- foot -->
<div class="login_foot">
   <div class="min_width">
   		<%-- <div class="foot_logo">
			<img alt="logo" src="${ctxStatic}/images/logo.png">
		
		</div> --%>	
	<p class="first">地址：西安市长安中路108号 &nbsp;&nbsp;&nbsp;&nbsp;       电话：029- 85239738</p>
	<p>陕ICP备05001584号-1</p>
   </div>

	
</div>





</body>
</html>