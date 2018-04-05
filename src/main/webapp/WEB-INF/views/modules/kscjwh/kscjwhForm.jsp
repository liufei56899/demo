<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>考试成绩管理</title>
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
		<li><a href="${ctx}/kscjwh/kscjwh/">考试成绩列表</a></li>
		<li class="active"><a href="${ctx}/kscjwh/kscjwh/form?id=${kscjwh.id}">考试成绩<shiro:hasPermission name="kscjwh:kscjwh:edit">${not empty kscjwh.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="kscjwh:kscjwh:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="kscjwh" action="${ctx}/kscjwh/kscjwh/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">考试名称：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">考试类别：</label>
			<div class="controls">
				<form:select path="tybe" id="tybe" class="input-medium">									
						<form:option value="0" label="其他"/>												
				</form:select>	
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">考试方式：</label>
			<div class="controls">
				<form:select path="way" id="way" class="input-medium">
						<form:option value="" label="请选择"/>											
						<form:option value="1" label="笔试"/>											
						<form:option value="0" label="在线考试"/>												
				</form:select>	
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">学年学期：</label>
			<div class="controls">
				<form:select path="semester" id="semester"  class="input-xlarge required" style="width:215px;" >
					<form:option value="" label="请选择" />
					<form:options items="${fns:getXnxqJbxxList()}" 
					              itemLabel="xnmc" itemValue="xnmc" htmlEscape="false" />
			   </form:select>	  
			</div>					
		</div>
		<div class="control-group">
			<label class="control-label">分数线：</label>
			<div class="controls">
				<form:input path="score" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="kscjwh:kscjwh:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>