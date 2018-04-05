<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学生考勤信息管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/studentattendance/studentattendance/">学生考勤信息列表</a></li>
		<shiro:hasPermission name="studentattendance:studentattendance:edit"><li><a href="${ctx}/studentattendance/studentattendance/form">学生考勤信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="studentattendance" action="${ctx}/studentattendance/studentattendance/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>小组名称：</label>
				<form:input path="groupname" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label>学生：</label>
				<form:input path="student" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label>成绩：</label>
				<form:input path="score" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<shiro:hasPermission name="studentattendance:studentattendance:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="studentattendance">
			<tr>
				<shiro:hasPermission name="studentattendance:studentattendance:edit"><td>
    				<a href="${ctx}/studentattendance/studentattendance/form?id=${studentattendance.id}">修改</a>
					<a href="${ctx}/studentattendance/studentattendance/delete?id=${studentattendance.id}" onclick="return confirmx('确认要删除该学生考勤信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>