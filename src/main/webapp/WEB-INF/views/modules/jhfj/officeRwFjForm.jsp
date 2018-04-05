<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>计划分解管理</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
	  .border-table {   
        border-collapse: collapse;   
        border: none;   
	    }   
	    .border-table td {   
	        border: solid #000 1px;   
	    }  
		
	</style>
	
</head>
<body>
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
			//如果是点击修改进入页面，则加载信息
			if("${jhFj.zsjh.id}" != ""){
				jsInfo = "${oldJsIdStr}";
				jsName = "${oldJsNameStr}";
				var showTable = "${showTable}";
				if(showTable != ""){
					$("#officeTable").html(showTable);
				}
				if("${jhFj.fjFlag}" == 1){
					$("#btnSave").addClass(" hide"); 
				}
			}
			
			$("#zsjhbmrwfj").select2();
			//加载部门
			$.getJSON("${ctx}/sys/user/findUserByOfficeId",{officeId:"${jhFj.office.id}"},function(data){
					if(data.length >0){
							var strOffice = "<table>";
							$.each(data,function(index,m){
								if(index==0){
									strOffice += "<tr>";
								}
								var strJsChecked = "";
								if(jsInfo.indexOf(m.id)!=-1){
									strJsChecked = "checked=\"checked\"";
								}
								strOffice += "<td><input type=\"checkbox\" id="+m.id+" "+strJsChecked+" name="+m.id+" value="+m.name+" onclick=\"selectOffice(this)\"/>";
								strOffice +=m.name;
								strOffice += "</td>";
								if((index+1)%6==0 && index!=0){
									strOffice += "</tr><tr>";
								}
							});
							strOffice += "</tr>";
							strOffice += "</table>";
							$("#officePanel").html(strOffice);
						}
			});
			
			
			//officeTable
			if("${jhFj.fjFlag}" == 1){
				$("#officeTable").find("table input[name='zsrsInput']").each(function()
				{
					$(this).attr("disabled","disabled");
				});
			
			}
		});
		
		var jsInfo = "";
		var jsName = "";
		//选择人员
		function selectOffice(obj){
			if(obj.checked){
				jsInfo = jsInfo + obj.id + ",";
				jsName = jsName + obj.value + ",";
			}
			else
			{
				jsInfo = jsInfo.replace(obj.id+",", "");
				jsName = jsName.replace(obj.value+",","");
			}
		}
		
		//保存选择的部门人员
		function saveOffice(){
			//绘制n行两列的表格
			var tableStr = "";
			tableStr += "<table class='table table-striped table-bordered table-condensed'>";
			tableStr += "<tr>";
			tableStr += "<td>教师名称</td>";
			tableStr += "<td>招生人数</td>";
			tableStr += "</tr>";
			var list = jsInfo.split(',');
			var listValue = jsName.split(',');
			for(var i=0;i<list.length-1;i++){
				tableStr += "<tr>";
				tableStr += "<td><input id=\"hidden"+list[i]+"\" type=\"hidden\" name=\"jsmc\" value=\""+list[i]+"\"/>"+listValue[i]+"</td>";
				tableStr += "<td><input id=\"input"+list[i]+"\" type=\"text\" name=\"zsrsInput\" style=\"width:80px;\"/></td>";
				tableStr += "</tr>";
			}
			tableStr += "</table>";
			if(jsInfo != ""){
				$("#officeTable").html(tableStr);
			}
		}
		
		function saveJhfj(){
			var strZsjh = $("#zsjhbmrwfj").val();
			var zszrs = $("#hiddenZszrs").val();
			var strJsId = "";
			var strZsrs = "";
			var zsrsTotal = 0;
			var jsmc = document.getElementsByName("jsmc");
			var zsrs = document.getElementsByName("zsrsInput");
			
			for(i = 0; i < jsmc.length; i++) {
				strJsId += jsmc[i].value + ",";
			}
			
			 for(i = 0; i < zsrs.length; i++) {
			 	if(zsrs[i].value == "" || zsrs[i].value == null){
			 		alert("招生人数请填写完整！");
			 		strZsrs = "";
			 		return false;
			 	}
			 	strZsrs += zsrs[i].value + ",";
			 	var rs = parseInt(zsrs[i].value);
			 	zsrsTotal = zsrsTotal+rs;
			 }
			if(zszrs != zsrsTotal){
				alert("招生人数总和不等于招生总人数，请重新填写！");
			 	return false;
			}
			 $.ajax({
			   type : 'post',
			   url: "${ctx}/jhfjgr/jhFjGr/SaveGrRwFj",
			   dataType:'text',
			   data : {jhfjId:"${jhFj.id}",zsjhId:strZsjh,jsIds:strJsId,zsrses:strZsrs},
			   success: function(data){
			   		location.href = "${ctx}/jhfj/jhFj/rwList/";
			   }
			});
			return true;
		}
	</script>
	<%-- <ul class="nav nav-tabs">
		<li><a href="${ctx}/jhfj/jhFj/rwList/">部门任务列表</a></li>
		<li class="active"><a href="${ctx}/jhfj/jhFj/bmRwFjForm?id=${jhFj.id}">部门任务分解<shiro:hasPermission name="jhfj:jhFj:edit">${not empty jhFj.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="jhfj:jhFj:edit">查看</shiro:lacksPermission></a></li>
	</ul> --%><br/>
	<form:form id="inputForm" modelAttribute="jhFj" action="${ctx}/jhfj/jhFj/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">招生计划：</label>
			<div class="controls">
				<form:select id="zsjhbmrwfj" path="zsjh.id" disabled="true" class="input-medium required">
					<form:option value="" label=""/>
					<form:options items="${fns:getZsjhList()}" itemLabel="jhmc" itemValue="id" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">招生总人数：</label>
			<div class="controls">
			     <label id="zsrsLabel">${jhFj.zsrs}</label>
			     <input type="hidden" id="hiddenZszrs" value="${jhFj.zsrs}"/>
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label">招生计划：</label>
			<label>${jhFj.zsjh.jhmc}</label>
			<input type="hidden" id="zsjh" value="${jhFj.zsjh.id}"/>
		</div>
		<div class="control-group">
			<label class="control-label">招生总人数：</label>
			<label id="zsrsLabel">${jhFj.zsrs}</label>
			<input type="hidden" id="hiddenZszrs" value="${jhFj.zsrs}"/>
		</div> --%>
		
		<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#selectOffice">选择人员</button>
		
		<div id="officeTable"></div>
		
		<!-- 人员 -->
		<div class="modal fade" style="width:400px;" id="selectOffice" tabindex="-1">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		       <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
		        <h4 class="modal-title" id="myModalLabel">选择人员</h4>
		      </div>
		      <div class="modal-body">
		      <div id="officePanel">
				</div>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		        <button type="button" onclick="saveOffice()" class="btn btn-primary" data-dismiss="modal">确定</button>
		      </div>
		    </div>
		  </div>
		</div>
		
		<%-- <div class="control-group">
		        <label class="control-label">审核结果：</label>
				<div class="controls">
					 <form:radiobutton path="grShZt" name="grShZt" value="1" disabled="true" checked="true"/>通过  
                     <form:radiobutton path="grShZt" name="grShZt" value="2" disabled="true"/>不通过
		        </div>
		</div>
		<div class="control-group">
			<label class="control-label">审核意见：</label>
			<div class="controls">
				<form:textarea path="grSpnr" id = "grSpnr" disabled="true" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge " style="width:597px;"/>
			</div>
		</div>
		
		<div class="control-group">
		  <div class="lg-form">
			<label class="control-label">审核人：</label>
			<div class="controls">
				<form:input path="grApproveBy.name" id="grApproveBy.name"  htmlEscape="false" maxlength="11" readonly="true" class="input-xlarge"/>
			</div>
		  </div>
		   <div class="lg-form">
			     <label class="control-label">审核时间：</label>
			     <div class="controls">
				     <input name="approveDate" type="text" disabled="disabled" maxlength="64" class="input-xlarge Wdate required"
					value="<fmt:formatDate value="${jhFj.grApproveDate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			     </div>
		   </div>
		</div> --%>

		<div class="form-actions">
			<input id="btnSave" class="btn btn-primary" type="button" onclick="return saveJhfj();" value="保 存"/>&nbsp;
			<!-- <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/> -->
			<input id="btnCancel" class="btn" type="button" value="关闭" onclick="closeDialog();"/>
		</div>
	</form:form>
</body>
</html>