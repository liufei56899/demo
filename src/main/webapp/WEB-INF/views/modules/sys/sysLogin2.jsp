<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>${fns:getConfig('productName')} 登录</title>
	<meta name="decorator" content="blank"/>
    <link rel="stylesheet" href="${ctxStatic}/login/style.css">
    <script type="text/javascript">
		$(document).ready(function() {
			$("#loginForm").validate({
				rules: {
					validateCode: {remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"}
				},
				messages: {
					username: {required: "请填写用户名."},password: {required: "请填写密码."},
					validateCode: {remote: "验证码不正确.", required: "请填写验证码."}
				},
				errorLabelContainer: "#messageBox",
				errorPlacement: function(error, element) {
					error.appendTo($("#loginError").parent());
				} 
			});
			$(window).resize();
		});
		// 如果在框架或在对话框中，则弹出提示并跳转到首页
		if(self.frameElement && self.frameElement.tagName == "IFRAME" || $('#left').length > 0 || $('.jbox').length > 0){
			alert('未登录或登录超时。请重新登录，谢谢！');
			top.location = "${ctx}";
		}
		$(window).resize(function(){
			$('body').height($(window).height());
			var top = $('body').height() / 2 - $('.form-signin').height() / 2 - 39;
			var left = $('body').width() / 2 - $('.form-signin').width() / 2 - 14;
			$('.form-signin').css({'top':top,'left':left});
			$('.footer').css({'top':top+250,'left':left+30});
		});
	</script>
</head>
<body style=" overflow:hidden;">
    <div class="top"></div>
	<div class="logintop">
		<span class="logo-font"> 
		  <img src="${ctxStatic}/lg-images/logofont.png"> 
		  <img src="${ctxStatic}/lg-images/loginxx.png" class="xx"> 
		</span>
	</div>
	<div class="loginline"></div>
    <div class="banner">
    <!--[if lte IE 6]><br/><div class='alert alert-block' style="text-align:left;padding-bottom:10px;"><a class="close" data-dismiss="alert">x</a><h4>温馨提示：</h4><p>你使用的浏览器版本过低。为了获得更好的浏览体验，我们强烈建议您 <a href="http://browsehappy.com" target="_blank">升级</a> 到最新版本的IE浏览器，或者使用较新版本的 Chrome、Firefox、Safari 等。</p></div><![endif]-->
	<div class="header">
		<div id="messageBox" class="alert alert-error ${empty message ? 'hide' : ''}"><button data-dismiss="alert" class="close">×</button>
			<label id="loginError" class="error">${message}</label>
		</div>
	</div>
     <form id="loginForm" class="loginbox"  style="position: absolute; left: 780px; top: 80px;" action="${ctx}/login" method="post">
		<ul>
		  <li><input type="text" id="username" name="username" class="loginuser required"  value="${username}"></li>
		  <li>
		     <input type="password" id="password" name="password" class="loginpwd required">
		     <c:if test="${isValidateCodeLogin}">
		       <div class="validateCode">
			      <label class="input-label mid" for="validateCode">验证码</label>
			      <sys:validateCode name="validateCode" inputCssStyle="margin-bottom:0;"/>
		       </div>
	        </c:if>
		  </li>
		  <li><input class="btn btn-primary" type="submit" value="登 录"/>
		      <label for="rememberMe" title="下次不需要再登录">
		         <input type="checkbox" id="rememberMe" name="rememberMe" ${rememberMe ? 'checked' : ''}/>记住密码
		      </label>
		  </li>
		</ul>
      </form>
  </div>
</div>
<div class="loginbm">版权所有  2016  <a href="#"></a>  陕西中等职业教育招生管理系统</div>
</body>
</html>