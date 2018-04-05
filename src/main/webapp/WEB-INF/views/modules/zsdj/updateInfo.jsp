<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>学生信息查看修改</title>
<meta name="decorator" content="default" />

</head>
<body>
<script type="text/javascript" src="${ctxStatic}/common/jeesite.js"></script>
<script type="text/javascript">
</script>
	<form:form id="" modelAttribute="zsdj" action="${ctx}/zsdj/zsdj/updateXsInfo" method="post" class="form-horizontal">
		<form:hidden path="id" />
		<form:hidden id="bcfs" path="bcfs"/>
		<input type="hidden" name="ly" value="3">
		<label id="tip" style="color: red; "></label>
		<div class="control-group">
		   <div class="lg-form">
		     <label class="control-label">学生姓名：</label>
			<div class="controls">
				<form:input path="xm" htmlEscape="false" maxlength="64" class="input-xlarge required" style="width:170px;"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		   </div>
		   <div class="lg-form">
					<label class="control-label">班级：</label>
				<div class="controls">
				<form:input path="bj" htmlEscape="false" maxlength="255" class="input-xlarge" style="width:170px;" />
				</div>
			</div>
		</div>
		<div class="control-group">
		    <div class="lg-form">
			<label class="control-label">性别：</label>
			<div class="controls">
				<form:select  path="xbm" class="input-xlarge required" style="width:184px;">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
			</div>
			<div class="lg-form">
				<label class="control-label">民族：</label>
				<div class="controls">
					<form:select  path="nation" class="input-xlarge  required" style="width:184px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('nation')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>	
			</div>
			
		</div>
		<div class="control-group">
			<div class="lg-form">
				 <label class="control-label">身份证件号码：</label>
				<div class="controls">
					<form:input id="sfzjh" path="sfzjh" htmlEscape="false" maxlength="18" 
						        class="input-xlarge required" style="width:170px;"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			 </div>
			 <div class="lg-form">
					<label class="control-label">出生日期：</label>
					<div class="controls">
						<input  name="csrq" type="text"  id="csrq"  maxlength="20" class="input-medium Wdate required" readonly="readonly"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'${nowDate}',isShowClear:false});" value="<fmt:formatDate value="${zsdj.csrq}" pattern="yyyy-MM-dd"/>"
						style ="width:170px;"/>
					<span class="help-inline"><font color="red">*</font> </span>
					</div>
			</div>
		</div>
		
		<div class="control-group">
				<label class="control-label">家庭住址：</label>
				<div class="controls">
				<form:input path="jtzz" htmlEscape="false" maxlength="255" class="input-xlarge required" style="width:350px;" />
				<span class="help-inline"><font color="red">*</font> </span>
				</div>
		
		</div>
		<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存" />&nbsp;
			<input id="btnCancel" class="btn" type="button" value="关闭" onclick="closeDialog();"/>
		</div>
	</form:form>
</body>
</html>