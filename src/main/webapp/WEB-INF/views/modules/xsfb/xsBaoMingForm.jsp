<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学生信息管理</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/base_index.jsp"%>
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
<body>
	
	<form:form id="inputForm" modelAttribute="xsJbxx" action="${ctx}/xs/xsJbxx/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">姓名：</label>
				<div class="controls">
					${xsJbxx.xm }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label labWidth" style ="width:130px;" >性别：</label>
				<div class="controls" style="margin-left:148px;">
					${fns:getDictLabel(xsJbxx.xbm, 'sex', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">出生日期：</label>
				<div class="controls">
					${fns:getDate(xsJbxx.csrq)}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label labWidth"  style ="width:130px;">身份证件号码：</label>
				<div class="controls" style="margin-left:148px;">
					${xsJbxx.sfzjh }
				</div>
			</div>
		</div>
 		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">专业类别：</label>
				<div class="controls">${xsJbxx.zylxId.lxmc}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label labWidth" style="width:130px;">专业名称：</label>
				<div class="controls" id="zhuaYeId"  style="margin-left:148px;">
					${xsJbxx.zyId.zymc}
				</div>
			</div>
		</div>
		
		<div class="form-actions">
			<input id="btnCancel" class="btn" style="text-align: center;" 
				type="button" value="关闭" onclick="closeDialog();"/>
		</div>
	</form:form>
</body>
</html>