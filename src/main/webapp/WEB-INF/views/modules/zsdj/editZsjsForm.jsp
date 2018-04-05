<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
<head>
	<title>招生登记查询界面</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<script type="text/javascript" src="${ctxStatic}/common/jeesite.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
		    var id = "${zsdj.zylx.id}";
		    var zyid =  "${zsdj.zy.id}";
		    if(id!=null && id!='')
			{
				var jh= "${zsdj.zsjh.id}";
				findZyLxByJhId1(jh,'${ctx}','zylbDiv','${zsdj.zylx.id}');
				$("#zylxId1").select2("destroy");
				$("#zylxId1").attr("style","width:180px;");
				$("#zylxId1").attr("disabled","true");
				$("#zylxId1").select2();
			}
		    var flag = "2";
		    if(id!=null&&id!=""){
		    	$("#zyByLx1").empty();
		       $.getJSON("${ctx}/zsdj/zsdj/findZyByJhLxId",
		             {jhid:"${zsdj.zsjh.id}",id:"${zsdj.zylx.id}",flag:flag},
		             function(result){
		                 if(result !=null && result!=""){
		                   $("#zyByLx1").html(result.html);
		                   $("#zyid").attr("style","width:180px;");
		                   $("#zyid").attr("disabled","true");
		                   $("#zyid").attr("onchange","findXueZhiById(this,'${ctx}','xzLab','xzId')");
		                   findXueZhiById($("#zyid"),'${ctx}','xzLab','xzId');
		                   $("#zyid").select2();
		                 }
		  	         }
		  	   );
		    }
			$("#inputForm").validate({
				submitHandler: function(form){
					var isTrue = validateLxdh();
					if(isTrue)
					{
						isTrue = validateSfzxx(null);
					}
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
		 //选择专业
		function lxChange1(info){
			var jhid = $("#jhId1").val();
		   if(info !=null && info!=""){
		    	$.getJSON("${ctx}/zsdj/zsdj/findZyByJhLxId",{jhid:jhid,id:info},function(result){
				   if(result!=null&&result!=""){
				   		var ht = result.html;
			               $("#zyByLx1").html(ht);
			               $("#xzLab").html("");
			               $("#zyid").attr("style","width:184px;");
			               $("#zyid").attr("onchange","findXueZhiById(this,'${ctx}','xzLab','xzId')");
			                findXueZhiById($("#zyid"),'${ctx}','xzLab','xzId');
			               $("#zyid").select2();
				   }
			    });
		    } else
		     {
		     	$("#zyid").select2("destroy");
				$("#zyid").find("option[value='']").attr("selected",true);
				$("#zyid").select2();
				
				$("#xzLab").html('');
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
		
		//验证家长电话
		function validateJzNumber() {
			var value = $("#jzNumber").val();
			if (value != null && value != "") {
				var isTrue = /^1\d{10}$/i.test(value)
						|| /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i
								.test(value);
				if (!isTrue) {
					validTxt("jzNumber", "联系电话格式有问题");
					return false;
				}
			}
			return true;
		}
		
		
		//验证身份证信息是否重复
	   function validateSfzxx(num){
	     var sfzjhvalue = $("#sfzjh").val();
	     var id ="${zsdj.id}";
	     var isTrue = true;
	     var sfzjlx = $("#sfzjlx").val();
	     if(sfzjlx=='1')
	     {
	     	 // 身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X
	         /* var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
	         if(reg.test(sfzjhvalue) === false)
	         {
	                 validTxt("sfzjh","身份证件号码输入不合法");
	                 return false;
	         } */
	          var isT = IdCardValidate(sfzjhvalue);
			if(!isT)
			{
				validTxt("sfzjh","请输入正确的身份证件号码");
				return false;
			}
	         //出生日期
	         if(num!=null)
	         {
	         	var csrqVal =findCsrqByCard(sfzjhvalue);
	       		$("#csrq").attr("onclick","");
	       		$("#csrq").attr("readonly","readonly");
	       		$("#csrq").val(csrqVal);
	         }
	     }else{
	     	$("#csrq").attr("onclick","WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});");
			$("#csrq").removeAttr("readonly");
			if(num!=null)
			{
	       		$("#csrq").val("");
			}
		}
       	if(sfzjhvalue!=null && sfzjhvalue!="")
       	{
		    jQuery.ajax({
			        type: "POST",
			        url: "${ctx}/zsdj/zsdj/validateSfzxx",
			        data: {sfzjh:sfzjhvalue,id:id},
			        dataType:'json',
			        async:false,
					success: function(result){
						isTrue = result.isTrue;
						if(!isTrue)
						{
							validTxt("sfzjh","身份证件号码不能重复");
							return false;
						}
				   }
			    });
	     }
	      return  isTrue;
	  }
		
		function findZyLxByJhId1(id,http,selectId,zylxId)
		{
			$("#"+selectId).empty();
			var selHtml ="<select name='zylx.id' id='zylxId1' onchange='lxChange1(this.value)' class='input-xlarge required' style='width:184px;'>";
			selHtml += "<option value='' >请选择</option>";
			jQuery.ajax({
		        type: "POST",
		        url: http+"/zsdj/zsdj/findZyLxByJhId",
		        data: {id:id},
		        dataType:'json',
		        async:false,
				success: function(result){
					for(var i=0;i<result.length;i++)
					{
						selHtml +="<option value='"+result[i].zylxId.id+"' ";
						if(zylxId!=null && zylxId!="")
						{
							if(result[i].zylxId.id == zylxId)
							{
								selHtml += "selected ='selected'";
							}
							
						}
						selHtml +=" > "+result[i].zylxId.lxmc+"</option>";
					}
			   }
		    });
			selHtml +="</select><span class='help-inline'><font color='red'>*</font> </span>";
			$("#"+selectId).html(selHtml);
			$("#zylxId1").select2();
			
			$("#zyid").select2("destroy");
			$("#zyid").find("option").each(function(index)
			{
				if(index>0)
				{
					$(this).remove();
				}
			});
			$("#zyid").find("option[value='']").attr("selected",true);
			$("#zyid").select2();
			
			$("#xzLab").html('');
		}
	</script>
   <%--  <ul class="nav nav-tabs">
		<li><a href="${ctx}/zsdj/zsdj/list">招生登记列表</a></li>
		<li class="active"><a href="${ctx}/zsdj/zsdj/form?id=${zsdj.id}">招生登记<shiro:hasPermission name="zsdj:zsdj:edit">${not empty zsdj.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="zsdj:zsdj:edit">查看</shiro:lacksPermission></a></li></li>
	</ul> --%><br/>
	<form:form id="inputForm" modelAttribute="zsdj" action="${ctx}/zsdj/zsdj/saveZsjs" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<input id="pageWs" name="pageWs" type="hidden" value="1" />
		<sys:message content="${message}"/>
		<div class="control-group">
		   <div class="lg-form">
			<label class="control-label">计划名称：</label>
			<div class="controls">
				<form:select disabled="true" path="zsjh.id"  id="jhId1" class="input-xlarge required" style="width:184px;"
					onchange="findXueNianXueQi(this,'${ctx}','zsjj','xnxqId');findZyLxByJhId1(this.value,'${ctx}','zylbDiv','');"  readonly="true">
					<form:option value="" label=""/>
					<form:options items="${fns:findListByUserId()}" itemLabel="jhmc" itemValue="id" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
			</div>
			<div class="lg-form">
			  <label class="control-label">学生姓名：</label>
			<div class="controls">
				<form:input path="xm" htmlEscape="false" maxlength="64" class="input-xlarge required" style="width:170px;" readonly="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
			</div>
		</div>
		<div class="control-group" >
		   <div class="lg-form">
			<label class="control-label">性别：</label>
			<div class="controls">
				<form:select disabled="true" path="xbm" class="input-xlarge required" style="width:184px;" readonly="true">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
			</div>
			
			<div class="lg-form">
				<%-- <label class="control-label">年级：</label>
				<div class="controls">
					<form:select path="nj.id" id="njId"  class="input-xlarge required" style="width:184px;">
								<form:option value="" label=""/>
								<form:options items="${fns:getXnJbxxList()}" itemLabel="nf" itemValue="id" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div> --%>
				<label class="control-label">民族：</label>
				<div class="controls">
					<form:select disabled="true" path="nation" class="input-xlarge  required" style="width:184px;" readonly="true">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('nation')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</div>
		<div class="control-group">
		  <div class="lg-form">
			<label class="control-label">专业类别：</label>
			<div class="controls" id="zylbDiv">
				<form:select disabled="true" path="zylx.id" id="zylxId" onchange="lxChange1(this.value)" class="input-xlarge required" style="width:184px;" readonly="true">
							<form:option value="" label="请选择"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
			</div>
			<div class="lg-form">
			  <label class="control-label">专业名称：</label>
			<div class="controls" id="zyByLx1" >
				<select disabled="true" name="zy.id" class="input-xlarge required" style="width:184px;"  id="zyid" readonly="true">
			        <option value="" label="请选择"/>
			    </select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
			</div>
		</div>
		
		<div class="control-group">
		 <div class="lg-form">
			<label class="control-label">招生季节：</label>
			<div class="controls">
					<label id="zsjj">${zsdj.xnxq.xnmc}</label>
					<input type="hidden" name="xnxq.id" id="xnxqId" value="${zsdj.xnxq.id}" />
			</div>
			</div>
			 <div class="lg-form">
			   <label class="control-label">学制：</label>
				<div class="controls" >
					<label id="xzLab">${zsdj.xz}</label>
						<input type="hidden" name="xz" id="xzId" value="${zsdj.zy.xz}" />
				</div>
			 </div>
		</div>
		<div class="control-group">
			 <div class="lg-form">
				<label class="control-label">身份证件类型：</label>
				<div class="controls">
					<form:select disabled="true" path="sfzjlx" class="input-xlarge  required" style="width:184px;" readonly="true">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('sfzjlx')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
				 <label class="control-label">身份证件号码：</label>
				<div class="controls">
					<form:input id="sfzjh" path="sfzjh" htmlEscape="false" maxlength="18" onblur="validateSfzxx('1')"
						        class="input-xlarge required" style="width:170px;" readonly="true"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			 </div>
		</div>
		
		<div class="control-group">
			<div class="lg-form">
					<label class="control-label">出生日期：</label>
					<div class="controls">
						<input disabled="true" name="csrq" type="text"  id="csrq"  maxlength="20" class="input-medium Wdate required" readonly="readonly"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'${nowDate}',isShowClear:false});" value="<fmt:formatDate value="${zsdj.csrq}" pattern="yyyy-MM-dd"/>"
						style ="width:170px;"/>
					<span class="help-inline"><font color="red">*</font> </span>
					</div>
			</div>
			 <div class="lg-form">
				<%-- <label class="control-label">民族：</label>
				<div class="controls">
					<form:select path="nation" class="input-xlarge  required" style="width:184px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('nation')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div> --%>
				<label class="control-label">部门名称：</label>
				<div class="controls">
					<sys:treeselect disabled="true" id="office" name="office.id" value="${zsdj.office.id}" labelName="office.name" labelValue="${zsdj.office.name}"
						title="部门" url="/sys/office/treeData?type=2" cssClass="required tabTreeselect" allowClear="true" notAllowSelectParent="true"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		
		</div>
		
	<%-- 	<div class="control-group">
			<label class="control-label">部门名称：</label>
			<div class="controls">
				<sys:treeselect id="office" name="office.id" value="${zsdj.office.id}" labelName="office.name" labelValue="${zsdj.office.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="required tabTreeselect" allowClear="true" notAllowSelectParent="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div> --%>
		<div class="control-group">
		   <div class="lg-form"> 
			<label class="control-label">家庭住址：</label>
			<div class="controls">
				<form:input path="jtzz" htmlEscape="false" maxlength="255" class="input-xlarge required" style="width:170px;" readonly="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		   </div>
		   <div class="lg-form">
		     <label class="control-label">联系电话：</label>
			<div class="controls">
				<form:input path="lxdh" htmlEscape="false" maxlength="32" class="input-xlarge required" style="width:170px;"
				            onblur="validateLxdh()"  readonly="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		   </div>
		</div>
		
		<div class="control-group">
			<div class="lg-form">
			  <label class="control-label">家长姓名：</label>
			<div class="controls">
				<form:input path="jzName" htmlEscape="false" maxlength="32"
					        class="input-xlarge required" style="width:170px;" readonly="true"/>
			    <span class="help-inline"><font color="red">*</font> </span>
			</div>
			</div>
			
			<div class="lg-form">
			  <label class="control-label">家长电话：</label>
			<div class="controls">
				<form:input path="jzNumber" htmlEscape="false" maxlength="32"
					        class="input-xlarge required" onblur="validateJzNumber()" style="width:170px;" readonly="true"/>
			    <span class="help-inline"><font color="red">*</font> </span>
			</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
			  <label class="control-label">招生老师：</label>
				<div class="controls">
				<form:select path="js.id"  style="width:184px;"
							class="input-xlarge  required" >
					<form:option value="" label="" />
					<form:options items="${fns:getAllUserList()}"
							itemLabel="name" itemValue="id" htmlEscape="false" />
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			
		</div>
		
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" 
					class="input-xxlarge " style="width:700px;" />
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="zsdj:zsdj:edit">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存" />&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="关闭" onclick="closeDialog();"/>
		</div>
	</form:form>
</body>
</html>