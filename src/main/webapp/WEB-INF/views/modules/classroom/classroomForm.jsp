<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>教室信息管理管理</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
		.form-horizontal .control-label
		{
			width:130px;
		}
		.form-horizontal .controls
		{
			margin-left: 147px;
		}
		.form-horizontal .lg-form .labWidth
		{
			width:160px;
			padding-right: 15px;
		}
		
		.form-horizontal .lg-form .controls .input-xlarge
		{
			width:180px;
		}
		.form-horizontal .lg-form .controls .select2-container
		{
			width:192px;
		}	
	</style>
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
	<form:form id="inputForm" modelAttribute="classroom" action="${ctx}/classroom/classroom/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>		
		<sys:message content="${message}"/>	
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">序号：</label>
				<div class="controls">
					<form:input path="xh" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label labWidth">教室楼号：</label>
				<div class="controls">
					<form:input path="jslh" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">教室门牌号：</label>
				<div class="controls">
					<form:input path="jsmph" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
					<span class="help-inline"><font color="red">*</font> </span>				
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label labWidth">教室类型：</label>
				<div class="controls">					
					<form:select path="jslx" id="jslx" class="input-medium">											
						<form:option value="1" label="普通教室"/>	
						<form:option value="2" label="非普通教室"/>				
					</form:select>					
				</div>
			</div>
		</div>	
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">可容纳人数：</label>
				<div class="controls">
					<form:input path="rnrs" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label labWidth">状态：</label>
				<div class="controls">					
					<form:select path="status" id="status" class="input-medium">
						<form:option value="1" label="启用"/>											
						<form:option value="0" label="停用"/>												
					</form:select>					
				</div>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="zy:zyJbxx:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="关闭" onclick="closeDialog();"/>
		</div>
	</form:form>
</body>
</html>