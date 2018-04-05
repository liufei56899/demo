<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>通知管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<script type="text/javascript" src="${ctxStatic}/common/jeesite.js"></script>
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
		<li><a href="${ctx}/oa/oaNotify/">通知列表</a></li>
		<li class="active"><a href="${ctx}/oa/oaNotify/form?id=${oaNotify.id}">通知<shiro:hasPermission name="oa:oaNotify:edit">${oaNotify.status eq '1' ? '查看' : not empty oaNotify.id ? '修改' : '添加'}</shiro:hasPermission><shiro:lacksPermission name="oa:oaNotify:edit">查看</shiro:lacksPermission></a></li>
	</ul> --%><br/>
	<form:form id="inputForm" modelAttribute="oaNotify" action="${ctx}/oa/oaNotify/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
			
		<div class="control-group" style="text-align: center;">
				<font style="font-size: 16px;font-weight: bold;" >${fns:abbr(oaNotify.title,50)}</font>
		</div>
		
		
		<div class="control-group" style="color:#777;">
			<center>发布人：${oaNotify.createBy.name }&nbsp;&nbsp;&nbsp; 发布时间：
			<fmt:formatDate value="${oaNotify.createDate}" pattern="yyyy-MM-dd" /> </center>
		</div>
		
		<div id="oaContent"  class="control-group">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<c:if test="${not empty oaNotify.content }">
				${fns:abbr(oaNotify.content,600)}
			</c:if>
			
			<c:if test="${ empty oaNotify.content }">
				暂无内容
			</c:if>
		</div>
		<%-- <div  class="control-group">
			附件：<c:if test="${not empty oaNotify.files }">
						<a href="${ctx }/oa/oaNotify/xiaZaiFuJian?id=${oaNotify.id}">下载附件</a>
					</c:if>
					<c:if test="${empty oaNotify.files }">
						未上传附件
					</c:if>
		</div> --%>
		
		<%-- <div class="control-group">
			<label class="control-label">类型：</label>
			<div class="controls">
				${fns:getDictLabel(oaNotify.type, 'oa_notify_type', '')}
			</div>
		</div>	
		<div class="control-group">
			<label class="control-label">标题：</label>
			<div class="controls">
				${fns:abbr(oaNotify.title,50)}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">内容：</label>
			<div class="controls">
				${fns:abbr(oaNotify.content,300)}
			</div>
		</div>
		<div class="control-group">
				<label class="control-label">附件：</label>
				<div class="controls">
					<c:if test="${not empty oaNotify.files }">
						<a href="${ctx }/oa/oaNotify/xiaZaiFuJian?id=${oaNotify.id}">下载附件</a>
					</c:if>
					<c:if test="${empty oaNotify.files }">
						未上传附件
					</c:if>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">状态：</label>
				<div class="controls">
					${fns:getDictLabel(oaNotify.status, 'oa_notify_status', '')}
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">接受人：</label>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th>接受人</th>
								<th>接受部门</th>
								<th>阅读状态</th>
								<th>阅读时间</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${oaNotify.oaNotifyRecordList}" var="oaNotifyRecord">
							<tr>
								<td>
									${oaNotifyRecord.user.name}
								</td>
								<td>
									${oaNotifyRecord.user.office.name}
								</td>
								<td>
									${fns:getDictLabel(oaNotifyRecord.readFlag, 'oa_notify_read', '')}
								</td>
								<td>
									<fmt:formatDate value="${oaNotifyRecord.readDate}" pattern="yyyy-MM-dd"/>
								</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
					已查阅：${oaNotify.readNum} &nbsp; 未查阅：${oaNotify.unReadNum} &nbsp; 总共：${oaNotify.readNum + oaNotify.unReadNum}
				</div>
			</div> --%>
			
		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="关闭" onclick="closeDialog();"/>
		</div>
	</form:form>
</body>
</html>