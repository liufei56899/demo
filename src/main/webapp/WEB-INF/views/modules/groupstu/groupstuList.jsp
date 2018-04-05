<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学生小组信息管理</title>
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
		<li class="active"><a href="${ctx}/groupstu/groupstu/">学生小组信息列表</a></li>
		<li><a href="${ctx}/groupstu/groupstu/form">学生小组信息添加</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="groupstu" action="${ctx}/groupstu/groupstu/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<div class="cxtj">查询条件</div> 
	      <table id="contentTable" class="table table-striped table-bordered table-condensed">
	      	<tr>
	      	<td>小组名称</td>
			<td><form:input path="groupname" htmlEscape="false" maxlength="255" class="input-xlarge required"/></td>
			   <td> <input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
		</td></tr>
			</table>
	</form:form>
	<sys:message content="${message}"/>
	<div class="cxjg">查询结果</div>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
			  <td>小组名称</td>
			  <td>小组学生数</td>
			  <td>小组学生</td>
			  <td>小组教师</td>
			  <td>
				<shiro:hasPermission name="groupstu:groupstu:edit">操作</shiro:hasPermission>
				</td>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="groupstu">
			<tr>
			  <td>${groupstu.groupname}</td>
			  <td>${groupstu.groupnum}</td>
			  <td>${fns:getStudent(groupstu.groupstudent)}</td>
			  <td>${fns:getTeacher(groupstu.groupteacher)}</td>
				<shiro:hasPermission name="groupstu:groupstu:edit"><td>
    				<a href="${ctx}/groupstu/groupstu/form?id=${groupstu.id}">修改</a>
					<a href="${ctx}/groupstu/groupstu/delete?id=${groupstu.id}" onclick="return confirmx('确认要删除该学生小组信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>