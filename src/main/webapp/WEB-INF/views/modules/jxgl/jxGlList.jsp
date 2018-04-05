<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>教学管理管理</title>
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
		<li class="active"><a href="${ctx}/jxgl/jxGl/">教学管理列表</a></li>
		<shiro:hasPermission name="jxgl:jxGl:edit"><li><a href="${ctx}/jxgl/jxGl/form">教学管理添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="jxGl" action="${ctx}/jxgl/jxGl/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		 <table class="table table-bordered">
		        <tr>
		         <td>学年学期:</td>
			      <td>
			     <form:select path="xnxqId" id="xnxqId"  class="input-xlarge" style="width:200px;">
						<form:option value="" label="请选择" />
						<form:options items="${fns:getXnxqJbxxList()}" 
						              itemLabel="xnmc" itemValue="xnmc" htmlEscape="false" />
				   </form:select>
			      </td>
		          <td>课程名称:</td>
			      <td>
			      <form:select path="kcId" id="kcId"  class="input-xlarge" style="width:200px;">
						<form:option value="" label="请选择" />
						<form:options items="${fns:getCourseList()}" 
						              itemLabel="coursename" itemValue="id" htmlEscape="false" />
				   </form:select>
			     </td>
			     </tr>
			     	<tr>
			     <td>授课老师:</td>
			   <td>
			   <input type="text" class="input-xlarge" name="skls" style="width:200px;" value="${jxGl.skls}">
			   </td>
			      <td>班级名称:</td>
			   <td>
			      <form:select path="bjId" id="bjId"  class="input-xlarge" style="width:200px;">
						<form:option value="" label="请选择" />
						<form:options items="${fns:findBjJbxxList()}" 
						              itemLabel="bjmc" itemValue="bjmc" htmlEscape="false" />
				   </form:select>
			   </td>
			     </tr>
			     	<tr>
				   <td colspan="6" style="text-align: center;">
						<input id="btnSubmit1" class="btn btn-primary" type="submit"value="查询" /> 
						<input id="btnReset" class="btn btn-primary" type="reset" onclick="resetClick();"  value="重置" />
					</td>
				</tr>
			     </table>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>学年学期</th>
				<th>课程名称</th>
				<th>班级名称</th>
				<th>课程性质</th>
				<th>总学时数</th>
				<th>已完成时数</th>
				<th>教学情况</th>
				<th>课堂情况</th>
				<th>学生考勤</th>
				<th>授课老师</th>
				<th>授课时间</th>
				<shiro:hasPermission name="jxgl:jxGl:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="jxGl">
			<tr>
				<td><a href="${ctx}/jxgl/jxGl/form?id=${jxGl.id}">
					${jxGl.xnxqId}
				</a></td>
				<td>
					${jxGl.kcId}
				</td>
				<td>
					${jxGl.bjId}
				</td>
				<td>
					${jxGl.kcxz}
				</td>
				<td>
					${jxGl.zxsCount}
				</td>
				<td>
					${jxGl.ywcCount}
				</td>
				<td>
					${jxGl.jxqk}
				</td>
				<td>
					${jxGl.ktqk}
				</td>
				<td>
					${jxGl.xskq}
				</td>
				<td>
					${jxGl.skls}
				</td>
				<td>
					${jxGl.sksj}
				</td>
				<shiro:hasPermission name="jxgl:jxGl:edit"><td>
    				<a href="${ctx}/jxgl/jxGl/form?id=${jxGl.id}">修改</a>
					<a href="${ctx}/jxgl/jxGl/delete?id=${jxGl.id}" onclick="return confirmx('确认要删除该教学管理吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>