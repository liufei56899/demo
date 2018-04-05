<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>年级信息管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					var istrue = btnSub();
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
		
		function btnSub()
		{
			var istrue = nfguize();
			if(istrue)
			{
				istrue = validateNf();
			}
			return istrue;
		}
		
		//验证年份规则
		function nfguize()
		{
			var istrue = true;
			var nf = $("#nf1").val();
			if(nf!=null && nf!="")
			{
				 var istrue1 = /^(19|20)\d{2}$/.test(nf);
				 if(!istrue1)
				 {
				 	validTxt("nf1","请输入正确的入学年份");
				 	istrue = false;
				 }
			}
			return istrue;
		}
		
		function validateNf()
		{
			var nf = $("#nf1").val();
			var id ="${xnJbxx.id}";
			var isTrue = true;
			if(nf!=null && nf!="")
			{
				jQuery.ajax({
			        type: "POST",
			        url: "${ctx}/xjxx/xnJbxx/validNf",
			        data: {nf:nf,id:id},
			        dataType:'json',
			        async:false,
					success: function(result){
						isTrue = result.isTrue;
						if(!isTrue)
						{
							validTxt("nf1","入学年份不能重复");
							return false;
						}
				   }
			    });
			}
			return isTrue;
		}
		
		
	</script>
	<%-- <ul class="nav nav-tabs">
		<li><a href="${ctx}/xjxx/xnJbxx/">年级信息列表</a></li>
		<li class="active"><a href="${ctx}/xjxx/xnJbxx/form?id=${xnJbxx.id}">年级信息<shiro:hasPermission name="xjxx:xnJbxx:edit">${not empty xnJbxx.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="xjxx:xnJbxx:edit">查看</shiro:lacksPermission></a></li>
	</ul> --%><br/>
	<form:form id="inputForm" modelAttribute="xnJbxx" action="${ctx}/xjxx/xnJbxx/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">入学年份：</label>
			<div class="controls">
				<form:input path="nf" id="nf1" htmlEscape="false" maxlength="20" class="input-xlarge required "/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="xjxx:xnJbxx:edit">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="关闭" onclick="closeDialog();"/>
		</div>
	</form:form>
</body>
</html>