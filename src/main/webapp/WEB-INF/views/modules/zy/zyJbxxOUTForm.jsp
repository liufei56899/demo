<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>专业管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<style type="text/css">
		.form-horizontal .control-label
		{
			width:130px;
		}
		.form-horizontal .controls
		{
			margin-left: 147px;
		}
		.form-horizontal .lg-form .labWidth
		{
			width:160px;
			padding-right: 15px;
		}
		
		.form-horizontal .lg-form .controls .input-xlarge
		{
			width:180px;
		}
		.form-horizontal .lg-form .controls .select2-container
		{
			width:192px;
		}
		
		
	</style>
<script type="text/javascript" src="${ctxStatic}/common/jeesite.js"></script>
<script type="text/javascript">
		$(document).ready(function() {
			$("#inputForm1").validate({
				submitHandler: function(form){
					var istrue = subClick1();
					if(istrue)
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
		
		function subClick1()
		{
			var istrue = validZymc1();
			if(istrue)
			{
				istrue = validJss1();
			}
			if(istrue)
			{
				istrue = validZfs1();
			}
			return istrue;
		}
		
		//验证教师数
		function validJss1()
		{
			var istrue = true;
			//zyjss 教师数
			var zyjss= $("#zyjss").val();
			if(zyjss!=null && zyjss!="")
			{
				 var istrue1 = /^[+]?[1-9]+\d*$/i.test(zyjss);
				 if(!istrue1)
				 {
				 	validTxt("zyjss","请输入整数");
				 	istrue = false;
				 }
			}
			return istrue;
		}
		
		function validZfs1()
		{
			var istrue = true;
			//zyzfs
			var zyzfs = $("#zyzfs").val();
			if(zyzfs!=null && zyzfs!="")
			{
				var istrue1 = /^([1-9]\d*(\.\d{1,2})?$)|^(0\.\d{1,2}$)|^0$/.test(zyzfs); 
				if(!istrue1)
				{
					validTxt("zyzfs","请输入最多2位小数的数字");
				 	istrue = false;
				}
			}
			return istrue;
		}
		
		//验证专业名称是否重复
		function validZymc1()
		{
			var zymc = $("#zymc2").val();//专业名称
			var zylxid = "";//专业类别id
			var xz=$("#xz2").find("option:selected").val();//学制
			var isTrue = true;
			var id ="${zyJbxx.id}";
			//console.log(zymc+"=="+zylxid+"===="+id);
			if(zymc!=null && zymc!="")
			{
				 jQuery.ajax({
			        type: "POST",
			        url: "${ctx}/zy/zyJbxx/validateZyMc",
			        data: {zymc:zymc,id:id,zylxid:zylxid,xz:xz},
			        dataType:'json',
			        async:false,
					success: function(result){
						isTrue = result.isTrue;
						if(!isTrue)
						{
							validTxt("xz2","该专业学制已存在");
							return false;
						}
				   }
			    });
				
			}
			return isTrue;
		}
		
	</script>
	<br/>
	<form:form id="inputForm1" modelAttribute="zyJbxx" action="${ctx}/zy/zyJbxx/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">专业类别：</label>
				<div class="controls">
					<label>目录外</label>
					<input type="hidden" name="zylx.id" value="0"/>
					<input type="hidden" name="zymlbb" value="0"/>
				</div>
			</div>
			<%-- <div class="lg-form">
				<label class="control-label labWidth">专业类别：</label>
				<div class="controls">
					<form:select path="zylx.id" id="zylxid" class="input-xlarge required" onchange="loadZy(this.value)">
						<form:option value="" label=""/>
							<form:options items="${fns:getZylxList()}" itemLabel="lxmc" itemValue="id" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div> --%>
		</div>
		
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">专业名称：</label>
				<div class="controls" id="zy_Id">
					<form:input path="zymc" id="zymc2" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
					
					<!-- <form:select path="zymc" id="zymc1" class="input-xlarge required" onchange="loadZyjnfx(this.value)">
						<form:option value="" label=""/>
					</form:select> -->
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label labWidth">专业方向：</label>
				<div class="controls" id="zyfx_Id">
					<form:input path="zyfxmc" htmlEscape="false" maxlength="64" class="input-xlarge" />
					
					<!-- <form:select path="zyfxmc" id="zyfxmc" class="input-xlarge">
						<form:option value="" label=""/>
					</form:select> -->
				</div>
			</div>
		</div>
		
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">学制：</label>
				<div class="controls">
					<form:select path="xz" id="xz2" class="input-xlarge required" >
						<form:options items="${fns:getDictList('xzdm')}" itemLabel="label" 
							itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red"></font> </span> 
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label labWidth">是否涉农专业：</label>
				<div class="controls">
					<form:select path="sfsnzy" class="input-xlarge" >
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('sfdm')}" itemLabel="label" 
							itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"></span>
				</div>
			</div>
		</div>
		
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">本校专业编号：</label>
				<div class="controls">
					<form:input path="bxzybh" htmlEscape="false" maxlength="64" class="input-xlarge" 
						/>
					<!-- <span class="help-inline"><font color="red">*</font> </span> -->
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label labWidth">专业简称：</label>
				<div class="controls">
					<form:input path="zyjc" htmlEscape="false" maxlength="64" class="input-xlarge" 
						/>
					<!-- <span class="help-inline"><font color="red">*</font> </span> -->
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">专业教师数：</label>
				<div class="controls">
					<form:input path="zyjss" id="zyjss" htmlEscape="false" maxlength="3" class="input-xlarge" 
						/>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label labWidth">总分数：</label>
				<div class="controls">
					<form:input path="zyzfs" id="zyzfs" htmlEscape="false" maxlength="6" class="input-xlarge" 
						/>
					<span class="help-inline"></span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">建立年月：</label>
				<div class="controls"><!-- ${fns:getDate(xsJbxx.rxny)} -->
					<input name="jlny" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
						value="<fmt:formatDate value="${zyJbxx.jlny }" pattern="yyyy-MM-dd"/>" pattern="yyyy-MM-dd" 
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label labWidth">办学状态：</label>
				<div class="controls">
					<form:select path="bxzt" class="input-xlarge required" >
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('bxzt')}" itemLabel="label" 
							itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</div>
		
		<div class="control-group">
			<div class="lg-form" style="width:788px;">
				<label class="control-label">备注信息：</label>
				<div class="controls">
					<form:textarea id="remarks" path="remarks" htmlEscape="false" rows="3" maxlength="255" 
						class="input-xxlarge " style="width:618px;"/>
				</div>
			</div>
		</div>
		
		
		
		
		
		
		<div class="form-actions">
			<shiro:hasPermission name="zy:zyJbxx:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<!-- <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/> -->
			<input id="btnCancel" class="btn" type="button" value="关闭" onclick="closeDialog();"/>
		</div>
	</form:form>
</body>
</html>