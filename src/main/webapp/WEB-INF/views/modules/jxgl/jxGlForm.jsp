<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>教学管理管理</title>
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
		//校验开始和结束时间
		function validateDate(){
			var kssj=$("#sksj").val();
			var jssj=$("#skjssj").val();
			if(kssj==""){
			alertx("开始时间不能为空！！！");
			 $("#skjssj").val("");
			}
			if(kssj>jssj){
			alertx("结束时间小于开始时间");
			$("#sksj").val("");
		   $("#skjssj").val("");
			}
			}
		//返显数据
		function courseChange(){
			var xnxq=$("#xnxqId").val();
			var kc=$("#kcId").val();
			var bj=$("#bjId").val();
			if(xnxq==""||bj==""){
			alertx("请先选择学年学期和班级");
			$("#kcId").select2("destroy");
		   	$("#kcId").find("option:selected").attr("selected",false);
		    $("#kcId").select2();
			return false;
			}
			if(kc!=""&&xnxq!=""&&bj!=""){
			  $.getJSON("${ctx}/jxdg/jxDg/findjxdgByCourseXnxq",{xnxq:xnxq,kcId:kc,bjId:bj},function(result) {
		       if(result.xuhao==0){
		       alertx("请选择正确是学年学期及课程！！！");
		       return false;
		       }else{
		       $("#zxsCount").val(result.zxsCount);
		       $("#ywcCount").val(parseInt(result.ywcconut)+1);
		       }
				}); 
			}
			}
	</script>
		<style>
	.comments {  
    width:85%;/*自动适应父布局宽度*/  
    overflow:auto;  
    word-break:break-all;  
    }
    #table1 td{
    text-align:left;
    padding-left: 4%;
    }
    #table3 td{
    text-align:left;
    padding-left: 4%;
    }
	</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/jxgl/jxGl/">教学管理列表</a></li>
		<li class="active"><a href="${ctx}/jxgl/jxGl/form?id=${jxGl.id}">教学管理<shiro:hasPermission name="jxgl:jxGl:edit">${not empty jxGl.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="jxgl:jxGl:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<div class="text-center"><span>教学管理</span></div>
	<div style="height: 10px;"></div>
	<form:form id="inputForm" modelAttribute="jxGl" action="${ctx}/jxgl/jxGl/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		 <table id="table1" class="table table-bordered" style="width:60%;height:100%; margin-left: 20%;">	
		    <tr >
			     <td >学年学期：</td>
			     <td >
					<form:select path="xnxqId" id="xnxqId"  class="input-xlarge required" >
						<form:option value="" label="请选择" />
						<form:options items="${fns:getXnxqJbxxList()}" 
						              itemLabel="xnmc" itemValue="xnmc" htmlEscape="false" />
				   </form:select>
				   <span class="help-inline"><font color="red">*</font></span>
				  
			     </td>
			     <td>班级名称:</td>
			   <td>
			      <form:select path="bjId" id="bjId"  class="input-xlarge required" style="width:200px;" >
						<form:option value="" label="请选择" />
						<form:options items="${fns:findBjJbxxList()}" 
						              itemLabel="bjmc" itemValue="bjmc" htmlEscape="false" />
				   </form:select>
				    <span class="help-inline"><font color="red">*</font></span>
			   </td>
			  </tr>
			  <tr>
			      <td>课程名称:</td>
			     <td>
			     <form:select path="kcId" id="kcId"  class="input-xlarge required" onchange="courseChange();" >
						<form:option value="" label="请选择" />
						<form:options items="${fns:getCourseList()}" 
						              itemLabel="coursename" itemValue="id" htmlEscape="false" />
				   </form:select>
				   <span class="help-inline"><font color="red">*</font></span>
			     </td>
			   <td>课程性质:</td>
			   <td>
			   <form:select path="kcxz" id="kcxz"  class="input-xlarge required" >
						  <form:option value="" label="全部" />
							<form:options items="${fns:getDictList('kcxzid')}" itemLabel="label" itemValue="label" 
								htmlEscape="false"/>
				   </form:select>
				   <span class="help-inline"><font color="red">*</font></span>
			   </td>
			  </tr>
			  <tr>
			   <td>总学时数:</td>
			    <td>
			   <input type="text" name="zxsCount"  id="zxsCount" class="input-xlarge required" readonly="readonly" value="${jxGl.zxsCount}" />
			   </td>
		       <td>已完成时数:</td>
			   <td>
			   <input type="text" name="ywcCount"  id="ywcCount" class="input-xlarge required" readonly="readonly" maxlength="3" value="${jxGl.ywcCount}" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" />
			   <span class="help-inline"><font color="red">*</font></span>
			   </td>
			</tr>
		  <tr>
			  <td>代课老师:</td>
			  <td>
			  <input type="text" name="skls"  id="skls" class="input-xlarge required"  value="${jxGl.skls}" />
		      </td>
		      <td>学生考勤:</td>
			  <td>
			  <span id=""></span><input type="text" name=xskq  id="skls" class="input-xlarge required"  value="${jxGl.xskq}" />
		      </td>
		  </tr>
		  <tr>
		    <td>授课时间:</td>
		    <td colspan="3"> 
		     <input name="sksj"  id="sksj"  type="text"  readonly="readonly" maxlength="20" class="input-xlarge Wdate required"
			 value="<fmt:formatDate value="${zsjh.startDate}" pattern="yyyy.MM.dd HH:mm"/>" 
			 onclick="WdatePicker({dateFmt:'yyyy.MM.dd  HH:mm',maxDate:new Date('month dd,yyyy hh:mm'),isShowClear:false});" />
		    <span>至</span>
		     <input name="skjssj" id="skjssj" type="text" readonly="readonly"maxlength="20" class="input-xlarge Wdate required"
				value="<fmt:formatDate value="${zsjh.endDate}" pattern="yyyy.MM.dd HH:mm"/>" 
			    onclick="WdatePicker({dateFmt:'yyyy.MM.dd  HH:mm',maxDate:new Date('month dd,yyyy hh:mm'),isShowClear:false});" onchange="validateDate();"/>
			  <span class="help-inline"><font color="red">*</font></span>
		    </td>
		  </tr>	
		   <tr>
		     <td>教学情况:</td>
		     <td   colspan="3">
		     <textarea  id=jxqk name="jxqk" maxlength="200" class="comments required"  style="vertical-align: middle;">${jxGl.jxqk}</textarea>
		      <span class="help-inline"><font color="red">*</font></span>
		     </td>
		  </tr>	
		 <tr>
		     <td>课堂情况:</td>
		     <td   colspan="3">
		     <textarea  id="ktqk" name="ktqk" class="comments required"  maxlength="200" style="vertical-align: middle;">${jxGl.ktqk}</textarea>
		      <span class="help-inline"><font color="red">*</font></span>
		     </td>
		  </tr>
		  </table> 
		<div style="text-align: center;">
			<shiro:hasPermission name="jxgl:jxGl:edit"><input id="btnSubmit" class="btn btn-primary" type="button" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>