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
	<script language="javascript" src="${ctxStatic}/Lodop6.218_CLodop2.130/LodopFuncs.js"></script>
	<script type="text/javascript">
		var LODOP;
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
        	$("#bj").attr("value",'');
        }		
		//点击行显示详细信息
		function showZsdjInfoForm(zsdj_id){
			openDialog("${ctx}/zsdj/zsdj/zsdjInfoForm?id="+zsdj_id,"查看报到注册信息",1100,480);
		}
		
		
		//导出
		function daoChuClick()
		{
			openDialog("${ctx}/zsdj/zsdj/IdCardExport","导出报到注册信息",700,340);
		}		
		//点击行显示详细信息
		function updateInfo(zsdj_id){
			openDialog("${ctx}/zsdj/zsdj/updateInfo?id="+zsdj_id,"修改学生信息",1100,480);
		}
					//拍照
		function getImage(id){
		openDialog("${ctx}/zsdj/zsdj/getImage?id="+id, "学籍照片拍照", 1200, 600);
		}
	</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="zsdj" action="${ctx}/zsdj/zsdj/listByXsbd3" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<div class="cxtj">查询条件</div>
			<input type="hidden" name="checkType" id="checkType"/>
			<table class="ul-form">
				<tr>
					<th style="width:200px;">学生姓名</th>
					<td style="width:300px;">
						<form:input path="xm" id="xm" htmlEscape="false" maxlength="64" class="input-medium"/>
					</td>
					
					<th style="width:200px;">身份证件号码</th>
					<td style="width:300px;">
						<form:input path="sfzjh" id="sfzjh" htmlEscape="false" 
							maxlength="64" class="input-medium" style="width:180px;"/>
					</td>
				</tr>
				<tr>
					<th style="width:200px;">班级</th>
					<td style="width:300px;">
						<form:input path="bj" id="bj" htmlEscape="false" maxlength="64" class="input-medium"/>
					</td>
					
					<td style="width:200px;"></td>
					<td style="width:300px;">
				
					</td>
				</tr>
				
				<tr>
					<td colspan="4"  style="text-align: center;">
						<input id="btnSubmit" class="btn btn-primary"  type="submit" value="查询" />
						<input id="btnReset" class="btn btn-primary" type="reset" onclick="resetClick();"  value="重置" />
						
						<input id="daoChuBut" class="btn btn-primary"  type="button" onclick="daoChuClick();" value="导出" />
					</td>
				</tr>
			</table>
		
	</form:form>
	<sys:message content="${message}"/>
	<div class="cxjg">查询结果</div>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>
					<input type="checkbox" id="checkboxAll" name="choose" onclick="selAll(this)">
					<input type="hidden" name="ids" value="" />
					<input type="hidden" name="shzts" value="" />
				</th>
				<th>学生姓名</th>	
				<th>班级</th>	
				<th>性别</th>			
				<th>身份证件号码</th>
				<th>出生日期</th>
				<th>民族</th>
				<th>家庭住址</th>
				<th>操作</th>
				<%-- <shiro:hasPermission name="zsdj:zsdj:edit"><th>操作</th></shiro:hasPermission> --%>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="zsdj">
			<tr>
				<td >
			    	<input type="checkbox" id="checkbox" name="choose" value="${zsdj.id}" onclick="selFirst()">
			    	<input type="hidden" name="ids" value="${zsdj.id}" />
			    	<input type="hidden" name="shzts" value="${zsdj.zsdjzt}" />
			    </td>
				<td>
					<a href="javascript:void(0);"  onClick="updateInfo('${zsdj.id}')">${zsdj.xm}</a>
				</td>
				
				<td>
					${zsdj.bj}
				</td>
				<td>
					${fns:getDictLabel(zsdj.xbm, 'sex', '')}
				</td>
				<td>
					${zsdj.sfzjh}
				</td>
				<td>
					<fmt:formatDate value="${zsdj.csrq}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					${fns:getDictLabel(zsdj.nation, 'nation', '')}
				</td>
				<td title="${zsdj.jtzz }">
					${fns:abbr(zsdj.jtzz,15)}
				</td>
				<td>
				<a href="javaScript:void(0);" onclick="getImage('${zsdj.id}');">拍照</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<script type="text/javascript" src="${ctxStatic}/validMes/validMes.js"></script>
</body>
</html>