<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>教学大纲管理</title>
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
	       	$("#xnxq").select2("destroy");
	       	$("#xnxq").find("option:selected").attr("selected",false);
	       	$("#xnxq").select2();
	       	$("#kcId").select2("destroy");
		   	$("#kcId").find("option:selected").attr("selected",false);
		    $("#kcId").select2();
		    $("#shccId").select2("destroy");
		   	$("#shccId").find("option:selected").attr("selected",false);
		    $("#shccId").select2();
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/jxdg/jxDg/">教学大纲列表</a></li>
		<shiro:hasPermission name="jxdg:jxDg:edit"><li><a href="${ctx}/jxdg/jxDg/form">教学大纲添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="jxDg" action="${ctx}/jxdg/jxDg/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		 <table class="table table-bordered">
		        <tr>
		         <td>学年学期:</td>
			      <td>
			     <form:select path="xnxq" id="xnxq"  class="input-xlarge" style="width:200px;">
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
			     <td>适合层次:</td>
			   <td>
			      <form:select path="shccId" id="shccId"  class="input-xlarge " >
						  <form:option value="" label="全部" />
							<form:options items="${fns:getDictList('shccId')}" itemLabel="label" itemValue="label" 
								htmlEscape="false"/>
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
		<div class="btn-div">
		<a href="${ctx}/jxdg/jxDg/form"><input id="btnSubmit2" class="btn btn-primary" type="button" value="增加" /></a>
	</div>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr><th>序号</th>
				<th>学年学期</th>
				<th>课程名称</th>
				<th>总学时数</th>
				<th>实践时数</th>
				<th>适合层次</th>
				<th>适合专业</th>
				<th>课程性质</th>
				<th>讲课时数</th>
				<th>课外实践</th>
				<th>开课学期</th>
				<th>制定人</th>
				<th>制定日期</th>
				<shiro:hasPermission name="jxdg:jxDg:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="jxDg">
			<tr>
				<td>
					${jxDg.xuhao}
				</td>
				<td>
					${jxDg.xnxq}
				</td>
				<td>
				<a href="${ctx}/jxdg/jxDg/form1?id=${jxDg.id}">
					${jxDg.kcmc}
					</a>
				</td>
				<td>
					${jxDg.zxsCount}
				</td>
				<td>
					${jxDg.sjCount}
				</td>
				<td>
				 ${jxDg.shccId}
				</td>
				<td>
				<a href="#" title="${jxDg.zyId}">${fn:substring(jxDg.zyId,0,2)}<c:if test="${jxDg.zyId !=''}">.....</c:if></a>
				</td>
				<td>
				 ${jxDg.kcxzid}
				</td>
				<td>
					${jxDg.jkCount}
				</td>
				<td>
					${jxDg.kwsjCount}
				</td>
				<td>
					${jxDg.kkxq}
				</td>
				<td>
					${jxDg.createBy.name}
				</td>
				<td>
					<fmt:formatDate value="${jxDg.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="jxdg:jxDg:edit"><td>
    				<a href="${ctx}/jxdg/jxDg/form1?id=${jxDg.id}">修改</a>
					<a href="${ctx}/jxdg/jxDg/delete?id=${jxDg.id}" onclick="return confirmx('确认要删除该教学大纲吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>