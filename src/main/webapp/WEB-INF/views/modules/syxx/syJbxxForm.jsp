<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>生源信息管理</title>
	<meta name="decorator" content="default"/>
	
</head>
<body>
	<script type="text/javascript" src="${ctxStatic}/common/jeesite.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
				    var isTrue = validateLxdh();
				    var isTrue2 = validateSfzxx();
					if(isTrue&&isTrue2)
					{
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
	//城市选择
	function setByChr(value) { 
        if(value!=null&&value!=""){
            var result0 = "<select select id='csId' path='csId.id' name='csId.id' class='input-xlarge required' style='width:212px;' onchange='setByArea(this.value)'><option value=''></option>";
		    $.getJSON("${ctx}/sys/area/findallbychr", {parentId: value}, function(result) {
			   $.each(result, function(i, field) {
				//修改城市信息
				result0+="<option value="+field.id+" >"+field.name+"</option>";
			   });
		       result0+="</select>";
		       $("#cSelect").html(result0);
		       $("#csId").select2();
		  });
        }else{
           alertx("获取城市数据失败,请联系管理员!");
        }
	}
	//区县选择
    function setByArea(value) {
       if(value!=null&&value!=""){
          var result0 = "<select select id='qxId' path='qxId.id'  name='qxId.id' class='input-xlarge required' style='width:212px;' onchange=''><option value=''></option>";
		  $.getJSON("${ctx}/sys/area/findallbychr", {parentId: value}, function(result) {
			$.each(result, function(i, field) {
				//修改地区信息
				result0+="<option value="+field.id+">"+field.name+"</option>";
			});
			result0+="</select>";
			$("#qSelect").html(result0);
			$("#qxId").select2();
		 });
       }else{
           alertx("获取城市数据失败,请联系管理员!");
       }
	 }
	 //验证联系电话
	 function validateLxdh()
		{
			var value = $("#lxdh").val();
			if(value !=null && value!="")
			{
				var isTrue = /^1\d{10}$/i.test(value) || /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i.test(value);
				if(!isTrue)
				{
				   validTxt("lxdh","联系电话格式有问题");
				   return false;
				}
			}
			return true;
		}
	 //验证身份证信息是否重复
	  function validateSfzxx(){
	     var sfzjhvalue = $("#sfzjh").val();
	     if(sfzjhvalue!=null&&sfzjhvalue!=""){
	          // 身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X
             var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
             if(reg.test(sfzjhvalue) === false){
                  validTxt("sfzjh","身份证件号码输入不合法");
                  return  false;
             }
             //验证身份证是否重复
	         $.getJSON("${ctx}/syxx/syJbxx/validateSyxx",{sfzjh:sfzjhvalue},function(result){
			   if(result!=null&&result!=""){
			     validTxt("sfzjh",result);
			     return false;
			   }else{
			     validTxt("sfzjh","");
			     return false;
			   }
		    });
	     }
	     return true;
	  }
		
  </script>

	<%-- <ul class="nav nav-tabs">
		<li><a href="${ctx}/syxx/syJbxx/">生源信息列表</a></li>
		<li class="active"><a href="${ctx}/syxx/syJbxx/form?id=${syJbxx.id}">生源信息<shiro:hasPermission name="syxx:syJbxx:edit">${not empty syJbxx.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="syxx:syJbxx:edit">查看</shiro:lacksPermission></a></li>
	</ul> --%><br/>
	<form:form id="inputForm" modelAttribute="syJbxx" action="${ctx}/syxx/syJbxx/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
		    <div class="lg-form">
			  <label class="control-label">姓名：</label>
			  <div class="controls">
				<form:input path="xm" htmlEscape="false" maxlength="64" class="input-xlarge required" style="width:200px;"/>
				<span class="help-inline"><font color="red">*</font> </span>
			  </div>
			</div>
			<div class="lg-form">
			   <label class="control-label">性别：</label>
			   <div class="controls">
				<form:select path="xbm" class="input-xlarge required" style="width:212px;">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			    <span class="help-inline"><font color="red">*</font> </span>
			</div>
			</div>
		</div>
		<div class="control-group">
		   <div class="lg-form">
			<label class="control-label">出生日期：</label>
			<div class="controls">
				<input name="csrq" type="text" readonly="readonly" maxlength="64" class="input-xlarge Wdate required"
					value="<fmt:formatDate value="${syJbxx.csrq}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		  </div>
		  <div class="lg-form">
		     <label class="control-label">年份：</label>
			<div class="controls">
				<input name="nf" type="text" readonly="readonly" maxlength="64" class="input-xlarge Wdate required"
					   value="${fns:getDate(syJbxx.nf)}" pattern="yyyy" style="width:200px;"
					   onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		  </div>
		</div>
		<div class="control-group">
		  <div class="lg-form">
			<label class="control-label">省份：</label>
			<div class="controls">
				<form:select path="sfId.id"  onchange="setByChr(this.value)" class="input-xlarge" style="width:212px;">
					<form:option value="" label=""/>
					<form:options items="${fns:findAllByChr('1')}" itemLabel="name"
						          itemValue="id" htmlEscape="false" />
				</form:select>
			</div>
		  </div>
		   <div class="lg-form">
		      <label class="control-label">学历：</label>
			<div class="controls">
				<form:select path="xlm" class="input-xlarge" style="width:212px;">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('education_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		   </div>
		</div>
		<div class="control-group">
		 <div class="lg-form">
			<label class="control-label">城市：</label>
			<div class="controls" id="cSelect">
			   <form:select id="csId.id" path="csId.id" class="input-xlarge" style="width:212px;">
				   <form:option value="" label="" />
				   <form:options items="${fns:findAllByChr(syJbxx.sfId.id)}" itemLabel="name"
						         itemValue="id" htmlEscape="false" />
				</form:select>
			</div>
			</div>
			 <div class="lg-form">
			  <label class="control-label">学期：</label>
			<div class="controls">
				<form:select path="xqId" class="input-xlarge" style="width:212px;">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('term_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
			 </div>
		</div>
		<div class="control-group">
		 <div class="lg-form">
			<label class="control-label">区县：</label>
			<div class="controls" id="qSelect">
			    <form:select id="qxId.id" path="qxId.id" class="input-xlarge" style="width:212px;">
				   <form:option value="" label="" />
				   <form:options items="${fns:findAllByChr(syJbxx.csId.id)}" itemLabel="name"
						         itemValue="id" htmlEscape="false" />
				</form:select>
			</div>
			</div>
			 <div class="lg-form">
			   <label class="control-label">学生来源：</label>
			<div class="controls">
				<form:select path="xsly" class="input-xlarge" style="width:212px;">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('xs_ly')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
			 </div>
		</div>
		<div class="control-group">
		 <div class="lg-form">
			<label class="control-label">详细地址：</label>
			<div class="controls">
				<form:input path="xxdz" htmlEscape="false" maxlength="255" class="input-xlarge " style="width:200px;"/>
			</div>
			</div>
			 <div class="lg-form">
			   <label class="control-label">联系电话：</label>
			<div class="controls">
				<form:input path="lxdh" id="lxdh" htmlEscape="false" maxlength="32" class="input-xlarge "
				            onblur="validateLxdh()" style="width:200px;"/><label></label>
			</div>
			 </div>
		</div>
		<div class="control-group">
		   <div class="lg-form">
			<label class="control-label">身份证件号码：</label>
			<div class="controls">
				<form:input id="sfzjh" path="sfzjh" htmlEscape="false" maxlength="18" class="input-xlarge " 
				            onblur="validateSfzxx()" style="width:200px;"/>
				<label></label>           
			</div>
		   </div>
		   <div class="lg-form">
		      <label class="control-label">毕业学校：</label>
			<div class="controls">
				<form:input path="byxx" htmlEscape="false" maxlength="64" class="input-xlarge " 
					style="width:200px;"/>
			</div>
		   </div>
		</div>
		<div class="control-group">
		  <div class="lg-form">
			<label class="control-label">学校名称：</label>
			<div class="controls">
				<form:input path="xxmc" htmlEscape="false" maxlength="64" class="input-xlarge " style="width:200px;"/>
			</div>
			</div>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" 
					class="input-xxlarge " style="width:720px;"/>
			</div>
		</div>
		<div class="form-actions">
			<%-- <shiro:hasPermission name="syxx:syJbxx:edit">
			</shiro:hasPermission> --%>
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存" />&nbsp;
			<input id="btnCancel" class="btn" type="button" value="关闭" onclick="closeDialog();"/>
		</div>
	</form:form>
</body>
</html>