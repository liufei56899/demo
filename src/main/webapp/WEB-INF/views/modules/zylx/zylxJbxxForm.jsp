<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>专业类别管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<style type="text/css">
		.form-horizontal .control-label
		{
			width:130px;
		}
		.form-horizontal .controls
		{
			margin-left:140px;
		}
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					var istrue = validateLxmc();
					if(istrue)
					{
						loading('正在提交，请稍等...');
						form.submit();
					}
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
		
		function validateLxmc()
		{
			var lxmc = $("#lxmc1").val();
			var isTrue = true;
			var id ="${zylxJbxx.id}";
			if(lxmc!=null && lxmc !="")
			{
				jQuery.ajax({
			        type: "POST",
			        url: "${ctx}/zylx/zylxJbxx/getZhuanYeMingCheng",
			        data: {lxmc:lxmc,id:id},
			        dataType:'json',
			        async:false,
					success: function(result){
						isTrue = result.isTrue;
						if(!isTrue)
						{
							validTxt("lxmc1","类型名称不能重复");
							return false;
						}
				   }
			    });
			}
			return isTrue;
		}
		
	</script>
	<%-- <ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/zylx/zylxJbxx/form?id=${zylxJbxx.id}">专业类别<shiro:hasPermission name="zylx:zylxJbxx:edit">${not empty zylxJbxx.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="zylx:zylxJbxx:edit">查看</shiro:lacksPermission></a></li>
	</ul> --%>
	<br/>
	<form:form id="inputForm" modelAttribute="zylxJbxx" action="${ctx}/zylx/zylxJbxx/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">类型名称：</label>
			<div class="controls">
				<form:input path="lxmc" id="lxmc1" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">类型描述：</label>
			<div class="controls">
				<form:input path="lxms" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "
					style="width:200px;"/>
			</div>
		</div>
		<div class="form-actions" style="height:25px;">
			<shiro:hasPermission name="zylx:zylxJbxx:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="关闭" onclick="closeDialog();"/>
		</div>
	</form:form>
</body>
</html>