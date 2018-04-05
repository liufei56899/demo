<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>学生信息管理</title>
<meta name="decorator" content="default" />
<%@ include file="/WEB-INF/views/include/base_index.jsp"%>
<style type="text/css">
.tabTreeselect {
	width: 226px;
}

.labWidth {
	width: 230px;
}
</style>
<script type="text/javascript" src="${ctxStatic}/common/jeesite.js"></script>
<script type="text/javascript">
		$(document).ready(function() {
			var zz="${xsJbxx.bgydlx}";
			alert(zz);
			console.log("***************"+zz);
			 yanzhengYdlx();
		});
		
		//根据学生信息异动类型去分别显示界面
		function yanzhengYdlx() {
			var bgydlx = $("#bgydlx").val();
			alert(bgydlx);
			if (bgydlx == "0") {
				$("#tiaoban").show();
			} else if (bgydlx == "1") {
				$("#tiaoZhuanYe").show();
			} else if (bgydlx == "2") {
				$("#tuixue").show();
			}
		}
</script>
<script type="text/javascript">
	

	function openNewDialog(href, title, width, height) {
		var length = $("div#dialogDiv").size();
		if (length == 0) {
			$("#inputForm").before(
					"<div id='dialogDiv' style='width:850px;'></div>");
		}
		$('#dialogDiv').dialog({
			title : title,
			width : width,
			height : height,
			closed : false,
			cache : false,
			href : href,
			modal : true
		});

		$(".panel").css("top", "0px");
		$(".window-shadow").css("top", "0px");
	}

	function openHistoryRecord(value) {//formXsJbxxHistory
		openNewDialog("${ctx}/xs/xsJbxx/formXsJbxxHistory?id=" + value,
				"历史记录查看", 1200, 650);
	}
</script>

</head>

<body>

	<script type="text/javascript">
		$(document).ready(function() {
			 yanzhengYdlx();
		});
		
		//根据学生信息异动类型去分别显示界面
		function yanzhengYdlx() {
			var bgydlx = $("#bgydlx").val();
			if (bgydlx == "0") {
				$("#tiaoban").show();
			} else if (bgydlx == "1") {
				$("#tiaoZhuanYe").show();
			} else if (bgydlx == "2") {
				$("#tuixue").show();
			}
		}
</script>
	<!-- data-options="href:''" -->
	<form:form modelAttribute="xsJbxx" action="${ctx}/xs/xsJbxx/save"
		method="post" class="form-horizontal">
		<form:hidden path="id" />
		<sys:message content="${message}" />
		<fieldset>
			<legend>
				学生信息变更异动类型:
				<form:select path="bgydlx" class="input-xlarge" id="bgydlx"
					disabled="true">
					<form:option value="" label="" />
					<form:options items="${fns:getDictList('bgydlx')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			</legend>
		</fieldset>

		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">姓名：</label>
				<div class="controls2">${xsJbxx.xm }</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1 ">姓名拼音：</label>
				<div class="controls2">${xsJbxx.xmpy }</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1 ">英文姓名：</label>
				<div class="controls2">${xsJbxx.ywxm }</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1 ">性别：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.xbm,'sex','')}</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">身份证件类型：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.sfzjlxm,'sfzjlx', '')}</div>
			</div>
			<div class="lg-form1" style="border-top: 1px dotted #ddd;">
				<label class="control-label1">身份证件号码：</label>
				<div class="controls2">${xsJbxx.sfzjh }</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">出生日期：</label>
				<div class="controls2">${fns:getDate(xsJbxx.csrq)}</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">民族：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.mzm,'nation','')}</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">联系电话：</label>
				<div class="controls2">${xsJbxx.lxdh }</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">健康状况：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.jkzkm,'health', '')}</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">婚姻状况：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.hyzkm,'hyzk', '')}</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">国籍/地区：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.gjdqm,'gjdqm', '')}</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">政治面貌：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.zzmmm,'zzmm', '')}</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">家庭电话：</label>
				<div class="controls2">${xsJbxx.jtdh }</div>
			</div>
		</div>

		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1" style="width: 180px;">户口所在地区县以下详细地址：</label>
				<div class="controls2">${xsJbxx.hkszdqxyxxxdz }</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">家庭现地址：</label>
				<div class="controls2">${xsJbxx.jtxdz }</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">家庭邮政编码：</label>
				<div class="controls2">${xsJbxx.jtyzbm }</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">年级：</label>
				<div class="controls2">${xsJbxx.nj.nf }</div>
			</div>
		</div>
		<!-- 调班界面显示 -->
		<div id="tiaoban" style="display: none;">
			<div class="control-group">
				<div class="lg-form1">
					<label class="control-label1">原班级名称：</label>
					<div class="controls2">${xsJbxx.bjmc.bjmc }</div>
				</div>
				<div class="lg-form1">
					<label class="control-label1"><font color="red">调整后班级名称：</font>
					</label>
					<div class="controls2">${xsJbxx.newBjmc.bjmc}</div>
				</div>
			</div>
		</div>

		<!-- 调专业界面 -->
		<div id="tiaoZhuanYe" style="display: none;">
			<div class="control-group">
				<div class="lg-form1">
					<label class="control-label1">原专业类别：</label>
					<div class="controls2">${xsJbxx.zylxId.lxmc}</div>
				</div>

				<div class="lg-form1">
					<label class="control-label1"><font color="red">调整后专业类别：</font>
					</label>
					<div class="controls2">${xsJbxx.newZyid.zylx.lxmc}</div>
				</div>
			</div>
			<div class="control-group">
				<div class="lg-form1">
					<label class="control-label1">原专业名称：</label>
					<div class="controls2">${xsJbxx.zyId.zymc}(${fns:getDictLabel(xsJbxx.zyId.xz,'xzdm','')})</div>
				</div>
				<div class="lg-form1">
					<label class="control-label1"><font color="red">调整后专业名称：</font>
					</label>
					<div class="controls2">${xsJbxx.newZyid.zymc}(${fns:getDictLabel(xsJbxx.newZyid.xz,'xzdm','')})</div>
				</div>
			</div>
			<div class="control-group">
				<div class="lg-form1">
					<label class="control-label1">原班级名称：</label>
					<div class="controls2">${xsJbxx.bjmc.bjmc }</div>
				</div>
				<div class="lg-form1">
					<label class="control-label1"><font color="red">调整后班级名称：</font>
					</label>
					<div class="controls2">${xsJbxx.newBjmc.bjmc}</div>
				</div>
			</div>
		</div>

		<!-- 退学信息审核 -->
		<div id="tuixue" style="display: none;">
			<div class="control-group">
				<div class="lg-form1">
					<label class="control-label1">学制：</label>
					<div class="controls2">${fns:getDictLabel(xsJbxx.xz,'xzdm','')}</div>
				</div>
				<div class="lg-form1">
					<label class="control-label1">班级名称：</label>
					<div class="controls2">${xsJbxx.bjmc.bjmc}</div>
				</div>
			</div>
		</div>

		<div class="form-actions" align="center">
			<input id="btnCancel" class="btn btn-primary" type="button"
				value="关闭" onclick="closeDialog();" />
		</div>
	</form:form>
</body>
</html>