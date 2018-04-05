<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>计划分解个人管理</title>
	<meta name="decorator" content="default"/>
	
</head>
<body>
<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});//如果是点击修改进入页面，则加载信息
			if("${jhFjGr.zsjh.id}" != ""){
				//绘制n行三列的表格
				var tableStr = "";
				tableStr += "<table class='table table-striped table-bordered table-condensed'>";
				tableStr += "<tr>";
				tableStr += "<td>教师姓名</td>";
				tableStr += "<td>招生人数</td>";
				tableStr += "<td>划分区域</td>";
				tableStr += "</tr>";
				tableStr += "<tr>";
				tableStr += "<td>${jhFjGr.jsmc}</td>";
				tableStr += "<td>${jhFjGr.zsrs}</td>";
				tableStr += "<td>${innerTable}</td>";
				tableStr += "</tr>";
				tableStr += "</table>";
				$("#officeTable").html(tableStr);
				
			}
		});
	</script>
	<%-- <ul class="nav nav-tabs">
		<li><a href="${ctx}/jhfjgr/jhFjGr/rwList/">个人任务列表</a></li>
		<li class="active"><a>个人任务详情<shiro:lacksPermission name="jhfjgr:jhFjGr:edit">查看</shiro:lacksPermission></a></li>
	</ul> --%><br/>
	<form:form id="inputForm" modelAttribute="jhFjGr" action="${ctx}/jhfjgr/jhFjGr/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group" > 
			<label class="control-label" style="font-weight: bold;">招生计划：</label>
			<label style="font-weight: bold;padding-top: 3px;">${jhFjGr.zsjh.jhmc}</label>
		</div>
		
		<div id="officeTable"></div>
		
		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="关闭" onclick="closeDialog();"/>
		</div>
	</form:form>
</body>
</html>