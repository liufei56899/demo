<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>新生报到管理</title>
	<meta name="decorator" content="default"/>
</head>
<body >
	<script type="text/javascript" src="${ctxStatic}/common/jeesite.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#inputForm").validate({
				submitHandler: function(form){
					//验证联系电话规则是否正确
					var isTrue = validateZiDuan();
					if(isTrue)
					{
						loading('正在提交，请稍等...');
						form.submit();
					}
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append"))
					{
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
					
					
				}
			});
			
		});
		
		
		
		
		
		//格式化
		function format(state) 
		{
			return state.text;
		}
		
		
		
		
		
		function validateZiDuan()
		{
			/* var isTrue = phoneOnBlur();
			if(isTrue)
			{
				isTrue = validateSfz();
			} */
			return true;
		}
		
</script>
	<%-- <ul class="nav nav-tabs">
		<li><a href="${ctx}/xsbd/bdJbxx/">新生报到列表</a></li>
		<li class="active"><a href="${ctx}/xsbd/bdJbxx/form?id=${bdJbxx.id}">新生报到<shiro:hasPermission name="xsbd:bdJbxx:edit">${not empty bdJbxx.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="xsbd:bdJbxx:edit">查看</shiro:lacksPermission></a></li>
	</ul> --%><br/>

	<div>
	<!-- <div style="padding-left: 63px;"><input type="button" onclick="$('#zx').css('display','')" 
		value="信息读取"/></div> -->
	<form:form id="inputForm" modelAttribute="bdJbxx" action="${ctx}/xsbd/bdJbxx/save" method="post" enctype="multipart/form-data" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		
		
		
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">姓名：</label>
				<div class="controls">${bdJbxx.xm }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">性别：</label>
				<div class="controls">${fns:getDictLabel(bdJbxx.xbm, 'sex', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">身份证件号码：</label>
				<div class="controls">${bdJbxx.sfzjh }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">出生日期：</label>
				<div class="controls"><fmt:formatDate value="${bdJbxx.csrq}" pattern="yyyy-MM-dd"/>
				</div>
			</div>
		</div>
	
		<!-- ========================== -->
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">专业类别：</label>
				<div class="controls" id="zhuanyelxId">${bdJbxx.zyId.lxmc}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">专业名称：</label>
				<div class="controls" id="zhuaYeId">${bdJbxx.zyname}
				</div>
			</div>
		</div>
		<div class="control-group">
		    <div class="lg-form">
				<label class="control-label">联系电话：</label>
				<div class="controls">${bdJbxx.lxdh}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">家庭住址：</label>
				<div class="controls">${bdJbxx.jtzz}
				</div>
			</div>
		</div>
		<div class="form-actions">
			<%-- <shiro:hasPermission name="xsbd:bdJbxx:edit">
			<input id="btnSubmit" class="btn btn-primary" style="margin-left: 300px;" 
				type="submit" value="保 存"/>&nbsp;</shiro:hasPermission> --%>
			<input id="btnCancel" class="btn" type="button" value="关闭" onclick="closeDialog();"/>
		</div>
	</form:form>
	</div>

</body>
</html>