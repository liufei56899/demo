<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>考试计划</title>
<meta name="decorator" content="default" />
<%@ include file="/WEB-INF/views/include/base_index.jsp" %>
<style type="text/css">
	  .tabTreeselect 
	  {
	  	width:130px;
	  }
	  body 
	  {
	  	padding: 0px;
	  }
	</style>
<script type="text/javascript">

	$(document).ready(function() {
		$("#searchForm").submit(function(){
			var startTime = $("#stime").val();
			var endTime = $("#etime").val();
			if(startTime > endTime){
				alertx("开始时间不能大于结束时间！");
				return false;
			}
			return true;
		});
	});
	
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		return false;
	}

	function format(state) {
		return state.text;
	}
	
	function add(){
		openDialog("${ctx}/ksjh/ksjh/form","增加考试计划",1280,480);
    }
    
    function editJkr()
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
				   ids = ids.substring(0,ids.length-3);
				   openDialog("${ctx}/ksjh/ksjh/form?id="+ids,"修改考试计划",1280,480);
				}
			}
			else if(count ==0)
			{
				alertx('请选择需要修改的考试计划！');
			}else
			{
				alertx('只能选择一个考试计划进行修改！');
			}
    	
    }
    
    function deleteKc()
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
				alertx('请选择需要删除的考试计划！');
			}else
			{
				if(ids!=null && ids!="")
				{
				   ids = ids.substring(0,ids.length-1);
				   
				 }
				confirmx('确认要删除选中的考试计划吗？', "${ctx}/ksjh/ksjh/delete?ids="+ids);
			}
    }
    
    	// 启用考试计划
       function openKsjh(){
        	var ids ="";       	
        	var count =0;
			$("#contentTable").find("input[type='checkbox']").each(function(){
				if($(this).attr("checked")){
					if($(this).next().val()!=null && $(this).next().val()!="")
					{
						ids += $(this).next().val();
						count++;
					}
				}
			});
			if(count == 1){
				if(ids!=null && ids!=""){			
					var i = ids.indexOf(",");
					var jhzt=ids.substring(i+1,ids.length); 				 									
				   	ids = ids.substring(0,i);
				   	if(jhzt==0){				    	
				   		confirmx('确认要启用该考试计划吗？', "${ctx}/ksjh/ksjh/save?id="+ids+"&jhzt=1"); 
				   	}else{
				   		alertx('该考试计划已经启用！');
				   	}  
				}
			}
			else if(count ==0)
			{
				alertx('请选择需要启用的考试计划！');
			}else
			{
				alertx('只能选择一个考试计划进行启用！');
			}
    	
        }
        
        // 停用考试计划 
        function closeKsjh(){
        	var ids ="";
        	var count =0;
			$("#contentTable").find("input[type='checkbox']").each(function()
			{
				if($(this).attr("checked"))
				{
					if($(this).next().val()!=null && $(this).next().val()!="")
					{
						ids += $(this).next().val();
						count++;
					}
				}
			});
			if(count == 1)
			{
				if(ids!=null && ids!=""){
					var i = ids.indexOf(",");
					var jhzt=ids.substring(i+1,ids.length); 				 									
				   	ids = ids.substring(0,i);
				   	if(jhzt==1){
				   		confirmx('确认要停用该考试计划吗？', "${ctx}/ksjh/ksjh/save?id="+ids+"&jhzt=0");
				   	}else{
				   		alertx('该考试计划已经停用！');
				   	}				  						   
				}
			}
			else if(count ==0)
			{
				alertx('请选择需要停用的考试计划！');
			}else
			{
				alertx('只能选择一个考试计划进行停用！');
			}
    	
        }
	    
	    //重置
		function resetClick()
        {
        	$("#ksjhmc2").attr("value","");
        	$("#stime").attr("value","");
        	$("#etime").attr("value","");
        	
        	$("#jhzt").select2("destroy");
        	$("#jhzt").find("option:selected").attr("selected",false);
        	$("#jhzt").select2();
        	$("#searchForm").submit();
        }
</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="ksjh"
		action="${ctx}/ksjh/ksjh/" method="post"
		class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden"
			value="${page.pageSize}" />
			
			<div class="cxtj">查询条件</div>
			<table class="ul-form">
				<tr>
					<th style="width:200px;">考试计划名称</th>
						<td style="width:300px;">
							<form:input path="ksjhmc" id="ksjhmc2" htmlEscape="false" maxlength="32" class="input-medium"/>
							<%-- <form:select path="kcmc" id="kcmc" class="input-medium">
								<form:option value="" label="全部" />
								<form:options items="${page.list}" itemLabel="kcmc"
									itemValue="id" htmlEscape="false" />
							</form:select> --%>
						</td>
					<th style="width:200px;">计划开始时间</th>
						<td style="width:300px;">
							<input name="stime" id="stime" type="text" readonly="readonly" maxlength="18" class="input-medium Wdate"
						       value="<fmt:formatDate value="${ksjh.stime}" pattern="yyyy-MM-dd"/>" 
						       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" />
						</td>
					<th style="width:200px;">计划结束时间</th>
						<td style="width:100px;">
							<input name="etime" id="etime" type="text" readonly="readonly" maxlength="18" class="input-medium Wdate"
						       value="<fmt:formatDate value="${ksjh.etime}" pattern="yyyy-MM-dd"/>" 
						       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" />
						</td>
					<th style="width:200px;">状态</th>
						<td style="width:100px;">
							<form:select path="jhzt" id="jhzt" class="input-medium">
								<form:option value="" label="--请选择--"/>					
								<form:option value="0" label="停用"/>	
								<form:option value="1" label="启用"/>						
							</form:select>
						</td>
				</tr>
				
				<tr>
				<td colspan="10"  style="text-align: center;">
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" />
					<input id="btnReset" class="btn btn-primary" type="reset" onclick="resetClick();"  value="重置" />
				</td>
				</tr>
			</table>
	</form:form>
	
	<div class="btn-div">
		<input id="btnAdd" class="btn btn-primary" type="button" onclick="add()" value="增加"/>
		<input id="btnEdit" class="btn btn-primary" type="button" onclick="editJkr()" value="修改"/>
		<input id="btnDel" class="btn btn-primary" type="button" onclick="deleteKc()" value="删除"/>
		<input id="btnDel" class="btn btn-primary" type="button" onclick="openKsjh()" value="启用"/>
		<input id="btnDel" class="btn btn-primary" type="button" onclick="closeKsjh()" value="停用"/>
	</div>
	
	<sys:message content="${message}" />
	<div class="cxjg">查询结果</div>
	<table id="contentTable"
		class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>
					<input type="checkbox" id="checkboxAll" name="choose" onclick="selAll(this)">
				</th>
				<th>考试计划名称</th>
				<th>计划开始时间</th>
				<th>计划结束时间</th>
				<th>考场数量</th>
				<th>参与人数</th>
				<th>创建人</th>
				<th>创建时间</th>
				<th>状态</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="ksjh">
				<tr>
					<td>
				    	<input type="checkbox" id="checkbox" name="choose" value="${ksjh.id}" onclick="selFirst()">
				    	<input type="hidden" name="ids" value="${ksjh.id},${ksjh.jhzt}" />
				    </td>
					<td>${ksjh.ksjhmc}</td>
					<td><fmt:formatDate value="${ksjh.stime}"
							pattern="yyyy-MM-dd" /></td>
					<td><fmt:formatDate value="${ksjh.etime}"
							pattern="yyyy-MM-dd" /></td>
					<td>${ksjh.kcsl}</td>
					<td>${ksjh.ckrs}</td>
					<td>${ksjh.createBy.name}</td>
					<td><fmt:formatDate value="${ksjh.createDate}"
							pattern="yyyy-MM-dd" /></td>
					<td>
						<c:if test="${ksjh.jhzt == 0}">停用</c:if>
						<c:if test="${ksjh.jhzt == 1}">启用</c:if>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<script type="text/javascript" src="${ctxStatic}/validMes/validMes.js"></script>
</body>
</html>