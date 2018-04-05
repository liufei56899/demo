<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学生考勤信息管理</title>
	<meta name="decorator" content="default"/>
	<style>
		.control-group{
			border-bottom: none;
		}
		.control-label{
			width: 210px !important;
			height: 50px;
			line-height: 50px;
			padding: 0 30px !important;
			border-right: 1px solid #ddd;
		}
		.controls{
			margin-left: 40% !important;
			padding-top:3px;
		}
		.input-xlarge{
			width: 90%;
		}
		.input-medium{
			width: 90%;
		}
		td{
			padding:0 !important;
		}
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			/* $("#inputForm").validate({
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
			}); */
		});
	</script>
</head>
<body>
	<%-- <ul class="nav nav-tabs">
		<li><a href="${ctx}/studentattendance/studentattendance/">学生考勤信息列表</a></li>
		<li class="active"><a href="${ctx}/studentattendance/studentattendance/form?id=${studentattendance.id}">学生考勤信息<shiro:hasPermission name="studentattendance:studentattendance:edit">${not empty studentattendance.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="studentattendance:studentattendance:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/> --%>
	<br/>
	<table class="table table-striped table-bordered table-condensed">
	<c:forEach items="${sList }" var="stu"  varStatus="status">
	<form:form id="inputForm${status.index }" modelAttribute="studentattendance" action="" method="post" class="form-horizontal" name="formname">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		
		<tr>
		<!-- <td height="30px">
						<input type="checkbox" id="checkboxAll" name="choose" onclick="selAll(this)">
				    	<input type="hidden" name="ids" value="" />
				    	<input type="hidden" name="name" value="" />
				    	<input type="hidden" name="status" value="" /> 
			</td> -->
		<td height="30px">小组名称</td>
		<td>学生姓名</td>
		<td>乐器</td>
		<td>归还日期</td>
		<td>服装</td>
		<td>归还日期</td>
		<td colspan="2">考勤</td>
		<td>成绩</td>
		<td>操作</td>
		</tr>
		
		
		<tr>
		<%-- <td height="30px">
						<input type="checkbox" id="checkbox" name="choose" value="${stu.id}" onclick="selFirst()">
						<input type="hidden" name="ids" value="${stu.id}" />
						<input type="hidden" name="name" value="" />
						<input type="hidden" name="status" value="" />
			  </td> --%>
		<td  height="30px">
				<input name="groupname" htmlEscape="false" maxlength="255" class="input-xlarge required" readonly="true"  value="${stu.groupname }"/>
			
		</td>
		<td>
				<input name="student" htmlEscape="false" maxlength="255" class="input-xlarge required" readonly="true" value="${fns:getStudent(stu.name )}"/>
			
		</td>
		<td>
				<form:input path="musical" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
				
		</td>
		<td>
				<input name="mback" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${studentattendance.mback}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
		
		</td>
		<td>
				<form:input path="clothing" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
				
		</td>
		<td>
				<input name="cback" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${studentattendance.cback}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
				
		</td>
		<td>
				<input name="worktime1" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${studentattendance.worktime1}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
				
		</td>
		<td>
				<input name="worktime2" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${studentattendance.worktime2}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
				
		</td>
		<td>
				<form:input path="score" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
				
		</td>
		<td>
			<input id="btnSubmit" class="btn btn-primary" type="button" value="保 存" onclick="saveT()"/>
		</td>
		</tr>
		<!-- <div class="form-actions">
			<shiro:hasPermission name="studentattendance:studentattendance:edit">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div> -->
	</form:form>
		</c:forEach>
		</table>
		
		<script type="text/javascript">
		/* 	 $(function() {
					         $("inputForm[id*='ms']").change(function() {
					         $("inputForm[id*='ms']").submit();
					        });
					  }); */
					function  saveT(){
					
				var f=	document.getElementsByName("formname")[0].value;
						/* var id= document.getElementById("form[id*='inputForm']").form.id; */
						alert("==="+f);
					/* 	$.ajax({
				        type: "POST",
				        url: "${ctx}/studentattendance/studentattendance/save1",
				        data: $("form[id*='inputForm']").serialize(),
				        dataType:'json',
				        async:false,
						success: function(data){
							if(data=="ok"){
								alertx("添加成功！");
							}
					   }
				    }); */
					}
		</script>
</body>
</html>