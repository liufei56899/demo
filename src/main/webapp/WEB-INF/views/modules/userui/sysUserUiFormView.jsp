<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>终端用户管理</title>
<meta name="decorator" content="default" />
<%@ include file="/WEB-INF/views/include/base_index.jsp"%>
<script type="text/javascript">
	$(document).ready(
			function() {
				//$("#name").focus();
				$("#inputForm")
						.validate(
								{
									submitHandler : function(form) {
										loading('正在提交，请稍等...');
										form.submit();
									},
									errorContainer : "#messageBox",
									errorPlacement : function(error, element) {
										$("#messageBox").text("输入有误，请先更正。");
										if (element.is(":checkbox")
												|| element.is(":radio")
												|| element.parent().is(
														".input-append")) {
											error.appendTo(element.parent()
													.parent());
										} else {
											error.insertAfter(element);
										}
									}
								});
			});
</script>
</head>
<body>
	<form:form id="inputForm" modelAttribute="sysUserUi"
		action="" method="post"
		class="form-horizontal">
		<form:hidden path="id" />
		<sys:message content="${message}" />
		<br/>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">部门：</label>
				<div class="controls">
					<form:input path="office" htmlEscape="false" maxlength="64"
						class="input-xlarge " readonly="true"/>
				</div>
			</div>
			<div class="lg-form">
                <label class="control-label">职位：</label>
				<div class="controls">
					<form:select path="zhiwei" id="zhiwei" class="input-xlarge "  readonly="true"
						style="width:215px;">
						<form:option value="" label="" />
						<form:options items="${fns:getDictList('gwzy')}" itemLabel="label"
							itemValue="value" htmlEscape="false" />
					</form:select>
				</div>
            </div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">用户名：</label>
				<div class="controls">
					<form:input path="username" htmlEscape="false" maxlength="100"
						class="input-xlarge"  readonly="true"/>
				</div>
			</div>
			<div class="lg-form">
			  <label class="control-label">性别：</label>
			  <div class="controls">
				<form:select path="xbm" id="xbm" class="input-xlarge required"  style="width:212px;" readonly="true">
					<form:option value="" label="" />
					<form:options items="${fns:getDictList('sex')}" itemLabel="label"
						          itemValue="value" htmlEscape="false" />
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			 </div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">密码：</label>
				<div class="controls">
					<form:input path="password" htmlEscape="false" maxlength="100"
						class="input-xlarge"  readonly="true"/>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">姓名：</label>
				<div class="controls">
					<form:input path="name" htmlEscape="false" maxlength="100"
						class="input-xlarge"  readonly="true"/>
				</div>
			</div>
		</div>

		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">邮箱：</label>
				<div class="controls">
					<form:input path="email" htmlEscape="false" maxlength="200"
						class="input-xlarge "  readonly="true"/>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">电话：</label>
				<div class="controls">
					<form:input path="phone" htmlEscape="false" maxlength="200"
						class="input-xlarge "  readonly="true"/>
				</div>
			</div>
		</div>

		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">手机：</label>
				<div class="controls">
					<form:input path="mobile" htmlEscape="false" maxlength="200"
						class="input-xlarge "  readonly="true"/>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">用户类型：</label>
				<div class="controls">
					<form:input path="userType" htmlEscape="false" maxlength="1"
						class="input-xlarge "  readonly="true"/>
				</div>
			</div>
		</div>

		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">用户头像：</label>
				<div class="controls">
					<form:input path="photo" htmlEscape="false" maxlength="1000"
						class="input-xlarge "  readonly="true"/>
				</div>
			</div>
	        <div class="lg-form">
				<label class="control-label">是否允许登录:</label>
			    <div class="controls">
				<form:select id="loginFlag1" path="loginFlag">
				    <form:option value="" label="" />
					<form:options items="${fns:getDictList('yes_no')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			</div>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
				<div class="controls">
					<form:textarea path="remarks" htmlEscape="false" rows="4"
						maxlength="255" class="input-xxlarge "  readonly="true"/>
				</div>
		</div>
		<div class="form-actions" style="height:15px; ">
			<input id="btnCancel" class="btn" type="button" value="关闭"
				onclick="closeDialog();" />
		</div>
	</form:form>
</body>
</html>