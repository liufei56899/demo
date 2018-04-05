<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>计划分解个人记录管理</title>
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
		<li class="active"><a href="${ctx}/jhfjgr/jhFjGrRecord/">计划分解个人记录列表</a></li>
		<shiro:hasPermission name="jhfjgr:jhFjGrRecord:edit"><li><a href="${ctx}/jhfjgr/jhFjGrRecord/form">计划分解个人记录添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="jhFjGrRecord" action="${ctx}/jhfjgr/jhFjGrRecord/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>招生计划：</label>
				<form:input path="jhId" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>招生老师：</label>
				<sys:treeselect id="jsId" name="jsId" value="${jhFjGrRecord.jsId}" labelName="" labelValue="${jhFjGrRecord.}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>招生人数：</label>
				<form:input path="zsrs" htmlEscape="false" maxlength="11" class="input-medium"/>
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
				<th>招生老师</th>
				<th>招生人数</th>
				<shiro:hasPermission name="jhfjgr:jhFjGrRecord:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="jhFjGrRecord">
			<tr>
				<td><a href="${ctx}/jhfjgr/jhFjGrRecord/form?id=${jhFjGrRecord.id}">
					${jhFjGrRecord.jhId}
				</a></td>
				<td>
					${jhFjGrRecord.}
				</td>
				<td>
					${jhFjGrRecord.zsrs}
				</td>
				<shiro:hasPermission name="jhfjgr:jhFjGrRecord:edit"><td>
    				<a href="${ctx}/jhfjgr/jhFjGrRecord/form?id=${jhFjGrRecord.id}">修改</a>
					<a href="${ctx}/jhfjgr/jhFjGrRecord/delete?id=${jhFjGrRecord.id}" onclick="return confirmx('确认要删除该计划分解个人记录吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>