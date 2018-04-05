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
			loadZylx(2010);
			$("#inputForm").validate({
				submitHandler: function(form){
					var istrue = subClick();
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
		
		function subClick()
		{
			/* var istrue = validZymc();
			if(istrue)
			{ */
			var	istrue = validJss();
			if(istrue)
			{
				istrue = validZfs();
			}
			return istrue;
		}
		
		//验证教师数
		function validJss()
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
		
		function validZfs()
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
		/* function validZymc()
		{
			var zymc = $("#zymc1").find("option:selected").text();//专业名称
			var zylxid = "";//专业类别id
			var xz=$("#xz1").find("option:selected").val();//学制
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
							validTxt("xz1","该专业学制已存在");
							return false;
						}
				   }
			    });
				
			}
			return isTrue;
		} */
		   //选择 专业目录版本 后加载 专业类别
		function loadZylx(info){
		     if(info!=null&&info!=""){
		    	 $.ajax({
				        type: "POST",
				        url: "${ctx}/professional_code/professionalCategoryCode/getCategoryByVersion",
				        data: {professionalVersionDate:info},
				        dataType:'json',
				        async:false,
						success: function(result){
							if(result!=null&&result!=""){
								  $("#zylxid").empty();
								  $("#zylxid").select2("destroy");
								  $("#zylxid").append("<option value='' selected='true'></option>");
								  for(var i=0;i<result.length;i++){
									  var r=result[i];
									  $("#zylxid").append("<option value='"+r.categoryId+"'>"+r.categoryName+"</option>");
								  }
								  $("#zylxid").select2();
								  
								  $("#zymc1").empty();
								  $("#zymc1").select2("destroy");
								  $("#zymc1").append("<option value='' selected='true'></option>");
								  $("#zymc1").select2();
								  
								  $("#zyfxmc").empty();
								  $("#zyfxmc").select2("destroy");
								  $("#zyfxmc").append("<option value='' selected='true'></option>");
								  $("#zyfxmc").select2();
							      
							  }else{
								  $("#zylxid").empty();
							  }
					   }
				    });
		        
		     }
		}		 
		   //选择 专业类别 后加载 专业
		function loadZy(info){
		     if(info!=null&&info!=""){
		     	/* //如果选择的是其他，则需要手动输入,否则需经下拉列表选则
		     	if(info==19){
		     		$("#zy_Id").empty();
		     		$("#zy_Id").append("<input name='zymc' id='zymc1' htmlEscape='false' maxlength='64' type='text' class='input-xlarge required'/>"
		     		+"<span class='help-inline'><font color='red'>*</font> </span>");
					$("#zyfx_Id").empty();
		     		$("#zyfx_Id").append("<input name='zyfxmc' htmlEscape='false' maxlength='64' type='text' class='input-xlarge' />");
				}else{ */
		     		$("#zy_Id").empty();
		     		$("#zy_Id").append("<select name='zyfxmc' id='zymc1' class='input-xlarge required' onchange='loadZyjnfx(this.value)'>"
						+"<option value=''></option>"
					+"</select>"
		     		+"<span class='help-inline'><font color='red'>*</font> </span>");
					$("#zyfx_Id").empty();
		     		$("#zyfx_Id").append("<select name='zymc' id='zyfxmc' class='input-xlarge'>"
						+"<option value=''></option>"
					+"</select>");
					$.ajax({
				        type: "POST",
				        url: "${ctx}/professional_code/professionalCategoryCode/getProfessionalCategoryId",
				        data: {categoryId:info},
				        dataType:'json',
				        async:false,
						success: function(result){
							if(result!=null&&result!=""){
								  $("#zymc1").empty();
								  $("#zymc1").select2("destroy");
								  $("#zymc1").append("<option value='' selected='true'></option>");
								  for(var i=0;i<result.length;i++){
									  var r=result[i];
									  $("#zymc1").append("<option value='"+r.professionalId+"'>"+r.professionalName+"</option>");
								  }
							      
								  $("#zymc1").select2();
								  $("#zyfxmc").empty();
								  $("#zyfxmc").select2("destroy");
								  $("#zyfxmc").append("<option value='' selected='true'></option>");
								  $("#zyfxmc").select2();
							  }else{
								  $("#zymc1").empty();
							  }
					   }
				    });
				//}
		    	 
		     }
		}		   
		   //选择 专业 后加载 专业技能方向
		function loadZyjnfx(info){
		     if(info!=null&&info!=""){
		    	 $.ajax({
				        type: "POST",
				        url: "${ctx}/professional_code/professionalCategoryCode/getprofessionalEmphasisByProfessionalId",
				        data: {professionalId:info},
				        dataType:'json',
				        async:false,
						success: function(result){
							if(result!=null&&result!=""){
								  $("#zyfxmc").empty();
								  $("#zyfxmc").select2("destroy");
								  $("#zyfxmc").append("<option value='' selected='true'></option>");
								  var results=result.list.professionalEmphasis.split("|");
								  for(var i=0;i<results.length;i++){
									  var r=results[i];
									  var zymc=false;							  
									  for(var j=0;j<result.zymclist.length;j++){
									  	var z=result.zymclist[j].zymc;
									  	if(r==z){
									  		zymc=true;		
									  	}					  										  										  													  
									  }
									  if(zymc){
									  	$("#zyfxmc").append("<option value='"+i+"'disabled='disabled' style='color:red;'>"+r+"</option>");
									  }else{
									  	$("#zyfxmc").append("<option value='"+i+"'>"+r+"</option>");
									  }
									  									 
								  }
								  $("#zyfxmc").select2();
							      
							  }else{
								  $("#zyfxmc").empty();
							  }
					   }
				    });
		     }
		}
	</script>
	<br/>
	<form:form id="inputForm" modelAttribute="zyJbxx" action="${ctx}/zy/zyJbxx/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">专业目录版本：</label>
				<div class="controls">
					<%--<form:input path="zymlbb" htmlEscape="false" maxlength="64" class="input-xlarge required" 
						/>
					--%>
					<form:select path="zymlbb" id="zymlbb" class="input-xlarge required" onchange="loadZylx(this.value)">
						<form:option value="2010" label="2010"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label labWidth">专业类别：</label>
				<div class="controls">
					<form:select path="zylx.id" id="zylxid" class="input-xlarge required" onchange="loadZy(this.value)">
						<form:option value="" label=""/>
							<%--<form:options items="${fns:getZylxList()}" itemLabel="lxmc" itemValue="id" htmlEscape="false"/>
					--%></form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</div>
		
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">专业方向：</label>
				<div class="controls" id="zy_Id">
					<%--<form:input path="zymc" id="zymc1" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
					--%>
					<form:select path="zyfxmc" id="zymc1" class="input-xlarge required" onchange="loadZyjnfx(this.value)">
						<form:option value="" label=""/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label labWidth">专业名称：</label>
				<div class="controls" id="zyfx_Id">
					<%--<form:input path="zyfxmc" htmlEscape="false" maxlength="64" class="input-xlarge required" />
					--%>
					<form:select path="zymc" id="zyfxmc" class="input-xlarge">
						<form:option value="" label=""/>
					</form:select>
				</div>
			</div>
		</div>
		
		<%-- <div class="control-group">
			<div class="lg-form">
				<label class="control-label">学制：</label>
				<div class="controls">
					<form:select path="xz" id="xz1" class="input-xlarge required" >
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('xzdm')}" itemLabel="label" 
							itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
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
		</div> --%>
		
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">本校专业编号：</label>
				<div class="controls">
					<form:input path="bxzybh" htmlEscape="false" maxlength="64" class="input-xlarge required" 
						/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label labWidth">专业简称：</label>
				<div class="controls">
					<form:input path="zyjc" htmlEscape="false" maxlength="64" class="input-xlarge required" 
						/>
					<span class="help-inline"><font color="red">*</font> </span>
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