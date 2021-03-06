<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学校信息管理</title>
	<meta name="decorator" content="default"/>
	
</head>
<body>
<style type="text/css">
		.lg-form-all
		{
			width: 100%;
		}
		
	</style>
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
			});
		});
	</script>
	<%-- <ul class="nav nav-tabs">
		<li><a href="${ctx}/school/schoolinfo/list">学校信息列表</a></li>
		<li class="active"><a href="${ctx}/school/schoolinfo/form?id=${schoolinfo.id}">学校信息<shiro:hasPermission name="school:schoolinfo:edit">${not empty schoolinfo.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="school:schoolinfo:edit">查看</shiro:lacksPermission></a></li>
	</ul> --%><br/>
	<form:form id="inputForm" modelAttribute="schoolinfo" action="${ctx}/school/schoolinfo/save1" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">学校代码：</label>
				<div class="controls">
					<form:input path="xxdm" htmlEscape="false" maxlength="64" class="input-xlarge "/>
				</div>
			</div>
			<div class="lg-form">
			<label class="control-label">学校名称：</label>
			<div class="controls">
				<form:input path="xxmc" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		</div>
		
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">学校英文名称：</label>
				<div class="controls">
					<form:input path="xxywmc" htmlEscape="false" maxlength="64" class="input-xlarge "/>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">学校地址：</label>
				<div class="controls">
					<form:input path="xxdz" htmlEscape="false" maxlength="255" class="input-xlarge "/>
				</div>
			</div>
		</div>
		
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">学校邮政编码：</label>
				<div class="controls">
					<form:input path="xxyzbm" htmlEscape="false" maxlength="6" class="input-xlarge "/>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">行政区划码：</label>
				<div class="controls">
					<form:input path="xzqhm" htmlEscape="false" maxlength="12" class="input-xlarge "/>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form-all">
				<label class="control-label">学校用户编码：</label>
				<div class="controls">
					<form:input path="xxyhbm" htmlEscape="false" class="input-xlarge "/>
					<span style="color: red">*该编码为用户账号编码规则，建议不宜过长</span>
				</div>
			</div>
		</div>
		
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">建校年月：</label>
				<div class="controls">
					<input name="jxny" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
						value="<fmt:formatDate value="${schoolinfo.jxny}" pattern="yyyy-MM"/>"
						onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false});" style="width:200px;"/>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">校长姓名：</label>
				<div class="controls">
					<form:input path="xzxm" htmlEscape="false" maxlength="10" class="input-xlarge "/>
				</div>
			</div>
		</div>
		
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">联系电话：</label>
				<div class="controls">
					<form:input path="lxdh" htmlEscape="false" maxlength="20" class="input-xlarge "/>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">传真电话：</label>
				<div class="controls">
					<form:input path="czdh" htmlEscape="false" maxlength="20" class="input-xlarge "/>
				</div>
			</div>
		</div>
		
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">电子信箱：</label>
				<div class="controls">
					<form:input path="dzxx" htmlEscape="false" maxlength="50" class="input-xlarge "/>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">主页地址：</label>
				<div class="controls">
					<form:input path="zydz" htmlEscape="false" maxlength="255" class="input-xlarge "/>
				</div>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" 
					class="input-xxlarge " style="width:720px;"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="school:schoolinfo:edit">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<!-- <input id="btnBack" class="btn" type="button" value="返 回" onclick="history.go(-1)"/> -->
			<input id="btnCancel" class="btn" type="button" value="关闭" onclick="closeDialog();"/>
		</div>
	</form:form>
</body>
</html>