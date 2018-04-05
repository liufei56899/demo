<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>部门区域关系管理</title>
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
		<li class="active"><a href="${ctx}/bmqygx/bmQyGx/">部门区域关系列表</a></li>
		<shiro:hasPermission name="bmqygx:bmQyGx:edit"><li><a href="${ctx}/bmqygx/bmQyGx/form">部门区域关系添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="bmQyGx" action="${ctx}/bmqygx/bmQyGx/" method="post" class="breadcrumb form-search">
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
				<th>年份</th>
				<th>学期</th>
				<th>部门</th>
				<th>区域</th>
				<th>生源数量</th>
				<th>更新时间</th>
				<shiro:hasPermission name="bmqygx:bmQyGx:view"><th>查看</th></shiro:hasPermission>
				<shiro:hasPermission name="bmqygx:bmQyGx:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bmQyGx">
			<tr>
				<td style="width:60px;">
					${bmQyGx.nf}
				</td>
				<td style="width:80px;">
					${fns:getDictLabel(bmQyGx.xqId, 'xq', '')}
				</td>
				<td style="width:120px;">
					${bmQyGx.office.name}
				</td>
				<td style="width:120px;">
					${bmQyGx.area.name}
				</td>
				<td style="width:60px;">
					${bmQyGx.sysl}
				</td>
				<td style="width:120px;">
					<fmt:formatDate value="${bmQyGx.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="bmqygx:bmQyGx:view"><td style="width:80px;"><a href="${ctx}/bmqygx/bmQyGx/form?id=${bmQyGx.id}">查看</a></td></shiro:hasPermission>
				<shiro:hasPermission name="bmqygx:bmQyGx:edit"><td style="width:80px;">
    				<a href="${ctx}/bmqygx/bmQyGx/form?id=${bmQyGx.id}">修改</a>
					<a href="${ctx}/bmqygx/bmQyGx/delete?id=${bmQyGx.id}" onclick="return confirmx('确认要删除该部门区域关系吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>