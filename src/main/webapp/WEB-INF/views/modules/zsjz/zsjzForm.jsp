<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>招生简章管理</title>
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
		<li><a href="${ctx}/zsjz/zsjz/list">焦点新闻列表</a></li>
		<li class="active"><a href="${ctx}/zsjz/zsjz/form?id=${zsjz.id}">焦点新闻<shiro:hasPermission name="zsjz:zsjz:edit">${not empty zsjz.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="zsjz:zsjz:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="zsjz" action="${ctx}/zsjz/zsjz/save" method="post" 
		class="form-horizontal" enctype="multipart/form-data">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">标题：</label>
			<div class="controls">
				<form:input path="title" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">标题图：</label>
			<div class="controls">
				<c:if test="${not empty zsjz.titleimg }">
					<img src="${ctxImg }${zsjz.titleimg }" style="width:200px;height:100px;" />
				</c:if>
				<input id="uploadFile" name="file" type="file" style="width:230px"/><br/><br/>　　
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">url：</label>
			<div class="controls">
				<form:input path="url" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">来源：</label>
			<div class="controls">
				<form:input path="laiyuan" htmlEscape="false" maxlength="500" 
					class="input-xlarge " />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">内容：</label>
			<div class="controls">
			    <form:textarea id="content" path="content" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
				<%-- <form:textarea id="content" htmlEscape="true" path="zsjz.content" rows="4" maxlength="255" class="input-xxlarge"/> --%>
				<sys:ckeditor replace="content" uploadPath="/cms/article" />
			</div>
			<%-- <div class="controls">
				<form:textarea path="content" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div> --%>
		</div>
		<div class="control-group">
			<label class="control-label">发布人：</label>
			<div class="controls">
				<form:input path="releaseby" value="${releaseby}" htmlEscape="false" maxlength="32" class="input-xlarge " readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">发布时间：</label>
			<div class="controls">
				<input name="releasedate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${zsjz.releasedate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="zsjz:zsjz:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>