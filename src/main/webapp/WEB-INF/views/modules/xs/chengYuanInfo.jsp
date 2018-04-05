<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学生信息管理</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
	  .tabTreeselect 
	  {
	  	width:226px;
	  }
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					/* var isTrue = validateSub();
					    alert(isTrue)
					if(isTrue)
					{
						loading('正在提交，请稍等...');
						form.submit();
					} */
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
			chengYuanYiOnBlur();
			chengYuanErOnBlur();
			
			
		});
		
		
		//
		function validateSub()
		{
			var isTrue = validateDh("cyylxdh");
			if(isTrue)
			{
				isTrue = validateSfz1();
			}
			if(isTrue)
			{
				isTrue = validateDh("cyelxdh");
			}
			if(isTrue)
			{
				isTrue =validateSfz2();
			}
			return isTrue;
		}
		
		
		//验证身份证号
		function validateSfz1()
		{
			var sfzjhVal = $("#cyysfzjh").val();
			if(sfzjhVal!=null && sfzjhVal!="")
			{
				var isT = IdCardValidate(sfzjhVal);
				if(!isT)
				{
					validTxt("cyysfzjh","请输入正确的身份证件号码");
					return false
				}
			}
			return true;
		}
		
		//验证身份证号
		function validateSfz2()
		{
			var sfzjhVal = $("#cyesfzjh").val();
			if(sfzjhVal!=null && sfzjhVal!="")
			{
				var isT = IdCardValidate(sfzjhVal);
				if(!isT)
				{
					validTxt("cyesfzjh","请输入正确的身份证件号码");
					return false
				}
			}
			return true;
		}
		
		
		//验证电话格式
		function validateDh(id)
		{
			var value = $("#"+id).val();
			if(value!=null && value!="")
			{
				var isTrue = /^1\d{10}$/i.test(value) || /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i.test(value);
				if(!isTrue)
				{
				   validTxt(id,"联系电话格式有问题");
				   return false;
				}
			}
			return true;
		}
		
		
		
		//成员1信息
		/**
		   （成员1和成员2信息可以都不填写）。若填写成员1或成员2信息时蓝色字体的4项信息同时为必填项，黑色字体为选填项
		**/
		function chengYuanYiOnBlur()
		{
			var cyyxm =$("#cyyxm").val();//姓名
			var cyygx = $("#cyygx").val();//关系
			var cyysfjhr = $("#cyysfjhr").val();//是否监护人
			var cyylxdh = $("#cyylxdh").val();//联系电话
			
			if((cyyxm !=null && cyyxm!="") || (cyygx !=null && cyygx!="") || (cyysfjhr !=null && cyysfjhr!="") || 
			 (cyylxdh !=null && cyylxdh!="") )
			 {
			 	addValidate("cyyxm");
				addValidate("cyygx");
				addValidate("cyysfjhr");
				addValidate("cyylxdh");
			 }else
			 {
			 	emptyValidate("cyyxm");
				emptyValidate("cyygx");
				emptyValidate("cyysfjhr");
				emptyValidate("cyylxdh");
			 	
			 }
		}
		
		//验证成员2信息
		function chengYuanErOnBlur()
		{
			var cyexm =$("#cyexm").val();//姓名
			var cyegx = $("#cyegx").val();//关系
			var cyesfjhr = $("#cyesfjhr").val();//是否监护人
			var cyelxdh = $("#cyelxdh").val();//联系电话
			if((cyexm !=null && cyexm!="") || (cyegx !=null && cyegx!="") || (cyesfjhr !=null && cyesfjhr!="") || 
			 (cyelxdh !=null && cyelxdh!="") )
			 {
			 	addValidate("cyexm");
				addValidate("cyegx");
				addValidate("cyesfjhr");
				addValidate("cyelxdh");
			 }else
			 {
			 	emptyValidate("cyexm");
				emptyValidate("cyegx");
				emptyValidate("cyesfjhr");
				emptyValidate("cyelxdh");
			 	
			 }
		}
		
		
		//添加验证
		function addValidate(id)
		{
		    if($("#"+id).next().attr("class") =="error")
			{
				$("#"+id).next().next().html("<font color='red'>*</font>");
			}else
			{
				$("#"+id).next().html("<font color='red'>*</font>");
			}
		    //$("#"+id).next().html("<font color='red'>*</font>");
			$("#"+id).addClass("required");
		}
		
		
		//清空验证
		function emptyValidate(id)
		{
			if($("#"+id).next().attr("class") =="error")
			{
			   	$("#"+id).next().remove();
			   	$("#"+id).next().empty();
			}
			else
			{
				$("#"+id).next().empty();
			}
			$("#"+id).removeClass("required");
			$("#"+id).removeClass("error");
		}
		
		function saveBefferCheck(){
			var shzt = "${xsJbxx.shzt}";
			if(shzt == 1){
				alert("该信息已经审核，不能修改！");
				return false;
			}
			return true;
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/xs/xsJbxx/list/">学生信息列表</a></li>
		<li><a href="${ctx}/xs/xsJbxx/form?id=${xsJbxx.id}">学生信息<shiro:hasPermission name="xs:xsJbxx:edit">${not empty xsJbxx.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="xs:xsJbxx:edit">查看</shiro:lacksPermission></a></li>
		<li class="active"><a href="${ctx}/xs/xsJbxx/chengYuanInfo?id=${xsJbxx.id}">成员信息修改
		<shiro:hasPermission name="xs:xsJbxx:edit">
		</shiro:hasPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="xsJbxx" action="${ctx}/xs/xsJbxx/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<fieldset>
			<legend>成员1信息:</legend>
		</fieldset>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">姓名：</label>
				<div class="controls">
					<form:input path="cyyxm" id="cyyxm" htmlEscape="false" maxlength="15" class="input-xlarge " style="width:268px;"/>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">关系：</label>
				<div class="controls">
					<form:select path="cyygx" id="cyygx" class="input-xlarge " style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('cygx')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"></span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">是否监护人：</label>
				<div class="controls">
					<form:select path="cyysfjhr" id="cyysfjhr" class="input-xlarge " style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('sfdm')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">联系电话：</label>
				<div class="controls">
					<form:input path="cyylxdh" id="cyylxdh" htmlEscape="false" maxlength="32" class="input-xlarge " style="width:268px;"/>
					<span class="help-inline"></span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">出生年月：</label>
				<div class="controls">
					<input name="cyycsny" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
						value="${fns:getDate(xsJbxx.cyycsny)}" pattern="yyyy-MM-dd" 
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" style="width:268px;"/>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">身份证件类型：</label>
				<div class="controls">
					<form:select path="cyysfzjlx" class="input-xlarge " style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('sfzjlx')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">身份证件号码：</label>
				<div class="controls">
					<form:input path="cyysfzjh" id="cyysfzjh" onblur="validateSfz1();"
						htmlEscape="false" maxlength="18" class="input-xlarge " style="width:268px;"/>
						<span class="help-inline"></span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">民族：</label>
				<div class="controls">
					<form:select path="cyymzm" class="input-xlarge " style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('nation')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">政治面貌：</label>
				<div class="controls">
					<form:select path="cyyzzmmm" class="input-xlarge " style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('zzmm')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">健康状况：</label>
				<div class="controls">
					<form:select path="cyyjkzkm" class="input-xlarge " style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('health')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">工作或学习单位：</label>
				<div class="controls">
					<form:input path="cyygzhxxdw" htmlEscape="false" maxlength="255" class="input-xlarge " style="width:268px;"/>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">职务：</label>
				<div class="controls">
					<form:input path="cyyzw" htmlEscape="false" maxlength="20" class="input-xlarge " style="width:268px;"/>
				</div>
			</div>
		</div>
		<fieldset>
			<legend>成员2信息:</legend>
		</fieldset>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">姓名：</label>
				<div class="controls">
					<form:input path="cyexm" id="cyexm" htmlEscape="false" maxlength="15" class="input-xlarge " style="width:268px;"/>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">关系：</label>
				<div class="controls">
					<form:select path="cyegx" id="cyegx" class="input-xlarge " style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('cygx')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"></span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">是否监护人：</label>
				<div class="controls">
					<form:select path="cyesfjhr" id="cyesfjhr" class="input-xlarge " style="width:284px;">
						<form:options items="${fns:getDictList('sfdm')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">联系电话：</label>
				<div class="controls">
					<form:input path="cyelxdh" id="cyelxdh" htmlEscape="false" maxlength="32" class="input-xlarge " style="width:268px;"/>
					<span class="help-inline"></span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">出生年月：</label>
				<div class="controls">
					<input name="cyecsny" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
						value="${fns:getDate(xsJbxx.cyecsny)}" pattern="yyyy-MM-dd"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" style="width:268px;"/>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">身份证件类型：</label>
				<div class="controls">
					<form:select path="cyesfzjlx" class="input-xlarge " style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('sfzjlx')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">身份证件号码：</label>
				<div class="controls">
					<form:input path="cyesfzjh" id="cyesfzjh" onblur="validateSfz2();"
						htmlEscape="false" maxlength="18" class="input-xlarge " style="width:268px;"/>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">民族：</label>
				<div class="controls">
					<form:select path="cyemzm" class="input-xlarge " style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('nation')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">政治面貌：</label>
				<div class="controls">
					<form:select path="cyezzmmm" class="input-xlarge " style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('zzmm')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">健康状况：</label>
				<div class="controls">
					<form:select path="cyejkzkm" class="input-xlarge " style="width:284px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('health')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">工作或学习单位：</label>
				<div class="controls">
					<form:input path="cyegzhxxdw" htmlEscape="false" maxlength="255" class="input-xlarge " style="width:268px;"/>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">职务：</label>
				<div class="controls">
					<form:input path="cyezw" htmlEscape="false" maxlength="20" class="input-xlarge " style="width:268px;"/>
				</div>
			</div>
		</div>
	
		<div class="form-actions">
			<shiro:hasPermission name="xs:xsJbxx:edit"><input id="btnSubmit" onclick="return saveBefferCheck()" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>