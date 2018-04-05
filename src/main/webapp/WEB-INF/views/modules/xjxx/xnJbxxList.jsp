<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>年级信息管理</title>
	<%@ include file="/WEB-INF/views/include/base_index.jsp" %>
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
        
        
        //添加
        function addXn()
        {
        	openDialog("${ctx}/xjxx/xnJbxx/form","添加年级信息",800,230);
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
				   var istrue =getXsJbxx("${ctx}",ids,null,null);
				   if(istrue)
				   {
				   		openDialog("${ctx}/xjxx/xnJbxx/form?id="+ids,"修改年级信息",800,200);
				   }else
				   {
				   		alertx('该年份下已存在学生不能修改！');
				   }
				   //
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
        
        function deleteXn()
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
						var istrue = getXsJbxx("${ctx}",$(this).next().val(),null,null);
						count++;
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
					confirmx('确认要删除年级信息吗？', "${ctx}/xjxx/xnJbxx/delete?ids="+ids);
				}else
				{
					alertx('不能删除年级下已存在的学生数据 ！');
				}
			
			}
        }
        
        function resetClick()
        {
        	$("#nf").attr("value",'');
        }
        
	</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="xnJbxx" action="${ctx}/xjxx/xnJbxx/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<div class="cxtj">查询条件</div>
		<table class="ul-form">
			<tr>
				<th style="width:50%;">年份</th>
				<td style="" colspan="3">
					<form:input path="nf" id="nf" htmlEscape="false" maxlength="200" class="input-medium"/>
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
	<div  class="btn-div">
		<c:if test="${not empty xqList }">
			<input id="btnAdd" class="btn btn-primary" type="button" onclick="addXn()" value="增加"/>
		</c:if>
		<input id="btnEdit" class="btn btn-primary" type="button" onclick="editXn()" value="修改"/>
		<input id="btnDel" class="btn btn-primary" type="button" onclick="deleteXn()" value="删除"/>
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
				<th>入学年份</th>
				<th>更新时间</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="xnJbxx">
			<tr>
				<td>
			    	<input type="checkbox" id="checkbox" name="choose" value="${xnJbxx.id}" onclick="selFirst()">
			    	<input type="hidden" name="ids" value="${xnJbxx.id}" />
			    </td>
			    <td>
			    	${xnJbxx.nf}
			    </td>
				<td>
					<fmt:formatDate value="${xnJbxx.updateDate}" pattern="yyyy-MM-dd"/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<script type="text/javascript" src="${ctxStatic}/validMes/validMes.js"></script>
</body>
</html>