<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>考场编号</title>
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

	});
	
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").submit();
		return false;
	}

	function format(state) {
		return state.text;
	}
	
	function add(){
		openDialog("${ctx}/kcbh/kcJbxx/form","考场编号",1280,480);
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
				   ids = ids.substring(0,ids.length-1);
				   openDialog("${ctx}/kcbh/kcJbxx/form?id="+ids,"设置监考人",1280,480);
				}
			}
			else if(count ==0)
			{
				alertx('请选择需要设置的考场！');
			}else
			{
				alertx('只能选择一个考场进行设置！');
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
				alertx('请选择需要删除的考场！');
			}else
			{
				if(ids!=null && ids!="")
				{
				   ids = ids.substring(0,ids.length-1);
				   
				 }
				confirmx('确认要删除考场信息吗？', "${ctx}/kcbh/kcJbxx/delete?ids="+ids);
			}
    }
	    
	    //重置
		function resetClick()
        {
        	$("#kcmc").select2("destroy");
        	$("#kcmc").find("option:selected").attr("selected",false);
        	$("#kcmc").select2();
        	
        	$("#kcdz").attr("value","");
        	$("#xsrs").attr("value","");
        	$("#jkrs").attr("value","");
        	
        	$("#zt").select2("destroy");
        	$("#zt").find("option:selected").attr("selected",false);
        	$("#zt").select2();
        }
</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="kcJbxx"
		action="${ctx}/kcbh/kcJbxx/" method="post"
		class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden"
			value="${page.pageSize}" />
			
			<div class="cxtj">查询条件</div>
			<table class="ul-form">
				<tr>
					<th style="width:200px;">考场名称</th>
						<td style="width:300px;">
							<form:select path="kcmc" id="kcmc" class="input-medium">
								<form:option value="" label="全部" />
								<form:options items="${page.list}" itemLabel="kcmc"
									itemValue="id" htmlEscape="false" />
							</form:select>
						</td>
					<th style="width:200px;">考场地址</th>
						<td style="width:300px;">
							<form:input path="kcdz" id="kcdz" htmlEscape="false" maxlength="64" class="input-medium"/>
						</td>
					<th style="width:200px;">学生人数</th>
						<td style="width:100px;">
							<form:input path="xsrs" id="xsrs" htmlEscape="false" maxlength="32" class="input-medium"/>
						</td>
					<th style="width:200px;">监考人数</th>
						<td style="width:100px;">
							<form:input path="jkrs" id="jkrs" htmlEscape="false" maxlength="32" class="input-medium"/>
						</td>
					<th style="width:200px;">状态</th>
						<td style="width:100px;">
							<form:select path="zt" id="zt" class="input-medium">
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
		<input id="btnAdd" class="btn btn-primary" type="button" onclick="add()" value="编号"/>
		<input id="btnEdit" class="btn btn-primary" type="button" onclick="editJkr()" value="设置监考人"/>
		<input id="btnDel" class="btn btn-primary" type="button" onclick="deleteKc()" value="删除"/>
		<input id="btnDel" class="btn btn-primary" type="button" onclick="print()" value="打印"/>
	</div>
	
	<sys:message content="${message}" />
	<div class="cxjg">查询结果</div>
	<table id="contentTable"
		class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>
					<input type="checkbox" id="checkboxAll" name="choose" onclick="selAll(this)">
					<input type="hidden" name="ids" value="" />
				</th>
				<th>考场名称</th>
				<th>考场地址</th>
				<th>使用次数</th>
				<th>学生人数</th>
				<th>监考人数</th>
				<th>状态</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="kcJbxx">
				<tr>
					<td>
				    	<input type="checkbox" id="checkbox" name="choose" value="${kcJbxx.id}" onclick="selFirst()">
				    	<input type="hidden" name="ids" value="${kcJbxx.id}" />
				    </td>
					<td>${kcJbxx.kcmc}</td>
					<td>${kcJbxx.kcdz}</td>
					<td>${kcJbxx.sycs}</td>			
					<td>${kcJbxx.xsrs}</td>
					<td>${kcJbxx.jkrs}</td>
					<td>
						<c:if test="${kcJbxx.zt == 0}">停用</c:if>
						<c:if test="${kcJbxx.zt == 1}">启用</c:if>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<script type="text/javascript" src="${ctxStatic}/validMes/validMes.js"></script>
</body>
</html>