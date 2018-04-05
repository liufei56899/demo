<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>教师信息管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<script type="text/javascript" src="${ctxStatic}/common/jeesite.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					var isTrue = tiJiaoOnClick();
					if(isTrue)
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
		
		//提交时验证字段
		function tiJiaoOnClick()
		{
			var isTrue =validateGh();
			if(isTrue)
			{
				isTrue = validateLxdh();
			}
			if(isTrue)
			{
				isTrue = validateSfz("1");
			}
			if(isTrue)
			{
				isTrue = valdiateEmail();	
			}
			if(isTrue)
			{
				isTrue = jgPD();	
			}
			return isTrue;
		}
		
		//机构必填项验证
		function jgPD(){
		   var jgh=$("#jghId").val();
		   if(jgh=="" || jgh==null){
		   	$("#span").before("<label class='error'>必填信息</label>");
		   	return false;
		   }
		   return true;
		}
		
		//验证身份证号
		function validateSfz(num)
		{
			var sfzjhVal = $("#sfzjh").val();
			
			
			
			if(num!=null && num !="")
			{
				var sfzjlxmSel = $("#sfzjlxmSel").val();
				if(sfzjlxmSel!=null && sfzjlxmSel !="")
				{
					if(sfzjlxmSel=="1")
					{
						if(sfzjhVal!=null && sfzjhVal!="")
						{
							var isT = IdCardValidate(sfzjhVal);
							if(!isT)
							{
								validTxt("sfzjh","请输入正确的身份证件号码");
								return false;
							}
						}
					 	var csrqVal = findCsrqByCard(sfzjhVal);
						$("#csrqInput").val(csrqVal);
					}else{
						$("#csrqInput").val("");
					}
				}
			}
			return true;
		}
		
		//验证工号是否重复
		function validateGh()
		{
			var ghVal = $("#gh").val();
			var isTrue = true;
			var id ="${jsJbxx.id}";
			if(ghVal!=null && ghVal!="")
			{
				$.getJSON("${ctx}/js/jsJbxx/validateGhIsChongFu",{gh:ghVal,id:id},function(result){
			       if(result.isTrue)
			       {
			       		return true;
			       }
			       else
			       {
			       		validTxt("gh","工号不能重复");
				   		return false;
			       }
		  		});
			}
			return true;
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
		
		///验证电子邮箱
		function valdiateEmail()
		{
		 //dzxx
		   var value = $("#dzxx").val();
		   if(value!=null && value!="")
		   {
			   	var isTrue = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.test(value);
				if(!isTrue)
				{
				   //$("#dzxx").next().find("label").empty();
				   validTxt("dzxx","电子信箱格式有问题");
				   return false;
				}
		   }
			return true;
		}
		
		function updateFile(ev)
		{
			console.log(ev);
		}
		
		function getFilePath()
		{
			
		}
		
		
	</script>

	<br/>
	<form:form id="inputForm" modelAttribute="jsJbxx" action="${ctx}/js/jsJbxx/save" method="post" class="form-horizontal" enctype="multipart/form-data">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<c:if test="${empty jsJbxx.id}">
			<div class="control-group">
				<div class="lg-form">
					<label class="control-label">工号：</label>
					<div class="controls">
						<form:input path="gh" id="gh" htmlEscape="false" maxlength="64" 
							class="input-xlarge tabInput required" onblur="validateGh();"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div> 
			</div>
		</c:if>
			
		<div class="control-group">
			<%-- <div class="lg-form">
				<label class="control-label">学校代码：</label>
				<div class="controls">
					<form:input path="xxdm" htmlEscape="false" maxlength="64" class="input-xlarge tabInput "/>
				</div>
			</div> --%>
			<div class="lg-form">
				<label class="control-label">姓名：</label>
				<div class="controls">
					<form:input path="xm" htmlEscape="false" maxlength="64" class="input-xlarge tabInput required"
						/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">学历：</label>
				<div class="controls">
					<form:select path="xlm" class="input-xlarge " style="width:215px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('education_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
		</div>
		<div class="control-group">
			<%-- <div class="lg-form">
				<label class="control-label">工号：</label>
				<div class="controls">
					<form:input path="gh" id="gh" htmlEscape="false" maxlength="64" 
						class="input-xlarge tabInput required" onblur="validateGh();"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div> --%>
			<div class="lg-form">
				<label class="control-label">性别：</label>
				<div class="controls">
					<form:select path="xbm" class="input-xlarge required" style="width:215px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">籍贯：</label>
				<div class="controls">
					<form:input path="jg" htmlEscape="false" maxlength="64" class="input-xlarge tabInput "/>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">联系电话：</label>
				<div class="controls">
					<form:input path="lxdh" id="lxdh" htmlEscape="false" maxlength="32" 
						class="input-xlarge tabInput required" onblur="validateLxdh();"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">曾用名：</label>
				<div class="controls">
					<form:input path="cym" htmlEscape="false" maxlength="64" class="input-xlarge tabInput "/>
				</div>
			</div>
			<%-- <div class="lg-form">
				<label class="control-label">英文姓名：</label>
				<div class="controls">
					<form:input path="ywxm" htmlEscape="false" maxlength="64" class="input-xlarge tabInput "/>
				</div>
			</div> --%>
		</div>
		<%-- <div class="control-group">
			<div class="lg-form">
				<label class="control-label">姓名拼音：</label>
				<div class="controls">
					<form:input path="xmpy" htmlEscape="false" maxlength="64" class="input-xlarge tabInput "/>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">家庭住址：</label>
				<div class="controls">
					<form:input path="jtzz" htmlEscape="false" maxlength="128" class="input-xlarge tabInput "/>
				</div>
			</div>
		</div> --%>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">身份证件类型：</label>
				<div class="controls">
					<form:select path="sfzjlxm" id="sfzjlxmSel" class="input-xlarge " style="width:215px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('sfzjlx')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">身份证件号码：</label>
				<div class="controls">
					<form:input path="sfzjh" id="sfzjh" onblur="validateSfz('1');"
						htmlEscape="false" maxlength="18" class="input-xlarge tabInput required"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
				<%-- <label class="control-label">曾用名：</label>
				<div class="controls">
					<form:input path="cym" htmlEscape="false" maxlength="64" class="input-xlarge tabInput "/>
				</div> --%>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">民族：</label>
				<div class="controls">
					<form:select path="mzm" class="input-xlarge " style="width:215px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('nation')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">出生日期：</label>
				<div class="controls">
					<input name="csrq" id="csrqInput" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
						value="${fns:getDate(jsJbxx.csrq)}" pattern="yyyy-MM-dd"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" style="width:205px;"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
				<%-- <label class="control-label">籍贯：</label>
				<div class="controls">
					<form:input path="jg" htmlEscape="false" maxlength="64" class="input-xlarge tabInput "/>
				</div> --%>
			</div>
		</div>
		<%-- <div class="control-group">
			<div class="lg-form">
				<label class="control-label">学历：</label>
				<div class="controls">
					<form:select path="xlm" class="input-xlarge " style="width:215px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('education_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">出生地码：</label>
				<div class="controls">
					<sys:treeselect id="csdm" name="csdm.id" value="${jsJbxx.csdm.id}" labelName="csdm.name" labelValue="${jsJbxx.csdm.name}"
						title="区域" url="/sys/area/treeData" cssClass="tabTreeselect" allowClear="true" notAllowSelectParent="true"
						 />
				</div>
			</div>
		</div> --%>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">婚姻状况：</label>
				<div class="controls">
					<form:select path="hyzkm" class="input-xlarge " style="width:215px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('hyzk')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">政治面貌：</label>
				<div class="controls">
					<form:select path="zzmmm" class="input-xlarge " style="width:215px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('zzmm')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">参加工作年月：</label>
				<div class="controls">
					<input name="gzny" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
						value="${fns:getDate(jsJbxx.gzny)}" pattern="yyyy-MM-dd"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" style="width:205px;"/>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">国籍/地区码：</label>
				<div class="controls">
					<form:select path="gjdqm" class="input-xlarge " style="width:215px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('gjdqm')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">家庭住址：</label>
				<div class="controls">
					<form:input path="jtzz" htmlEscape="false" maxlength="128" class="input-xlarge tabInput "/>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">来校年月：</label>
				<div class="controls">
					<input name="lxny" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
						value="${fns:getDate(jsJbxx.lxny)}" pattern="yyyy-MM-dd"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" style="width:205px;"/>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">从教年月：</label>
				<div class="controls">
					<input name="cjny" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
						value="${fns:getDate(jsJbxx.cjny)}" pattern="yyyy-MM-dd"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" style="width:205px;"/>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">血型：</label>
				<div class="controls">
					<form:select path="xxm" class="input-xlarge " style="width:215px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('blood_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">健康状况：</label>
				<div class="controls">
					<form:select path="jkzkm" class="input-xlarge " style="width:215px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('health')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">港澳台侨外码：</label>
				<div class="controls">
					<form:select path="gatqwm" class="input-xlarge " style="width:215px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('gatqwm')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>	
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">信仰宗教：</label>
				<div class="controls">
					<form:select path="xyzjm" class="input-xlarge " style="width:215px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('religion')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">电子信箱：</label>
				<div class="controls">
					<form:input path="dzxx" id="dzxx" htmlEscape="false" maxlength="64" 
						class="input-xlarge tabInput " onblur="valdiateEmail();"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">邮政编码：</label>
				<div class="controls">
					<form:input path="yzbm" htmlEscape="false" maxlength="6" class="input-xlarge tabInput "/>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">主页地址：</label>
				<div class="controls">
					<form:input path="zydz" htmlEscape="false" maxlength="128" class="input-xlarge tabInput "/>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">特长：</label>
				<div class="controls">
					<form:input path="tc" htmlEscape="false" maxlength="255" class="input-xlarge tabInput "/>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">岗位职业码：</label>
				<div class="controls">
					<form:select path="gwzym" class="input-xlarge " style="width:215px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('gwzy')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">主要任课学段：</label>
				<div class="controls">
					<form:input path="zyrkxd" htmlEscape="false" maxlength="64" class="input-xlarge tabInput "/>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">编制类别码：</label>
				<div class="controls">
					<form:select path="bzlbm" class="input-xlarge " style="width:215px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('bzlbm')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">档案编号：</label>
				<div class="controls">
					<form:input path="dabh" htmlEscape="false" maxlength="10" class="input-xlarge tabInput "/>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">档案文本：</label>
				<div class="controls">
					<form:input path="dawb" htmlEscape="false" maxlength="512" class="input-xlarge tabInput "/>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">通信地址：</label>
				<div class="controls">
					<form:input path="txdz" htmlEscape="false" maxlength="255" class="input-xlarge  tabInput"/>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">身份证件有效期：</label>
				<div class="controls">
					<input name="sfzjyxq" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
						value="${fns:getDate(jsJbxx.sfzjyxq)}" pattern="yyyy-MM-dd"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" style="width:205px;"/>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">机构：</label>
				<div class="controls">
					<sys:treeselect id="jgh" name="jgh.id" value="${jsJbxx.jgh.id}" labelName="jgh.name" labelValue="${jsJbxx.jgh.name}"
						title="部门" url="/sys/office/treeData?type=2" cssClass="tabTreeselect" allowClear="true" notAllowSelectParent="true"
						/>
					<span id="span" class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">现住址：</label>
				<div class="controls">
					<form:input path="xzz" htmlEscape="false" maxlength="255" class="input-xlarge tabInput "/>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">户口所在地：</label>
				<div class="controls">
					<form:input path="hkszd" htmlEscape="false" maxlength="64" class="input-xlarge tabInput "/>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">户口性质码：</label>
				<div class="controls">
					<form:input path="hkxzm" htmlEscape="false" maxlength="64" class="input-xlarge tabInput "/>
				</div>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" 
				  class="input-xxlarge " style="width:780px;"/>
			</div>
		</div>
		
		<div class="form-actions">
			<shiro:hasPermission name="js:jsJbxx:edit">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="关闭" onclick="closeDialog();"/>
		</div>
	</form:form>
	
</body>
</html>