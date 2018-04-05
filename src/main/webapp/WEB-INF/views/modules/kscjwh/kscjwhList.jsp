<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>考试成绩管理</title>
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
        
         function resetClick(){
		    $("#name").attr("value","");       	
        	$("#semester").select2("destroy");
		   	$("#semester").find("option:selected").attr("selected",false);
		    $("#semester").select2();
        	$("#searchForm").submit();
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/kscjwh/kscjwh/">考试成绩列表</a></li>
		<shiro:hasPermission name="kscjwh:kscjwh:edit"><li><a href="${ctx}/kscjwh/kscjwh/form">考试成绩添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="kscjwh" action="${ctx}/kscjwh/kscjwh/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		
		<table class="table table-bordered">
		        <tr>
		        <th style="width:200px;">考试名称</th>
					<td style="width:300px;">
						<form:input path="name" id="name" htmlEscape="false" maxlength="64" class="input-medium"/>
					</td>
		        <th style="width:200px;">学年学期</th>
						<td style="width:100px;">
							<form:select path="semester" id="semester"  class="input-xlarge" style="width:200px;">
								<form:option value="" label="请选择" />
								<form:options items="${fns:getXnxqJbxxList()}" 
						              itemLabel="xnmc" itemValue="xnmc" htmlEscape="false" />
				   			</form:select>
						</td>
			    <tr>
				<td colspan="10"  style="text-align: center;">
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" />
					<input id="btnReset" class="btn btn-primary" type="reset" onclick="resetClick();"  value="重置" />
				</td>
				</tr>
			     </table>
	</form:form>
	
	<sys:message content="${message}"/>
	<div class="btn-div">
		<a href="${ctx}/kscjwh/kscjwh/form"><input id="btnSubmit2" class="btn btn-primary" type="button" value="增加" /></a>
	</div>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>序号</th>
				<th>考试名称</th>
				<th>类别</th>
				<th>考试方式</th>
				<th>学年学期</th>
				<th>修改时间</th>
				<shiro:hasPermission name="kscjwh:kscjwh:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="kscjwh">
			<tr>
				<td>
					${kscjwh.xh}
				</td>
				<td><a href="${ctx}/kscjwh/kscjwh/form?id=${kscjwh.id}">
					${kscjwh.name}
				</a></td>
				<td>
					<c:if test="${kscjwh.tybe == 0}">其他</c:if>
				</td>
				<td>
					<c:if test="${kscjwh.way == 0}">在线考试</c:if>
					<c:if test="${kscjwh.way == 1}">笔试</c:if>
				</td>
				<td>
					${kscjwh.semester}
				</td>
				<td>
					<fmt:formatDate value="${kscjwh.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
			
				<shiro:hasPermission name="kscjwh:kscjwh:edit">
					<td>
    					<a href="${ctx}/kscjwh/kscjwh/form?id=${kscjwh.id}">修改</a>
						<a href="${ctx}/kscjwh/kscjwh/delete?id=${kscjwh.id}" onclick="return confirmx('确认要删除该考试成绩吗？', this.href)">删除</a>
					</td>
				</shiro:hasPermission>
			
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>