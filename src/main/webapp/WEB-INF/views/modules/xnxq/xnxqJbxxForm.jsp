<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学年学期管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<script type="text/javascript" src="${ctxStatic}/common/jeesite.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					var istrue =btnSub();
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
		
		function btnSub()
		{
		
			var istrue = validatexnmc();
			if(istrue)
			{
				istrue = xnmcIsChongFu();
			}
			if(istrue){
				istrue=datePD();
			}
			if(istrue)
			{
				istrue = validateShiJian();
			}
			return istrue;
		}
		
		//时间判断
		function datePD(){
			var sDate = $("#kssj").val();
			var eDate = $("#jssj").val();
			var date= new Date(sDate);
			var date1= new Date(eDate);
			if(date1>date){
				return true;
			}else{
				alertx("结束时间不能小于或者等于开始时间！");
     			return false;
			}
		}
		
		//验证学年名称格式
		function validatexnmc()
		{
			var xnmc = $("#xnmc1").val();
			var istrue =true;
			if(xnmc!=null && xnmc!=null)
			{
				//包含
				if(xnmc.indexOf("-") >=0)
				{
					var strArr = xnmc.split("-");
					if(strArr.length==2)
					{
						var str1 = strArr[0];
						var str2 = strArr[1];
						if((str1!=null && str1!="") && (str2!=null && str2!=""))
						{
							var istrue1 = /^(19|20)\d{2}$/.test(str1);
							 if(!istrue1)
							 {
							 	validTxt("xnmc1","请输入正确的格式");
							 	istrue = false;
							 }else{
							 	istrue1 = /^(19|20)\d{2}$/.test(str2);
							 	if(!istrue1)
							 	{
							 		validTxt("xnmc1","请输入正确的格式");
							 		istrue = false;
							 	}
							 }
							 
						}else{
							validTxt("xnmc1","请输入正确的格式");
							return false;
						}
					}else{
						validTxt("xnmc1","请输入正确的格式");
						return false;
					}
				}else{
					validTxt("xnmc1","请输入正确的格式");
					return false;
				}
			}
			return istrue;
		}
		
		//学年名称是否重复
		function xnmcIsChongFu()
		{
			var xnmc = $("#xnmc1").val();
			var zsjj = $("#xq").val();
			var id = "${xnxqJbxx.id}";
			var istrue =true;
			if(xnmc!=null && xnmc!=null)
			{
				jQuery.ajax({
			        type: "POST",
			        url: "${ctx}/xnxq/xnxqJbxx/validateXnmc",
			        data: {xnmc:xnmc,id:id,xq:zsjj},
			        dataType:'json',
			        async:false,
					success: function(result){
						istrue = result.isTrue;
						if(!istrue)
						{
							validTxt("xnmc1","该学年学期已存在！");
							return false;
						}
				   }
			    });
			}
			return istrue;
		}
		
		
		function validateShiJian()
		{
			var xnmc =$("#xnmc1").val();
			var strArr = xnmc.split("-");
			var str1 = strArr[0];
			var str2 = strArr[1];
			var kssj = $("#kssj").val();
			var jssj = $("#jssj").val();
			
			var ksStr = kssj.split("-");
			var jsStr = jssj.split("-");
			
			if(!(ksStr[0]>=str1 && ksStr[0]<=str2 ))
			{
				validTxt("kssj","开始时间需在学年名称段时间内");
				return false;
			}
			else if(!(jsStr[0]>=str1 && jsStr[0]<=str2))
			{
				validTxt("jssj","结束时间需在学年名称段时间内");
				return false;
			}
			return true;
			
			
		}
		
	</script>
	<%-- <ul class="nav nav-tabs">
		<li><a href="${ctx}/xnxq/xnxqJbxx/">学年学期列表</a></li>
		<li class="active"><a href="${ctx}/xnxq/xnxqJbxx/form?id=${xnxqJbxx.id}">学年学期<shiro:hasPermission name="xnxq:xnxqJbxx:edit">${not empty xnxqJbxx.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="xnxq:xnxqJbxx:edit">查看</shiro:lacksPermission></a></li>
	</ul> --%><br/>
	<form:form id="inputForm" modelAttribute="xnxqJbxx" action="${ctx}/xnxq/xnxqJbxx/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label" style="width:100px;">学年名称：</label>
				<div class="controls" style="width:480px;margin-left: 118px;">
					<form:input path="xnmc" id="xnmc1" htmlEscape="false" maxlength="200" 
						class="input-xlarge required" style="width:180px;" />
					<span class="help-inline"><font color="red">*</font> </span>
					<span class="help-inline">格式(2013-2014)</span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label labWidth" style="width:130px;">学期名称：</label>
				<div class="controls" style="margin-left: 148px;">
					<form:select id="xq" path="xq" class="input-xlarge required"  style="width:193px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('term_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label"  style="width:100px;">开始时间：</label>
				<div class="controls" style="width:480px;margin-left: 118px;">
					<input name="kssj" id="kssj" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${xnxqJbxx.kssj}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label labWidth" style="width:130px;">结束时间：</label>
				<div class="controls" style="margin-left: 148px;">
					<input name="jssj" id="jssj" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${xnxqJbxx.jssj}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</div>
		
		
		<div class="form-actions">
			<shiro:hasPermission name="xnxq:xnxqJbxx:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="关闭" onclick="closeDialog();"/>
		</div>
	</form:form>
</body>
</html>