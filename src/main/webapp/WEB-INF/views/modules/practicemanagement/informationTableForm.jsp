<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>艺术实践管理管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	var js="";
	var st="";
	var stu="";
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
			
			  
		  js+='<tr>';
		  js+='<td>小组名称</td>';
		  js+='<td>教师姓名</td>';
		  js+='<td><div class="control-group">';
		  js+='<label class="control-label">教师考勤时间</label>';
		  js+='<div class="controls">';
		  js+='<input name="tetime1" id="tetime1" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "';
		  js+='value="<fmt:formatDate value="${informationTable.tetime1}" pattern="yyyy-MM-dd HH:mm:ss"/>"';
		  js+='onclick="WdatePicker({dateFmt:"yyyy-MM-dd HH:mm:ss",isShowClear:false});"/>';
		  js+='至';
		  js+='<input name="tetime2" id="tetime2" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "';
		  js+='value="<fmt:formatDate value="${informationTable.tetime2}" pattern="yyyy-MM-dd HH:mm:ss"/>"';
		  js+='onclick="WdatePicker({dateFmt:"yyyy-MM-dd HH:mm:ss",isShowClear:false});"/>';	 
		  js+='</div></div></td></tr>';

			
			st+='<tr><td>';
			st+='<div class="control-group">';
			st+='<label class="control-label">小组名称</label>';
			st+='<div class="h-controls">';
			st+='<input name="groupname" htmlEscape="false" maxlength="255" class="input-xlarge "/>';
			st+='</div></div></td><td>';
			st+='<div class="control-group">';
			st+='<label class="control-label">小组学生数</label>';
			st+='<div class="h-controls">';
			st+='<input name="groupnum" htmlEscape="false" maxlength="11" id="groupnum" class="input-xlarge  digits"/>';
			st+='</div></div></td></tr><tr><td>';
			st+='<div class="control-group">';
			st+='<label class="control-label">小组学生</label>';
			st+='<div class="h-controls" >';
			st+='<select name="groupstudent" class="input-xlarge required" id="stu">';
			st+='<option value="" label=""/>';
			st+='</select>';
			st+='<span class="help-inline" onclick="byStudent()"  ><font color="red">+点击选择学生+</font> </span>';
			st+='</div></div></td><td>';
			st+='<div class="control-group">';
			st+='<label class="control-label">小组负责教师</label>';
			st+='<div class="h-controls" >';
			st+='<select name="groupteacher" class="input-xlarge required" id="tea">';
			st+='<option value="" label=""/>';
			st+='</select>';
			/* st+='<treeselect id="groupteacher" name="groupteacher" value="${informationTable.groupteacher}" labelName="" labelValue=""';
			st+='title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true"/>'; */
			st+='<span class="help-inline" onclick="byTeacher()"  ><font color="red">+点击选择教师+</font> </span>';
			st+='</div></div></td></tr> ';
			
			
			
			stu+='<tr><td><div class="control-group"><div class="controls">手提琴</div></div>';
			stu+='</td><td><div class="control-group"><div class="controls">李四</div></div></td><td>';
			stu+='<div class="control-group"><div class="controls">';
			stu+='<input name="musical" htmlEscape="false" maxlength="255" class="input-xlarge " /></div></div></td><td>';
			stu+='<div class="control-group"><div class="s-controls">';
			stu+='<input name="mback" id="mback" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "';
			stu+='value="<fmt:formatDate value="${informationTable.mback}" pattern="yyyy-MM-dd HH:mm:ss"/>"';						
			stu+='onclick="WdatePicker({dateFmt:"yyyy-MM-dd HH:mm:ss",isShowClear:false});"/>';						
			stu+='</div></div></td><td>';
			stu+='<div class="control-group"><div class="controls">';
			stu+='<input name="clothing" htmlEscape="false" maxlength="255" class="input-xlarge "/></div></div></td><td>';
			stu+='<div class="control-group"><div class="s-controls">';
			stu+='<input name="cback" id="cback" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "';
			stu+='value="<fmt:formatDate value="${informationTable.cback}" pattern="yyyy-MM-dd HH:mm:ss"/>"';
			stu+='onclick="WdatePicker({dateFmt:"yyyy-MM-dd HH:mm:ss",isShowClear:false});"/>';
			stu+='</div></div></td><td>';
			stu+='<div class="control-group"><div class="s-controls">';
			stu+='<input name="sttime1" id="sttime1" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "';
			stu+='value="<fmt:formatDate value="${informationTable.sttime1}" pattern="yyyy-MM-dd HH:mm:ss"/>"';
			stu+='onclick="WdatePicker({dateFmt:"yyyy-MM-dd HH:mm:ss",isShowClear:false});"/></div></div>至';
			stu+='<div class="control-group"><div class="s-controls">';
			stu+='<input name="sttime2" id="sttime2" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "';
			stu+='value="<fmt:formatDate value="${informationTable.sttime2}" pattern="yyyy-MM-dd HH:mm:ss"/>"';
			stu+='onclick="WdatePicker({dateFmt:"yyyy-MM-dd HH:mm:ss",isShowClear:false});"/>';
			stu+='</div></div></td><td>';
			stu+='<input name="score" htmlEscape="false" maxlength="255" class="input-xlarge "/></td></tr>';
		
				
			
			
		});
		
		
		
		function byStudent(){
 			var xnxq=$("#xnxq").val();
 			if(xnxq!=null&&xnxq!=""&&xnxq!=undefined){
 			$.ajax({
			type : "POST",
			url : "${ctx}/practicemanagement/informationTable/ByStudent",
			data : {
				xnxq : xnxq
			},
			dataType : 'json',
			async : false,
			success : function(result) {
			$("#stu").empty();
			$("#stu").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
				for ( var i = 0; i < result.length; i++) {
					var r = result[i];
					$("#stu").select2("destroy");
					$("#stu")
							.append(
									"<option value='"+r.id+"'>" + r.xm
											+ "</option> ").select2();
				}
			}
		});
 	}else{
 	   alert("请先选择学年学期！");
 	   return;
 	}
 	}
 
		
		
			
 		function addRow(){
 			var num=$("#znum").val();
	 		if(num>0){
		 		  for(var i = 0;i < num; i++) {
		 		 	 $("#jskq").append(js);
		 		 	   $('.controls>input').live('click',function(){
      					 WdatePicker({dateFmt:"yyyy-MM-dd HH:mm:ss",isShowClear:false});
 						}); 
		 		  }
	 		}else{
	 			return;
	 		}
		}
		function addRowst(){
 			var num=$("#znum").val();
	 		if(num>0){
		 		  for(var i = 0;i < num; i++) {
		 		 	 $("#groups").append(st);
		 		 	   $('.h-controls>select').live('click',function(){
      					 byStudent();
      					 byTeacher();
 						}); 
		 		  }
	 		}else{
	 			return;
	 		}
		}
			function addRowstu(){
			var znum=$("#znum").val();
 			var num=$("#groupnum").val();
 			if(znum>0){
	 		if(num>0){
		 		  for(var i = 0;i < num; i++) {
		 		 	 $("#tabstu").append(stu);
		 		   	 $('.s-controls>input').live('click',function(){
      					 WdatePicker({dateFmt:"yyyy-MM-dd HH:mm:ss",isShowClear:false});
 						}); 
		 		  }
	 		}else{
	 			alert("请添加小组学生人数！");
	 			return;
	 		}
	 		}else{
	 			alert("请添加小组学生信息！");
	 			return;
	 		}
		}
		function byTeacher(){
 			$.ajax({
			type : "POST",
			url : "${ctx}/practicemanagement/informationTable/Alljs",
			data : {
			},
			dataType : 'json',
			async : false,
			success : function(result) {
			$("#tea").empty();
			$("#tea").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
				for ( var i = 0; i < result.length; i++) {
					var r = result[i];
					$("#tea").select2("destroy");
					$("#tea")
							.append(
									"<option value='"+r.id+"'>" + r.name
											+ "</option> ").select2();
				}
			}
		});
 	
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
		<%-- <li><a href="${ctx}/practicemanagement/informationTable/">艺术实践管理列表</a></li> --%><br/>
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
				<input type="button" onclick="addRowst()" value="添加小组信息 +" />
			</td>
			</tr>
			
			</table>
			
	<%-- <table class="table table-bordered"  id="bmTable">
	<tr>
				<td>
		<div class="control-group">
			<label class="control-label">小组名称：</label>
			<div class="controls">
				<form:input path="groupname" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		</td>
				<td>
		<div class="control-group">
			<label class="control-label">小组学生数：</label>
			<div class="controls">
				<form:input path="groupnum" htmlEscape="false" maxlength="11" class="input-xlarge  digits"/>
			</div>
		</div>
		</td>
			</tr>
			<tr>
				<td>
		<div class="control-group">
			<label class="control-label">小组学生：</label>
			<div class="controls" >
					<form:select path="groupstudent" class="input-xlarge required" id="stu">
					<form:option value="" label=""/>
					
				</form:select>
				<span class="help-inline" onclick="byStudent()"  ><font color="red">*点击选择学生</font> </span>
			</div>
		</div>
			</td>	
				<td>
		<div class="control-group">
			<label class="control-label">小组负责教师：</label>
			<div class="controls">
				<sys:treeselect id="groupteacher" name="groupteacher" value="${informationTable.groupteacher}" labelName="" labelValue=""
					title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true"/>
			</div>
		</div>
			</td>
			</tr> 
			</table> --%>
			
			
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
			
			<tr>
			<td height="50px" >
			学生考勤
			</td>
			<td>
			<input type="button" onclick="addRowstu()" value="添加学生考勤信息 +" />
			</td>
			</tr>
			</table>
			
			<table class="table table-bordered" id="tabstu">
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
			</tr>
			
			
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
		</tr> --%>
		</table>
		
		
		<table class="table table-bordered" >
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
		</tr>
		
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
			</tr> --%>
		</table>
		
		
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
</body>
</html>