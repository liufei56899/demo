<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>追加招生计划</title>
<meta name="decorator" content="default" />
<%@ include file="/WEB-INF/views/include/base_index.jsp"%>
</head>
<body>
<script type="text/javascript" src="${ctxStatic}/common/jeesite.js"></script>
<style  type="text/css">
		label.error
		{
			background-position: 0px 3px;
		}
		.form-horizontal .control-label 
		{
			width:130px;	
		}
		.form-horizontal .controls 
		{
			margin-left:140px;
		}
		
	</style>
	<script type="text/javascript">
		function validateJhmc()
		{
			var ret = true;
			var jhmc = $("#jhmc2").val();
			var id = "${zsjh.id}";
			if(jhmc!=null && jhmc!="")
			{
				jQuery.ajax({
			        type: "POST",
			        url: "${ctx}/zsjh/zsjh/validateJhmc",
			        data: {jhmc:jhmc,id:id},
			        dataType:'json',
			        async:false,
					success: function(result){
						ret = result.isTrue;
						if(!ret)
						{
							validTxt("jhmc2","计划名称不能重复");
							return false;
						}
				   }
			    });
			}
			return ret;
		}
	
		var rows = 0;
		$(document).ready(
				function() {
					$("#inputForm").validate(
							{
								submitHandler : function(form) {
									var ret = validateJhmc();
									if(ret)
									{
										loading('正在提交，请稍等...');
										form.submit();
									}
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
					var jh_id = $("#id").val();
					if (jh_id != null && jh_id != "") {
						var zt = "${zsjh.zt}";
						if (zt != null && zt != "" && zt > 2) {
							startInit(jh_id,
									"${ctx}/zsjh/zsjh/findZyJhInitDisplay");
							initCommit();
						} else {
							startInit(jh_id, "${ctx}/zsjh/zsjh/findZyJhInit");
						}
					} else {
						rows = 1;
					}
				});
		function startInit(jh_id, url) {
			$.getJSON(url, {
				id : jh_id,
				rows : 1,
				viewmodel : 0
			}, function(result) {
				$("#bmTable1").append(result.html);
				var r = document.getElementById("bmTable1");
				rows = r.rows.length;
				if (rows > 1) {
					for ( var i = 1; i < rows; i++) {
						selectAddStyle("zylx" + i);
						selectAddStyle("zy" + i);

					}
				}
			});
		}
		//首次提交初始化
		function initCommit() {
			$("#jhmc").attr("readonly", true);
			$("#nf").attr("readonly", true);
			$("#xqId").attr("disabled", "disabled");
			$("#zsrs").attr("readonly", true);
			$("#remarks").attr("readonly", true);
			$("#jhsm").attr("readonly", true);
		}

		function addRow() {
			rows = rows + 1;
			//表格行数
			//var rows = $("#bmTable").rows;
			//var tab = document.getElementById("bmTable2");
			//表格行数
			$.getJSON("${ctx}/zsjh/zsjh/findPsTable", {
				rows : rows
			}, function(result) {
				$("#bmTable2").append(result.html);
				selectAddStyle("zylx" + (rows));
				selectAddStyle("zy" + (rows));
			});
		}

		function zyLx(rows, info) {
			$.getJSON("${ctx}/zsjh/zsjh/findZyByLxId", {
				id : info.value,
				rows : rows
			}, function(result) {
				$("#zyS" + rows).html(result.html);
				$("#zy"+rows).addClass("required");
		      	$("#zy"+rows).attr("style","width:150px;");
				selectAddStyle("zy" + (rows));
			});
		}

		function bc() {
			$("#bcStatus").val("1");
		}

		function tj() {
			$("#bcStatus").val("2");
		}

		function del(o) {
			var t = document.getElementById("bmTable2");
			t.deleteRow(o.parentNode.parentNode.rowIndex)
		}

		function validateYear(obj, id, mes) {
			if (!/^\d{4}$/.test(obj.value)) {
				var myDate = new Date();
				myDate.getYear(); //获取当前年份(2位)
				obj.value = myDate.getFullYear();
				validTxt(id, mes);
			}
		}
		/***
		 *验证专业不重复
		 */
		function checkZy(info, id2) {
		   $.getJSON("${ctx}/zsjh/zsjh/getZhuanYeById", {id : info.value },
		            function(result) {
							$("p#"+id2).text(result);
					});
		}

		/*
		 *招生人数总和
		 */
		function sumZsrs(th, value) {
			if (value == 0) {
				alertx("计划人数大于 0");
				th.value = "";
				return;
			}
			var result = 0;
			var h = 0;
			var start = "";
			if (rows > 1) {
				for ( var i = 0; i < rows; i++) {
					start = $("input[name='jhZyInfos[" + i + "].zsrs']").val();
					if (start != null && start != "") {
						h = parseInt(start);
						result = result + h;
					}
				}
				$("#zsrs").val(result);
			}
		}

		//修改页面信息状态
		var viewmodel = "${zsjh.viewModel}";
		if (viewmodel == "1") {
			$("#zybiaoti").css("display", "none");
			$("#option").css("display", "none");
			$("#btnSubmitBc").css("display", "none");
			$("#btnSubmitTj").css("display", "none");
		} else if (viewmodel == "3") {
			$("#zybiaoti").css("display", "none");
			$("#option").css("display", "none");
			$("#btnSubmitBc").css("display", "none");
		}
	</script>
	<div style="margin-left: 50px;height: 29px;">
		<c:if test="${zsjh.zt eq '2'}">
			<script type="text/javascript">
				var jericho = {
					buildTabpanel : function() {
						$.fn.initJerichoTab({
							renderTo : "#divRight",
							uniqueId : "myJerichoTab",
							contentCss : {
								"height" : $("#divRight").height()
							},
							tabs : []
						});
					}
				};
				$()
						.ready(
								function() {
									$('#divRight').css({
										width : 1060,
										height : 500
									});
									jericho.buildTabpanel();
									$.fn.jerichoTab.addTab({
										title : "计划名称",
										closeable : false,
										data : {
											dataType : "formtag",
											dataLink : "#tbNews"
										}
									}).loadData(true);
									var jh_id = $("#id").val();
									//显示历史记录信息
									$
											.getJSON(
													"${ctx}/zsjh/zsjhrecord/zsjhrecordlist",
													{
														rid : jh_id
													},
													function(result) {
														var div = $("#selection_title");
														var option = "<select onchange=\"addtab(this.value)\"><option value=''></option>";
														for ( var i = 0; i < result.length; i++) {
															option += "<option value=\""+result[i].id+"-"+result[i].cid+"\">"
																	+ result[i].cid
																	+ "</option>";
														}
														option = option
																+ "</select>";
														div.append(option);
													});
								});
				function addtab(value) {
					if (value == "" || value == null) {
						return;
					}
					var value1 = value.substr(0, value.indexOf("-"));
					var name = value.substr(value.indexOf("-") + 1,
							value.length);
					$.fn.jerichoTab
							.addTab(
									{
										title : name,
										closeable : true,
										data : {
											dataType : "iframe",
											dataLink : "${ctx}/zsjh/zsjhrecord/formshhistory?id="
													+ value1
										}
									}).loadData(true);
				}
			</script>
			<label class="control-label">招生计划历史记录:</label>
			<label class="control-label" style="margin-left: 20px;">
				<div id="selection_title"></div> </label>
		</c:if>
	</div>
	<div id="divRight"></div>
	<c:if test="${zsjh.zt eq '2'}">
		<div id="tbNews" style="overflow-y: scroll;height: 500px;">
	</c:if>
	<c:if test="${zsjh.zt eq '0' or zsjh.zt eq '1' or zsjh.zt eq '3'}">
		<div id="tbNews">
	</c:if>
	<form:form id="inputForm" modelAttribute="zsjh"
		action="${ctx}/zsjh/zsjh/save" method="post" class="form-horizontal"
		style="width: 98%;">
		<%-- <form:hidden path="id" id="jh_id"/> --%>
		<form:hidden path="viewModel" id="viewModel" />
		<form:hidden path="id" id="id" />
		<form:hidden path="act.taskId" />
		<form:hidden path="act.taskName" />
		<form:hidden path="act.taskDefKey" />
		<form:hidden path="act.procInsId" />
		<form:hidden path="act.procDefId" />
		<form:hidden id="flag" path="act.flag" value="yes" />
		<form:hidden path="zt" id="zt" />
		<form:hidden path="bcStatus" id="bcStatus" />
		<sys:message content="${message}" />
		<div class="control-group">
			<div class="lg-form"  style="width:1050px;">
				<label class="control-label">计划名称：</label>
				<div class="controls">
				<form:input path="jhmc" id="jhmc2" htmlEscape="false" maxlength="64"
					class="input-xlarge required"  style="width:733px;"/>
				<span class="help-inline"><font color="red">*</font> </span></div>
			</div>
		</div>
		<div class="control-group">
			<%-- <div class="lg-form">
				<label class="control-label">学期：</label>
				<form:select path="xqId" id="xqId" style="width:215px;">
					<form:option value="" label="全部" />
					<form:options items="${fns:getDictList('term_type')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div> --%>
			<div class="lg-form">
				<label class="control-label">招生人数：</label><div class="controls">
				<form:input path="zsrs" id="zsrs" htmlEscape="false" maxlength="11"
					readonly="true" class="input-xlarge required digits" /></div>
			</div>
			<div class="lg-form">
		       <label class="control-label">学年：</label>
		       <div class="controls">
				<form:select path="nf.id" id="nf2"  class="input-xlarge required" style="width:215px;" >
					<form:option value="" label="全部" />
					<form:options items="${fns:getXnxqJbxxList()}" 
					              itemLabel="xnmc" itemValue="id" htmlEscape="false" />
			   </form:select>
			   <span class="help-inline"><font color="red">*</font></span>
			   </div>
		   </div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">招生开始时间：</label>
				<div class="controls"> <input
					name="startDate" id="startDate" type="text" readonly="readonly"
					maxlength="20" class="input-xlarge Wdate"
					value="<fmt:formatDate value="${zsjh.startDate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" />
				<span class="help-inline"><font color="red">*</font> </span></div>
			</div>
			<div class="lg-form">
				<label class="control-label">招生结束时间：</label> 
				<div class="controls"> <input name="endDate"
					id="endDate" type="text" readonly="readonly" maxlength="20"
					class="input-xlarge Wdate"
					value="<fmt:formatDate value="${zsjh.endDate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" />
				<span class="help-inline"><font color="red">*</font> </span></div>
			</div>
		</div>
		<div style="width: 80%;  margin-bottom: 5px;" id="zybiaoti">
			<input style="margin-left: 90px;" type="button" onclick="addRow()"
				value="招生专业 +" />
		</div>
		<div class="control-group">
			<div
				style="text-align: center; width: 90%;margin-left: 90px; margin-bottom:10px; height:200px; overflow: auto;">
				<table id="bmTable1"
					class="table table-striped table-bordered table-condensed">
					<tr>
						<th style="font-size:14px;width: ">专业类别</th>
						<th style="font-size:14px;">专业名称</th>
						<th style="font-size:14px;">招生人数</th>
						<!-- <th style="font-size:14px;">班级数量</th> -->
						<th style="font-size:14px;" id="option">操作</th>
					</tr>
				</table>
				<table id="bmTable2"
					class="table table-striped table-bordered table-condensed">
				</table>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">招生说明：</label>
			<div class="controls">
				<form:textarea path="jhsm" id="jhsm" htmlEscape="false" rows="4"
					maxlength="255" style="width:750px;resize: none;"
					class="input-xxlarge" />
			</div>
		</div>
		<div style="text-align: center;">
			<input id="btnSubmitBc" class="btn btn-primary" onclick="bc()"
					type="submit" value="保 存" />&nbsp;
			<input id="btnSubmitTj" class="btn btn-primary" onclick="tj()"
					type="submit" value="提交" />&nbsp;
			<input id="btnCancel" class="btn" type="button"
				value="关 闭" onclick="closeDialog();" />
		</div>
	</form:form>

</body>

</html>
