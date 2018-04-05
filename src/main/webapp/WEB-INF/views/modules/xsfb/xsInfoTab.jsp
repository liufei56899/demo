<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学生信息管理</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/base_index.jsp"%>
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
	<script type="text/javascript">
		
		function openNewDialog(href, title, width, height) {
		var length = $("div#dialogDiv").size();
		if (length == 0) {
			$("#inputForm").before(
					"<div id='dialogDiv' style='width:820px;'></div>");
		}
		$('#dialogDiv').dialog({
			title : title,
			width : width,
			height : height,
			closed : false,
			cache : false,
			href : href,
			modal : true
		});
	
		$(".panel").css("top", "0px");
		$(".window-shadow").css("top", "0px");
	}

	function openHistoryRecord(value) {//formXsJbxxHistory
		openNewDialog("${ctx}/xs/xsJbxx/formXsJbxxHistory?id=" + value,"历史记录查看", 1200, 650);
	}
	</script>
</head>
<body><!-- data-options="href:''" -->
	<div id="tt" class="easyui-tabs" style="width:850px;height:500px;">
	    <div title="基本信息" style="padding:20px;" data-options="href:'${ctx}/xsfb/xsfb/getXueShengInfo?id=${id }'" >
	        
	    </div>
	    <div title="成员信息" data-options="href:'${ctx}/xsfb/xsfb/getChengYuanInfo?id=${id }'" style="overflow:auto;padding:20px;">
	        
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