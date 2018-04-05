<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>实践成果管理管理</title>
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
		<li><a href="${ctx}/sjcggl/sjcggl/">实践成果管理列表</a></li>
		<li class="active"><a href="${ctx}/sjcggl/sjcggl/form?id=${sjcggl.id}">实践成果管理<shiro:hasPermission name="sjcggl:sjcggl:edit">${not empty sjcggl.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sjcggl:sjcggl:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="sjcggl" action="${ctx}/sjcggl/sjcggl/save"  enctype="multipart/form-data"  method="post" class="form-horizontal"  >
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">参赛名称：</label>
			<div class="controls">
				<form:input path="csmc" htmlEscape="false" maxlength="64" class="input-xlarge  requ required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">参赛人员：</label>
			<div class="controls">
				<form:input path="csry" htmlEscape="false" maxlength="64" class="input-xlarge  requ required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">参赛时间：</label>
			<div class="controls">
				<input name="cssj" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${sjcggl.cssj}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
					<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">获奖情况：</label>
			<div class="controls">
				<form:input path="hjqk" htmlEscape="false" maxlength="200" class="input-xlarge"/>
				
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">附件：</label>
			<div class="controls">
				<input name="file" type="file"  maxlength="200" class="input-xlarge"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="sjcggl:sjcggl:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>