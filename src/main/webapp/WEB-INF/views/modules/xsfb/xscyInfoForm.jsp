<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学生信息管理</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/base_index.jsp"%>
	<style type="text/css">
	  .tabTreeselect 
	  {
	  	width:226px;
	  }
	  .labWidth 
	  {
	  	 width:230px;
	  }
	</style>
	<script type="text/javascript">
		
		function openNewDialog(href, title, width, height) {
		var length = $("div#dialogDiv").size();
		if (length == 0) {
			$("#inputForm").before(
					"<div id='dialogDiv' style='width:820px;'></div>");
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
		openNewDialog("${ctx}/xs/xsJbxx/formXsJbxxHistory?id=" + value,"历史记录查看", 1200, 650);
	}
	</script>
</head>
<body>

	<form:form id="inputForm1" modelAttribute="xsJbxx" action="${ctx}/xs/xsJbxx/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		
		<fieldset>
			<legend>成员1信息:</legend>
		</fieldset>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">姓名：</label>
				<div class=".controls2">${xsJbxx.cyyxm }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">关系：</label>
				<div class=".controls2">${fns:getDictLabel(xsJbxx.cyygx, 'cygx', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">是否监护人：</label>
				<div class=".controls2">${fns:getDictLabel(xsJbxx.cyysfjhr, 'sfdm', '')}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">联系电话：</label>
				<div class=".controls2">${xsJbxx.cyylxdh }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">出生年月：</label>
				<div class=".controls2">${fns:getDate(xsJbxx.cyycsny)}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">身份证件类型：</label>
				<div class=".controls2">${fns:getDictLabel(xsJbxx.cyysfzjlx, 'sfzjlx', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">身份证件号码：</label>
				<div class=".controls2">${xsJbxx.cyysfzjh }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">民族：</label>
				<div class=".controls2">${fns:getDictLabel(xsJbxx.cyymzm, 'nation', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">政治面貌：</label>
				<div class=".controls2">${fns:getDictLabel(xsJbxx.cyyzzmmm, 'zzmm', '')}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">健康状况：</label>
				<div class=".controls2">${fns:getDictLabel(xsJbxx.cyyjkzkm, 'health', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">工作或学习单位：</label>
				<div class=".controls2">${xsJbxx.cyygzhxxdw }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">职务：</label>
				<div class=".controls2">${xsJbxx.cyyzw }
				</div>
			</div>
		</div>
		<fieldset>
			<legend>成员2信息:</legend>
		</fieldset>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">姓名：</label>
				<div class=".controls2">${xsJbxx.cyexm }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">关系：</label>
				<div class=".controls2">${fns:getDictLabel(xsJbxx.cyegx, 'cygx', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">是否监护人：</label>
				<div class=".controls2">${fns:getDictLabel(xsJbxx.cyesfjhr, 'sfdm', '')}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">联系电话：</label>
				<div class=".controls2">${xsJbxx.cyelxdh }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">出生年月：</label>
				<div class=".controls2">${fns:getDate(xsJbxx.cyecsny)}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">身份证件类型：</label>
				<div class=".controls2">${fns:getDictLabel(xsJbxx.cyesfzjlx, 'sfzjlx', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">身份证件号码：</label>
				<div class=".controls2">${xsJbxx.cyesfzjh }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">民族：</label>
				<div class=".controls2">${fns:getDictLabel(xsJbxx.cyemzm, 'nation', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">政治面貌：</label>
				<div class=".controls2">${fns:getDictLabel(xsJbxx.cyezzmmm, 'zzmm', '')}
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">健康状况：</label>
				<div class=".controls2">${fns:getDictLabel(xsJbxx.cyejkzkm, 'health', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">工作或学习单位：</label>
				<div class=".controls2">${xsJbxx.cyegzhxxdw }
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">职务：</label>
				<div class=".controls2">${xsJbxx.cyezw }
				</div>
			</div>
		</div>
		
	</form:form>
</body>
</html>