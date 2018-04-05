<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>专业管理</title>
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
			margin-left: 147px;
		}
		.form-horizontal .lg-form .labWidth
		{
			width:160px;
			padding-right: 15px;
		}
		
		.form-horizontal .lg-form .controls .input-xlarge
		{
			width:180px;
		}
		.form-horizontal .lg-form .controls .select2-container
		{
			width:192px;
		}
		
		
	</style>
<script type="text/javascript" src="${ctxStatic}/common/jeesite.js"></script>

	<form:form id="inputForm" modelAttribute="zyJbxx" action="${ctx}/zy/zyJbxx/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		
		<div class="control-group">
			<c:if test="${zyJbxx.zymlbb!=0}">
				<div class="lg-form">
					<label class="control-label">专业目录版本：</label>
					<div class="controls">
						${zyJbxx.zymlbb}
					</div>
				</div>
			</c:if>
			<div class="lg-form">
				<label class="control-label <c:if test="${zyJbxx.zymlbb!=0}">labWidth</c:if>">专业类别：</label>
				<div class="controls">
					${zyJbxx.zylx.lxmc}
				</div>
			</div>
		</div>
		
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">专业名称：</label>
				<div class="controls" id="zy_Id">
					${zyJbxx.zymc}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label labWidth">专业方向：</label>
				<div class="controls" id="zyfx_Id">
					${zyJbxx.zyfxmc}
				</div>
			</div>
		</div>
		
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">学制：</label>
				<div class="controls">
					${zyJbxx.xzmc}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label labWidth">是否涉农专业：</label>
				<div class="controls">
					${fns:getDictLabel(zyJbxx.sfsnzy, 'sfdm', '')}
				</div>
			</div>
		</div>
		
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">本校专业编号：</label>
				<div class="controls">
					${zyJbxx.bxzybh}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label labWidth">专业简称：</label>
				<div class="controls">
					${zyJbxx.zyjc}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">专业教师数：</label>
				<div class="controls">
					${zyJbxx.zyjss}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label labWidth">总分数：</label>
				<div class="controls">
					${zyJbxx.zyzfs}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">建立年月：</label>
				<div class="controls">
					<fmt:formatDate value="${zyJbxx.jlny}" pattern="yyyy-MM-dd"/>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label labWidth">办学状态：</label>
				<div class="controls">
					${fns:getDictLabel(zyJbxx.bxzt, 'bxzt', '')}
				</div>
			</div>
		</div>
		
		<div class="control-group">
			<div class="lg-form" style="width:788px;">
				<label class="control-label">备注信息：</label>
				<div class="controls">
					${zyJbxx.remarks}
				</div>
			</div>
		</div>
		
		
		
		
		
		
		<div class="form-actions">
			<!-- <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/> -->
			<input id="btnCancel" class="btn" type="button" value="关闭" onclick="closeDialog();"/>
		</div>
	</form:form>
</body>
</html>