<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>计划分解个人任务记录管理</title>
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
		<li class="active"><a href="${ctx}/jhfjgr/jhFjGrRwRecord/">计划分解个人任务记录列表</a></li>
		<shiro:hasPermission name="jhfjgr:jhFjGrRwRecord:edit"><li><a href="${ctx}/jhfjgr/jhFjGrRwRecord/form">计划分解个人任务记录添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="jhFjGrRwRecord" action="${ctx}/jhfjgr/jhFjGrRwRecord/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>省份：</label>
				<form:input path="sf" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>城市：</label>
				<form:input path="cs" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>区县：</label>
				<form:input path="qx" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>乡镇：</label>
				<form:input path="xz" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>省份</th>
				<th>城市</th>
				<th>区县</th>
				<th>乡镇</th>
				<shiro:hasPermission name="jhfjgr:jhFjGrRwRecord:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="jhFjGrRwRecord">
			<tr>
				<td><a href="${ctx}/jhfjgr/jhFjGrRwRecord/form?id=${jhFjGrRwRecord.id}">
					${jhFjGrRwRecord.sf}
				</a></td>
				<td>
					${jhFjGrRwRecord.cs}
				</td>
				<td>
					${jhFjGrRwRecord.qx}
				</td>
				<td>
					${jhFjGrRwRecord.xz}
				</td>
				<shiro:hasPermission name="jhfjgr:jhFjGrRwRecord:edit"><td>
    				<a href="${ctx}/jhfjgr/jhFjGrRwRecord/form?id=${jhFjGrRwRecord.id}">修改</a>
					<a href="${ctx}/jhfjgr/jhFjGrRwRecord/delete?id=${jhFjGrRwRecord.id}" onclick="return confirmx('确认要删除该计划分解个人任务记录吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>