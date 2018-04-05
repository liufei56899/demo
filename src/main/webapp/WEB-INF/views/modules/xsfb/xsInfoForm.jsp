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
	<script type="text/javascript" src="/em/static/js/jquery-2.1.0.min.js"></script>
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
		openNewDialog("${ctx}/xs/xsJbxx/formXsJbxxHistory?id=" + value,"历史记录查看", 1200, 650);
	}
	
	
	
	
	</script>

</head>

<body>


<!-- data-options="href:''" -->
	<form:form id="inputForm" modelAttribute="xsJbxx" action="${ctx}/xs/xsJbxx/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<fieldset>
			<legend>学生基本信息:</legend>
		</fieldset>	
		
		
		<div class="cont-group1">
		<div class="left-control-group">
			<div class="left-form">
				<label class="control-label1"><font color="red">姓名：</font></label>
				<div class="controls2">
					${xsJbxx.xm }
				</div>
			</div>
			<div class="left-form">
				<label class="control-label1 labWidth" >姓名拼音：</label>
				<div class="controls2">
					${xsJbxx.xmpy }
				</div>
			</div>
			<div class="left-form">
				<label class="control-label1 labWidth" >英文姓名：</label>
				<div class="controls2">
					${xsJbxx.ywxm }
				</div>
			</div>
			<div class="left-form">
				<label class="control-label1 labWidth" ><font color="red">性别：</font></label>
				<div class="controls2">
					${fns:getDictLabel(xsJbxx.xbm, 'sex', '')}
				</div>
			</div>
		</div>
		<div class="right-control-group">
		<div class="right-form">
				<label class="control-label1"  style="padding:0; line-height: 161px; height: auto;">照片：</label>
				<c:if test="${xsJbxx.photo==null}">
				<img src="${ctxStatic }/js/xszp.png" id="imgShow0" style='width:120px; height:160px;'/>			
					</c:if>
				<c:if test="${xsJbxx.photo!=null}">
				<img src="${xsJbxx.photo}" id="imgShow0" style='width:120px; height:160px;'/>			
					</c:if>
			</div>
		
		</div>
		
	</div>
		
		
		
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1"><font color="red">身份证件类型：</font></label>
				<div class="controls2">
					${fns:getDictLabel(xsJbxx.sfzjlxm, 'sfzjlx', '')}
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1"><font color="red">身份证件号码：</font></label>
				<div class="controls2">
					${xsJbxx.sfzjh }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1"><font color="red">出生日期：</font></label>
				<div class="controls2">
					${fns:getDate(xsJbxx.csrq)}
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1" >民族：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.mzm, 'nation', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">联系电话：</label>
				<div class="controls2">${xsJbxx.lxdh }
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1" >健康状况：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.jkzkm, 'health', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">婚姻状况：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.hyzkm, 'hyzk', '')}
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1" >国籍/地区：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.gjdqm, 'gjdqm', '')}
				</div>
			</div>
		</div>
		
		<div class="control-group">
			<div class="lg-form1">
					<label class="control-label1">户口性质：</label>
					<div class="controls2">${fns:getDictLabel(xsJbxx.hkxz, 'hkxz', '')}
					</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1" >学生居住地类型：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.xsjzdlx, 'xsjzdlx', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">港澳台侨外：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.gatqwm, 'gatqwm', '')}
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">政治面貌：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.zzmmm, 'zzmm', '')}
				</div>
			</div>
		</div>
		
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">电子信箱/其他联系方式：</label>
				<div class="controls2">${xsJbxx.dzxx }
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">生源地行政区划码：</label>
				<div class="controls2">${xsJbxx.sydxzqhm }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">出生地：</label>
				<div class="controls2">${xsJbxx.csd}
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">出生地行政区划码：</label>
				<div class="controls2">${xsJbxx.csdxzqhm }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">籍贯：</label>
				<div class="controls2">${xsJbxx.jg}
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">籍贯地行政区划码：</label>
				<div class="controls2">${xsJbxx.jgdxzqhm }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">户口所在地：</label>
				<div class="controls2">${xsJbxx.hkszd}
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">户口所在地行政区划码：</label>
				<div class="controls2">${xsJbxx.hkszdxzqhm }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1" >户口所在地区县以下详细地址：</label>
				<div class="controls2">${xsJbxx.hkszdqxyxxxdz }
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">家庭现地址：</label>
				<div class="controls2">${xsJbxx.jtxdz }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1" >家庭邮政编码：</label>
				<div class="controls2">${xsJbxx.jtyzbm }
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">家庭电话：</label>
				<div class="controls2">${xsJbxx.jtdh }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">所属派出所：</label>
				<div class="controls2">${xsJbxx.scpcs }
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">乘火车区间：</label>
				<div class="controls2">${xsJbxx.chcqj }
				</div>
			</div>
		</div>
		
			<%-- <div class="lg-form1">
				<label class="control-label1" style ="width:230px;">班级名称：</label>
				<div class="controls2">
					<form:input path="bjmc" htmlEscape="false" readonly="readonly" maxlength="32" class="input-xlarge "/>
					<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" 
						data-target="#selectBanJi">选择班级</button>
					<c:if test="${not empty xsJbxx.bjmc.bjmc }">
						<span id="banJiMc">${xsJbxx.bjmc.bjmc }</span> 
					</c:if>
					<c:if test="${empty xsJbxx.bjmc.bjmc }">
						<span id="banJiMc">未分班</span> 
					</c:if>
					<input type="hidden" name="bjmc.id" value="${xsJbxx.bjmc.id }" id="banJiId" />
				</div>
			</div> --%>
		<%-- <div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">学号：</label>
				<div class="controls2">
					${xsJbxx.xh }
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1" >学生类别：</label>
				<div class="controls2">
					${fns:getDictLabel(xsJbxx.xslbm, 'xslb', '')}
				</div>
			</div>
		</div> --%>
		<%-- <div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">学习形式：</label>
				<div class="controls2">
					${fns:getDictLabel(xsJbxx.xxxsm, 'xxxs', '')}
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1" style ="width:230px;">入学方式：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.rxfsm, 'rxfs', '')}
				</div>
			</div>
		</div> --%>
		<%-- <div class="control-group">
			<div class="lg-form1">
				<label class="control-label1" >国籍/地区：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.gjdqm, 'gjdqm', '')}
				</div>
			</div>
		</div> --%>
	<%-- 	<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">联系电话：</label>
				<div class="controls2">${xsJbxx.lxdh }
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1" >国籍/地区：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.gjdqm, 'gjdqm', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">港澳台侨外：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.gatqwm, 'gatqwm', '')}
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">婚姻状况：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.hyzkm, 'hyzk', '')}
				</div>
			</div>
		</div> --%>
		<%-- <div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">乘火车区间：</label>
				<div class="controls2">${xsJbxx.chcqj }
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1" style ="width:230px;">是否随迁子女：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.sfsqzn, 'sfdm', '')}
				</div>
			</div>
		</div> --%>
		<%-- <div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">生源地行政区划码：</label>
				<div class="controls2">${xsJbxx.sydxzqhm }
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">出生地：</label>
				<div class="controls2">${xsJbxx.csdxzqhm }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">籍贯：</label>
				<div class="controls2">${xsJbxx.jgdxzqhm }
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1" >户口所在地区县以下详细地址：</label>
				<div class="controls2">${xsJbxx.hkszdqxyxxxdz }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">所属派出所：</label>
				<div class="controls2">${xsJbxx.scpcs }
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">户口所在地：</label>
				<div class="controls2">${xsJbxx.hkszdxzqhm }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">户口性质：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.hkxz, 'hkxz', '')}
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1" >学生居住地类型：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.xsjzdlx, 'xsjzdlx', '')}
				</div>
			</div>
		</div>

		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">政治面貌：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.zzmmm, 'zzmm', '')}
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1" >健康状况：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.jkzkm, 'health', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">学生来源：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.xslym, 'xs_ly', '')}
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1" >招生对象：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.zsdx, 'zsdx', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">监护人联系电话：</label>
				<div class="controls2">${xsJbxx.jhrlxdh }
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1" >毕业学校：</label>
				<div class="controls2">${xsJbxx.byxx }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">电子信箱/其他联系方式：</label>
				<div class="controls2">${xsJbxx.dzxx }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">备注：</label>
				<div class="controls2">${xsJbxx.remarks}
				</div>
			</div>
		</div>
		 --%>
		
		
		
		<fieldset>
			<legend>学生来源信息:</legend>
		</fieldset>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">学生来源：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.xslym, 'xs_ly', '')}
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1" >招生对象：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.zsdx, 'zsdx', '')}
				</div>
			</div>
		</div>
		
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">入学方式：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.rxfsm, 'rxfs', '')}
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1" >是否随迁子女：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.sfsqzn, 'sfdm', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">招生生源地：</label>
				<div class="controls2">
					<div class="controls2" style="width: 300">${xsJbxx.zssyd}
				</div>
				</div>
			</div>		
		</div>
		
		
		<fieldset>
			<legend>学生入学信息:</legend>
		</fieldset>
		
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1" ><font color="red">入学年月：</font></label>
				<div class="controls2">${fns:getDate(xsJbxx.rxny)}
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">学号：</label>
				<div class="controls2">
					${xsJbxx.xh }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1" >学生类别：</label>
				<div class="controls2">
					${fns:getDictLabel(xsJbxx.xslbm, 'xslb', '')}
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1" ><font color="red">招生季节：</font></label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.zsjj, 'term_type', '')}</div>
				<%-- <div class="controls2">${xsJbxx.zsjj}</div> --%>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">专业简称：</label>
				<div class="controls2">${xsJbxx.zyjc}
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">学习形式：</label>
				<div class="controls2">
					${fns:getDictLabel(xsJbxx.xxxsm, 'xxxs', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">年级：</label>
				<div class="controls2">
					${xsJbxx.nj.nf }
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1"><font color="red">学制：</font></label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.xz, 'xzdm', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">分段培养方式：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.fdpyfs, 'fdpyfs', '')}
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">班级名称：</label>
				<div class="controls2">${xsJbxx.bjmc.bjmc}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">是否校外教学点学生：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.sfxwjxdxs, 'sfdm', '')}
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">就读方式：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.jdfsm, 'jdfs', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1" >招生方式：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.zsfs, 'zsfs', '')}
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">准考证号：</label>
				<div class="controls2">${xsJbxx.zkzh }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1" >考生号：</label>
				<div class="controls2">${xsJbxx.ksh }
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">考试总分：</label>
				<div class="controls2">${xsJbxx.kszf }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">联招合作类型：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.lzhzlx, 'lzhzlx', '')}
				</div>
			</div>
				<div class="lg-form1">
				<label class="control-label1">联招合作学校名称：</label>
				<div class="controls2">${xsJbxx.lzhzxxmc}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1" >联招合作办学形式：</label>
				<div class="controls2"> ${fns:getDictLabel(xsJbxx.lzhzbxfs, 'lzhzbxxs', '')}
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">联招合作学校代码：</label>
				<div class="controls2">${xsJbxx.lzhzxxdm}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1" >校外教学点：</label>
				<div class="controls2">${xsJbxx.xwjxd }
				</div>
			</div>
		</div>
		<%-- 
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">考生总分：</label>
				<div class="controls2">${xsJbxx.kszf }
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1" >考生特长：</label>
				<div class="controls2">${xsJbxx.kstc }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">考生既往病史：</label>
				<div class="controls2">${xsJbxx.ksjwbs }
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1" >体检结论：</label>
				<div class="controls2">${xsJbxx.tjjl }
				</div>
			</div>
		</div>
		<div class="control-group">
			
			
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">联招合作学校名称：</label>
				<div class="controls2">${xsJbxx.lzhzxxdm }
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1" >校外教学点：</label>
				<div class="controls2">${xsJbxx.xwjxd }
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1" >联招合作学校办学类型：</label>
				<div class="controls2">
				</div>
			</div>
		</div>
		<div class="control-group">
			
			 <div class="lg-form1">
				<label class="control-label1" >校外教学点：</label>
				<div class="controls2">${xsJbxx.xwjxd }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">分段培养方式：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.fdpyfs, 'fdpyfs', '')}
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">电子信箱/其他联系方式：</label>
				<div class="controls2">${xsJbxx.dzxx }
				</div>
			</div>
		</div>
		
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">家庭现地址：</label>
				<div class="controls2">${xsJbxx.jtxdz }
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1" >家庭邮政编码：</label>
				<div class="controls2">${xsJbxx.jtyzbm }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">家庭电话：</label>
				<div class="controls2">${xsJbxx.jtdh }
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1" >入学年月：</label>
				<div class="controls2">${fns:getDate(xsJbxx.rxny)}
				</div>
			</div>
			
			<div class="lg-form1">
				<label class="control-label1">乘火车区间：</label>
				<div class="controls2">${xsJbxx.chcqj }
				</div>
			</div>
		</div>
		
		<div class="control-group">
			
			<div class="lg-form1">
				<label class="control-label1">分段培养方式：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.fdpyfs, 'fdpyfs', '')}
				</div>
			</div>
		</div>
		
		<div  class="control-group">
			
		
		</div>
		
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">专业类别：</label>
				<div class="controls2">${xsJbxx.zylxId.lxmc}
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1" >专业名称：</label>
				<div class="controls2" id="zhuaYeId">
					${xsJbxx.zyId.zymc}
					
				</div>
			</div>
		</div>
		<div class="control-group">
			
			
		</div>
		<div class="control-group">
		
		
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1" >专业方向：</label>
				<div class="controls2">${xsJbxx.zyfx}
				</div>
			</div>
		</div> --%>
		<%-- <fieldset>
			<legend>成员1信息:</legend>
		</fieldset>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">姓名：</label>
				<div class="controls2">${xsJbxx.cyyxm }
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">关系：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.cyygx, 'cygx', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">是否监护人：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.cyysfjhr, 'sfdm', '')}
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">联系电话：</label>
				<div class="controls2">${xsJbxx.cyylxdh }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">出生年月：</label>
				<div class="controls2">${fns:getDate(xsJbxx.cyycsny)}
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">身份证件类型：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.cyysfzjlx, 'sfzjlx', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">身份证件号：</label>
				<div class="controls2">${xsJbxx.cyysfzjh }
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">民族：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.cyymzm, 'nation', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">政治面貌：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.cyyzzmmm, 'zzmm', '')}
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">健康状况：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.cyyjkzkm, 'health', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">工作或学习单位：</label>
				<div class="controls2">${xsJbxx.cyygzhxxdw }
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">职务：</label>
				<div class="controls2">${xsJbxx.cyyzw }
				</div>
			</div>
		</div>
		<fieldset>
			<legend>成员2信息:</legend>
		</fieldset>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">姓名：</label>
				<div class="controls2">${xsJbxx.cyexm }
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">关系：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.cyegx, 'cygx', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">是否监护人：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.cyesfjhr, 'sfdm', '')}
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">联系电话：</label>
				<div class="controls2">${xsJbxx.cyelxdh }
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">出生年月：</label>
				<div class="controls2">${fns:getDate(xsJbxx.cyecsny)}
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">身份证件类型：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.cyesfzjlx, 'sfzjlx', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">身份证件号：</label>
				<div class="controls2">${xsJbxx.cyesfzjh }
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">民族：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.cyemzm, 'nation', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">政治面貌：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.cyezzmmm, 'zzmm', '')}
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">健康状况：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.cyejkzkm, 'health', '')}
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">工作或学习单位：</label>
				<div class="controls2">${xsJbxx.cyegzhxxdw }
				</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">职务：</label>
				<div class="controls2">${xsJbxx.cyezw }
				</div>
			</div>
		</div> --%>
	</form:form>
</body>
</html>