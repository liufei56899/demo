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
        
        function modify(bcStatus,fjFlag,id){
        	if(bcStatus == "1"){
        		alertx("此部门任务已经审核通过，不能修改");
        		return;
        	}
        	if(fjFlag == "1"){
        		alertx("此部门任务已经分解，不能修改");
        		return;
        	}
        	location.href = "${ctx}/jhfj/jhFj/form?id="+id;
        }
        
        function deleteJhFj(bcStatus,id,obj){
        	if(bcStatus == "1"){
        		alertx("此部门任务已经审核过，不能删除");
        		return;
        	}else if(bcStatus == "2")
        	{
        		alertx("此部门任务已经审核过，不能删除");
        		return;
        	}
        	else{
        		var r = confirmx("确认要删除该计划分解个人吗？", "${ctx}/jhfj/jhFj/deleteJhfj?id="+id);
        	}
        }
        
        function addbmfj()
        {    var bodyWidth = document.body.clientWidth;
             var bodyHeight = document.body.clientHeight;
             bodyWidth = parseInt(bodyWidth * 0.8);
             bodyHeight = parseInt(bodyHeight * 0.6);
        	openDialog("${ctx}/jhfj/jhFj/form","分解任务到部门",bodyWidth,bodyHeight);
        }
        
        function editbmfj()
        {
        	var ids ="";
        	var bcStatus ="";
        	var count =0;
			$("#contentTable").find("input[type='checkbox']").each(function()
			{
				if($(this).attr("checked"))
				{
					if($(this).next().val()!=null && $(this).next().val()!="")
					{
						ids += $(this).next().val()+",";
						bcStatus += $(this).next().next().val()+",";
						count++;
					}
				}
			});
			if(count == 1)
			{
				if(ids!=null && ids!="")
				{
				   ids = ids.substring(0,ids.length-1);
				   bcStatus = bcStatus.substring(0,bcStatus.length-1);
				   /* if(bcStatus == "1"){
		        		alertx("此部门任务已经审核通过，不能修改");
		        		return;
		        	} */
		        	var bodyWidth = document.body.clientWidth;
                    var bodyHeight = document.body.clientHeight;
                        bodyWidth = parseInt(bodyWidth * 0.8);
                        bodyHeight = parseInt(bodyHeight * 0.6);
				   openDialog("${ctx}/jhfj/jhFj/form?id="+ids,"分解任务到部门",bodyWidth,bodyHeight);
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
        
        function deletebmfj()
        {
        	var ids ="";
        	var bcStatus ="";
        	var count =0;
			$("#contentTable").find("input[type='checkbox']").each(function()
			{
				if($(this).attr("checked"))
				{
					if($(this).next().val()!=null && $(this).next().val()!="")
					{
						ids += $(this).next().val()+",";
						bcStatus += $(this).next().next().val()+",";
						count++;
					}
				}
			});
			
			var indexTG = bcStatus.indexOf("1");
			var indexBTG = bcStatus.indexOf("2");
			if(count ==0)
			{
				alertx('请选择需要删除的数据！');
			}else
			{
				if(ids!=null && ids!="")
				{
				   ids = ids.substring(0,ids.length-1);
				 }
				 if(indexTG > -1 || indexBTG > -1){
		        		alertx("选中的记录包含已经审核过的信息，不能删除");
		        		return;
		        	}
				confirmx('确认要删除该部门任务吗？', "${ctx}/jhfj/jhFj/deletes?ids="+ids);
			}
        }
        
        function jhfjView(id)
        {
        	openDialog("${ctx}/jhfj/jhFj/jhfjView?id=" + id,"部门任务分解查看", 850, 450);
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
		<li class="active"><a href="${ctx}/jhfj/jhFj/list/">计划分解列表</a></li>
		<shiro:hasPermission name="jhfj:jhFj:edit"><li><a href="${ctx}/jhfj/jhFj/form">计划分解添加</a></li></shiro:hasPermission>
	</ul> --%>
	<form:form id="searchForm" modelAttribute="jhFj" action="${ctx}/jhfj/jhFj/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<div class="cxtj">查询条件</div>
			<table class="ul-form">
				<tr>
					<th style="width:200px;">招生计划</th>
					<td style="width:300px;">
						<form:select id="zsjh" path="zsjh.id" class="input-medium">
						<form:option value="" label=""/>
						<form:options items="${fns:findListZsjh()}" itemLabel="jhmc" itemValue="id" htmlEscape="false"/>
					</form:select>
					</td>
					
					<th style="width:200px;">部门名称</th>
					<td style="width:300px;">
						<sys:treeselect id="office" name="office.id" value="${jhFj.office.id}" labelName="office.name" labelValue="${jhFj.office.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
					</td>
				</tr>
				<tr>
					<th >招生人数</th>
					<td >
					    <form:input path="zsrs" id="zsrs" class="input-medium" htmlEscape="false" maxlength="11"
					          style="width:165px;"
					    	/>
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
		<input id="btnAdd" class="btn btn-primary" type="button" onclick="addbmfj()" value="分解"/>
		<input id="btnEdit" class="btn btn-primary" type="button" onclick="editbmfj()" value="修改"/>
		<input id="btnDel" class="btn btn-primary" type="button" onclick="deletebmfj()" value="删除"/>
	</div>
	<sys:message content="${message}"/>
	<div class="cxjg">查询结果</div>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>
					<input type="checkbox" id="checkboxAll" name="choose" onclick="selAll(this)">
					<input type="hidden" name="ids" value="" />
					<input type="hidden" name="bcStatus" value="" />
				</th>
				<th>招生计划</th>
				<th>部门名称</th>
				<th>招生人数</th>
				<th>分解状态</th>
				<th>审核状态</th>
				<th>更新时间</th>
				<%-- <shiro:hasPermission name="jhfj:jhFj:edit"><th>操作</th></shiro:hasPermission> --%>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="jhFj">
			<tr>
				<td>
			    	<input type="checkbox" id="checkbox" name="choose" value="${jhFj.id}" onclick="selFirst()">
			    	<input type="hidden" name="ids" value="${jhFj.id}" />
			    	<input type="hidden" name="bcStatus" value="${jhFj.bcStatus}" />
			    </td>
				<td>
					<a href="javascript:void(0);" onclick="jhfjView('${jhFj.id}');">${jhFj.zsjh.jhmc}</a>
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
					<c:if test="${jhFj.bcStatus eq '0'}">
					   <span style="color: #0099CC;">审核中</span>
					</c:if>
					<c:if test="${jhFj.bcStatus eq '1'}">
					  <span style="color: #0D73F3;">审核通过</span>
					</c:if>
					<c:if test="${jhFj.bcStatus eq '2'}">
					 <span style="color: #ff0033;">审核不通过</span>
					</c:if>
				</td>
				<td>
					<fmt:formatDate value="${jhFj.updateDate}" pattern="yyyy-MM-dd"/>
				</td>
				<%-- <shiro:hasPermission name="jhfj:jhFj:edit"><td>
    				<a href="javascript:modify('${jhFj.bcStatus}','${jhFj.fjFlag}','${jhFj.id}');">修改</a>
					<a href="javascript:deleteJhFj('${jhFj.bcStatus}','${jhFj.id}',this);">删除</a>
				</td></shiro:hasPermission> --%>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>