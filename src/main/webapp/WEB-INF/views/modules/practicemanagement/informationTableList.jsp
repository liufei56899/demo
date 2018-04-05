<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>艺术实践管理管理</title>
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
		<li class="active"><a href="${ctx}/practicemanagement/informationTable/">艺术实践管理列表</a></li>
		<shiro:hasPermission name="practicemanagement:informationTable:edit"><li><a href="${ctx}/practicemanagement/informationTable/form">艺术实践管理添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="informationTable" action="${ctx}/practicemanagement/informationTable/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		  <div class="cxtj">查询条件</div> 
			<table class="ul-form" style=" width: 100%;">
			    <tr>
					<td>学年学期</td>
					<td>
						<form:select path="xnxq" class="input-xlarge " id="xnxq">
						<form:option value="" label=""/>
						<form:options items="${fns:getXnxq()}" itemLabel="xnmc" itemValue="id" htmlEscape="false"/>
						</form:select>
					</td>
					<td>艺术实践类型</td>
					<td>
							<form:select path="shijiantype" class="input-xlarge ">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('music')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						    </form:select>
					</td>
					<td>艺术实践时间</td>
					<td>
							<input name="shijiantime1" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
							value="<fmt:formatDate value="${informationTable.shijiantime1}" pattern="yyyy-MM-dd HH:mm:ss"/>"
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
							至
							<input name="shijiantime2" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
							value="<fmt:formatDate value="${informationTable.shijiantime2}" pattern="yyyy-MM-dd HH:mm:ss"/>"
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
					</td>
					<td>组成小组数量</td>
					<td><form:input path="znum" htmlEscape="false" maxlength="11" class="input-xlarge  digits"  id="znum"/></td>
					<td><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></td>
					</tr>
				</table>
	</form:form>
	<sys:message content="${message}"/>
	<div class="cxjg">查询结果</div>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
			<td>学年学期</td>
			<td>艺术实践类型</td>
			<td>艺术实践时间</td>
			<td>组成小组数量</td>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="informationTable">
			<tr>
				<td>${fns:getXnxqmc(informationTable.xnxq)}</td>
				<td>${fns:getDictLabel(informationTable.shijiantype, 'music', '')}</td>
				<td><fmt:formatDate value="${informationTable.shijiantime1}"
							pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;&nbsp;至&nbsp;&nbsp;
						<fmt:formatDate value="${informationTable.shijiantime2}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
				<td>${informationTable.znum}</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>