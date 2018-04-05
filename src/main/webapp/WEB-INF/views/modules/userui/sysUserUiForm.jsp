<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
<title>终端用户管理</title>
<meta name="decorator" content="default" />
</head>
<body>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/base_index.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {
		$("#inputForm").validate({
				submitHandler : function(form) {
						loading('正在提交，请稍等...');
						form.submit();
				},
				errorContainer : "#messageBox",
				errorPlacement : function(error, element) {
				$("#messageBox").text("输入有误，请先更正。");
				if (element.is(":checkbox")|| element.is(":radio")|| element.parent().is(".input-append")) {
					error.appendTo(element.parent().parent());
				} else {
					error.insertAfter(element);
				}
			}
		});
		var departmentId = "${departmentId}";
		
		//设置部门信息
		$.getJSON("${ctx}/sys/office/treeData",function(data){
		  var content = "<select id='departmentid' name='office' onchange='setByName(this.value)' style='width:212px;'><option value=''></option>>";
		  $.each(data,function(i,field){
		     if(departmentId==field.name){
		       content+="<option value="+field.id+" selected=\"selected\">"+field.name+"</option>";
		       setByName(field.id);
		     }
		      content+="<option value="+field.id+" >"+field.name+"</option>";
		  });
		  content+="</select>";
		  $("#bmSelect").html(content);
		  $("#departmentid").select2();
		});
	});
			
	function setByName(value){
	   var username = "${username}";
	   $.getJSON("${ctx}/userui/sysUserUi/listfrom2", {id: value}, function(data){
	      var content = "<select id='usernameid' name='username' onchange='setByName2(this.value)' style='width:212px;'><option value=''></option>>";
		  $.each(data,function(i,field){
		      if(username == field.name){
		         content+="<option value="+field.id+"-"+field.name+"  selected=\"selected\">"+field.name+"</option>";
		      }
		      content+="<option value="+field.id+"-"+field.name+" >"+field.name+"</option>";
		  });
		  content+="</select>";
		  $("#yhmlist").html(content);
		  $("#usernameid").select2();
	   });
	}
	
	function setByName2(id){
	  var idstr = id.substr(0,id.indexOf("-"));
	  $.getJSON("${ctx}/sys/user/getSysUserUi", {id: idstr}, function(data){
	      console.log(data.gwzym+"=="+data.phone+"==data:::"+JSON.stringify(data));
		
	      $("#phone1").val(data.phone);
	      $("#mobile1").val(data.mobile);
	      $("#password1").val("123456");
	      $("#name1").val(data.name);
	      $("#xbm1").val(data.xb);
	      $("#zhiwei").val(data.gwzym);
	      $("#email1").val(data.email);
	      $("#loginFlag1").val(data.loginFlag);
	      $("#userType1").val("终端用户");
	      
	  });
	}
				
</script>
	<form:form id="inputForm" modelAttribute="sysUserUi"
		action="${ctx}/userui/sysUserUi/save" method="post"
		class="form-horizontal">
		<form:hidden path="id" />
		<sys:message content="${message}" />
		<br/>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">部门：</label>
				<div class="controls" id="bmSelect">
				  
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">账号：</label>
				<div class="controls" id="yhmlist">
				   <form:select path="username" class="input-xlarge select2" style="width:212px;">
					 <form:option value="" label=""/>
				   </form:select>
				</div>
			</div>
			
		</div>
		<div class="control-group">
		    <div class="lg-form">
				<label class="control-label">手机号：</label>
				<div class="controls">
					<form:input id="mobile1" path="mobile" htmlEscape="false" style="width:212px;" value=""
						class="input-xlarge required" readonly="true"/>
					<span class="help-inline"><font color="red">*手机号为App终端登录账号!</font> </span>
				</div>
			</div>
		   <div class="lg-form">
			<label class="control-label">性别：</label>
			<div class="controls">
				<form:select path="xbm" id="xbm1" class="input-xlarge required"  style="width:212px;" readonly="true">
					<form:option value="" label="" />
					<form:options items="${fns:getDictList('sex')}" itemLabel="label"
						          itemValue="value" htmlEscape="false" />
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			 </div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">密码：</label>
				<div class="controls">
					<form:input id="password1" path="password" htmlEscape="false" maxlength="100"
						class="input-xlarge required" />
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">姓名：</label>
				<div class="controls">
					<form:input id="name1" path="name" htmlEscape="false" maxlength="100" value=""
						class="input-xlarge required" readonly="true"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</div>

		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">邮箱：</label>
				<div class="controls">
					<form:input id="email1" path="email" htmlEscape="false" maxlength="200" value=""
						class="input-xlarge" readonly="true"/>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">电话：</label>
				<div class="controls">
					<form:input id="phone1" path="phone" htmlEscape="false" maxlength="200"
						class="input-xlarge" readonly="true"/>
				</div>
			</div>
		</div>

		<div class="control-group">
			<div class="lg-form">
                <label class="control-label">职位：</label>
				<div class="controls">
					<form:select path="zhiwei" id="zhiwei" class="input-xlarge "  readonly="true"
						style="width:215px;">
						<form:option value="" label="" />
						<form:options items="${fns:getDictList('gwzy')}" itemLabel="label"
							itemValue="value" htmlEscape="false" />
					</form:select>
				</div>
            </div>
			<div class="lg-form">
				<label class="control-label">用户类型：</label>
				<div class="controls">
					<form:input id="userType1" path="userType" htmlEscape="false" 
						class="input-xlarge" readonly="true"/>
				</div>
			</div>
		</div>

		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">用户头像：</label>
				<div class="controls">
					<form:input path="photo" htmlEscape="false" maxlength="1000"
						class="input-xlarge" readonly="true"/>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">是否允许登录:</label>
			    <div class="controls">
				<form:select id="loginFlag1" path="loginFlag">
				    <form:option value="" label="" />
					<form:options items="${fns:getDictList('yes_no')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			</div>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
				<div class="controls">
					<form:textarea path="remarks" htmlEscape="false" rows="4"
						maxlength="255" class="input-xxlarge" />
				</div>
		</div>
		<div class="form-actions" style="height:15px; ">
			<shiro:hasPermission name="userui:sysUserUi:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit"
					value="保 存" />&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="关闭"
				onclick="closeDialog();" />
		</div>
	</form:form>
</body>
</html>