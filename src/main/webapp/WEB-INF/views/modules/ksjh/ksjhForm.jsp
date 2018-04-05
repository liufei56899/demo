<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/base_index.jsp" %>
<html>
<head>
	<title>考试计划管理</title>
	<meta name="decorator" content="default"/>
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
		
		
		//监考老师必填项验证
		function jsPD(){
		   var js=$("#primaryPersonId").val();
		   if(js=="" || js ==  null){
		   	$("#span").before("<label class='error'>必填信息</label>");
		   	return false;
		   }
		   return true;
		}
		
		/* function addKcx(){
			openDialog("${ctx}/ksjh/ksjh/form","增加考场",1280,480);
	    }
	    
	    function editKcxx()
	    {
	    	var ids ="";
	        	var count =0;
				$("#classTable").find("input[type='checkbox']").each(function()
				{
					if($(this).attr("checked"))
					{
						if($(this).next().val()!=null && $(this).next().val()!="")
						{
							ids += $(this).next().val()+",";
							count++;
						}
					}
				});
				if(count == 1)
				{
					if(ids!=null && ids!="")
					{
					   ids = ids.substring(0,ids.length-1);
					   openDialog("${ctx}/ksjh/ksjh/form?id="+ids,"修改考场信息",1280,480);
					}
				}
				else if(count ==0)
				{
					alertx('请选择需要修改的考场！');
				}else
				{
					alertx('只能选择一个考场进行修改！');
				}
	    	
	    }
	    
	    function deleteKcxx()
	    {
	    	var ids ="";
	        	var count =0;
				$("#classTable").find("input[type='checkbox']").each(function()
				{
					if($(this).attr("checked"))
					{
						if($(this).next().val()!=null && $(this).next().val()!="")
						{
							ids += $(this).next().val()+",";
							count++;
						}
					}
				});
				
				if(count ==0)
				{
					alertx('请选择需要删除的考场！');
				}else
				{
					if(ids!=null && ids!="")
					{
					   ids = ids.substring(0,ids.length-1);
					   
					 }
					confirmx('确认要删除选中的考场吗？', "${ctx}/ksjh/ksjh/delete?ids="+ids);
				}
	    }
	 */
	</script>
</head>
<body>
<script type="text/javascript">

		function addKcx(){
			openDialog("${ctx}/ksjh/ksjh/addKcxx","增加考场",1280,480);
	    }
	    
 		function editKcxx()
	    {
	    	var ids ="";
	        	var count =0;
				$("#classTable").find("input[type='checkbox']").each(function()
				{
					if($(this).attr("checked"))
					{
						if($(this).next().val()!=null && $(this).next().val()!="")
						{
							ids += $(this).next().val()+",";
							count++;
						}
					}
				});
				if(count == 1)
				{
					if(ids!=null && ids!="")
					{
					   ids = ids.substring(0,ids.length-1);
					   openDialog("${ctx}/ksjh/ksjh/form?id="+ids,"修改考场信息",1280,480);
					}
				}
				else if(count ==0)
				{
					alertx('请选择需要修改的考场！');
				}else
				{
					alertx('只能选择一个考场进行修改！');
				}
	    	
	   		}
	    
	    	function deleteKcxx()
	    	{
		    	var ids ="";
		        	var count =0;
					$("#classTable").find("input[type='checkbox']").each(function()
					{
						if($(this).attr("checked"))
						{
							if($(this).next().val()!=null && $(this).next().val()!="")
							{
								ids += $(this).next().val()+",";
								count++;
							}
						}
					});
					
					if(count ==0)
					{
						alertx('请选择需要删除的考场！');
					}else
					{
						if(ids!=null && ids!="")
						{
						   ids = ids.substring(0,ids.length-1);
						   
						 }
						confirmx('确认要删除选中的考场吗？', "${ctx}/ksjh/ksjh/delete?ids="+ids);
					}
		    }
</script>

	<form:form id="inputForm" modelAttribute="ksjh" action="${ctx}/ksjh/ksjh/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<div class="control-group">	
			<div class="lg-form">
				<label class="control-label">考试计划名称：</label>
				<div class="controls">
					<form:input path="ksjhmc" htmlEscape="false" maxlength="64" class="input-xlarge "/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">计划状态：</label>
				<div class="controls">
					<form:select path="jhzt" id="jhzt" class="input-medium">
						<form:option value="" label="请选择"/>											
						<form:option value="1" label="启用"/>											
						<form:option value="0" label="停用"/>												
					</form:select>	
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">计划开始时间：</label>
				<div class="controls">
					<input
						name="stime" id="stime" type="text" readonly="readonly"
						maxlength="20" class="input-xlarge Wdate"
						value="<fmt:formatDate value="${ksjh.stime}" pattern="yyyy-MM-dd"/>"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'${nowDate}',isShowClear:false});" />
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">计划结束时间：</label>
				<div class="controls">
					<input
						name="etime" id="etime" type="text" readonly="readonly"
						maxlength="20" class="input-xlarge Wdate"
						value="<fmt:formatDate value="${ksjh.etime}" pattern="yyyy-MM-dd"/>"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'${nowDate}',isShowClear:false});" />
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">监考老师：</label>
				<div class="controls">
					<sys:treeselect id="primaryPerson"   name="jclsId" value="${ksjh.jclsId}" labelName="jcname" labelValue="${ksjh.jcname}"
					notAllowSelectRoot="true" checked="true"  title="老师" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">参与班级：</label>
				<div class="controls">
					<!-- <form:input path="bjId" htmlEscape="false" maxlength="11" class="input-xlarge "/> -->
					
					<select style="width:185px;" id="bjId"  name="bjId" class="input-xlarge required">
						<option value="">请选择</option>
						<c:forEach items="${bjJbxx}" var="bj">
							<option value="${bj.id }">${bj.bjmc}</option>
						</c:forEach>
					</select>
					
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">监考人数：</label>
				<div class="controls">
 					<form:input path="jkrs" htmlEscape="false" maxlength="11" class="input-xlarge "/>
 					<!-- <input type="text" id="jkrs" value="" readonly="readonly" htmlEscape="false" maxlength="11" class="input-xlarge "/> -->
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">考试人数：</label>
				<div class="controls">
					<form:input path="ckrs" htmlEscape="false" maxlength="11" class="input-xlarge "/>
					<%-- <input type="text" id="ckrs" value="${ksjh.ckrs }"  htmlEscape="false" maxlength="11" class="input-xlarge "/> --%>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">考场数量：</label>
				<div class="controls">
					<form:input path="kcsl" htmlEscape="false" maxlength="11" class="input-xlarge "/>
				</div>
			</div>
		</div>
		<div class="control-group">
			<span>考场信息</span>
		</div>
		
		<div class="btn-div">
			<input id="btnAdd" class="btn btn-primary" type="button" onclick="addKcx()" value="增加"/>
			<input id="btnEdit" class="btn btn-primary" type="button" onclick="editKcxx()" value="修改"/>
			<input id="btnDel" class="btn btn-primary" type="button" onclick="deleteKcxx()" value="删除"/>
		</div>
		<table id="classTable"
			class="table table-striped table-bordered table-condensed">
			<thead>
				<tr>
					<th>
						<input type="checkbox" id="checkboxAll" name="choose" onclick="selAll(this)">
						<input type="hidden" name="ids" value="" />
					</th>
					<th>考场名称</th>
					<th>考场地址</th>
					<th>容纳人数</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${classroom}" var="cla">
					<tr>
						<td>
					    	<input type="checkbox" id="checkbox" name="choose" value="cla.id" onclick="selFirst()">
					    	<input type="hidden" name="ids" value="cla.id" />
					    </td>
						<td>${cla.kcmc}</td>
						<td>${cla.kcdz}</td>
						<td>${cla.xsrs}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="form-actions">
			<shiro:hasPermission name="ksjh:ksjh:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="取消" onclick="closeDialog()"/>
		</div>
	</form:form>
</body>
</html>