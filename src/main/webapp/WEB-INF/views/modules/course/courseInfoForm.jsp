<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学校课程代码表管理</title>
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
</head>
<body>
	<form:form id="inputForm" modelAttribute="course" action="${ctx}/course/course/save" method="post" class="form-horizontal">	
	<div class="control-group">
		<div class="lg-form">
			<label class="control-label">课程名称：</label>
			<div class="controls">
				${course.coursename}			
			</div>
		</div>
		<div class="lg-form">
			<label class="control-label labWidth">代课老师：</label>
			<div class="controls">
				${course.teachername}	
			</div>
		</div>
	</div>
	<div class="control-group">
		<div class="lg-form">
			<label class="control-label">开始时间：</label>
			<div class="controls">
				<fmt:formatDate value="${course.kssj}" pattern="yyyy-MM-dd"/>						
			</div>
		</div>
		<div class="lg-form">
			<label class="control-label labWidth">结束时间：</label>
			<div class="controls">
				<fmt:formatDate value="${course.jssj}" pattern="yyyy-MM-dd"/>
			</div>
		</div>
	</div>
	<div class="control-group">
		<div>
			<label class="control-label">说明：</label>
			<div class="controls">
				${course.remarks}				
			</div>
		</div>
	</div>	
	<div class="form-actions">		
		<input id="btnCancel" class="btn" type="button" value="关闭" onclick="closeDialog();"/>
	</div>
	</form:form>
</body>
</html>