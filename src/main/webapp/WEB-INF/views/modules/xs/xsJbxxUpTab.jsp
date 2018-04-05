<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学生信息管理</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/base_index.jsp"%>
</head>
<body><!-- data-options="href:''" -->
	<style type="text/css">
	  .tabTreeselect 
	  {
	  	width:226px;
	  }
	  .labWidth 
	  {
	  	 width:230px;
	  }
	</style>
	<div id="tt" class="easyui-tabs" style="width:1260px;height:500px;">
	    <div title="基本信息" style="padding:20px;" data-options="href:'${ctx}/xs/xsJbxx/xsUpdateJiBenForm?id=${id }'" >
	        
	    </div>
	    <div title="成员信息" data-options="href:'${ctx}/xs/xsJbxx/xsUpdateChengYuanForm?id=${id }'" style="overflow:auto;padding:20px;">
	        
	    </div>
	</div>
	<form:form id="inputForm" modelAttribute="xsJbxx" action="${ctx}/xs/xsJbxx/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<div class="form-actions">
			<input id="btnCancel" class="btn" style="text-align: center;" 
				type="button" value="关闭" onclick="closeDialog();"/>
		</div>
	</form:form>
</body>
</html>