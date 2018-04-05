<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学校信息管理</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/base_index.jsp" %>
	<style type="text/css">
		body
		{
			padding: 0px;
		}
		.cxjg{
		 clear: bo
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
        function addSchool(){
        	openDialog("${ctx}/school/schoolinfo/form","添加学校信息",1100,440);
        }
        
        //菜单维护
        function menuWh()
        {
        	openDialog("${ctx}/sys/role/menuWeiHu","菜单维护",1100,440);
        }
        
        function editSchool()
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
				   openDialog("${ctx}/school/schoolinfo/form?id="+ids,"修改学校信息",1100,440);
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
        
        function deleteSchool()
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
				confirmx('确认要删除学校信息吗？', "${ctx}/school/schoolinfo/delete?ids="+ids);
			}
        }
        
        function modify(id){
        	window.open("${ctx}/school/schoolinfo/form?id="+id, "修改学校信息", "top=400,left=530,menubar=no,location=yes,resizable=yes,scrollbars=yes,status=yes");
        }
        
        //重置
		function resetClick()
        {
        	$("#xxmc").attr("value",'');
        	$("#xzxm").attr("value",'');
        }
	</script>
</head>
<body>
	
	<form:form id="searchForm" modelAttribute="schoolinfo" action="${ctx}/school/schoolinfo/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<div class="cxtj">查询条件</div>
			<table class="ul-form">
				<tr>
					<th style="width:200px;">学校名称</th>
					<td style="width:300px;">
						<form:input path="xxmc" id="xxmc" htmlEscape="false" maxlength="64" class="input-medium"/>
					</td>
					<th style="width:200px;">校长姓名</th>
					<td style="width:300px;"><form:input path="xzxm" id="xzxm" htmlEscape="false" maxlength="10" class="input-medium"/></td>
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
		<!-- <input id="btnAdd" class="btn btn-primary" type="button" onclick="menuWh()" value="菜单维护"/> -->
		<!-- <input id="btnAdd" class="btn btn-primary" type="button" onclick="addSchool()" value="增加"/> -->
		<input id="btnEdit" class="btn btn-primary" type="button" onclick="editSchool()" value="修改"/>
		<!-- <input id="btnDel" class="btn btn-primary" type="button" onclick="deleteSchool()" value="删除"/> -->
	</div>
	
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>
					<input type="checkbox" id="checkboxAll" name="choose" onclick="selAll(this)">
					<input type="hidden" name="ids" value="" />
				</th>
				<th>学校代码</th>
				<th>学校名称</th>
				<th>学校邮政编码</th>
				<th>建校年月</th>
				<th>校长姓名</th>
				<th>联系电话</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="schoolinfo">
			<tr>
				<td>
			    	<input type="checkbox" id="checkbox" name="choose" value="${schoolinfo.id}" onclick="selFirst()">
			    	<input type="hidden" name="ids" value="${schoolinfo.id}" />
			    </td>
				<td>
					${schoolinfo.xxdm}
				</td>
				<td>
					${schoolinfo.xxmc}
				</td>
				<td>
					${schoolinfo.xxyzbm}
				</td>
				<td>
					<fmt:formatDate value="${schoolinfo.jxny}" pattern="yyyy-MM"/>
				</td>
				<td>
					${schoolinfo.xzxm}
				</td>
				<td>
					${schoolinfo.lxdh}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<script type="text/javascript" src="${ctxStatic}/validMes/validMes.js"></script>
</body>
</html>