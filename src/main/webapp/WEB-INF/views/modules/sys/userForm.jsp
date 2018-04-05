<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>用户管理</title>
<meta name="decorator" content="default" />

</head>
<body>
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
	$(document).ready(
		function() {
		$("#no").focus();
		$("#inputForm").validate(
					{
						rules : {
									loginName : {
										remote : "${ctx}/sys/user/checkLoginName?oldLoginName="	+ encodeURIComponent('${user.loginName}')
												}
								},
						messages : {
									loginName : {
										remote : "用户登录名已存在"
								   },
					    confirmNewPassword : {
										equalTo : "输入与上面相同的密码"
											}
						},
						submitHandler : function(form) {
												var ret = validatePass();
												console.log(ret);
												if(ret)
												{
													loading('正在提交，请稍等...');
													form.submit();
												}
						},
						errorContainer : "#messageBox",
						errorPlacement : function(error,element) {
								$("#messageBox").text("输入有误，请先更正。");
									if (element.is(":checkbox")|| element.is(":radio")|| element.parent().is(".input-append")) {
													error.appendTo(element.parent().parent());
												} else {
													error.insertAfter(element);
												}
											}
										});
					});
					
					
					function checkImg(){
				
					}
</script>
	<br />
	<form:form id="inputForm" modelAttribute="user"
		action="${ctx}/sys/user/save" method="post" class="form-horizontal">
		<form:hidden path="id" />
		<sys:message content="${message}" />
		<div>
				<div class="control-group">
					<label class="control-label">头像:</label>
					<div class="controls">
	<form:hidden id="nameImage" path="photo" htmlEscape="false" maxlength="255" class="input-xlarge"/>
   <sys:ckfinder input="nameImage" type="images" uploadPath="/photo" selectMultiple="false" 
               maxWidth="100" maxHeight="100"/>
				<span class="help-inline">温馨提示：文件名不能包含中文字符,推荐使用英文和数字</span>	
					</div>
				</div>
		</div>
        <div class="control-group">
             <div class="lg-form">
                <label class="control-label">姓名:</label>
				<div class="controls">
					<form:input path="name" htmlEscape="false" maxlength="50"
						class="required" />
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
             </div>
             <div class="lg-form">
               <label class="control-label">账号:</label>
			   <div class="controls">
				  <input id="oldLoginName" name="oldLoginName" type="hidden" value="${user.loginName}">
				  <form:input path="loginName" htmlEscape="false" maxlength="50" class="required userName"/>
				  <span class="help-inline"><font color="red">*</font> </span>
			   </div>
             </div>
        </div>
        <div class="control-group">
             <div class="lg-form">
                 <label class="control-label">密码:</label>
				<div class="controls">
					<input id="newPassword" name="newPassword" type="password" onblur="validatePass();" value=""
						maxlength="50" minlength="3"
						class="${empty user.id?'required':''}" />
					<c:if test="${empty user.id}">
						<span class="help-inline"><font color="red">*</font> </span>
					</c:if>
					<c:if test="${not empty user.id}">
						<span class="help-inline">若不修改密码，请留空。</span>
					</c:if>
				</div>
             </div>
             <div class="lg-form">
                  <label class="control-label">确认密码:</label>
				<div class="controls">
					<input id="confirmNewPassword" name="confirmNewPassword"
						type="password" value="" maxlength="50" minlength="3"
						equalTo="#newPassword" />
					<c:if test="${empty user.id}">
						<span class="help-inline"><font color="red">*</font> </span>
					</c:if>
				</div>
             </div>
        </div>
        <div class="control-group">
             <div class="lg-form">
                 <label class="control-label">性别:</label>
                 <div class="controls">
					<form:select path="xbm" class="input-xlarge required"
						style="width:215px;">
						<form:option value="" label="" />
						<form:options items="${fns:getDictList('sex')}" itemLabel="label"
							itemValue="value" htmlEscape="false" />
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
             </div>
             <div class="lg-form">
                 <label class="control-label">部门:</label>
				<div class="controls">
					<sys:treeselect id="office1" name="office.id" value="${user.office.id}" 
						labelName="office.name" labelValue="${user.office.name}" 
						title="部门" url="/sys/office/treeData?type=2" cssClass=" required"
						 allowClear="true" notAllowSelectParent="true" />
				</div>
             </div>
        </div>
        <div class="control-group">
            <div class="lg-form">
                <label class="control-label">职位:</label>
				<div class="controls">
					<form:select path="gwzym" class="input-xlarge "
						style="width:215px;">
						<form:option value="" label="" />
						<form:options items="${fns:getDictList('gwzy')}" itemLabel="label"
							itemValue="value" htmlEscape="false" />
					</form:select>
				</div>
            </div>
            <div class="lg-form">
                 <label class="control-label">用户类型:</label>
			   <div class="controls">
				<form:select path="userType" class="input-xlarge">
					<form:option value="" label="请选择" />
					<form:options items="${fns:getDictList('sys_user_type')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			</div>
            </div>
        </div>
        <div class="control-group">
            <div class="lg-form">
				<label class="control-label">邮箱:</label>
				<div class="controls">
					<form:input path="email" htmlEscape="false" maxlength="100"
						class="email" />
				</div>
			</div>
	        <div class="lg-form">
            <label class="control-label">是否允许登录:</label>
			<div class="controls">
				<form:select path="loginFlag">
					<form:options items="${fns:getDictList('yes_no')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
				<span class="help-inline"><font color="red">*</font>
					“是”代表此账号允许登录,<br>&nbsp;&nbsp;&nbsp;“否”则表示此账号不允许登录</span>
			</div>
            </div>
        </div>
      <%--   <div class="control-group">
        <div class="lg-form">
				<label class="control-label">单位:</label>
				<div class="controls">
					<sys:treeselect id="company1" name="company.id"
						value="${user.company.id}" labelName="company.name"
						labelValue="${user.company.name}" title="公司"
						url="/sys/office/treeData?type=1" cssClass="required" />
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">工号:</label>
				<div class="controls">
					<form:input path="no" htmlEscape="false" maxlength="50"
						class="required" />
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			
		</div>
 --%>
        <div class="control-group">
            <label class="control-label">用户角色:</label>
			<div class="controls">
				<form:checkboxes path="roleIdList" items="${allRoles}"
					itemLabel="name" itemValue="id" htmlEscape="false" class="required" />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
        </div>
                
       <!--  <div class="control-group">
            <div class="lg-form">
               <label class="control-label">电话:</label>
				<div class="controls">
					<form:input path="phone" htmlEscape="false" maxlength="100" />
				</div>
            </div>
            <div class="lg-form">
            <label class="control-label">手机:</label>
			<div class="controls">
				<form:input path="mobile" htmlEscape="false" maxlength="100" />
			</div>
			</div>
        </div> -->
        <div class="control-group">
           <label class="control-label">备注:</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="5"
					maxlength="300" class="input-xlarge" />
			</div>
        </div>
        	<c:if test="${not empty user.id}">
			<div class="control-group">
				<label class="control-label">创建时间:</label>
				<div class="controls">
					<label class="lbl"><fmt:formatDate
							value="${user.createDate}" type="both" dateStyle="full" /> </label>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">最后登陆:</label>
				<div class="controls">
					<label class="lbl">IP:
						${user.loginIp}&nbsp;&nbsp;&nbsp;&nbsp;时间：<fmt:formatDate
							value="${user.loginDate}" type="both" dateStyle="full" /> </label>
				</div>
			</div>
		</c:if>
		<div class="form-actions">
			<shiro:hasPermission name="sys:user:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit"
					value="保 存" />&nbsp;</shiro:hasPermission>
			<!-- <input id="btnCancel" class="btn" type="button" value="返 回"
				onclick="history.go(-1)" /> -->
				<input id="btnCancel" class="btn" type="button" value="关闭" onclick="closeDialog();"/>
		</div>
	</form:form>
</body>
</html>