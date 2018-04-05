<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>专业类别代码表管理</title>
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
		<li class="active"><a href="${ctx}/professional_code/professionalCategoryCode/">专业类别代码表列表</a></li>
		<shiro:hasPermission name="professional_code:professionalCategoryCode:edit"><li><a href="${ctx}/professional_code/professionalCategoryCode/form">专业类别代码表添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="professionalCategoryCode" action="${ctx}/professional_code/professionalCategoryCode/" method="post" class="breadcrumb form-search">
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
				<shiro:hasPermission name="professional_code:professionalCategoryCode:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="professionalCategoryCode">
			<tr>
				<shiro:hasPermission name="professional_code:professionalCategoryCode:edit"><td>
    				<a href="${ctx}/professional_code/professionalCategoryCode/form?id=${professionalCategoryCode.id}">修改</a>
					<a href="${ctx}/professional_code/professionalCategoryCode/delete?id=${professionalCategoryCode.id}" onclick="return confirmx('确认要删除该专业类别代码表吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>