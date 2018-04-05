<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学生小组信息管理</title>
	<meta name="decorator" content="default"/>
	<%-- <%@ include file="/WEB-INF/views/include/base_index.jsp"%>
	 --%>
	 <link rel="stylesheet" href="${ctxStatic}/multiple-select-master/demos/assets/bootstrap/css/bootstrap.css" />
    <link rel="stylesheet" href="${ctxStatic}/multiple-select-master/multiple-select.css" />
    <style type="text/css">
    	.input-xlarge{
    		height: 30px !important;
    	}
    	.btn{
    		    background-color: #d81919 !important;
    		    border-color: #ffffff !important;
    	}
    </style>
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
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/groupstu/groupstu/">学生小组信息列表</a></li>
		<li><a href="${ctx}/groupstu/groupstu/form">学生小组信息添加</a></li>
	</ul>
	<form:form id="inputForm" modelAttribute="groupstu" action="${ctx}/groupstu/groupstu/save2" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<input name="" value="${znum }" type="hidden"/>
		<input name="" value="${xnxq }" type="hidden" />
		
		<table class="table table-striped table-bordered table-condensed">
		<br>
		<tr>
		<td height="40px">小组名称</td>
		<td>小组人数</td>
		<td>小组学生</td>
		<td>小组教师</td>
		</tr>
		<tr>
		<td height="40px">
				<form:input path="groupname" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
		</td>
		<td>
				<form:input path="groupnum" htmlEscape="false" maxlength="11" class="input-xlarge required"/>
		</td>
		
		<td>
					
				<select id="ms${state.index }" multiple="multiple"  name="groupstudent">
						<!-- <option value="" >请选择</option> -->
						<c:forEach items="${studentList}" var="stu" >
							<option value="${stu.id }" <c:if test="${stu.id==groupstu.groupstudent}">selected="selected"</c:if>
							>${stu.name }</option>
						</c:forEach>
				</select>
		</td>
		<td>
				<select id="tea${state.index }" multiple="multiple"  name="groupteacher">
						<!-- <option value="" >请选择</option> -->
						<c:forEach items="${teacher}" var="stu" >
							<option value="${stu.id }" <c:if test="${stu.id==groupstu.groupteacher}">selected="selected"</c:if>
							>${stu.name }</option>
						</c:forEach>
				</select>
		</td>
		</tr>
	</table>
		
		<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存" />
		</div>
	</form:form>
	
					<script src="${ctxStatic}/multiple-select-master/demos/assets/jquery.min.js"></script>
					<script src="${ctxStatic}/multiple-select-master/multiple-select.js"></script>
					<script>
					    $(function() {
					         $("select[id*='ms']").change(function() {
					            console.log($(this).val());
					        }).multipleSelect({
					        	selectAllText: '全选',
					        	 allSelected: '已全选',
					            width: '200px'
					        });
					        $("select[id*='tea']").change(function() {
					            console.log($(this).val());
					        }).multipleSelect({
					        	selectAllText: '全选',
					        	 allSelected: '已全选',
					            width: '200px'
					        });
					    });
					    	
					</script>
</body>
</html>