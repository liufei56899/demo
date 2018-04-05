<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>招生简章管理</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/base_index.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
        
        function addJz()
        {
        	openDialog("${ctx}/zsjz/zsjz/form","添加焦点新闻",800,480);
        }
        
        
        //重置
        function resetClick()
        {
        	$("#titleZs").attr("value","");
        	$("#fbr").attr("value","");
        	$("#fbdate").attr("value","");
        }
        
        
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/zsjz/zsjz/list">焦点新闻列表</a></li>
		<shiro:hasPermission name="zsjz:zsjz:edit"><li><a href="${ctx}/zsjz/zsjz/form">焦点新闻添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="zsjz" action="${ctx}/zsjz/zsjz/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<div class="cxtj">查询条件</div>
		<table class="ul-form">
		   <tr>
		     <th style="text-align: right;">标题</th>
		     <td><form:input path="title" id="titleZs" htmlEscape="false" maxlength="32" class="input-medium"/></td>
		     <th style="text-align: right;">发布人</th>
		     <td><form:input path="releaseby" id="fbr" htmlEscape="false" maxlength="32" class="input-medium"/></td>
		   </tr>
		   <tr>
		     <th style="text-align: right;">发布时间</th>
		     <td><input name="releasedate" id="fbdate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${zsjz.releasedate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/></td>
		   </tr>
		   <tr>
		     <td colspan="4"  style="text-align: center;">
		        <input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
		        <input id="btnReset" class="btn btn-primary" type="reset" onclick="resetClick();"  value="重置" />
		      </td>
		   </tr>
		</table>
	</form:form>
	<!-- <div  class="btn-div">
		<input id="btnAdd" class="btn btn-primary" type="button" onclick="addJz()" value="增加"/>
		<input id="btnEdit" class="btn btn-primary" type="button" onclick="editJz()" value="修改"/>
		<input id="btnDel" class="btn btn-primary" type="button" onclick="deleteJz()" value="删除"/>
	</div> -->
	
	<sys:message content="${message}"/>
	<div class="cxjg">查询结果</div>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>标题</th>
				<!-- <th>内容</th> -->
				<th>发布人</th>
				<th>发布时间</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="zsjz:zsjz:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="zsjz">
			<tr>
				<td><a href="${ctx}/zsjz/zsjz/form?id=${zsjz.id}">
					${zsjz.title}
				</a></td>
				<%-- <td>
					${zsjz.content}
				</td> --%>
				<td>
					${zsjz.releaseby}
				</td>
				<td>
					<fmt:formatDate value="${zsjz.releasedate}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					<fmt:formatDate value="${zsjz.updateDate}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					${zsjz.remarks}
				</td>
				<shiro:hasPermission name="zsjz:zsjz:edit"><td>
    				<a href="${ctx}/zsjz/zsjz/form?id=${zsjz.id}">修改</a>
					<a href="${ctx}/zsjz/zsjz/delete?id=${zsjz.id}" onclick="return confirmx('确认要删除该招生简章吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<script type="text/javascript" src="${ctxStatic}/validMes/validMes.js"></script>
</body>
</html>