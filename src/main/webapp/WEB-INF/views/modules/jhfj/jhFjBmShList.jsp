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
        
        function piLiangShenHe()
        {
        	var ids ="";
        	var jhIds ="";
        	var grShZts ="";
        	var count =0;
        	var officeIds = "";//部门编号
        	var officenames = "";//部门名称
			$("#contentTable").find("input[type='checkbox']").each(function()
			{
				if($(this).attr("checked"))
				{
					if($(this).next().val()!=null && $(this).next().val()!="")
					{
						ids += $(this).next().val()+",";
						jhIds += $(this).next().next().val()+",";
						grShZts += $(this).next().next().next().val()+",";
						officeIds += $(this).next().next().next().next().val()+",";
						officenames += $(this).next().next().next().next().next().val() + "<br>";
						count++;
					}
				}
			});
			
			var indexTG = grShZts.indexOf("1");
			var indexBTG = grShZts.indexOf("2");
			if(count == 0)
			{
				alertx('请选择需要审核的部门任务！');
			}
			else if(count ==1)
			{
				if(ids!=null && ids!="")
				{
				   ids = ids.substring(0,ids.length-1);
				   /* if(grShZts == "1"){
		        		alertx("此部门任务已经审核，不需要再次审核");
		        		return;
		        	} */
				   openDialog("${ctx}/jhfj/jhFj/bmRwFjShForm?id="+ids,"部门内部任务审核",850,500);
				}
			}else
			{
				if (ids != null && ids != "") {
					ids = ids.substring(0, ids.length - 1);
					jhIds = jhIds.substring(0, jhIds.length - 1);
					officeIds = officeIds.substring(0, officeIds.length - 1);
				}
				if(indexTG >=0 || indexBTG >= 0){
					alertx('选中的记录包含已审核过的信息，请重新选择 ！');
					return;
				}
				$("#dialogDiv2").dialog({
					collapsible : false,
					minimizable : false,
					maximizable : false,
					title : "审核意见",
				    width : "400",
		            height : "300",
				    content :"<div style=\"text-align: left;margin-top: 10px;\"><p>对以下部门内部任务进行审核:"+
				             "<span style=\"color:red;\">(注意:审核通过的任务不允许修改!)</span></p>"+
				               officenames+"</div>",
					buttons : [ {
						text : "审核通过",
						handler : function() {
						    $.getJSON("${ctx}/jhfj/jhFj/morebmRwSh",{ids:ids,jhIds:jhIds,officeIds:officeIds,grShZt:"1"},function(result){
						         if(result == "1"){
						         	alertx("部门内部任务审核'通过'成功!");
			  					      //刷新列表
			                         $("#searchForm").attr("action","${ctx}/jhfj/jhFj/bmshList");
						             $("#searchForm").submit();
						             closeDialog();
			  					 }else if(result == "0"){
			  					     alertx("部门内部任务审核'通过'失败!");
			  					     closeDialog();
			  					 }
		                    });
						}
					}, {
						text : "审核不通过",
						handler : function() {
							$.getJSON("${ctx}/jhfj/jhFj/morebmRwSh",{ids:ids,jhIds:jhIds,officeIds:officeIds,grShZt:"2"},function(result){
			  					 if(result == "2"){
			  					 	alertx("部门内部任务审核'不通过'成功!");
			  					      //刷新列表
			                         $("#searchForm").attr("action","${ctx}/jhfj/jhFj/bmshList");
						             $("#searchForm").submit();
						             closeDialog();
			  					 }else if(result == "0"){
			  					     alertx("部门内部任务审核'不通过'失败!");
			  					     closeDialog();
			  					 }
		                    });
						}
					} ]
				});
				$(".panel").css("top", "0px");
				$(".window-shadow").css("top", "0px");
			}
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
        	
        	$("#grShZt").select2("destroy");
        	$("#grShZt").find("option:selected").attr("selected",false);
        	$("#grShZt").select2();
        }
	</script>
</head>
<body>
	<%-- <ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/jhfj/jhFj/rwList/">部门任务分解列表</a></li>
		<shiro:hasPermission name="jhfj:jhFj:edit"><li><a href="#">计划分解添加</a></li></shiro:hasPermission>
	</ul> --%>
	<div id="dialogDiv2"></div>
	<form:form id="searchForm" modelAttribute="jhFj" action="${ctx}/jhfj/jhFj/bmshList/" method="post" class="breadcrumb form-search">
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
						<sys:treeselect id="office" name="office.id" value="${requestScope.jhFj.office.id}" labelName="office.name" labelValue="${requestScope.jhFj.office.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
					</td>
				</tr>
				<tr>
					<th >招生人数</th>
					<td >
					    <form:input path="zsrs" id="zsrs" class="input-medium" htmlEscape="false" maxlength="11" 
					    	 style="width:165px;" />
					</td>
					<th style="text-align: right;">审核状态</th>
					<td>
						<form:select path="grShZt" id="grShZt" class="input-medium" style="width:181px;">
							<form:option value="" label="全部"/>
							<form:options items="${fns:getDictList('jhfjzt')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
				</tr>
				<tr>
					<td colspan="4"  style="text-align: center;">
						<input id="btnSubmit" class="btn btn-primary"  type="submit" value="查询" />
						<input id="btnReset" class="btn btn-primary" type="reset" onclick="resetClick();"  value="重置" />
					</td>
				</tr>
			</table>
	</form:form>
	<div  class="btn-div">
		<input id="btnEdit" class="btn btn-primary" type="button" onclick="piLiangShenHe()" value="审核"/>
	</div>
	<sys:message content="${message}"/>
	<div class="cxjg">查询结果</div>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>
					<input type="checkbox" id="checkboxAll" name="choose" onclick="selAll(this)">
					<input type="hidden" name="ids" value="" />
					<input type="hidden" name="jhIds" value="" />
					<input type="hidden" name="grShZts" value="" />
					<input type="hidden" name="officeids" value="" />
					<input type="hidden" name="name" value="" />
				</th>
				<th>招生计划</th>
				<th>部门名称</th>
				<th>招生人数</th>
				<th>审核状态</th>
				<th>更新时间</th>
				<%-- <shiro:hasPermission name="jhfj:jhFj:edit"><th>任务分解</th></shiro:hasPermission> --%>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="jhFj">
			<tr>
				<td>
			    	<input type="checkbox" id="checkbox" name="choose" value="${jhFj.id}" onclick="selFirst()">
			    	<input type="hidden" name="ids" value="${jhFj.id}" />
			    	<input type="hidden" name="jhIds" value="${jhFj.zsjh.id}" />
			    	<input type="hidden" name="grShZts" value="${jhFj.grShZt}" />
			    	<input type="hidden" name="officeids" value="${jhFj.office.id}" />
			    	<input type="hidden" name="name" value="${jhFj.office.name}" />
			    </td>
				<td>
					${jhFj.zsjh.jhmc}
				</td>
				<td>
					${jhFj.office.name}
				</td>
				<td>
					${jhFj.zsrs}
				</td>
				<td>
					<c:if test="${jhFj.grShZt eq '0'}">
					   <span style="color: #0099CC;">审核中</span>
					</c:if>
					<c:if test="${jhFj.grShZt eq '1'}">
					   <span style="color: #0D73F3;">审核通过</span>
					</c:if>
					<c:if test="${jhFj.grShZt eq '2'}">
					 	<span style="color: #ff0033;">审核不通过</span>
					</c:if>
				</td>
				<td>
					<fmt:formatDate value="${jhFj.updateDate}" pattern="yyyy-MM-dd"/>
				</td>
				<%-- <shiro:hasPermission name="jhfj:jhFj:edit"><td>
    				<a href="${ctx}/jhfj/jhFj/bmRwFjForm?id=${jhFj.id}">分解</a>
    				<a href="javascript:rwfj('${jhFj.id}','${jhFj.fjFlag}');">分解</a>
				</td></shiro:hasPermission> --%>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>