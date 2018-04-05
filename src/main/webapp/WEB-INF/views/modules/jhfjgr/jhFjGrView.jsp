<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>计划分解个人管理</title>
	<meta name="decorator" content="default"/>
	
</head>
<body>
<script type="text/javascript">
		function tiJiao()
	    {
			if ($("#shyj").next().attr("class") == "error") {
					$("#shyj").next().remove();
			}
			$("#shyj").next().remove();
	    	var val= $("input[name='bcStatus']:checked").val();
	    	$("#shyj").removeClass("required");
				$("#shyj").removeClass("error");
				if ($("#shyj").next().attr("class") == "error") {
					$("#shyj").next().remove();
				}
				$("#shyj").attr("class","input-xxlarge");
	    	if(val==2)
	    	{
	    		$("#shyj").parent().append("<span class='help-inline'><font color='red'>*</font> </span>");
	    		$("#shyj").addClass("required");
	    	}else
	    	{
				$("#shyj").removeClass("required");
				$("#shyj").removeClass("error");
				if ($("#shyj").next().attr("class") == "error") {
					$("#shyj").next().remove();
				}
				$("#shyj").attr("class","input-xxlarge");
				$("#shyj").next().remove();
		   }
	    }

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
			if("${jhFjGr.zsjh.id}" != ""){
				//绘制n行三列的表格
				var tableStr = "";
				tableStr += "<table class='table table-striped table-bordered table-condensed'>";
				tableStr += "<tr>";
				tableStr += "<td>教师姓名</td>";
				tableStr += "<td>招生人数</td>";
				tableStr += "<td>划分区域</td>";
				tableStr += "</tr>";
				tableStr += "<tr>";
				tableStr += "<td><input id=\"hidden${jhFjGr.jsId}\" type=\"hidden\" name=\"jsmc\" value=\"${jhFjGr.jsId}\"/>${jhFjGr.jsmc}</td>";
				tableStr += "<td>${jhFjGr.zsrs}<input id=\"input${jhFjGr.jsId}\" type=\"hidden\" name=\"zsrsInput\" value=\"${jhFjGr.zsrs}\" class=\"input-xlarge\"/></td>";
				tableStr += "<td>${innerTable}</td>";
				tableStr += "</tr>";
				tableStr += "</table>";
				$("#officeTable").html(tableStr);
			  	$("#surplus").val("${surplusValue}");
			  	if("${jhFjGr.bcStatus}" == 1 || "${jhFjGr.bcStatus}" == 2){
			  		$("#btnSubmitOk").addClass(" hide"); 
			  	}
			  	$("#zsjhsh").select2();
			}
		});
		
		
		
		function getSurplus(obj){
			 $.getJSON("${ctx}/zsjh/zsjh/findSurplus",{id:obj.value},function(result)
			 {
			 	$("#surplus").val(result.surplusValue);
		  	 });
		}
	</script>
	<br/>
	<form:form id="inputForm" modelAttribute="jhFjGr" action="${ctx}/jhfjgr/jhFjGr/saveSh" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">招生计划：</label>
			<div class="controls">${zsjhEntity.jhmc }
				<%-- <form:select id="zsjhsh" path="zsjh.id" disabled="true" class="input-medium required" onchange="getSurplus(this)" style="width:215px;">
					<form:option value="" label=""/>
					<form:options items="${fns:getZsjhList()}" itemLabel="jhmc" itemValue="id" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span> --%>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">剩余人数：</label>
			<div class="controls">${surplusValue }
				<!-- <input type="text" id="surplus" name="surplus"  readonly="true" class="input-xlarge"/> -->
			</div>
		</div>
		
		
		<div id="officeTable"></div>

		<c:if test="${jhFjGr.bcStatus eq '1' || jhFjGr.bcStatus eq '2' }">
		<div class="control-group">
		        <label class="control-label">审核结果：</label>
				<div class="controls">
					<c:if test="${jhFjGr.bcStatus eq '1'}">
						通过 
					</c:if>
					<c:if test="${jhFjGr.bcStatus eq '2'}">
						不通过 
					</c:if>
		        </div>
		</div>
		<div class="control-group">
			<label class="control-label">审核意见：</label>
			<div class="controls">
				<c:if test="${jhFjGr.bcStatus eq '1' || jhFjGr.bcStatus eq '2' }">
					${jhFjGr.spnr}
				</c:if>
			</div>
		</div>
		
		<div class="control-group">
		  <div class="lg-form">
			<label class="control-label">审核人：</label>
			<div class="controls">
				<c:if test="${jhFjGr.bcStatus eq '1' || jhFjGr.bcStatus eq '2' }">
					${jhFjGr.approveBy.name}
				</c:if>
			</div>
		  </div>
		   <div class="lg-form">
			     <label class="control-label">审核时间：</label>
			     <div class="controls">
				
				<c:if test="${jhFjGr.bcStatus eq '1' || jhFjGr.bcStatus eq '2' }">
					<fmt:formatDate value="${jhFjGr.approveDate}" pattern="yyyy-MM-dd"/>
				</c:if>
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