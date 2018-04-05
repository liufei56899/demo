<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>专业类别代码表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
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
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/professional_code/professionalCategoryCode/">专业类别代码表列表</a></li>
		<li class="active"><a href="${ctx}/professional_code/professionalCategoryCode/form?id=${professionalCategoryCode.id}">专业类别代码表<shiro:hasPermission name="professional_code:professionalCategoryCode:edit">${not empty professionalCategoryCode.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="professional_code:professionalCategoryCode:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="professionalCategoryCode" action="${ctx}/professional_code/professionalCategoryCode/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">category_id：</label>
			<div class="controls">
				<form:input path="categoryId" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">category_name：</label>
			<div class="controls">
				<form:input path="categoryName" htmlEscape="false" maxlength="40" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">professional_id：</label>
			<div class="controls">
				<form:input path="professionalId" htmlEscape="false" maxlength="20" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">professional_name：</label>
			<div class="controls">
				<form:input path="professionalName" htmlEscape="false" maxlength="40" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">professional_emphasis：</label>
			<div class="controls">
				<form:input path="professionalEmphasis" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">professional_version_date：</label>
			<div class="controls">
				<form:input path="professionalVersionDate" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="professional_code:professionalCategoryCode:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>