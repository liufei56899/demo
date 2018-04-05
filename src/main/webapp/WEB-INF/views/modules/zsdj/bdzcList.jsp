<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>报到注册中心</title>
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
        	$("#zyZymc").attr("value",''); 
        	$("#zsdjzt").select2("destroy");
        	$("#zsdjzt").find("option:selected").attr("selected",false);
        	$("#zsdjzt").select2();
        }
	</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="zsdj" action="${ctx}/zsdj/zsdj/bdzcList" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<div class="cxtj">查询条件</div>
			<table class="ul-form">
				<tr>
					<th style="width:200px;">学生姓名</th>
					<td style="width:300px;">
						<form:input path="xm" id="xm" htmlEscape="false" maxlength="64" class="input-medium"/>
					</td>
					<th style="width:200px;">身份证件号码</th>
					<td style="width:300px;">
						<form:input path="sfzjh" id="sfzjh" htmlEscape="false" maxlength="64" class="input-medium"/>
					</td>
				
				</tr>
				<tr>
					<th>专业名称</th>
					<td  id="zyByLx">
						<form:input path="zy.zymc" id="zyZymc" htmlEscape="false" maxlength="64" class="input-medium"/>
					</td>
					<th>报到状态
					</th>
					<td>
						<form:select path="zsdjzt" id="zsdjzt" class="input-medium" style="width:195px;">
							<form:option value="" label="全部"/>
							<form:options items="${fns:getDictList('zsdjzt')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
	
	<div class="btn-div">
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
				<th>计划名称</th>
				<th>招生部门</th>
				<th>招生老师</th>
				<th>年级</th>
				<th>招生季节</th>
				<th>学生姓名</th>				
				<th>身份证件号码</th>
				<th>专业名称</th>
				<th>联系电话</th>
				<th>招生类型</th>
				<th>报到状态</th>
				<%-- <shiro:hasPermission name="zsdj:zsdj:edit"><th>操作</th></shiro:hasPermission> --%>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="zsdj">
			<tr>
				<td>
			    	<input type="checkbox" id="checkbox" name="choose" value="${zsdj.id}" onclick="selFirst()">
			    	<input type="hidden" name="ids" value="${zsdj.id}" />
			    </td>
				<td>
					${zsdj.zsjh.jhmc}
				</td>
				<td>
					${zsdj.office.name}
				</td>
				<td>
					${zsdj.name}
				</td>
				<td>
					${zsdj.nj.nf}
				</td>
				<td>
					${zsdj.xnxq.xnmc}
				</td>
				<td>
					${zsdj.xm}
				</td>
				<td>
					${zsdj.sfzjh}
				</td>
				<td>
					${zsdj.zy.zymc}(${zsdj.xz})
				</td>
				<td>
					${zsdj.lxdh}
				</td>
				<td>
					<c:if test="${zsdj.ly =='1' || zsdj.ly eq '1'}">
					        校招+招生老师
					</c:if>
					<c:if test="${zsdj.ly =='2' || zsdj.ly eq '2'}">
					       网上招生
					</c:if>
					<c:if test="${zsdj.ly =='3' || zsdj.ly eq '3'}">
					        现场报道
					</c:if>
					<c:if test="${zsdj.ly =='4' || zsdj.ly eq '4'}">
					       代理机构招生
					</c:if>
				</td>
				<td>
					${zsdj.remarks}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<script type="text/javascript" src="${ctxStatic}/validMes/validMes.js"></script>
</body>
</html>