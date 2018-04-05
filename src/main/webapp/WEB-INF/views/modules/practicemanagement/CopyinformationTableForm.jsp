<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>艺术实践管理管理111</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/base_index.jsp"%>

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
		
		function addRowst(){
 			var num=$("#znum").val();
 			var xnxq=$("#xnxq").val();
	 		if(num>0&&xnxq!=null&&xnxq!=""&&xnxq!=undefined){
		 		openDialog("${ctx}/groupstu/groupstu/form1?znum="+num+"&xnxq="+xnxq, "添加小组学生信息", 1100, 510);
	 		}else{
	 			alertx("请先选择学年学期和填写小组数量！");
	 			return;
	 		}
		}
			function addRowstu(){
 		/* 	var num=$("#znum").val();
 			var xnxq=$("#xnxq").val();
	 		if(num>0&&xnxq!=null&&xnxq!=""&&xnxq!=undefined){
		 		openDialog("${ctx}/groupstu/groupstu/form1?znum="+num+"&xnxq="+xnxq, "添加小组学生信息", 1100, 510);
	 		}else{
	 			alertx("请先选择学年学期和填写小组数量！");
	 			return;
	 		} */
		}
		
	

	</script>
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
			width: 235px;
		}
		.input-medium{
			width: 220px;
		}
		td{
			padding:0 !important;
		}
	</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/practicemanagement/informationTable/">艺术实践管理列表</a></li>
		<li class="active">
		<a href="#">艺术实践管理
		</a>
		</li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="informationTable" action="${ctx}/practicemanagement/informationTable/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<table class="table table-bordered" id="groups">
			<tr>
				<td>
		<div class="control-group">
			<label class="control-label">学年学期：</label>
			<div class="controls">
				<form:select path="xnxq" class="input-xlarge " id="xnxq">
					<form:option value="" label=""/>
					<form:options items="${fns:getXnxq()}" itemLabel="xnmc" itemValue="id" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		</td>
				<td>
		<div class="control-group">
			<label class="control-label">艺术实践时间：</label>
			<div class="controls">
				<input name="shijiantime1" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${informationTable.shijiantime1}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
					至
				<input name="shijiantime2" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${informationTable.shijiantime2}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
			</td>
		</tr>
			<tr>
				<td>
		<div class="control-group">
			<label class="control-label">艺术实践类型：</label>
			<div class="controls">
				<form:select path="shijiantype" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('music')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		</td>
				<td>
		<div class="control-group">
			<label class="control-label">组成小组数量：</label>
			<div class="controls">
				<form:input path="znum" htmlEscape="false" maxlength="11" class="input-xlarge  digits"  id="znum"/>
			</div>
		</div>
		</td>
			</tr>
			
			<tr height="50px">
			<td  colspan="2">
				<input type="button" onclick="addRowst()" value="添加小组信息 +"  class="btn btn-primary" />
				&nbsp;&nbsp;
				<input type="button" onclick="addRowstu()" value="添加学生考勤信息 +" class="btn btn-primary" />
				&nbsp;&nbsp;
				<input type="button" onclick="addRow()" value="添加教师考勤信息 +" class="btn btn-primary" />
			</td>
			</tr>
			
			</table>
			
			
			<table class="table table-bordered">
			<tr>
				<td>
	<div class="control-group">
			<label class="control-label">指挥教师：</label>
			<div class="controls">
				<sys:treeselect id="zhihui" name="zhihui" value="${informationTable.zhihui}" labelName="" labelValue=""
					title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true"/>
			</div>
		</div>
		</td>
				<td>
		<div class="control-group">
			<label class="control-label">指挥教师考勤开始时间：</label>
			<div class="controls">
				<input name="zhihuitime1" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${informationTable.zhihuitime1}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
					至
					<input name="zhihuitime2" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${informationTable.zhihuitime2}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
			</td>
			</tr>
			
			
			</table>
			
			<!-- <table class="table table-bordered" id="tabstu">
			<tr height="50px">
				<td>
					小组名称
			</td>
				<td>
					学生姓名
			</td>
			<td>
					乐器
			</td>
			<td>
					归还日期
			</td>
			<td>
					服装
			</td>
			<td>
					归还日期
			</td>
			<td>
					考勤
			</td>
			<td>
					成绩
			</td>
			</tr> -->
			
			
			<%-- <tr>
			<td>
					手提琴
			</td>
			<td>
					李四
			</td>
				<td>
								<form:input path="musical" htmlEscape="false" maxlength="255" class="input-xlarge " />
			</td>
				<td>
								<input name="mback" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
									value="<fmt:formatDate value="${informationTable.mback}" pattern="yyyy-MM-dd HH:mm:ss"/>"
									onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</td>
				<td>
								<form:input path="clothing" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</td>
				<td>
								<input name="cback" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
									value="<fmt:formatDate value="${informationTable.cback}" pattern="yyyy-MM-dd HH:mm:ss"/>"
									onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
		</td>
				<td>
								<input name="sttime1" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
									value="<fmt:formatDate value="${informationTable.sttime1}" pattern="yyyy-MM-dd HH:mm:ss"/>"
									onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
									至
									<input name="sttime2" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
									value="<fmt:formatDate value="${informationTable.sttime2}" pattern="yyyy-MM-dd HH:mm:ss"/>"
									onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</td>
				<td>
								<form:input path="score" htmlEscape="false" maxlength="255" class="input-xlarge "/>
		</td>
		</tr>
		</table> --%>
		
		
		<!-- <table class="table table-bordered" >
		<tr>
			<td  colspan="5" height="50px" >
			教师考勤
			</td>
			<td  colspan="4" >
			<input type="button" onclick="addRow()" value="添加教师考勤信息 +" />
			</td>
			</tr>
		</table>
		
		
		<table class="table table-bordered" id="jskq">
		<tr height="50px">
		<td>小组名称</td>
		<td>教师姓名</td>
		<td colspan="2" >考勤</td>
		</tr> -->
		
		<%-- <tr>
		<td>小组名称</td>
		<td>教师姓名</td>
		
		<td>
		<div class="control-group">
			<label class="control-label">教师考勤时间：</label>
			<div class="controls">
				<input name="tetime1" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${informationTable.tetime1}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
					至
					<input name="tetime2" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${informationTable.tetime2}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		</td>
		</tr>
		<tr>
			<td  colspan="4" height="50px" >
			课堂情况
			</td>
			</tr>
		</table> --%>
		
		
		<table class="table table-bordered">
		<tr>
			<td>
			课堂情况
			</td>
		<td>
				<form:textarea path="remake" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
		</td>
		</tr>
			<tr>
				<td colspan="2">
		<div class="form-actions">
			<shiro:hasPermission name="practicemanagement:informationTable:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
			</td>
			</tr>	
		</table>		
	</form:form>
	
		<script type="text/javascript">
		function openDialog(href, title, width, height) {
		var length = $("div#dialogDiv").size();
			if (length == 0) {
				$("#groups").before(
						"<div id='dialogDiv' style='width:820px;'></div>");
			}
			$('#dialogDiv').dialog({
				title : title,
				width : width,
				height : height,
				closed : false,
				cache : false,
				href : href,
				modal : true
			});
			/*$(".panel").css("top", "0px");
			$(".window-shadow").css("top", "0px");*/
			$("#dialogDiv").panel("move",{top:$(document).scrollTop() + ($(window).height()-height) * 0.5});
		}
		</script>
</body>
</html>