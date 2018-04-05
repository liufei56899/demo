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
				
				if("${jhFj.grShZt}" == 1 || "${jhFj.grShZt}" == 2){
			  		$("#btnSubmitOk").addClass(" hide"); 
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
		
		function tiJiao()
	    {
			if ($("#grSpnr").next().attr("class") == "error") {
					$("#grSpnr").next().remove();
			}
			$("#grSpnr").next().remove();
	    	var val= $("input[name='grShZt']:checked").val();
	    	$("#grSpnr").removeClass("required");
				$("#grSpnr").removeClass("error");
				if ($("#grSpnr").next().attr("class") == "error") {
					$("#grSpnr").next().remove();
				}
				$("#grSpnr").attr("class","input-xxlarge");
	    	if(val==2)
	    	{
	    		$("#grSpnr").parent().append("<span class='help-inline'><font color='red'>*</font> </span>");
	    		$("#grSpnr").addClass("required");
	    	}else
	    	{
				$("#grSpnr").removeClass("required");
				$("#grSpnr").removeClass("error");
				if ($("#grSpnr").next().attr("class") == "error") {
					$("#grSpnr").next().remove();
				}
				$("#grSpnr").attr("class","input-xxlarge");
				$("#grSpnr").next().remove();
		   }
	    }
		
		function saveBmSh()
		{
			//tiJiao();
			var strZsjh = $("#zsjhbmrwfj").val();
			var zszrs = $("#hiddenZszrs").val();
			var strGrSpnr = $("#grSpnr").val();
			var strGrShZt = $("input[name='grShZt']:checked ").val();
			var strJhfjgrId = "";
			var strJsId = "";
			var strZsrs = "";
			var zsrsTotal = 0;
			var jhfjgrId = document.getElementsByName("jhfjgrId");
			var jsmc = document.getElementsByName("jsmc");
			var zsrs = document.getElementsByName("zsrsInput");
			for(i = 0; i < jhfjgrId.length; i++) {
				strJhfjgrId += jhfjgrId[i].value + ",";
			}
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
			if(strGrShZt=='2')
			{
				if(strGrSpnr==null || strGrSpnr=='')
				{
					alertx("请输入审核意见！");
					return false;
				}
				
			}
			$.ajax({
				   type : 'post',
				   url: "${ctx}/jhfj/jhFj/bmRwSh",
				   dataType:'text',
				   data : {jhfjId:"${jhFj.id}",jhfjgrIds:strJhfjgrId,zsrses:strZsrs,grShZt:strGrShZt,grSpnr:strGrSpnr},
				   success: function(data){
				   		location.href = "${ctx}/jhfj/jhFj/bmshList/";
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
			<div class="controls">${zsjhEntity.jhmc }
				<%-- <form:select id="zsjhbmrwfj" path="zsjh.id" disabled="true" class="input-medium required">
					<form:option value="" label=""/>
					<form:options items="${fns:getZsjhList()}" itemLabel="jhmc" itemValue="id" htmlEscape="false"/>
				</form:select> --%>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">招生总人数：</label>
			<div class="controls">${jhFj.zsrs}
			<label id="zsrsLabel" style="display:none;">${jhFj.zsrs}</label>
			<input type="hidden" id="hiddenZszrs" value="${jhFj.zsrs}"/></div>
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
		
		<!-- <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#selectOffice">选择人员</button> -->
		
		<div id="officeTable"></div>
		
		<!-- 人员 -->
		<div class="modal fade" style="width:450px;" id="selectOffice" tabindex="-1">
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
		
		<c:if test="${jhFj.grShZt eq '1' || jhFj.grShZt eq '2' }">
			<div class="control-group">
		        <label class="control-label">审核结果：</label>
				<div class="controls">
					<c:if test="${jhFj.grShZt eq '1'}">
						<span style="color: #0D73F3;">审核通过</span> 
					</c:if>
					<c:if test="${jhFj.grShZt eq '2'}">
						<span style="color: #ff0033;">审核不通过</span>
					</c:if>
		        </div>
		</div>
		<div class="control-group">
			<label class="control-label">审核意见：</label>
			<div class="controls">${jhFj.grSpnr}
			</div>
		</div>
		
		<div class="control-group">
		  <div class="lg-form">
			<label class="control-label">审核人：</label>
			<div class="controls">${jhFj.grApproveBy.name}
			</div>
		  </div>
		   <div class="lg-form">
			     <label class="control-label">审核时间：</label>
			     <div class="controls"><fmt:formatDate value="${jhFj.grApproveDate}" pattern="yyyy-MM-dd"/>
			     </div>
		   </div>
		</div>
		
		</c:if>
		

		<div class="form-actions">
			<input id="btnCancel" class="btn"  type="button" value="关闭" onclick="closeDialog();"/>
		</div>
	</form:form>
</body>
</html>