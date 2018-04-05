<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>计划分解管理</title>
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
        
        function rwfj(id,fjFlags){
        	/* if(fjFlags == "1"){
				alertx("此部门任务已经分解，不需要再次分解");
		        return;
		    } */
        	openDialog("${ctx}/jhfj/jhFj/bmRwFjForm?id="+id,"部门任务分解",850,500);
        }
        
        function CutRw()
        {
        	var ids ="";
        	var fjFlags ="";
        	var count =0;
			$("#contentTable").find("input[type='checkbox']").each(function()
			{
				if($(this).attr("checked"))
				{
					if($(this).next().val()!=null && $(this).next().val()!="")
					{
						ids += $(this).next().val()+",";
						fjFlags += $(this).next().next().val()+",";
						count++;
					}
				}
			});
			if(count == 1)
			{
				if(ids!=null && ids!="")
				{
				   ids = ids.substring(0,ids.length-1);
				   fjFlags = fjFlags.substring(0,fjFlags.length-1);
				   /* if(fjFlags == "1"){
		        		alertx("此部门任务已经分解，不需要再次分解");
		        		return;
		        	} */
				   openDialog("${ctx}/jhfj/jhFj/bmRwFjForm?id="+ids,"部门任务分解",850,500);
				}
			}
			else if(count ==0)
			{
				alertx('请选择需要分解的部门任务！');
			}else
			{
				alertx('只能选择一条任务进行分解！');
			}
        }
        
        function bmfjView(id)
        {
        	 openDialog("${ctx}/jhfj/jhFj/bmfjView?id="+id,"部门任务分解查看",850,480);
        }
        
        //重置
		function resetClick()
        {
        	$("#zsrs").attr("value",'');
        	$("#zsjh").select2("destroy");
        	$("#zsjh").find("option:selected").attr("selected",false);
        	$("#zsjh").select2();
        	
        	$("#office").attr("value","");
        	$("#officeId").attr("value","");
        	$("#officeName").attr("value","");
        }
	</script>
</head>
<body>
	<%-- <ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/jhfj/jhFj/rwList/">部门任务分解列表</a></li>
		<shiro:hasPermission name="jhfj:jhFj:edit"><li><a href="#">计划分解添加</a></li></shiro:hasPermission>
	</ul> --%>
	<form:form id="searchForm" modelAttribute="jhFj" action="${ctx}/jhfj/jhFj/rwList/" method="post" class="breadcrumb form-search">
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
					
					<th style="width:200px;">部门名称</th>
					<td style="width:300px;">
						<sys:treeselect id="office" name="office.id" 
							value="${jhFj.office.id}" labelName="office.name" 
							labelValue="${jhFj.office.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
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
						<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" />
						<input id="btnReset" class="btn btn-primary" type="reset" onclick="resetClick();"  value="重置" />
					</td>
				</tr>
			</table>
	</form:form>
	<div  class="btn-div">
		<input id="btnEdit" class="btn btn-primary" type="button" onclick="CutRw()" value="分解"/>
	</div>
	<sys:message content="${message}"/>
	<div class="cxjg">查询结果</div>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>
					<input type="checkbox" id="checkboxAll" name="choose" onclick="selAll(this)">
					<input type="hidden" name="ids" value="" />
					<input type="hidden" name="fjFlags" value="" />
				</th>
				<th>招生计划</th>
				<th>部门名称</th>
				<th>招生人数</th>
				<th>分解状态</th>
				<th>审核状态</th>
				<th>更新时间</th>
				<shiro:hasPermission name="jhfj:jhFj:edit"><th>任务分解</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="jhFj">
			<tr>
				<td>
			    	<input type="checkbox" id="checkbox" name="choose" value="${jhFj.id}" onclick="selFirst()">
			    	<input type="hidden" name="ids" value="${jhFj.id}" />
			    	<input type="hidden" name="fjFlags" value="${jhFj.fjFlag}" />
			    </td>
				<td>
					<a href="javascript:void(0);" onclick="bmfjView('${jhFj.id}');" >${jhFj.zsjh.jhmc}</a>
				</td>
				<td>
					${jhFj.office.name}
				</td>
				<td>
					${jhFj.zsrs}
				</td>
				<td>
					${fns:getDictLabel(jhFj.fjFlag, 'fjFlag', '')}
				</td>
				<td>
					<c:if test="${jhFj.fjFlag eq '0'}">
					   <span style="color: #0099CC;">未提交</span>
					</c:if>
					<c:if test="${jhFj.fjFlag eq '1'}">
						<c:if test="${jhFj.grShZt eq '0'}">
						   <span style="color: #0099CC;">审核中</span>
						</c:if>
						<c:if test="${jhFj.grShZt eq '1'}">
						   <span style="color: #0D73F3;">审核通过</span>
						</c:if>
						<c:if test="${jhFj.grShZt eq '2'}">
						   <span style="color: #ff0033;">审核不通过</span>
						</c:if>
					</c:if>
				</td>
				<td>
					<fmt:formatDate value="${jhFj.updateDate}" pattern="yyyy-MM-dd"/>
				</td>
				<shiro:hasPermission name="jhfj:jhFj:edit"><td>
    				<%-- <a href="${ctx}/jhfj/jhFj/bmRwFjForm?id=${jhFj.id}">分解</a> --%>
    				<a href="javascript:rwfj('${jhFj.id}','${jhFj.fjFlag}');">分解</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>