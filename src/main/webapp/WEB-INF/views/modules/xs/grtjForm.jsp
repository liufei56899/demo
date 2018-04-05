<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>招生统计</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript" src="${ctxStatic}/main/main.js"></script>
	<script type="text/javascript" src="${ctxStatic}/main/mainHighchartsGR.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function SearchGrtj(){
		      var zsjhid = $("#selector").val();
		      var id = $("#primaryPersonId").val();
		      var name = $("#primaryPersonName").val();
		      $.getJSON("${ctx}/xs/xsJbxx/zstjGrList",{jsid:id,jhid:zsjhid}, function(data){
		          viewZstjInfo(data);//招生统计/个人
	          });
		}
		
	</script>
</head>
<body>
	<%-- <ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/xs/xsJbxx/lytjForm/">各专业来源情况统计</a></li>
	</ul> --%>
	<form:form id="searchForm1" modelAttribute="zsdj" action="${ctx}/xs/xsJbxx/grtjForm/" method="post" class="breadcrumb form-search">
	<div class="cxtj">统计条件</div>
		<table class="ul-form">
		   <tr>
			<th style="width:200px;">教师</th>
	     	<td style="width:300px;">
				<sys:treeselect id="primaryPerson" name="bjmc.jsId" value="${requestScope.xsJbxx.bjmc.jsId.id}" 
			                labelName="bjmc.jsId.name" labelValue="${requestScope.xsJbxx.bjmc.jsId.name}"
				            title="用户" url="/sys/office/newTreeData?type=3"  
				            cssClass="tabTreeselect"  allowClear="true" notAllowSelectParent="true" />
		   </td>
	       <th style="width:200px;">招生计划</th>
		   <td style="width:300px;">
				<form:select id="selector" path="zsjh.id" maxlength="64" class="input-medium" style="width:175px;">
					<form:option value="" label="" />
					<form:options items="${fns:getZsjhList()}" itemLabel="jhmc"
						itemValue="id" htmlEscape="false" />
				</form:select>
			</td>
		</tr>
		<tr>
			<td class="btns" colspan="4" align="center">
			    <input id="btnSearch" onclick="SearchGrtj();" class="btn btn-primary" type="button" value="查询"/>
			</td>
		</tr>
		</table>
	</form:form>
	<sys:message content="${message}"/>
	<div class="cxjg">统计结果</div>
	<div class="content_style" id="zstjgr_info"></div>
</body>
</html>