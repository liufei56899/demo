<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>专业资料管理管理</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/base_index.jsp" %>
	<style type="text/css">
		body{
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
         //重置
		function resetClick(){
        	$("#zlname").attr("value",'');
        	$("#uploadname").attr("value",'');
        	$("#uploaddate").attr("value",'');
        }
        function fjxz(fj){     	
        	window.location.href="${ctx}/zyzl/xxZyzl/download?pathName="+fj;
        }
        function update(id){
        	window.location.href="${ctx}/zyzl/xxZyzl/form?id="+id;       	
        }   
        function delZyzl(id){
        	confirmx('确认要删除该专业资料管理吗？', "${ctx}/zyzl/xxZyzl/delete?id="+id);       	
        }
        function add(){
        	window.location.href="${ctx}/zyzl/xxZyzl/form";
        }
	</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="xxZyzl" action="${ctx}/zyzl/xxZyzl/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<div class="cxtj">查询条件</div>
		<table class="ul-form">
			<tr>
				<th>资料名称：</th>
				<td>
					<form:input path="zlname" id="zlname" htmlEscape="false" maxlength="64" class="input-medium"/>
				</td>
				<th>上传人：</th>
				<td>
					<form:input path="uploadname" id="uploadname" htmlEscape="false" maxlength="64" class="input-medium"/>
				</td>					
			</tr>
			<tr>
				<td colspan="4"  style="text-align: center;">
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" />
					<input id="btnReset" class="btn btn-primary" type="reset" onclick="resetClick();"  value="重置" />
				</td>
			</tr>
		</table>
	</form:form>
	<div class="btn-div">
		<shiro:hasPermission name="zyzl:xxZyzl:edit">
			<a href="javascript:void(0)" onclick="add()"class="btn btn-primary">增加</a>
		</shiro:hasPermission>
	</div>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>序号</th>
				<th>资料名称</th>
				<th>上传人</th>
				<th>上传时间</th>			
				<th>附件</th>
				<th>说明</th>
				<shiro:hasPermission name="zyzl:xxZyzl:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="xxZyzl">
			<tr>
				<td>
					${xxZyzl.xh}
				</td>
				<td>
					${xxZyzl.zlname}
				</td>
				<td>					
					${fn:substringAfter(xxZyzl.uploadname, ",")}					
				</td>
				<td>
					<fmt:formatDate value="${xxZyzl.uploaddate}" pattern="yyyy-MM-dd"/>
				</td>		
				<td>				
					<a href="javascript:void(0)" onclick="fjxz('${xxZyzl.fj}')">${not empty xxZyzl.fj?'附件下载':''}</a>					
				</td>
				<td>
					${xxZyzl.remarks}
				</td>	
				<shiro:hasPermission name="zyzl:xxZyzl:edit">
					<td>
						<c:if test="${username==xxZyzl.uploadname}">
    						<a href="javascript:void(0)" onclick="update('${xxZyzl.id}')" style="color: #d81919">修改</a> 
							<a href="javascript:void(0)" onclick="delZyzl('${xxZyzl.id}')" style="color: #d81919">删除</a>
						</c:if>
					</td>
				</shiro:hasPermission>				
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<script type="text/javascript" src="${ctxStatic}/validMes/validMes.js"></script>
</body>
</html>