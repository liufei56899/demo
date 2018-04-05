<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学校课程代码表管理</title>
	<meta name="decorator" content="default"/>
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
	
</head>		
<body>
	<script type="text/javascript">
		function lxChange(info){ 			
		    $.getJSON("${ctx}/zy/zyJbxx/findZyListByLxId",{id:info},function(result){		    	
		       var zyJbxxList=result.zyJbxxList;
		       var html="<div class='controls'>";
		        for (let i = 0;i < zyJbxxList.length;i++){
   					html+="<input type='checkbox' name='zyid' value='"+zyJbxxList[i].id+"'/>"+zyJbxxList[i].zymc;   
				}
		       html+="</div>";		       
		       $("#zyxx").html(html);
		  	});
		 } 
	</script>
	<script type="text/javascript" src="${ctxStatic}/common/jeesite.js"></script>
	<form:form id="inputForm" modelAttribute="course" action="${ctx}/course/course/defendCourseSave" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">课程名称：</label>
				<div class="controls">
					<input name="coursename" id="coure" value="${course.coursename}" class="input-xlarge required" readonly="readonly"/>								
				</div>
			</div>		
		</div>
		<div class="control-group">
			<div class="lg-form">
			   <label class="control-label">专业类别：</label>
				<div class="controls">
					<form:select path="zylxid" id="zylxId" style="width:185px;" onchange="lxChange(this.value)" class="input-xlarge required">
							<form:option value="" label=""/>
							<form:options items="${fns:getZylxList()}" itemLabel="lxmc" itemValue="id" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>		
		</div> 
		<div class="control-group">
			<label class="control-label">专业名称：</label>
			<div id="zyxx">
			<div class="controls">
			<c:forEach items="${zyJbxxs}" var="zyJbxx">
				<c:forEach items="${coursezy}" var="coursezy">
					<c:if test="${zyJbxx.id==coursezy.zyid}">
						<input type="checkbox" name="zyid" value="${coursezy.zyid}" checked="checked"/>${zyJbxx.zymc}
					</c:if>
				</c:forEach>
			</c:forEach>	   
			</div>
			</div>			
		</div>	
		<div class="form-actions">
			<shiro:hasPermission name="zy:zyJbxx:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="关闭" onclick="closeDialog();"/>
		</div>
	</form:form>
</body>
</html>