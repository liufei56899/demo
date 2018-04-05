<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>计划分解管理</title>
<meta name="decorator" content="default" />
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

	$(document)
			.ready(
					function() {
						//$("#name").focus();
						$("#inputForm").validate(
								{
									submitHandler : function(form) {
										loading('正在提交，请稍等...');
										form.submit();
									},
									errorContainer : "#messageBox",
									errorPlacement : function(error, element) {
										$("#messageBox").text("输入有误，请先更正。");
										if (element.is(":checkbox")
												|| element.is(":radio")
												|| element.parent().is(
														".input-append")) {
											error.appendTo(element.parent()
													.parent());
										} else {
											error.insertAfter(element);
										}
									}
								});

						//如果是点击修改进入页面，则加载信息
						if ("${jhFj.zsjh.id}" != "") {
							//绘制n行三列的表格
							var tableStr = "";
							tableStr += "<table class='table table-striped table-bordered table-condensed'>";
							tableStr += "<tr>";
							tableStr += "<td>部门</td>";
							tableStr += "<td>招生人数</td>";
							tableStr += "<td>划分区域</td>";
							tableStr += "</tr>";
							tableStr += "<tr>";
							tableStr += "<td><input id=\"hidden${jhFj.office.id}\" type=\"hidden\" name=\"bmmc\" value=\"${jhFj.office.id}\"/>${jhFj.office.name}</td>";
							tableStr += "<td>${jhFj.zsrs}<input id=\"input${jhFj.office.id}\" type=\"hidden\" name=\"zsrsInput\" value=\"${jhFj.zsrs}\" class=\"input-xlarge\"/></td>";
							tableStr += "<td>${innerTable}</td>";
							tableStr += "</tr>";
							tableStr += "</table>";
							$("#officeTable").html(tableStr);
							$("#surplus").val("${surplusValue}");
							if("${jhFj.bcStatus}" == 1 || "${jhFj.bcStatus}" == 2){
						  		$("#btnSubmitOk").addClass(" hide"); 
						  	}
						  	$("#zsjhsh").select2();
						}
					});


	

	function getSurplus(obj) {
		$.getJSON("${ctx}/zsjh/zsjh/findSurplus", {
			id : obj.value
		}, function(result) {
			$("#surplus").val(result.surplusValue);
		});
	}
</script>
	<br />
	<form:form id="inputForm" modelAttribute="jhFj"
		action="${ctx}/jhfj/jhFj/saveSh" method="post" class="form-horizontal">
		<form:hidden path="id" />
		<sys:message content="${message}" />
		<div class="control-group">
			<label class="control-label">招生计划：</label>
			<div class="controls">
				<%-- <form:select id="zsjhsh" path="zsjh.id" disabled="true" class="input-medium required"
					style="width:215px;" onchange="getSurplus(this)">
					<form:option value="" label="" />
					<form:options items="${fns:getZsjhList()}" itemLabel="jhmc"
						itemValue="id" htmlEscape="false" />
				</form:select> --%>
				${zsjhEntity.jhmc }
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">剩余人数：</label>
			<div class="controls">
				<!-- <input type="text" id="surplus" name="surplus" readonly="true"
					class="input-xlarge" /> -->
				${surplusValue }
			</div>
		</div>


		<div id="officeTable"></div>
		
		<c:if test="${jhFj.bcStatus ne '1' && jhFj.bcStatus ne '2' }">
				<div class="control-group">
		        <label class="control-label">审核结果：</label>
				<div class="controls">
					 <form:radiobutton path="bcStatus" value="1" checked="true"/>通过  
                     <form:radiobutton path="bcStatus" value="2"/>不通过
		        </div>
			</div>
			<div class="control-group">
				<label class="control-label">审核意见：</label>
				<div class="controls">
					<form:textarea path="spnr" id="shyj" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge " style="width:598px;"/>
				</div>
			</div>
			<div class="control-group">
			  <div class="lg-form">
				<label class="control-label">审核人：</label>
				<div class="controls">
					<form:input path="grApproveBy.name" id="grApproveBy.name" 
						htmlEscape="false" maxlength="11" readonly="true" class="input-xlarge"/>
				</div>
			  </div>
			   <div class="lg-form">
				     <label class="control-label">审核时间：</label>
				     <div class="controls">
					     <input name="approveDate" type="text" disabled="disabled" maxlength="64" 
					     class="input-xlarge Wdate required"
						value="<fmt:formatDate value="${jhFj.grApproveDate}" pattern="yyyy-MM-dd"/>"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
				     </div>
			   </div>
			</div>
		</c:if>
		
		<c:if test="${jhFj.bcStatus eq '1' || jhFj.bcStatus eq '2' }">
			<div class="control-group">
		        <label class="control-label">审核结果：</label>
				<div class="controls">
					<c:if test="${jhFj.bcStatus eq '1'}">
						通过 
					</c:if>
					<c:if test="${jhFj.bcStatus eq '2'}">
						不通过 
					</c:if>
		        </div>
			</div>
			<div class="control-group">
				<label class="control-label">审核意见：</label>
				<div class="controls">
					${jhFj.spnr}
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
			<input id="btnSubmitOk" class="btn btn-primary"  onclick="tiJiao();" type="submit" value="确定"/>&nbsp;
			<input id="btnCancel" class="btn"  type="button" value="关闭" onclick="closeDialog();"/>
		</div>
	</form:form>
</body>
</html>