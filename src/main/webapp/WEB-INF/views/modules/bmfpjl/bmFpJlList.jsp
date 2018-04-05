<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>部门分配招生人数记录管理</title>
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
		<li class="active"><a href="${ctx}/bmfpjl/bmFpJl/">部门分配招生人数记录列表</a></li>
		<shiro:hasPermission name="bmfpjl:bmFpJl:edit"><li><a href="${ctx}/bmfpjl/bmFpJl/form">部门分配招生人数记录添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="bmFpJl" action="${ctx}/bmfpjl/bmFpJl/" method="post" class="breadcrumb form-search">
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
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="bmfpjl:bmFpJl:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bmFpJl">
			<tr>
				<td><a href="${ctx}/bmfpjl/bmFpJl/form?id=${bmFpJl.id}">
					<fmt:formatDate value="${bmFpJl.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</a></td>
				<td>
					${bmFpJl.remarks}
				</td>
				<shiro:hasPermission name="bmfpjl:bmFpJl:edit"><td>
    				<a href="${ctx}/bmfpjl/bmFpJl/form?id=${bmFpJl.id}">修改</a>
					<a href="${ctx}/bmfpjl/bmFpJl/delete?id=${bmFpJl.id}" onclick="return confirmx('确认要删除该部门分配招生人数记录吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>