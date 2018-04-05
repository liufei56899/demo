<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>计划专业管理</title>
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
		<li><a href="${ctx}/zszy/jhZyInfo/">计划专业列表</a></li>
		<li class="active"><a href="${ctx}/zszy/jhZyInfo/form?id=${jhZyInfo.id}">计划专业<shiro:hasPermission name="zszy:jhZyInfo:edit">${not empty jhZyInfo.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="zszy:jhZyInfo:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="jhZyInfo" action="${ctx}/zszy/jhZyInfo/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">招生计划：</label>
			<div class="controls">
				<form:input path="zsjhId" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">专业类别：</label>
			<div class="controls">
				<form:input path="zylxId" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">专业名称：</label>
			<div class="controls">
				<form:input path="zyId" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">remarks：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">计划人数：</label>
			<div class="controls">
				<form:input path="zsrs" htmlEscape="false" maxlength="11" class="input-xlarge  digits"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="zszy:jhZyInfo:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>