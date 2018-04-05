<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>计划分解任务历史记录管理</title>
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
		<li class="active"><a href="${ctx}/jhfj/jhFjRwRecord/">计划分解任务历史记录列表</a></li>
		<shiro:hasPermission name="jhfj:jhFjRwRecord:edit"><li><a href="${ctx}/jhfj/jhFjRwRecord/form">计划分解任务历史记录添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="jhFjRwRecord" action="${ctx}/jhfj/jhFjRwRecord/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>计划分解</th>
				<th>省份</th>
				<th>城市</th>
				<th>区县</th>
				<th>乡镇</th>
				<shiro:hasPermission name="jhfj:jhFjRwRecord:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="jhFjRwRecord">
			<tr>
				<td><a href="${ctx}/jhfj/jhFjRwRecord/form?id=${jhFjRwRecord.id}">
					${jhFjRwRecord.jhFjId}
				</a></td>
				<td>
					${jhFjRwRecord.sf}
				</td>
				<td>
					${jhFjRwRecord.cs}
				</td>
				<td>
					${jhFjRwRecord.qx}
				</td>
				<td>
					${jhFjRwRecord.xz}
				</td>
				<shiro:hasPermission name="jhfj:jhFjRwRecord:edit"><td>
    				<a href="${ctx}/jhfj/jhFjRwRecord/form?id=${jhFjRwRecord.id}">修改</a>
					<a href="${ctx}/jhfj/jhFjRwRecord/delete?id=${jhFjRwRecord.id}" onclick="return confirmx('确认要删除该计划分解任务历史记录吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>