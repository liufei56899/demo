<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>部门区域关系管理</title>
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
		<li><a href="${ctx}/bmqygx/bmQyGx/">部门区域关系列表</a></li>
		<li class="active"><a href="${ctx}/bmqygx/bmQyGx/form?id=${bmQyGx.id}">部门区域关系<shiro:hasPermission name="bmqygx:bmQyGx:edit">${not empty bmQyGx.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="bmqygx:bmQyGx:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="bmQyGx" action="${ctx}/bmqygx/bmQyGx/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">年份：</label>
			<div class="controls">
				<form:input  style="width:255px;" path="nf" htmlEscape="false" maxlength="11" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">学期：</label>
			<div class="controls">
				<form:select path="xqId" class="input-xlarge required" style="width:270px;">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('xq')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">部门：</label>
			<div class="controls">
				<sys:treeselect id="office" name="office.id" value="${bmQyGx.office.id}" labelName="office.name" labelValue="${bmQyGx.office.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">区域：</label>
			<div class="controls">
				<sys:treeselect id="area" name="area.id" value="${bmQyGx.area.id}" labelName="area.name" labelValue="${bmQyGx.area.name}"
					title="区域" url="/sys/area/treeData" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">生源数量：</label>
			<div class="controls" >
				<form:input path="sysl" htmlEscape="false" maxlength="11" class="input-xlarge " style="width:255px;"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="bmqygx:bmQyGx:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>