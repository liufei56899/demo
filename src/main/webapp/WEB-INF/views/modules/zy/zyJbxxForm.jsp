<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>专业管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<div id="tt" class="easyui-tabs" style="width:1080px;height:480px;">
	    <div title="目录内专业" style="padding:20px; overflow: hidden;" data-options="href:'${ctx}/zy/zyJbxx/zyJbxxINForm'" >
	        
	    </div>
	    <div title="目录外专业" data-options="href:'${ctx}/zy/zyJbxx/zyJbxxOUTForm'" >
	        
	    </div>
	</div>
</body>
</html>