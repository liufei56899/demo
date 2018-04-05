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
	<div id="tt" class="easyui-tabs" style="width:1200px;height:400px;">
	    <div title="学籍拍照" style="padding:20px;" 
	    data-options="href:'${ctx}/zsdj/zsdj/getPic?id=${id }'" >
	        
	    </div>
	</div>
	<form:form id="inputForm" modelAttribute="zsdj" action="${ctx}/zsdj/zsdj/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<div class="form-actions">
			<input id="btnCancel" class="btn" style="text-align: center;" 
				type="button" value="关闭" onclick="closeDialog();"/>
		</div>
	</form:form>
</body>
</html>