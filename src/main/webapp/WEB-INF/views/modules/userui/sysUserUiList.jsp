<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>终端用户管理</title>
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
        //增加终端用户
        function addUserUI()
        {   
        	openDialog("${ctx}/userui/sysUserUi/form","添加终端用户",980,520);
        }
        //修改终端用户
        function editUserUI()
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
				   ids = ids.substring(0,ids.length-1);
				   openDialog("${ctx}/userui/sysUserUi/form?id="+ids,"修改终端用户",980,520);
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
        
         //查看终端用户
        function editUserUI2(id)
        {
        	openDialog("${ctx}/userui/sysUserUi/formview?id="+id,"查看终端用户",980,520);
        }
        
        //删除终端用户
        function deleteUserUI()
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
			var index = ids.indexOf(","+"${loginUser.id}"+",");
			if(index > -1){
				alertx('不能删除当前登录用户！');
				return;
			}
			if(count ==0)
			{
				alertx('请选择需要删除的数据！');
			}else
			{
				if(ids!=null && ids!="")
				{
				   ids = ids.substring(0,ids.length-1);
				 }
				confirmx('确认要删除该用户吗？', "${ctx}/userui/sysUserUi/delete?ids="+ids);
			}
        }
	</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="sysUserUi" action="${ctx}/userui/sysUserUi/list2" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<div class="cxtj">查询条件</div>
		<table class="ul-form">
		   <tr>
		       <td style="text-align: right;"><label>部门：</label></td>
		       <td><sys:treeselect id="office" name="office.id" value="${sysUserUi.office.id}" labelName="office.name" labelValue="${sysUserUi.office.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/></td>
		      <td style="text-align: right;"><label>用户名：</label></td>
		      <td><form:input path="username" htmlEscape="false" maxlength="100" class="input-medium"/></td>
		   </tr>
		   <tr>
		      <td style="text-align: right;"><label>性别：</label></td>
		      <td><form:input path="xbm" htmlEscape="false" maxlength="64" class="input-medium"/></td>
		      <td style="text-align: right;"><label>姓名：</label></td>
		      <td><form:input path="name" htmlEscape="false" maxlength="100" class="input-medium"/></td>
		   </tr>
		   <tr>
		       <td style="text-align: right;"><label>手机：</label></td>
		       <td><form:input path="mobile" htmlEscape="false" maxlength="200" class="input-medium"/></td>
		   </tr>
		   <tr>
		      <td colspan="4"  style="text-align: center;">
		        <input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
		      </td>
		   </tr>
		</table>
	</form:form>
	<sys:message content="${message}"/>
	<div  class="btn-div">
		<input id="btnAdd" class="btn btn-primary" type="button" onclick="addUserUI()" value="增加"/>
		<input id="btnEdit" class="btn btn-primary" type="button" onclick="editUserUI()" value="修改"/>
		<input id="btnDel" class="btn btn-primary" type="button" onclick="deleteUserUI()" value="删除"/>
	</div>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
			    <th>
				  <input type="checkbox" id="checkboxAll" name="choose" onclick="selAll(this)">
				  <input type="hidden" name="ids" value="${sysUserUi.id}" />
			    </th>
				<th>部门</th>
				<th>用户名</th>
				<th>性别</th>
				<th>姓名</th>
				<th>手机</th>
				<th>更新时间</th>
				<th>备注信息</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="sysUserUi">
			<tr>
			    <td>
			    	<input type="checkbox" id="checkbox" name="choose" value="${sysUserUi.id}" onclick="selFirst()">
			    	<input type="hidden" name="ids" value="${sysUserUi.id}" />
			    </td>
				<td><a href="javascript:editUserUI2('${sysUserUi.id}')">
					${sysUserUi.office.name}
				</a></td>
				<td>
					${sysUserUi.username}
				</td>
				<td>
					${sysUserUi.xbm}
				</td>
				<td>
					${sysUserUi.name}
				</td>
				<td>
					${sysUserUi.mobile}
				</td>
				<td>
					<fmt:formatDate value="${sysUserUi.updateDate}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					${sysUserUi.remarks}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>