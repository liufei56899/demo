<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学年学期管理</title>
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
        
        //添加
        function addXn()
        {
        	openDialog("${ctx}/xnxq/xnxqJbxx/form","添加学年学期",1200,280);
        }
        
        //修改
        function editXn()
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
				   ids = ids.substring(0,ids.length-1);//
				   var istrue = getZsjhList('${ctx}',ids);
				   if(istrue)
				   {
				   		openDialog("${ctx}/xnxq/xnxqJbxx/form?id="+ids,"修改学年学期",1200,280);
				   }else
				   {
				   		alertx('该学年学期下已存在招生计划不能修改！');
				   }
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
        
        //删除
        function piLiangDelOnClick()
        {
        	var ids ="";
        	var count =0;
        	var index =0;
			$("#contentTable").find("input[type='checkbox']").each(function()
			{
				if($(this).attr("checked"))
				{
					if($(this).next().val()!=null && $(this).next().val()!="")
					{
						ids += $(this).next().val()+",";
						count++;
						var istrue = getZsjhList('${ctx}',$(this).next().val());
						if(!istrue)
						{
							index++;
						}
					}
				}
			});
			
			if(count ==0)
			{
				alertx('请选择需要删除的数据！');
			}else
			{
				if(index<=0)
				{
					if(ids!=null && ids!="")
					{
					   ids = ids.substring(0,ids.length-1);
					   
					 }
					confirmx('确认要删除学年学期信息吗？', "${ctx}/xnxq/xnxqJbxx/delete?ids="+ids);
				}else
				{
					alertx('不能删除学年学期下已存在的招生计划数据 ！');
				}
				
				
			}
        }
        
        
        function resetClick()
        {
        	$("#xnmc").attr("value",'');
        	$("#xqId").select2("destroy");
        	$("#xqId").find("option:selected").attr("selected",false);
        	$("#xqId").attr("value",'');
        	$("#xqId").select2();
        }
        
	</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="xnxqJbxx" action="${ctx}/xnxq/xnxqJbxx/" method="post" class="breadcrumb form-search">
		<div class="cxtj">查询条件</div>
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table class="ul-form">
			<tr>
				<th style="width:200px;">学年名称</th>
				<td style="width:300px;">
					<form:input path="xnmc" id="xnmc" htmlEscape="false" maxlength="200" class="input-medium"/>
				</td>
				
				<th style="width:200px;">学期名称</th>
				<td style="width:300px;">
					<form:select path="xq" id="xqId" class="input-medium">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('term_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</td>
			</tr>
			
			<tr>
				<td colspan="4"  style="text-align: center;">
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" />
					<input id="btnReset" class="btn btn-primary" type="reset" onclick="resetClick();" value="重置" />
				</td>
			</tr>
		</table>
	</form:form>
	<div class="btn-div">
		<c:if test="${not empty zyList }">
			<input id="btnAdd" class="btn btn-primary" type="button" onclick="addXn()" value="增加"/>	
		</c:if>
		<!-- <input id="btnAdd" class="btn btn-primary" type="button" onclick="addXn()" value="增加"/> -->	
		<input id="btnEdit" class="btn btn-primary" type="button" onclick="editXn()" value="修改"/>
		<input id="btnDel" class="btn btn-primary" type="button" onclick="piLiangDelOnClick()" value="删除"/>
	</div>
	<sys:message content="${message}"/>
	<div class="cxjg">查询结果</div>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				 <th><input type="checkbox" id="checkboxAll" name="choose" onclick="selAll(this)">
				    	<input type="hidden" name="ids" value="" />
				 </th>
				<th>学年名称</th>
				<th>学期名称</th>
				<th>开始时间</th>
				<th>结束时间</th>
				<th>更新时间</th>
				<!-- <th>备注信息</th> -->
				<%-- <shiro:hasPermission name="xnxq:xnxqJbxx:edit"><th>操作</th></shiro:hasPermission> --%>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="xnxqJbxx">
			<tr>
				 <td>
					<input type="checkbox" id="checkbox" name="choose" value="${xnxqJbxx.id}" onclick="selFirst()">
					<input type="hidden" name="id" value="${xnxqJbxx.id}" />
				</td>
				<td><%-- <a href="${ctx}/xnxq/xnxqJbxx/form?id=${xnxqJbxx.id}"> --%>
					${xnxqJbxx.xnmc}
				<!-- </a> --></td>
				<td>
					${fns:getDictLabel(xnxqJbxx.xq, 'term_type', '')}
				</td>
				<td>
					<fmt:formatDate value="${xnxqJbxx.kssj}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					<fmt:formatDate value="${xnxqJbxx.jssj}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					<fmt:formatDate value="${xnxqJbxx.updateDate}" pattern="yyyy-MM-dd"/>
				</td>
				<%-- <td>
					${xnxqJbxx.remarks}
				</td> --%>
				<%-- <shiro:hasPermission name="xnxq:xnxqJbxx:edit"><td>
    				<a href="${ctx}/xnxq/xnxqJbxx/form?id=${xnxqJbxx.id}">修改</a>
					<a href="${ctx}/xnxq/xnxqJbxx/delete?id=${xnxqJbxx.id}" onclick="return confirmx('确认要删除该学年学期吗？', this.href)">删除</a>
				</td></shiro:hasPermission> --%>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<script type="text/javascript" src="${ctxStatic}/validMes/validMes.js"></script>
</body>
</html>