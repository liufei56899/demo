<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>快捷菜单设置管理</title>
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
        
        //菜单维护
        function menuWh()
        {
        	openDialog("${ctx}/sys/role/menuWeiHu","菜单维护",600,440);
        }
        
        
        //删除
        function deleteMenu()
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
			
			if(count ==0)
			{
				alertx('请选择需要删除的数据！');
			}else
			{
				if(ids!=null && ids!="")
				{
				   ids = ids.substring(0,ids.length-1);
				   
				 }
				confirmx('确认要删除菜单吗？', "${ctx}/um/sysUserMenu/deleteMenu?ids="+ids);
			}
        }
        
        function resetClick()
        {
        	$("#nameTxt").attr("value",'');
        }
        
        function menuSheZhi(title,name,link)
		{
            window.parent.tabKjcd(title,name,link); 
		}
	</script>
</head>
<body>
	<%-- <ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/kjcdsz/sysMenu/">快捷菜单设置列表</a></li>
		<shiro:hasPermission name="kjcdsz:sysMenu:edit"><li><a href="${ctx}/kjcdsz/sysMenu/form">快捷菜单设置添加</a></li></shiro:hasPermission>
	</ul> --%>
	<form:form id="searchForm" modelAttribute="sysMenu" action="${ctx}/kjcdsz/sysMenu/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<div class="cxtj">查询条件</div>
		<table class="ul-form">
			<tr>
				<th style="width:400px;">名称</th>
				<td colspan="3">
					<form:input path="name" id="nameTxt" htmlEscape="false" maxlength="100" class="input-medium"/>
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
	<div style="margin-left: 1200px;margin-bottom: 10px;">
		<input id="btnAdd" class="btn btn-primary" type="button" onclick="menuWh()" value="菜单维护"/>
		<input id="btnDel" class="btn btn-primary" type="button" onclick="deleteMenu()" value="删除"/>
	</div>
	<sys:message content="${message}"/>
	<div class="cxjg">查询结果</div>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>
					<input type="checkbox" id="checkboxAll" name="choose" onclick="selAll(this)">
					<input type="hidden" name="ids" value="" />
				</th>
				<th>名称</th>
				<!-- <th>链接</th> -->
				<!-- <th>更新时间</th> -->
				<!-- <th>备注信息</th> -->
				<%-- <shiro:hasPermission name="kjcdsz:sysMenu:edit"><th>操作</th></shiro:hasPermission> --%>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="sysMenu">
			<tr>
				<td>
			    	<input type="checkbox" id="checkbox" name="choose" value="${sysMenu.id}" onclick="selFirst()">
			    	<input type="hidden" name="ids" value="${sysMenu.id}" />
			    </td>
				<td><a href="javaScript:void(0);" onclick="menuSheZhi('${sysMenu.name}','${sysMenu.name}','${ctx}${sysMenu.href}');">
					${sysMenu.name}
					</a>
				</td>
				<%-- <td>
					${sysMenu.href}
				</td> --%>
				<%-- <td>
					<fmt:formatDate value="${sysMenu.updateDate}" pattern="yyyy-MM-dd"/>
				</td> --%>
				<%-- <td>
					${sysMenu.remarks}
				</td> --%>
				<%-- <shiro:hasPermission name="kjcdsz:sysMenu:edit"><td>
    				<a href="${ctx}/kjcdsz/sysMenu/form?id=${sysMenu.id}">修改</a>
					<a href="${ctx}/kjcdsz/sysMenu/delete?id=${sysMenu.id}" onclick="return confirmx('确认要删除该快捷菜单设置吗？', this.href)">删除</a>
				</td></shiro:hasPermission> --%>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<script type="text/javascript" src="${ctxStatic}/validMes/validMes.js"></script>
</body>
</html>