<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学校课程代码表管理</title>
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
        function addCoursce(){
        	openDialog("${ctx}/course/course/form","添加课程信息",900,350);
        }
        function editCoursce(){
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
				   openDialog("${ctx}/course/course/form?id="+ids,"修改课程信息",900,350);
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
        function deleteCoursce(){
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
				   confirmx('确认要删除该专业名称吗？', "${ctx}/course/course/delete?id="+ids);
			   
				}
			}
			else if(count ==0)
			{
				alertx('请选择需要修改的数据！');
			}else
			{
				alertx('只能选择一条信息进行删除！');
			}
    	
        }
        //点击行显示详细信息
        function showCourseForm(course_id){
        	openDialog("${ctx}/course/course/courseInfoForm?id="+course_id,"查看课程详细信息",900,300);
        }           		
        //重置
		function resetClick(){
        	$("#coursename").attr("value",'');
        	$("#teachername").attr("value",'');  	
        }
        //课程专业维护
        function defendCoursce(){
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
				   openDialog("${ctx}/course/course/defendCoursce?id="+ids,"维护课程专业信息",900,270);
				}
			}
			else if(count ==0)
			{
				alertx('请选择需要维护的课程信息！');
			}else
			{
				alertx('只能选择一条课程信息进行维护！');
			}
    	
        
        }         
	</script>
</head>
<body>	
	<form:form id="searchForm" modelAttribute="course" action="${ctx}/course/course/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table class="ul-form">
			<tr>
				<th>课程名称</th>
				<td>
					<form:input path="coursename" id="coursename" htmlEscape="false" maxlength="64" class="input-medium"/>
				</td>
				<th>教师名称</th>
				<td>
					<form:input path="teachername" id="teachername" htmlEscape="false" maxlength="64" class="input-medium"/>
				</td>
			</tr>
			<tr>
				<td colspan="4" style="text-align: center;">
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" />
					<input id="btnReset" class="btn btn-primary" type="reset" onclick="resetClick();"  value="重置" />
				</td>
			</tr>
		</table>
	</form:form>
	<div  class="btn-div">
		<input id="btnDefend" class="btn btn-primary" type="button" onclick="defendCoursce()" value="课程专业维护"/>
		<input id="btnAdd" class="btn btn-primary" type="button" onclick="addCoursce()" value="增加"/>
		<input id="btnEdit" class="btn btn-primary" type="button" onclick="editCoursce()" value="修改"/>
		<input id="btnDel" class="btn btn-primary" type="button" onclick="deleteCoursce()" value="删除"/>
	</div>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>
					<input type="checkbox" id="checkboxAll" name="choose" onclick="selAll(this)">
					<input type="hidden" name="ids" value="" />
				</th>
				<th>课程名称</th>				
				<th>教师名称</th>
				<!-- <th>学年</th>
				<th>专业类型名称</th>
				<th>专业名称</th> -->
				<th>开始时间</th>
				<th>结束时间</th>
				<th>说明</th>				
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="course">
			<tr>
				<td>
			    	<input type="checkbox" id="checkbox" name="choose" value="${course.id}" onclick="selFirst()">
			    	<input type="hidden" name="ids" value="${course.id}" />
			    </td>
				<td>
				<a href="javascript:void(0);" onClick="showCourseForm('${course.id}')">			
					${course.coursename}
				</a></td>		
				<td>
					${course.teachername}
				</td>
				<%-- <td>
					${course.xn}
				</td>
				<td>
					${course.zylxmc}
				</td>
				<td>
					${course.zymc}
				</td> --%>
				<td>
					<fmt:formatDate value="${course.kssj}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					<fmt:formatDate value="${course.jssj}" pattern="yyyy-MM-dd"/>
				</td>
				<td width="300px">
					${course.remarks}
				</td>				
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<script type="text/javascript" src="${ctxStatic}/validMes/validMes.js"></script>
</body>
</html>