<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>修改密码</title>
	<meta name="decorator" content="default"/>

	<script type="text/javascript">
		function validatePass()
		{
			var newPassword=$("#newPassword").val();
			if(newPassword!=null && newPassword!="")
			{
				var isTrue = /^[a-zA-Z_][a-zA-Z0-9_]{5,8}$/i.test(newPassword);
					if(!isTrue)
					{
						validTxt("newPassword","必须以字母下划线开头,输入6~9字节");
						return false;
					}
			}
			return true;
		}
	
		$(document).ready(function() {
			$("#oldPassword").focus();
			$("#inputForm").validate({
				rules: {
				},
				messages: {
					confirmNewPassword: {equalTo: "输入与上面相同的密码"}
				},
				submitHandler: function(form){
					var ret = validatePass();
					if(ret)
					{
						loading('正在提交，请稍等...');
						form.submit();
					}
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
	<style type="text/css">
	      .control-group{
	      border-bottom: none
	      }
	</style>
</head>
<body>


<div id="main">
    <!-- 显示顶部信息 -->
	<div id="main_top">
	   <div class="top-left"></div>
       <div class="top-right">
      <!--   <div class="right-top">
            <div style="text-align: center;">
            <span id="user_officename" style="margin-right: 15px;"></span>
            </div>
        </div> -->
        <div class="right-down">
            <ul>
                <li><i class="icon1"></i><a href="${ctx}/sys/role/zxbzpage" target="_blank">帮助</a></li>
                <!-- <li>
                <i class="icon2"></i>
                <a href="#" onclick="modifyPwd();">修改密码</a>
                <p id="hPassword" style="visibility: hidden;"></p>
                </li> -->
                <li style="border-right: none;"><i class="icon3"></i><a href="${ctx}/logout" title="退出登录">退出</a></li>
            </ul>
        </div>
       </div>
	</div>





	<ul class="nav nav-tabs">
		<%-- <li><a href="${ctx}/sys/user/info">个人信息</a></li> --%>
		<%-- <li class="active"><a href="${ctx}/sys/user/modifyPwd">修改密码</a></li> --%>
	</ul><br/>
	<center>
	<form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/modifyPwdnew" 
	method="post" class="form-horizontal"  style="width:40%">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">旧密码:</label>
			<div class="controls">
				<input id="oldPassword" name="oldPassword" type="password" value="" maxlength="50" minlength="3" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">新密码:</label>
			<div class="controls">
				<input id="newPassword" name="newPassword" type="password" 
					value="" maxlength="50" minlength="3" class="required" onblur="validatePass();"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">确认新密码:</label>
			<div class="controls">
				<input id="confirmNewPassword" name="confirmNewPassword" type="password" value="" maxlength="50" minlength="3" class="required" equalTo="#newPassword"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>
		</div>
	</form:form>
	</center>
</body>
</html>