<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>通知管理</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/base_index.jsp" %>
	<style type="text/css">
		body
		{
			padding: 0px;
		}
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
        
        function addTzgg()
        {
        	openDialog("${ctx}/oa/oaNotify/form","添加通知信息",860,440);
        }
        
        function readNotify(id){
        	openDialog("${ctx}/oa/oaNotify/viewNotify?id="+id,"查看通知信息",860,440);
        }
        
        function editTzgg()
        {
        	var ids ="";
        	var count =0;
			$("#contentTable").find("input[type='checkbox']").each(function()
			{
				if($(this).attr("checked"))
				{
					if($(this).next().val()!=null && $(this).next().val()!="")
					{
						ids += $(this).next().val()+",";
						count++;
					}
				}
			});
			if(count == 1)
			{
				if(ids!=null && ids!="")
				{
				   ids = ids.substring(0,ids.length-1);///zy/zyJbxx/form
				   openDialog("${ctx}/oa/oaNotify/form?id="+ids,"修改通知信息",860,440);
				}
			}
			else if(count ==0)
			{
				alertx('请选择需要修改的数据！');
			}else
			{
				alertx('只能选择一条信息进行修改！');
			}
        }
        
        function deleteTzgg()
        {
        	var ids ="";
        	var count =0;
			$("#contentTable").find("input[type='checkbox']").each(function()
			{
				if($(this).attr("checked"))
				{
					console.log($(this).parent().find("input[name='zt']").val());
					if($(this).parent().find("input[name='zt']").val()!="")
					{
						if($(this).next().val()!=null && $(this).next().val()!="")
						{
							ids += $(this).next().val()+",";
							count++;
						}
					}
				}
			});
			
			if(count ==0)
			{
				alertx('请选择需要删除的数据！');
			}else
			{
				if(ids!=null && ids!="")
				{
				   ids = ids.substring(0,ids.length-1);
				   
				 }
				confirmx('确认要删除通知信息吗？', "${ctx}/oa/oaNotify/delete?ids="+ids);
			}
        }
        
          function resetClick()
	        {
	        	$("#title").attr("value","");
	        	$("#type").select2("destroy");
	        	$("#type").find("option:selected").attr("selected",false);
	        	$("#type").select2();
	        	var istrue = ${oaNotify.self};
	        	console.log(istrue);
	        	if(!istrue)
	        	{
	        		$("#status").select2("destroy");
		        	$("#status").find("option:selected").attr("selected",false);
		        	$("#status").select2();
	        	}
	        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/oa/oaNotify/${oaNotify.self?'self':''}">通知列表</a></li>
		<c:if test="${!oaNotify.self}"><shiro:hasPermission name="oa:oaNotify:edit">
			<li><a href="${ctx}/oa/oaNotify/form">通知添加</a></li></shiro:hasPermission></c:if>
	</ul>
	<form:form id="searchForm" modelAttribute="oaNotify" action="${ctx}/oa/oaNotify/${oaNotify.self?'self':''}" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			<div class="cxtj">查询条件</div>
			<table class="ul-form">
				<tr>
					<th style="width:200px;">标题</th>
					<td style="width:300px;">
						<form:input path="title" id="title" htmlEscape="false" maxlength="200" class="input-medium"/>
					</td>
					<th style="width:200px;">类型</th>
					<td style="width:300px;">
						<form:select path="type" id="type" class="input-medium">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('oa_notify_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
				</tr>
				<c:if test="${!oaNotify.self}">
				<tr>
					<th>
						状态
					</th>
					<td>
						<form:select path="status" id="status" class="input-medium" style="width:195px;">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('oa_notify_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
				</tr>
				</c:if>
				<tr>
					<td colspan="4"  style="text-align: center;">
						<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" />
						<input id="btnReset" class="btn btn-primary" type="reset" onclick="resetClick();"  value="重置" />
					</td>
				</tr>
			</table>
		
	</form:form>
	
	<c:if test="${!oaNotify.self}">
		<div  class="btn-div">
			<!-- <input id="btnAdd" class="btn btn-primary" type="button" onclick="addTzgg()" value="增加"/>
			<input id="btnEdit" class="btn btn-primary" type="button" onclick="editTzgg()" value="修改"/> -->
			<input id="btnDel" class="btn btn-primary" type="button" onclick="deleteTzgg()" value="删除"/>
		</div>
	
	</c:if>
	
	<sys:message content="${message}"/>
	<div class="cxjg">查询结果</div>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<c:if test="${!requestScope.oaNotify.self}">
					<th>
						<input type="checkbox" id="checkboxAll" name="choose" onclick="selAll(this)">
						<input type="hidden" name="ids" value="" />
						<input type="hidden" name="zt" value="" />
					</th>
				</c:if>
				<th>标题</th>
				<th>类型</th>
				<th>状态</th>
				<th>查阅状态</th>
				<th>更新时间</th>
				<shiro:hasPermission name="oa:oaNotify:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="oaNotify">
			<tr>
				<c:if test="${!requestScope.oaNotify.self}">
					<td>
				    	<input type="checkbox" id="checkbox" name="choose" value="${oaNotify.id}" onclick="selFirst()">
				    	<input type="hidden" name="ids" value="${oaNotify.id}" />
				    	<input type="hidden" name="zt" value="${oaNotify.status }" />
				    </td>
				</c:if>
				<td><a href="javascript:readNotify('${oaNotify.id}');">
					${fns:abbr(oaNotify.title,50)}
					</a>
				</td>
				<td>
					${fns:getDictLabel(oaNotify.type, 'oa_notify_type', '')}
				</td>
				<td>
					${fns:getDictLabel(oaNotify.status, 'oa_notify_status', '')}
				</td>
				<td>
					<c:if test="${requestScope.oaNotify.self}">
						${fns:getDictLabel(oaNotify.readFlag, 'oa_notify_read', '')}
					</c:if>
					<c:if test="${!requestScope.oaNotify.self}">
						${oaNotify.readNum} / ${oaNotify.readNum + oaNotify.unReadNum}
					</c:if>
				</td>
				<td>
					<fmt:formatDate value="${oaNotify.updateDate}" pattern="yyyy-MM-dd"/>
				</td>
				<shiro:hasPermission name="oa:oaNotify:edit"><td>
    				<a href="${ctx}/oa/oaNotify/form?id=${oaNotify.id}">修改</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<script type="text/javascript" src="${ctxStatic}/validMes/validMes.js"></script>
</body>
</html>