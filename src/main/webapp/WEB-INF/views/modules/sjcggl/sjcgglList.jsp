<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>实践成果管理管理</title>
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
        //重置
		function resetClick()
        {
        	$("#csmc").attr("value",'');
        	$("#csry").attr("value",''); 
        	$("#uploadBy").attr("value",''); 
       }
       function add(){
       window.location.href="${ctx}/sjcggl/sjcggl/form";
       }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/sjcggl/sjcggl/">实践成果管理列表</a></li>
		<shiro:hasPermission name="sjcggl:sjcggl:edit"><li><a href="${ctx}/sjcggl/sjcggl/form">实践成果管理添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="sjcggl" action="${ctx}/sjcggl/sjcggl/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table  class="ul-form" style=" width: 100%;">
		  <tr >
		  <td>参赛名称：</td>
		  <td><form:input path="csmc"  id="csmc" htmlEscape="false" maxlength="64" class="input-medium"/></td>		
		  <td>参赛人员：</td>
		  <td><form:input path="csry" id="csry"  htmlEscape="false" maxlength="64" class="input-medium"/></td>	
		  <td>创建者：</td>
		  <td><form:input path="uploadBy" id="uploadBy"  htmlEscape="false" maxlength="64" class="input-medium"/></td>	
		  </tr>
		  <tr>
		     <td colspan="6" style="text-align: center;">
				<input id="btnSubmit1" class="btn btn-primary" type="submit"value="查询" /> 
				<input id="btnReset" class="btn btn-primary" type="reset" onclick="resetClick();"  value="重置" />
			 </td>
		  </tr>
		</table>
	</form:form>
		<div class="btn-div">
		<input id="btnSubmit2" onclick="add();"class="btn btn-primary" type="button" value="增加" /> 
	</div>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>序号</th>
				<th>参赛名称</th>
				<th>参赛人员</th>
				<th>参赛时间</th>
				<th>获奖情况</th>
				<th>附件</th>
				<th>创建者</th>
				<th>创建时间</th>
				<shiro:hasPermission name="sjcggl:sjcggl:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="sjcggl">
			<tr>
				<td>
					${sjcggl.num}
				</td>
				<td>
					${sjcggl.csmc}
				</td>
				<td>
					${sjcggl.csry}
				</td>
				<td>
				<fmt:formatDate value="${sjcggl.cssj}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					${sjcggl.hjqk}
				</td>
				<shiro:hasPermission name="sjcggl:sjcggl:edit">
				<td><c:if test="${sjcggl.fj !=null && sjcggl.fj!=''}">
				<a href="${ctx}/sjcggl/sjcggl/download?fj=${sjcggl.fj}">附件下载</a>
				</c:if>
					
				</td>
				</shiro:hasPermission>
				<td>
					${sjcggl.uploadBy}
				</td>
				<td>
					<fmt:formatDate value="${sjcggl.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				
				<shiro:hasPermission name="sjcggl:sjcggl:edit"><td>
				<c:if test="${sjcggl.createBy.id==user.id}">
    				<a href="${ctx}/sjcggl/sjcggl/form?id=${sjcggl.id}"><span style="color:#d81919">修改</span></a>
					<a href="${ctx}/sjcggl/sjcggl/delete?id=${sjcggl.id}" onclick="return confirmx('确认要删除该实践成果管理吗？', this.href)" style="color:#d81919">删除</a>
				</c:if>
				</td></shiro:hasPermission>
				
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>