<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>教室信息管理管理</title>
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
		
		$(document).ready(function() {						
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
		
		 function xnChange(info){		
		    $.getJSON("${ctx}/classroom/classroom/findClassBynjId",{njid:info},function(result){
		       $("#className").html(result.html);
		       $("#classid").attr("style","width:195px;");
		       $("#classid").select2();//设置样式
		  	});
		 }
	</script>
	<form:form id="inputForm" modelAttribute="classroom" action="${ctx}/classroom/classroom/saveset" method="post" class="form-horizontal">
		<form:hidden path="id"/>				
		<sys:message content="${message}"/>	
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">序号：</label>
				<div class="controls">		
					${classroom.xh}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label labWidth">教室楼号：</label>
				<div class="controls">				
					${classroom.jslh}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">教室门牌号：</label>
				<div class="controls">				
					${classroom.jsmph}				
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label labWidth">教室类型：</label>
				<div class="controls">					
					<c:if test="${classroom.jslx==1}">普通教室</c:if>
					<c:if test="${classroom.jslx==2}">非普通教室</c:if>					
				</div>
				
			</div>
		</div>	
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">可容纳人数：</label>
				<div class="controls">
					${classroom.rnrs}						
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label labWidth">状态：</label>
				<div class="controls">
					<c:if test="${classroom.status==0}">停用</c:if>
					<c:if test="${classroom.status==1}">启用</c:if>															
				</div>
			</div>
		</div>
		<c:if test="${flag=='view'}">
			<c:if test="${!empty bjjbxx.bjmc}">
				<div class="control-group">
					<div class="lg-form">
						<label class="control-label">学年：</label>
						<div class="controls">
							${bjjbxx.njid.nf}													
						</div>
					</div>
					<div class="lg-form">
						<label class="control-label">班级：</label>
						<div class="controls">
							${bjjbxx.bjmc}													
						</div>
					</div>				
				</div>
			</c:if>	
		</c:if>
		<c:if test="${empty flag}">
			<div class="control-group">
				<input type="hidden" name="classroomid" value="${bjjbxx.classroomid}"/>
				<div class="lg-form">
			   		<label class="control-label widthLab">学年：</label>
					<div class="controls">			
						<select style="width:185px;" id="njid"  name="njid" onchange="xnChange(this.value)" class="input-xlarge">
							<option value="">--请选择--</option>
							<c:forEach items="${xnList }" var="xn">
								<option value="${xn.id }" <c:if test="${xn.id==bjjbxx.njid.id}">selected ="selected"</c:if>>${xn.xnmc}</option>
							</c:forEach>
						</select>				
					</div>
				</div>			
				<div class="lg-form">
					<label class="control-label widthLab">班级：</label>
					<div class="controls" id="className">
						<select id='classid' name='classid'  class="input-xlarge" style="width:195px;">
							<option value="">--请选择--</option>
							<c:forEach items="${BjJbxx}" var="BJ">													
								<option value="${BJ.id}">${BJ.bjmc}</option>
							</c:forEach>					
						</select>										
					</div>					
				</div>	
			</div>
		</c:if>
		<div class="form-actions">
			<c:if test="${empty flag}">
				<shiro:hasPermission name="zy:zyJbxx:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			</c:if>
			<input id="btnCancel" class="btn" type="button" value="关闭" onclick="closeDialog();"/>
		</div>
	</form:form>
</body>
</html>