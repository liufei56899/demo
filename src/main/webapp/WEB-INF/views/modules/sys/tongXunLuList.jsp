<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>通讯录</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/base_index.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			/* $("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出用户数据吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctx}/sys/user/export");
						$("#searchForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
			$("#btnImport").click(function(){
				$.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true}, 
					bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
			}); */
		});
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctx}/sys/user/tongXunLuList");
			$("#searchForm").submit();
	    	return false;
	    }
	    
        
        
        function searchUser(id){
        	openDialog("${ctx}/sys/user/form?id="+id,"修改用户",980,520);
        }
        
        function deleteUser(){
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
				confirmx('确认要删除该用户吗？', "${ctx}/sys/user/deletes?ids="+ids);
			}
        }
        
        
        //重置
        function resetClick()
        {
        	$("#name1").attr("value","");
        }
        
	</script>
</head>
<body>
	<%-- <div id="importBox" class="hide">
		<form id="importForm" action="${ctx}/sys/user/import" method="post" enctype="multipart/form-data"
			class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
			<input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　　
			<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
			<a href="${ctx}/sys/user/import/template">下载模板</a>
		</form>
	</div> --%>
	<form:form id="searchForm" modelAttribute="user" action="${ctx}/sys/user/tongXunLuList" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<div class="cxtj">查询条件</div>
		<table class="ul-form">
			<tr>
				<th>姓名</th>
				<td><form:input path="name" id="name1" htmlEscape="false" maxlength="50" class="input-medium"/></td>
			</tr>
			<tr>
				<td colspan="4"  style="text-align: center;">
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
					<input id="btnReset" class="btn btn-primary" type="reset" onclick="resetClick();"  value="重置" />
					<!-- <input id="btnExport" class="btn btn-primary" type="button" value="导出"/>
					<input id="btnImport" class="btn btn-primary" type="button" value="导入"/> -->
				</td>
			</tr>
		</table>
	</form:form>
	<div  class="btn-div">
		<!-- <input id="btnAdd" class="btn btn-primary" type="button" onclick="addUser()" value="增加"/>
		<input id="btnEdit" class="btn btn-primary" type="button" onclick="editUser()" value="修改"/>
		<input id="btnDel" class="btn btn-primary" type="button" onclick="deleteUser()" value="删除"/> -->
	</div>
	<sys:message content="${message}"/>
	<div class="cxjg">查询结果</div>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><!-- <th>归属公司</th> -->
			<!-- <th>
				<input type="checkbox" id="checkboxAll" name="choose" onclick="selAll(this)">
				<input type="hidden" name="ids" value="" />
			</th> -->
		    <!-- <th>账号</th> -->
		    <th>姓名</th>
			<!-- <th>部门</th>
			<th>职位</th>
			<th>角色</th> -->
			<th>电话</th>
		<tbody>
		<c:forEach items="${page.list}" var="user">
			<tr>
				<%-- <td>${user.loginName}</td> --%>
				<td>${user.name}</td>
				<%-- <td>${user.office.name}</td>
				<td>${user.gwzym}</td>
				<td>
				<c:forEach items="${user.roleList}" var="items">
				   [${items.name}]
				</c:forEach>
				</td>		 --%>
				<td>${user.mobile}
					<c:if test="${not empty user.phone }">
						/${user.phone}
					</c:if>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>