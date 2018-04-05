<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>计划分解个人管理</title>
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
        
        function searchGrrw(id){
        	openDialog("${ctx}/jhfjgr/jhFjGr/grRwForm?id="+id,"个人任务查看",850,480);
        }
        
        //重置
		function resetClick()
        {
        	$("#jsId").attr("value",'');
        	$("#zsrs").attr("value",'');
        	$("#jsId").attr("value",'');
        	$("#jsIdId").attr("value",'');
        	$("#jsIdName").attr("value",'');
        	$("#zsjh").select2("destroy");
        	$("#zsjh").find("option:selected").attr("selected",false);
        	$("#zsjh").select2();
        }
	</script>
</head>
<body>
	<%-- <ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/jhfjgr/jhFjGr/rwList/">个人任务列表</a></li>
		<shiro:hasPermission name="jhfjgr:jhFjGr:edit"><li><a href="#">个人任务详情</a></li></shiro:hasPermission>
	</ul> --%>
	<form:form id="searchForm" modelAttribute="jhFjGr" action="${ctx}/jhfjgr/jhFjGr/bmrwList" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<div class="cxtj">查询条件</div>
		<table class="ul-form">
				<tr>
					<th style="width:200px;">招生计划</th>
					<td style="width:300px;">
						<form:select id="zsjh" path="zsjh.id" class="input-medium">
							<form:option value="" label=""/>
							<form:options items="${fns:getZsjhList()}" itemLabel="jhmc" itemValue="id" htmlEscape="false"/>
						</form:select>
					</td>
					
					<th style="width:200px;">教师名称</th>
					<td style="width:300px;">
						<sys:treeselect id="jsId" name="jsId" value="${jhFjGr.jsId}" 
							labelName="jsmc" labelValue="${jhFjGr.jsmc}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
					</td>
				</tr>
				<tr>
					<th >招生人数</th>
					<td >
						<form:input path="zsrs" id="zsrs" class="input-medium" htmlEscape="false" maxlength="11" 
							 style="width:165px;" />
					</td>
				</tr>
				<tr>
					<td colspan="4"  style="text-align: center;">
						<input id="btnSubmit" class="btn btn-primary"  type="submit" value="查询" />
						<input id="btnReset" class="btn btn-primary" type="reset" onclick="resetClick();"  value="重置" />
					</td>
				</tr>
			</table>
		
	</form:form>
	<sys:message content="${message}"/>
	<div class="cxjg">查询结果</div>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>招生计划</th>
				<th>教师名称</th>
				<th>招生人数</th>
				<th>招生完成数</th>
				<th>更新时间</th>
				<shiro:hasPermission name="jhfjgr:jhFjGr:edit"><th>查看</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="jhFjGr">
			<tr>
				<td>
					${jhFjGr.zsjh.jhmc}
				</td>
				<td>
					${jhFjGr.jsmc}
				</td>
				<td>
					${jhFjGr.zsrs}
				</td>
				<td>
					${jhFjGr.remarks}
				</td>
				<td>
					<fmt:formatDate value="${jhFjGr.updateDate}" pattern="yyyy-MM-dd"/>
				</td>
				<shiro:hasPermission name="jhfjgr:jhFjGr:edit"><td>
    				<a href="javascript:searchGrrw('${jhFjGr.id}');">查看</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>