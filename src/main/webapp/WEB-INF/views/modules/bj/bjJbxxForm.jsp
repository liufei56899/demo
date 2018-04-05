<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>班级管理</title>
	<meta name="decorator" content="default"/>	
</head>
<body>
<style type="text/css">
		.form-horizontal .control-label
		{
			width:175px;
		}
		.form-horizontal .widthLab
		{
			width:205px;
			padding-right: 7px;
		}
		
		
</style>
<script type="text/javascript" src="${ctxStatic}/common/jeesite.js"></script>
<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					var istrue = btnSub();
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
			var info = "${bjJbxx.zylxId.id}";
			var zyId = "${bjJbxx.zyId.id}";
			if(info !=null && info!=""){
				$.getJSON("${ctx}/zy/zyJbxx/findInitZysByLxId",{id:info,zyId:zyId},function(result){
			       $("#zyByLx").html(result.html);
			       $("#zyid").attr("style","width:185px;");
			       $("#zyid").select2();//设置样式
			  	});			  	
			}
			
		});
		
		function btnSub()
		{
			var ret = validateBjmc();
			if(ret)
			{
				ret = validateBh();
			}
			if(ret)
			{
				ret = datePD();
			}
			if(ret)
			{
				ret = jsPD();
			}		
			return ret;
		}
		//班主任必填项验证
		function jsPD(){
		   var js=$("#primaryPersonId").val();
		   if(js=="" || js ==  null){
		   	$("#span").before("<label class='error'>必填信息</label>");
		   	return false;
		   }
		   return true;
		}
		
		
		//验证编号是否为纯数字
		function validateBh()
		{
			var bh =$("#bh").val();
			if(bh!=null && bh!="")
			{
				var ret = /^[+]?[1-9]+\d*$/i.test(bh);
				if(!ret)
				{
					validTxt("bh","请输入正确的格式");
					return false;
				}
			}
			return true;
		}
		
		//时间判断
		function datePD(){
			var sDate = $("#jbny").val();
			var eDate = $("#byrq").val();
			var date= new Date(sDate);
			var date1= new Date(eDate);			
			if( eDate == "" || date<date1){
     			return true;
			}else{
				alertx("毕业日期不能小于或者等于建班日期！");
     			return false;
			}
		}
		
		//验证班级名称是否重复
		function validateBjmc()
		{
			var bjmc = $("#bjmc1").val();
			var id = "${bjJbxx.id}";
			var isTrue = true;
			if(bjmc!=null && bjmc!="")
			{
				 jQuery.ajax({
			        type: "POST",
			        url: "${ctx}/bj/bjJbxx/validateBjmc",
			        data: {bjmc:bjmc,id:id},
			        dataType:'json',
			        async:false,
					success: function(result){
						isTrue = result.isTrue;
						if(!isTrue)
						{
							validTxt("bjmc1","班级名称不能重复");
							return false;
						}
				   }
			    });
			}
			return isTrue;
		}
		
		function checkRnrs(id,mes) { 
		    var txt = $("#rnrs").val();
		    var r = /^\+?[1-9][0-9]*$/;//正整数 
     		var b = r.test(txt);
     		if(!b){
     		   var txt = $("#rnrs").val(0);
     		   validTxt(id,mes);
     		}
     	} 
         function validateYear(obj,id,mes){
			   if(!/^\d{4}$/.test(obj.value)){
			   var myDate = new Date();
				 myDate.getYear(); //获取当前年份(2位)
				 obj.value=myDate.getFullYear();
				 validTxt(id,mes);
			   }
		 }
		 
		 function lxChange(info){
		    $.getJSON("${ctx}/zy/zyJbxx/findZysByLxId",{id:info},function(result){
		       $("#zyByLx").html(result.html);
		       $("#zyid").attr("style","width:185px;");
		       $("#zyid").select2();//设置样式
		  	});
		 }
	</script>
	<%-- <ul class="nav nav-tabs">
		<li><a href="${ctx}/bj/bjJbxx/">班级列表</a></li>
		<li class="active"><a href="${ctx}/bj/bjJbxx/form?id=${bjJbxx.id}">班级<shiro:hasPermission name="bj:bjJbxx:edit">${not empty bjJbxx.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="bj:bjJbxx:edit">查看</shiro:lacksPermission></a></li>
	</ul> --%><br/>
	<form:form id="inputForm" modelAttribute="bjJbxx" action="${ctx}/bj/bjJbxx/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
		<div class="lg-form" style="width:1200px;">
			<label class="control-label">班级名称：</label>
			<div class="controls">
				<form:input path="bjmc" id="bjmc1" htmlEscape="false" maxlength="64" 
					style="width:815px;" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<%-- <div class="lg-form">
		   <label class="control-label">年份：</label>
			<div class="controls">
				<form:input path="nf" id="nf" onblur="validateYear(this,'nf','年份格式不对')" style="width:170px;" htmlEscape="false" maxlength="11" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div> --%>
		</div>
		
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">班号：</label>
				<div class="controls">
					<form:input path="bh" id="bh" htmlEscape="false" maxlength="20" style="width:170px;" 
						class="input-xlarge required"/>
					<span class="help-inline"><font color="red">*</font> </span>
					<span class="help-inline">格式为纯数字</span>
				</div>
			</div>
			<div class="lg-form">
			   <label class="control-label widthLab">学年：</label>
				<div class="controls">
					<%-- <form:input path="njid" id="njid" 
						style="width:170px;" htmlEscape="false" maxlength="11" class="input-xlarge required"/> --%>
					<select style="width:185px;" id="njid"  name="njid.id" class="input-xlarge required">
						<option value="">请选择</option>
						<c:forEach items="${xnList }" var="xn">
							<option value="${xn.id }"
								<c:if test="${xn.id eq bjJbxx.njid.id }">selected="selected"</c:if>
							>${xn.xnmc}</option>
						</c:forEach>
					</select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</div>
	
		<div class="control-group">
		   <%-- <div class="lg-form">
			<label class="control-label">学期：</label>
			<div class="controls">
			<form:select  path="xqId" class="input-xlarge required" style="width:185px;">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('term_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
			</div> --%>
			<div class="lg-form">
				<label class="control-label">建班日期：</label>
				<div class="controls">
					<%-- <form:input path="bh" htmlEscape="false" maxlength="64" style="width:170px;" 
						class="input-xlarge required"/> --%>
					<input name="jbny" id="jbny" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
						value="<fmt:formatDate value="${bjJbxx.jbny}" pattern="yyyy-MM-dd"/>"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" style="width:170px;"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
			   <label class="control-label widthLab">专业类别：</label>
				<div class="controls">
					<form:select path="zylxId.id" id="zylxId" style="width:185px;" onchange="lxChange(this.value)" class="input-xlarge required">
							<form:option value="" label=""/>
							<form:options items="${fns:getZylxList()}" itemLabel="lxmc" itemValue="id" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
			</div>
		</div>
		
		<div class="control-group">
		<div class="lg-form">
			<label class="control-label">专业名称：</label>
			<div class="controls" id="zyByLx" >
				<form:select path="zyId.id"  class="input-xlarge required" style="width:185px;">
							<form:option value="" label=""/>
							<%-- <form:options items="${fns:getZyList()}" itemLabel="zymc" itemValue="id" htmlEscape="false"/> --%>					
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
			</div>
			<div class="lg-form">
			  <label class="control-label widthLab">容纳人数：</label>
			<div class="controls">
				<form:input path="rnrs" id="rnrs" style="width:170px;" 
					onblur="checkRnrs('rnrs','只能为正整数')" htmlEscape="false" maxlength="11" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">校区名称：</label>
				<div class="controls">
					<%-- <form:input path="bh" htmlEscape="false" maxlength="64"
						style="width:170px;" class="input-xlarge required"/> --%>
					<form:select path="xqmc"  class="input-xlarge required" style="width:185px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('xqmc')}" itemLabel="label" 
							itemValue="value" htmlEscape="false"/>
					</form:select>
					
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
			   <label class="control-label widthLab">班主任：</label>
				<div class="controls">
					<sys:treeselect id="primaryPerson"   name="jsId" value="${bjJbxx.jsId.id}" labelName="bjJbxx.jsId.name" labelValue="${bjJbxx.jsId.name}"
					title="用户" url="/sys/office/treeData?type=3"
					allowClear="true" notAllowSelectParent="true"  cssClass="tabTreeselect" />					
					<span id="span" class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</div>	
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">是否少数名族双语教学班：</label>
				<div class="controls">
					<form:select path="sfssmzjxb"  class="input-xlarge" style="width:185px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('sfdm')}" itemLabel="label" 
							itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="lg-form">
			   <label class="control-label widthLab">少数名族双语教学班语言名称：</label>
				<div class="controls">
					<form:input path="ssmzjxbmzyymc" id="ssmzjxbmzyymc"  style="width:170px;" 
					htmlEscape="false" maxlength="60" class="input-xlarge"/>
					<span class="help-inline"></span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">少数名族双语教学模式：</label>
				<div class="controls">
					<form:select path="ssmzsyjxms"  class="input-xlarge" style="width:185px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('ssmzsyjxms')}" itemLabel="label" 
							itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="lg-form">
			   <label class="control-label widthLab">是否全日制：</label>
				<div class="controls">
					<form:select path="sfqrz"  class="input-xlarge" style="width:185px;">
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
				<label class="control-label">内地新疆中职班：</label>
				<div class="controls">
					<form:select path="ndxjzzb"  class="input-xlarge" style="width:185px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('sfdm')}" itemLabel="label" 
							itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="lg-form">
			   <label class="control-label widthLab">内地西藏中职班：</label>
				<div class="controls">
					<form:select path="ndxzzzb"  class="input-xlarge" style="width:185px;">
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
				<label class="control-label">是否毕业班：</label>
				<div class="controls">
					<form:select path="sfbyb"  class="input-xlarge" style="width:185px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('sfdm')}" itemLabel="label" 
							itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="lg-form">
			   <label class="control-label widthLab">毕业日期：</label>
				<div class="controls">
					<input name="byrq" id="byrq" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
						value="<fmt:formatDate value="${bjJbxx.byrq}" pattern="yyyy-MM-dd"/>"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" style="width:170px;"/>
					<span class="help-inline"></span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">班级荣誉称号：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" 
					class="input-xxlarge " style="width:780px;"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="bj:bjJbxx:edit">
			<input id="btnSubmit" class="btn btn-primary" type="submit" 
				value="保 存"/>&nbsp;</shiro:hasPermission>
			<!-- <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/> -->
			<input id="btnCancel" class="btn" type="button" value="关闭" onclick="closeDialog();"/>
		</div>
	</form:form>
</body>
</html>