<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学生信息记录管理</title>
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
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/xs/xsJbxxRecord/">学生信息记录列表</a></li>
		<li class="active"><a href="${ctx}/xs/xsJbxxRecord/form?id=${xsJbxxRecord.id}">学生信息记录<shiro:hasPermission name="xs:xsJbxxRecord:edit">${not empty xsJbxxRecord.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="xs:xsJbxxRecord:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="xsJbxxRecord" action="${ctx}/xs/xsJbxxRecord/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">学生编号：</label>
			<div class="controls">
				<form:input path="xsId" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">姓名：</label>
			<div class="controls">
				<form:input path="xm" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">性别码 0：未知；1：男；2：女；9：未说明：</label>
			<div class="controls">
				<form:input path="xbm" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">出生日期：</label>
			<div class="controls">
				<form:input path="csrq" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">身份证件类型：</label>
			<div class="controls">
				<form:input path="sfzjlxm" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">身份证件号码：</label>
			<div class="controls">
				<form:input path="sfzjh" htmlEscape="false" maxlength="18" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">姓名拼音：</label>
			<div class="controls">
				<form:input path="xmpy" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">班级名称：</label>
			<div class="controls">
				<form:input path="bjmc" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">学号：</label>
			<div class="controls">
				<form:input path="xh" htmlEscape="false" maxlength="18" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">学生类别：</label>
			<div class="controls">
				<form:input path="xslbm" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">学习形式：</label>
			<div class="controls">
				<form:input path="xxxsm" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">入学方式：</label>
			<div class="controls">
				<form:input path="rxfsm" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">就读方式：</label>
			<div class="controls">
				<form:input path="jdfsm" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">国籍/地区：</label>
			<div class="controls">
				<form:input path="gjdqm" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">港澳台侨外：</label>
			<div class="controls">
				<form:input path="gatqwm" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">婚姻状况：</label>
			<div class="controls">
				<form:input path="hyzkm" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">乘火车区间：</label>
			<div class="controls">
				<form:input path="chcqj" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否随迁子女：</label>
			<div class="controls">
				<form:input path="sfsqzn" htmlEscape="false" maxlength="1" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">生源地行政区划码：</label>
			<div class="controls">
				<form:input path="sydxzqhm" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">出生地行政区划码：</label>
			<div class="controls">
				<form:input path="csdxzqhm" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">籍贯地行政区划码：</label>
			<div class="controls">
				<form:input path="jgdxzqhm" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">户口所在地区县以下详细地址：</label>
			<div class="controls">
				<form:input path="hkszdqxyxxxdz" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">所属派出所：</label>
			<div class="controls">
				<form:input path="scpcs" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">户口所在地行政区划码：</label>
			<div class="controls">
				<form:input path="hkszdxzqhm" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">户口性质：</label>
			<div class="controls">
				<form:input path="hkxz" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">学生居住地类型：</label>
			<div class="controls">
				<form:input path="xsjzdlx" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">入学年月：</label>
			<div class="controls">
				<form:input path="rxny" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">专业名称：</label>
			<div class="controls">
				<form:input path="zyId" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">专业简称：</label>
			<div class="controls">
				<form:input path="zyjc" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">专业方向：</label>
			<div class="controls">
				<form:input path="zyfx" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">学制：</label>
			<div class="controls">
				<form:input path="xz" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">民族：</label>
			<div class="controls">
				<form:input path="mzm" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">政治面貌：</label>
			<div class="controls">
				<form:input path="zzmmm" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">健康状况：</label>
			<div class="controls">
				<form:input path="jkzkm" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">学生来源：</label>
			<div class="controls">
				<form:input path="xslym" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">招生对象：</label>
			<div class="controls">
				<form:input path="zsdx" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">监护人联系电话：</label>
			<div class="controls">
				<form:input path="jhrlxdh" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">毕业学校：</label>
			<div class="controls">
				<form:input path="byxx" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">联系电话：</label>
			<div class="controls">
				<form:input path="lxdh" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">招生方式：</label>
			<div class="controls">
				<form:input path="zsfs" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">联招合作类型：</label>
			<div class="controls">
				<form:input path="lzhzlx" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">准考证号：</label>
			<div class="controls">
				<form:input path="zkzh" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">考生号：</label>
			<div class="controls">
				<form:input path="ksh" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">考生总分：</label>
			<div class="controls">
				<form:input path="kszf" htmlEscape="false" maxlength="10" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">考生特长：</label>
			<div class="controls">
				<form:input path="kstc" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">考生既往病史：</label>
			<div class="controls">
				<form:input path="ksjwbs" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">体检结论：</label>
			<div class="controls">
				<form:input path="tjjl" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">联招合作办学方式：</label>
			<div class="controls">
				<form:input path="lzhzbxfs" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">联招合作学校代码：</label>
			<div class="controls">
				<form:input path="lzhzxxdm" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">校外教学点：</label>
			<div class="controls">
				<form:input path="xwjxd" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">分段培养方式：</label>
			<div class="controls">
				<form:input path="fdpyfs" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">英文姓名：</label>
			<div class="controls">
				<form:input path="ywxm" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">电子信箱/其他联系方式：</label>
			<div class="controls">
				<form:input path="dzxx" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">家庭现地址：</label>
			<div class="controls">
				<form:input path="jtxdz" htmlEscape="false" maxlength="128" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">家庭邮政编码：</label>
			<div class="controls">
				<form:input path="jtyzbm" htmlEscape="false" maxlength="6" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">家庭电话：</label>
			<div class="controls">
				<form:input path="jtdh" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">成员1姓名：</label>
			<div class="controls">
				<form:input path="cyyxm" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">成员1关系：</label>
			<div class="controls">
				<form:input path="cyygx" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">成员1是否监护人：</label>
			<div class="controls">
				<form:input path="cyysfjhr" htmlEscape="false" maxlength="1" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">成员1联系电话：</label>
			<div class="controls">
				<form:input path="cyylxdh" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">成员1出生年月：</label>
			<div class="controls">
				<form:input path="cyycsny" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">成员1身份证件类型：</label>
			<div class="controls">
				<form:input path="cyysfzjlx" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">成员1身份证件号码：</label>
			<div class="controls">
				<form:input path="cyysfzjh" htmlEscape="false" maxlength="18" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">成员1民族：</label>
			<div class="controls">
				<form:input path="cyymzm" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">成员1政治面貌：</label>
			<div class="controls">
				<form:input path="cyyzzmmm" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">成员1健康状况：</label>
			<div class="controls">
				<form:input path="cyyjkzkm" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">成员1工作或学习单位：</label>
			<div class="controls">
				<form:input path="cyygzhxxdw" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">成员1职务：</label>
			<div class="controls">
				<form:input path="cyyzw" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">成员2姓名：</label>
			<div class="controls">
				<form:input path="cyexm" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">成员2关系：</label>
			<div class="controls">
				<form:input path="cyegx" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">成员2是否监护人：</label>
			<div class="controls">
				<form:input path="cyesfjhr" htmlEscape="false" maxlength="1" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">成员2联系电话：</label>
			<div class="controls">
				<form:input path="cyelxdh" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">成员2出生年月：</label>
			<div class="controls">
				<form:input path="cyecsny" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">成员2身份证件类型：</label>
			<div class="controls">
				<form:input path="cyesfzjlx" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">成员2身份证件号码：</label>
			<div class="controls">
				<form:input path="cyesfzjh" htmlEscape="false" maxlength="18" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">成员2民族：</label>
			<div class="controls">
				<form:input path="cyemzm" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">成员2政治面貌：</label>
			<div class="controls">
				<form:input path="cyezzmmm" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">成员2健康状况：</label>
			<div class="controls">
				<form:input path="cyejkzkm" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">成员2工作或学习单位：</label>
			<div class="controls">
				<form:input path="cyegzhxxdw" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">成员2职务：</label>
			<div class="controls">
				<form:input path="cyezw" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">专业类别：</label>
			<div class="controls">
				<form:input path="zylxId" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">1:通过 2:不通过：</label>
			<div class="controls">
				<form:input path="shzt" htmlEscape="false" maxlength="1" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">审批内容：</label>
			<div class="controls">
				<form:input path="spnr" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="xs:xsJbxxRecord:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>