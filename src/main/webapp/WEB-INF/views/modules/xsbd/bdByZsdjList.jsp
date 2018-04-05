<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>招生登记管理</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/base_index.jsp" %>
	<style type="text/css">
		.form-horizontal .control-label 
		{
			width:130px;
		}
		.form-horizontal .controls
		{
			margin-left: 150px;
		}
		.tabTreeselect{
			width:125px;
		}
		body{
			padding: 0px;
		}
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
		   
		});
		
		function format(state) 
		{
			return state.text;
		}
		
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		
		//重置
		function resetClick()
        {
        	$("#xm").attr("value",'');
        	$("#sfzjh").attr("value",'');
        	$("#zymc").attr("value","");
        	$("#start").attr("value","");
        	$("#end").attr("value","");
        	$("#zsdjzt").select2("destroy");
        	$("#zsdjzt").find("option:selected").attr("selected",false);
        	$("#zsdjzt").select2();
        }		
		//点击行显示详细信息
		function showZsdjInfoForm(zsdj_id){
			openDialog("${ctx}/zsdj/zsdj/zsdjInfoForm?id="+zsdj_id,"查看报到注册信息",1100,480);
		}
		//修改招生登记状态
		function changzsdjzt(zsdj_id){
		confirmx('确认要修改报道状态吗？', "${ctx}/zsdj/zsdj/savezsdezt?id="+zsdj_id);
		}
		
		//导出
		function daoChuClick()
		{
			openDialog("${ctx}/zsdj/zsdj/bdzcExport","导出报到注册信息",700,340);
		}
			//拍照
		function getImage(id){
		openDialog("${ctx}/zsdj/zsdj/getImage?id="+id, "学籍照片拍照", 1200, 600);
		}
	</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="zsdj" action="${ctx}/zsdj/zsdj/listByXsbd" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<div class="cxtj">查询条件</div>
			<input type="hidden" name="checkType" id="checkType"/>
			<table class="ul-form">
				<tr>
					<th >学生姓名</th>
					<td >
						<form:input path="xm" id="xm" htmlEscape="false" maxlength="64" class="input-medium"/>
					</td>
					<th >性别</th>
					<td >
					    <form:select path="xbm" id="xbm" class="input-medium" style="width:175px;">
							<form:option value="" label="全部"/>
							<form:options items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
					</tr>
				<tr>
					<th >联系电话</th>
					<td >
						<form:input path="lxdh" id="lxdh" htmlEscape="false" maxlength="64" class="input-medium"/>
					</td>
					<th>报到状态</th>
					<td>
						<form:select path="zsdjzt" id="zsdjzt" class="input-medium" style="width:195px;">
							<form:option value="" label="全部"/>
							<form:option value="1" label="预报到"/>
							<form:option value="2" label="已报到"/>
						</form:select>
					</td>
				</tr>
				
				
				<tr>
					<td colspan="4"  style="text-align: center;">
						<input id="btnSubmit" class="btn btn-primary"  type="submit" value="查询" />
						<input id="btnReset" class="btn btn-primary" type="reset" onclick="resetClick();"  value="重置" />
						
					<!-- 	<input id="daoChuBut" class="btn btn-primary"  type="button" onclick="daoChuClick();" value="导出" /> -->
					</td>
				</tr>
			</table>
		
	</form:form>
	
	<sys:message content="${message}"/>
	<!-- <div class="cxjg">查询结果</div> -->
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>学生姓名</th>	
				<th>性别</th>			
				<th>身份证件号码</th>
				<th>专业类别</th>
				<th>专业名称</th>
				<th>出生日期</th>
				<th>家庭住址</th>
				<th>联系电话</th>
				<th>报到状态</th>
				<!-- <th>创建时间</th> -->
				<%-- <shiro:hasPermission name="zsdj:zsdj:edit"><th>操作</th></shiro:hasPermission> --%>
				<!-- <th>操作</th> -->
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="zsdj">
			<tr>
				<td>
					<a href="javascript:void(0);"  onClick="showZsdjInfoForm('${zsdj.id}')">${zsdj.xm}</a>
				</td>
				<td>
					${fns:getDictLabel(zsdj.xbm, 'sex', '')}
				</td>
				<td>
					${zsdj.sfzjh}
				</td>
				<td>
					${zsdj.zylx.lxmc}
				</td>
				<td>
					${zsdj.zy.zymc}
				</td>
				<td>
					<fmt:formatDate value="${zsdj.csrq}" pattern="yyyy-MM-dd"/>
				</td>
				<td title="${zsdj.jtzz }">
					${fns:abbr(zsdj.jtzz,15)}
				</td>
				<td>
					${zsdj.lxdh}
				</td>
				<td>
					<c:if test="${zsdj.zsdjzt eq '1' }">
					<a href="javascript:void(0);"  onClick="changzsdjzt('${zsdj.id}')"><span style="color:#FF69B4;">预报到</span></a>
					</c:if>
					<c:if test="${zsdj.zsdjzt eq '2' }">
					<span style="color: #0D73F3;">已报到</span>
					</c:if>
					<c:if test="${zsdj.zsdjzt eq '3' }">
					<span style="color: #0D73F3;">已分班</span>
					</c:if>
				</td>
				<%-- <td>
					<fmt:formatDate value="${zsdj.createDate}" pattern="yyyy-MM-dd"/>
				</td> --%>
				<%-- <td>
				<a href="javaScript:void(0);" onclick="getImage('${zsdj.id}');">拍照</a>
				</td> --%>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<script type="text/javascript" src="${ctxStatic}/validMes/validMes.js"></script>
</body>
</html>