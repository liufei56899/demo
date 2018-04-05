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
	<script type="text/javascript" src="${ctxStatic}/common/jeesite.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
				var istrue = btnSub();
				
					if(istrue){
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
		/*  function lxChange(info){ 	
		    $.getJSON("${ctx}/zy/zyJbxx/findZysByLxId",{id:info},function(result){		    	
		       $("#zyByLx").html(result.html);
		       $("#zyid").attr("style","width:185px;");
		       $("#zyid").select2();//设置样式
		  	});
		 } */
		 //班主任必填项验证
		function jsPD(){
		   var js=$("#primaryPersonId").val();
		   if(js=="" || js ==  null){
		   	$("#span").before("<label class='error'>必填信息</label>");
		   	return false;
		   }
		   return true;
		}
		//时间判断
		function datePD(){
			var sDate = $("#kssj").val();
			var eDate = $("#jssj").val();
			var date= new Date(sDate);
			var date1= new Date(eDate);			
			if( eDate == "" || date<date1){
     			return true;
			}else{
				alertx("开始时间不能小于或者等于结束时间！");
     			return false;
			}
		}
		function btnSub(){
			var ret = datePD();										
			if(ret){
				ret = jsPD();
			}
			if(ret){
				var name=$("#coure").val();
				ret = checkCourseName(name);
			}		
			return ret;
		}
		function checkCourseName(name){
			 $.getJSON("${ctx}/course/course/checkCourseName",{courseName:name},function(result){		    	
		      if(result.count>0){
		      	$("#cname").text("课程名称不能重复!");		    
		      	$("#coure").focus();
		      	return false;	    	
		      }else{
		      	$("#cname").text("");
		      	return true;
		      }
		  	});		
		}
	</script>
	<form:form id="inputForm" modelAttribute="course" action="${ctx}/course/course/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">课程名称：</label>
				<div class="controls">
					<input name="coursename" id="coure" value="${course.coursename}" class="input-xlarge required" onblur="checkCourseName(this.value)"/>					
					<span class="help-inline"><font color="red">*</font></span>
					<span id="cname" class="help-inline" style="color: red;"></span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label widthLab">代课老师：</label>
				<div class="controls">
					<sys:treeselect id="primaryPerson"   name="jsId.id" value="${course.jsId.id}" labelName="jsId.name" labelValue="${course.jsId.name}"
					notAllowSelectRoot="true" checked="true"  title="老师" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>					
					<span id="span" class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</div>
			<%-- <div class="lg-form">
			   <label class="control-label widthLab">学年：</label>
				<div class="controls">
					<select style="width:185px;" id="njid"  name="xnid" class="input-xlarge required">
						<option value="">--请选择--</option>
						<c:forEach items="${xnList}" var="xn">
							<option value="${xn.id}"
								<c:if test="${xn.id eq course.xnid}">selected="selected"</c:if>
							>${xn.nf}</option>
						</c:forEach>
					</select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>		 --%>									
		<%-- </div>
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
			<div class="lg-form">
				<label class="control-label widthLab">专业名称：</label>
				<div class="controls" id="zyByLx">
					<form:select path="zyId.id"  class="input-xlarge required" style="width:185px;">
								<form:option value="" label=""/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>					
			</div>
		</div> --%>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">开始时间：</label>
				<div class="controls">
					<input name="kssj" id="kssj" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${course.kssj}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label labWidth">结束时间：</label>
				<div class="controls">
					<input name="jssj" id="jssj" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${course.jssj}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div>
				<label class="control-label">说明：</label>
				<div class="controls">
					<form:textarea path="remarks" htmlEscape="false" maxlength="64" class="input-xxlarge "/>
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