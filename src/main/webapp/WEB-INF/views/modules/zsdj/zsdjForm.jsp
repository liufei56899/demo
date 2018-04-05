<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学校老师招生管理</title>
	<meta name="decorator" content="default"/>

</head>
<body>
<script type="text/javascript" src="${ctxStatic}/common/jeesite.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	$("#sfid").select2("destroy");
	$("#sfid").find(
			"option[value='" + '610000'
					+ "']").attr("selected", true);
	$("#sfid").select2();
	
   var sfid= "${zsdj.sf}";
   var csid= "${zsdj.cs}";
   var qxid= "${zsdj.qx}";
   var xzid= "${zsdj.jd}";
   if(sfid==null||sfid==""){
	   sfid=$("#sfid").val();
   }
    byCS(sfid);
    byQX(csid);
    byXZ(qxid);
	var cs_title = document.getElementById("cs");
	var cs_title_value="";
   for ( var i = 0; i < cs_title.options.length; i++) {
					if (cs_title.options[i].value == csid) {
						cs_title_value=cs_title.options[i].value;
						$("#cs").select2("destroy");
						$("#cs").find(
								"option[value='" + cs_title_value
										+ "']").attr("selected", true);
						$("#cs").select2();
						break;
					}
				}
				
	var qx_title = document.getElementById("qx");
						var qx_title_value = "";
						for ( var i = 0; i < qx_title.options.length; i++) {
							if (qx_title.options[i].value == qxid) {
								qx_title_value = qx_title.options[i].value;
								$("#qx").select2("destroy");
								$("#qx").find(
										"option[value='" + qx_title_value
												+ "']").attr("selected", true);
								$("#qx").select2();
								break;
							}
						}
		var xz_title = document.getElementById("xz");
						var xz_title_value = "";
						for ( var i = 0; i < xz_title.options.length; i++) {
							if (xz_title.options[i].value == xzid) {
								xz_title_value = xz_title.options[i].value;
								$("#xz").select2("destroy");
								$("#xz").find(
										"option[value='" + xz_title_value
												+ "']").attr("selected", true);
								$("#xz").select2();
								break;
							}
						}
		
		
		    $("#tip").text("${tip}");
		    var id = "${zsdj.zylx.id}";
		    var zyid =  "${zsdj.zy.id}";
		      if(id!=null && id!='')
			{
				var jh= "${zsdj.zsjh.id}";
				findZyLxByJhId(jh,'${ctx}','zylbDiv','${zsdj.zylx.id}');
			}
		    var flag = "2";
		    if(id!=null&&id!=""){
		    	$("#zyByLxzs").empty();
		    	$.getJSON("${ctx}/zsdj/zsdj/findZyByJhLxId",
		             {jhid:"${zsdj.zsjh.id}",id:"${zsdj.zylx.id}",flag:flag},
		             function(result){
		                 if(result !=null && result!=""){
		                   $("#zyByLxzs").html(result.html);
		                   $("#zyid").attr("style","width:220px;");
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
			
			if("${zsdj.id}" != "")
			{
				$("#btnSaveAndAdd").addClass(" hide");
			}
		});
		 //选择专业
		function lxChange(info){
			if(info!=null&&info!=""){
		     	var jhid = $("#jhId1").val();
		         $.getJSON("${ctx}/zsdj/zsdj/findZyByJhLxId",{jhid:jhid,id:info},function(result){
				   if(result!=null&&result!=""){
				      $("#zyByLxzs").html(result.html);
				      $("#xzLab").html("");
				      $("#zyid").attr("style","width:220px;");
				      $("#zyid").attr("onchange","findXueZhiById(this,'${ctx}','xzLab','xzId')");
				      findXueZhiById($("#zyid"),'${ctx}','xzLab','xzId');
				      $("#zyid").select2({
					 	formatResult: format,
					    formatSelection: format,
					    escapeMarkup: function(m) { return m; }
					 });
				   }
			    });
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
	     var sfzjlx = $("#sfzjlx").val();
	     var isTrue = true;
	     if(sfzjlx=='1')
	     {
	     	// 身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X
	        /*  var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
	         if(reg.test(sfzjhvalue) === false){
	               validTxt("sfzjh","身份证件号码输入不合法");
	               return  false;
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
	     }
	     else{
	     	$("#csrq").attr("onclick","WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});");
			$("#csrq").removeAttr("readonly");
			if(num!=null)
			{
	       		$("#csrq").val("");
			}
		}
	     if(sfzjhvalue!=null&&sfzjhvalue!=""){
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
	      return isTrue;
	  }
		 //清除提示信息
	    function cleanTip(){
	       $("#tip").text("");
	    }
	    
	    function setBcfs(fs){
	  	$("#bcfs").val(fs);
	  }
function byCS(val) {
		$.ajax({
			type : "POST",
			url : "${ctx}/statistics/ByAreas",
			data : {
				id : val
			},
			dataType : 'json',
			async : false,
			success : function(result) {
			$("#cs").empty();
			$("#qx").empty();
			$("#xz").empty();
			$("#cs").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
			$("#qx").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
			$("#xz").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
				for ( var i = 0; i < result.length; i++) {
					var r = result[i];
					$("#cs").select2("destroy");
					$("#cs")
							.append(
									"<option value='"+r.id+"'>" + r.name
											+ "</option> ").select2();
				}
			}
		});
	}

	function byQX(val) {
		$.ajax({
			type : "POST",
			url : "${ctx}/statistics/ByAreas",
			data : {
				id : val
			},
			dataType : 'json',
			async : false,
			success : function(result) {
			$("#qx").empty();
			$("#xz").empty();
			$("#qx").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
			$("#xz").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
				for ( var i = 0; i < result.length; i++) {
					var r = result[i];
					$("#qx").select2("destroy");
					$("#qx")
							.append(
									"<option value='"+r.id+"'>" + r.name
											+ "</option> ").select2();
				}
			}
		});
	}
	
	function byXZ(val) {
		$.ajax({
			type : "POST",
			url : "${ctx}/statistics/ByAreas",
			data : {
				id : val
			},
			dataType : 'json',
			async : false,
			success : function(result) {
			$("#xz").empty();
			$("#xz").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
				for ( var i = 0; i < result.length; i++) {
					var r = result[i];
					$("#xz").select2("destroy");
					$("#xz")
							.append(
									"<option value='"+r.id+"'>" + r.name
											+ "</option> ").select2();
				}
			}
		});
	}
	</script>
	<form:form id="inputForm" modelAttribute="zsdj" action="${ctx}/zsdj/zsdj/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden id="bcfs" path="bcfs"/>
		<input type="hidden" name="ly" value="1"> 
		<sys:message content="${message}"/>
		<label id="tip" style="color: red; "></label>
		<div class="control-group">
		   <div class="lg-form">
			<label class="control-label">计划名称：</label>
			<div class="controls">
				<form:select path="zsjh.id" id="jhId1"  class="input-xlarge required" style="width:220px;"
					 onchange="findXueNianXueQi(this,'${ctx}','zsjj','xnxqId');findZyLxByJhId(this.value,'${ctx}','zylbDiv','');" >
					<form:option value="" label=""/>
					<form:options items="${fns:findZsjhListByUserId()}" itemLabel="jhmc" itemValue="id" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
			</div>
			<div class="lg-form">
			  			<label class="control-label">学生姓名：</label>
			<div class="controls">
				<form:input path="xm" htmlEscape="false" maxlength="64" class="input-xlarge required" style="width:208px;" onclick="cleanTip()"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
			</div>
		</div>
		<div class="control-group">
		   <div class="lg-form">
			<label class="control-label">性别：</label>
			<div class="controls">
				<form:select path="xbm" class="input-xlarge required" style="width:220px;">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
			</div>
			
			<div class="lg-form">
				<%-- <label class="control-label">年级：</label>
				<div class="controls">
					<form:select path="nj.id" id="njId"  class="input-xlarge required" style="width:220px;">
								<form:option value="" label=""/>
								<form:options items="${fns:getXnJbxxList()}" itemLabel="nf" itemValue="id" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div> --%>
				<label class="control-label">民族：</label>
				<div class="controls">
					<form:select path="nation" class="input-xlarge  required" style="width:220px;">
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
					<form:select path="zylx.id" id="zylxId" onchange="lxChange(this.value)" class="input-xlarge required" style="width:220px;">
							<form:option value="" label="请选择"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
			</div>
			<div class="lg-form">
				<label class="control-label">专业名称：</label>
				<div class="controls" id="zyByLxzs">
					<form:select path="zy.id" class="input-xlarge required"
						style="width:220px;">
						<form:option value="" label="请选择" />
					</form:select>
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
					<form:select path="sfzjlx" class="input-xlarge  required" style="width:220px;">
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
						        class="input-xlarge required" style="width:208px;"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			 </div>
		</div>
		
		<div class="control-group">
			<div class="lg-form">
					<label class="control-label">出生日期：</label>
					<div class="controls">
						<input name="csrq" type="text" id="csrq"  maxlength="20" class="input-medium Wdate required" readonly="readonly"
						  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'${nowDate}',isShowClear:false});" value="<fmt:formatDate value="${zsdj.csrq}" pattern="yyyy-MM-dd"/>"
						 style ="width:208px;"/>
					<span class="help-inline"><font color="red">*</font> </span>
					</div>
			</div>
			 <div class="lg-form">
				<%-- <label class="control-label">民族：</label>
				<div class="controls">
					<form:select path="nation" class="input-xlarge  required" style="width:220px;">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('nation')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div> --%>
				<label class="control-label">家庭住址：</label>
				<div class="controls">
					<form:input path="jtzz" htmlEscape="false" maxlength="255" class="input-xlarge " style="width:208px;"/>
				</div>
			</div>
		
		</div>
		
		
		
		<div class="control-group">
		<div class="lg-form">
			  <label class="control-label">生源校：</label>
			<div class="controls">
				<form:input path="fromSchool" htmlEscape="false" maxlength="32"
					        class="input-xlarge required" style="width:208px;"/>
			    <span class="help-inline"><font color="red">*</font> </span>
			</div>
			</div>
		   
		   <div class="lg-form">
		     			<label class="control-label">联系电话：</label>
			<div class="controls">
				<form:input path="lxdh" htmlEscape="false" maxlength="32" class="input-xlarge "  style="width:208px;"
				            onblur="validateLxdh()" /><label></label>
			</div>
		   </div>
		</div>
		
		<div class="control-group">
			<div class="lg-form">
			  <label class="control-label">家长姓名：</label>
			<div class="controls">
				<form:input path="jzName" htmlEscape="false" maxlength="32"
					        class="input-xlarge" style="width:208px;"/>
			   
			</div>
			</div>
			
			<div class="lg-form">
			  <label class="control-label">家长电话：</label>
			<div class="controls">
				<form:input path="jzNumber" htmlEscape="false" maxlength="32"
					        class="input-xlarge" onblur="validateJzNumber()" style="width:208px;"/>
			   
			</div>
			</div>
		</div>
		<div  class="control-group">
			<label class="control-label">生源地区：</label>
			<div  class="controls">
			<form:select path="sf" class="input-xlarge  required" id="sfid" style="width:100px; margin-right:20px;" onchange="byCS(this.value)" >
						<form:option value="" label="请选择"/>
						
						<form:options items="${fns:findBySF()}" itemLabel="name" itemValue="id" htmlEscape="false"/>
					</form:select>
			<form:select path="cs" class="input-xlarge  required" style="width:100px; margin-right:20px;" id="cs" onchange="byQX(this.value)" >
						<form:option value="" label="请选择"/>
					</form:select>
			<form:select path="qx" class="input-xlarge  required" style="width:100px; margin-right:20px;" id="qx" onchange="byXZ(this.value)" >
						<form:option value="" label="请选择"/>
					</form:select>
					<form:select path="jd" class="input-xlarge  required" style="width:100px; margin-right:20px;" id="xz">
						<form:option value="" label="请选择"/>
					</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<%-- <div class="control-group">
		<div class="lg-form">
			<label class="control-label">家庭住址：</label>
			<div class="controls">
				<form:input path="jtzz" htmlEscape="false" maxlength="255" class="input-xlarge " style="width:208px;"/>
			</div>
		   </div>
		   </div> --%>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" 
					class="input-xxlarge " style="width:733px;" />
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="zsdj:zsdj:edit">
			   <input id="btnSave" onclick="return setBcfs('save');" class="btn btn-primary" type="submit"
					   value="保存" />
			  <input id="btnCancel" class="btn" type="button" value="关闭" onclick="closeDialog();"/>
				<!-- <input id="btnSaveAndAdd" onclick="return setBcfs('saveAndAdd');" class="btn btn-primary" type="submit"
					   value="保存并新增" /> -->
			</shiro:hasPermission>
		</div>
	</form:form>
</body>
</html>