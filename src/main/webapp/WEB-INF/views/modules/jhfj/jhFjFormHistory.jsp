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
	$(document).ready(
					function() {
						//$("#name").focus();
						$("#inputForm1").validate(
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
						if ("${jhFjRecord.zsjh.id}" != "") {
							//绘制n行三列的表格
							var tableStr = "";
							tableStr += "<table class='table table-striped table-bordered table-condensed'>";
							tableStr += "<tr>";
							tableStr += "<td>部门</td>";
							tableStr += "<td>招生人数</td>";
							tableStr += "<td>划分区域</td>";
							tableStr += "</tr>";
							tableStr += "<tr>";
							tableStr += "<td><input id=\"hidden${jhFjRecord.office.id}\" type=\"hidden\" name=\"bmmc\" value=\"${jhFjRecord.office.id}\"/>${jhFjRecord.office.name}</td>";
							tableStr += "<td><input id=\"input${jhFjRecord.office.id}\" type=\"text\" name=\"zsrsInput1\" value=\"${jhFjRecord.zsrs}\" class=\"input-xlarge\"/></td>";
							tableStr += "<td>${innerTable}</td>";
							tableStr += "</tr>";
							tableStr += "</table>";
							$("#officeTable1").html(tableStr);
							$("#surplus1").val("${surplusValue}");
						}
					});

</script>
	<br />
	<form:form id="inputForm1" modelAttribute="jhFjRecord"
		action="${ctx}/jhfj/jhFjRecord/saveSh" method="post" class="form-horizontal">
		<form:hidden path="id" />
		<sys:message content="${message}" />
		<div class="control-group">
			<label class="control-label">招生计划：</label>
			<div class="controls">
				<form:select id="zsjh" path="zsjh.id" class="input-medium required"
					style="width:215px;">
					<form:option value="" label="" />
					<form:options items="${fns:getZsjhList()}" itemLabel="jhmc"
						itemValue="id" htmlEscape="false" />
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">剩余人数：</label>
			<div class="controls">
				<input type="text" id="surplus1" name="surplus"
					class="input-xlarge required digits" />
			</div>
		</div>


		<div id="officeTable1"></div>
		
		<div class="control-group">
		        <label class="control-label">审核结果：</label>
				<div class="controls">
					 <form:radiobutton path="bcstatus" value="1" checked="true"/>通过  
                     <form:radiobutton path="bcstatus" value="2"/>不通过
		        </div>
		</div>
		<div class="control-group">
			<label class="control-label">审核意见：</label>
			<div class="controls">
				<form:textarea path="spnr" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge " style="width:284px;"/>
			</div>
		</div>
		<div class="control-group">
		  <div class="lg-form">
			<label class="control-label">审核人：</label>
			<div class="controls">
				<form:input path="approveBy.name" id="approveBy.name"  htmlEscape="false" maxlength="11" readonly="true" class="input-xlarge"/>
			</div>
		  </div>
		   <div class="lg-form">
			     <label class="control-label">审核时间：</label>
			     <div class="controls">
				     <input name="approveDate" type="text" disabled="disabled" maxlength="64" class="input-xlarge Wdate required"
					value="<fmt:formatDate value="${jhFjRecord.approveDate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			     </div>
		   </div>
		</div>
		
		<!-- <div class="form-actions">
			<input id="btnCancel" class="btn btn-primary"  type="button" value="取消" onclick="closeDialog();"/>
		</div> -->
	</form:form>
</body>
</html>