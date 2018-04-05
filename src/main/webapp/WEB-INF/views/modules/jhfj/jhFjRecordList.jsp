<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>部门任务分解记录管理</title>
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
		<li class="active"><a href="${ctx}/jhfj/jhFjRecord/">部门任务分解记录列表</a></li>
		<shiro:hasPermission name="jhfj:jhFjRecord:edit"><li><a href="${ctx}/jhfj/jhFjRecord/form">部门任务分解记录添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="jhFjRecord" action="${ctx}/jhfj/jhFjRecord/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>招生计划：</label>
				<form:input path="jhId" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>招生部门：</label>
				<sys:treeselect id="bmId" name="bmId" value="${jhFjRecord.bmId}" labelName="" labelValue="${jhFjRecord.}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>招生计划</th>
				<th>招生部门</th>
				<th>招生人数</th>
				<th>分解状态</th>
				<shiro:hasPermission name="jhfj:jhFjRecord:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="jhFjRecord">
			<tr>
				<td><a href="${ctx}/jhfj/jhFjRecord/form?id=${jhFjRecord.id}">
					${jhFjRecord.jhId}
				</a></td>
				<td>
					${jhFjRecord.}
				</td>
				<td>
					${jhFjRecord.zsrs}
				</td>
				<td>
					${jhFjRecord.fjFlag}
				</td>
				<shiro:hasPermission name="jhfj:jhFjRecord:edit"><td>
    				<a href="${ctx}/jhfj/jhFjRecord/form?id=${jhFjRecord.id}">修改</a>
					<a href="${ctx}/jhfj/jhFjRecord/delete?id=${jhFjRecord.id}" onclick="return confirmx('确认要删除该部门任务分解记录吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>