<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>招生信息查看</title>
<meta name="decorator" content="default" />

</head>
<body>
<script type="text/javascript" src="${ctxStatic}/common/jeesite.js"></script>
<script type="text/javascript">
</script>
	<form:form id="inputForm" modelAttribute="zsdj" class="form-horizontal">
		<form:hidden path="id" />
		<form:hidden id="bcfs" path="bcfs"/>
		<input type="hidden" name="ly" value="3">
		<sys:message content="${message}" />
		<label id="tip" style="color: red; "></label>
		<div class="control-group">
		   <div class="lg-form">
			<label class="control-label">计划名称：</label>
			<div class="controls">
				${zsdj.zsjh.jhmc}
			</div>
		   </div>
		   <div class="lg-form">
		     <label class="control-label">学生姓名：</label>
			<div class="controls">
				${zsdj.xm}
			</div>
		   </div>
		</div>
		<div class="control-group">
		    <div class="lg-form">
			<label class="control-label">性别：</label>
			<div class="controls">
				${fns:getDictLabel(zsdj.xbm, 'sex', '')}
			</div>
			</div>
			<div class="lg-form">
				<%-- <label class="control-label">年级：</label>
				<div class="controls">
					${zsdj.nj.nf}
				</div> --%>
				<label class="control-label">民族：</label>
				<div class="controls">
					${fns:getDictLabel(zsdj.nation, 'nation', '')}
				</div>
			</div>
			
		</div>
		<div class="control-group">
		
		    <div class="lg-form">
			<label class="control-label">专业类别：</label>
			<div class="controls">
				${zsdj.zylx.lxmc}
			</div>
			</div>
			
			 <div class="lg-form">
			   <label class="control-label">专业名称：</label>
			 <div class="controls" id="zyByLxmm" >
			 	${zsdj.zy.zymc}(${zsdj.xz})
			 </div>
			 </div>
			 
		</div>
		
		
		<div class="control-group">
		 <div class="lg-form">
			<label class="control-label">招生季节：</label>
			<div class="controls">
					${zsdj.xnxq.xnmc}
			</div>
			</div>
			 <div class="lg-form">
			   <label class="control-label">学制：</label>
				<div class="controls" >
					${zsdj.xz}
				</div>
			 </div>
		</div>
		<div class="control-group">
			 <div class="lg-form">
				<label class="control-label">身份证件类型：</label>
				<div class="controls">
					${fns:getDictLabel(zsdj.sfzjlx, 'sfzjlx', '')}
				</div>
			</div>
			<div class="lg-form">
				 <label class="control-label">身份证件号码：</label>
				<div class="controls">
					${zsdj.sfzjh}
				</div>
			 </div>
		</div>
		
		<div class="control-group">
			<div class="lg-form">
					<label class="control-label">出生日期：</label>
					<div class="controls">
						<fmt:formatDate value="${zsdj.csrq}" pattern="yyyy-MM-dd"/>
					</div>
			</div>
			 <div class="lg-form">
				<%-- <label class="control-label">民族：</label>
				<div class="controls">
					${fns:getDictLabel(zsdj.nation, 'nation', '')}
				</div> --%>
				<label class="control-label">家庭住址：</label>
				<div class="controls">
					${zsdj.jtzz}
				</div>
			</div>
		
		</div>
		
		
		
		<div class="control-group">
		  <div class="lg-form">
			<%-- <label class="control-label">家庭住址：</label>
			<div class="controls">
				${zsdj.jtzz}
			</div> --%>
			<label class="control-label">生源校：</label>
			<div class="controls">
				${zsdj.fromSchool}
			</div>
			</div>
			<div class="lg-form">
			  <label class="control-label">联系电话：</label>
			<div class="controls">
				${zsdj.lxdh}
			</div>
			</div>
		</div>
		
		<div class="control-group">
		  <div class="lg-form">
			<label class="control-label">家长姓名：</label>
			<div class="controls">
				${zsdj.jzName}
			</div>
			</div>
			<div class="lg-form">
			  <label class="control-label">家长电话：</label>
			<div class="controls">
				${zsdj.jzNumber}
			</div>
			</div>
		</div>
		
		<div class="control-group">
		  <div class="lg-form">
			<label class="control-label">生源地区：</label>
			<div class="controls">
				${zsdj.sfName}&nbsp;&nbsp;${zsdj.csName}&nbsp;&nbsp;${zsdj.qxName}&nbsp;&nbsp;${zsdj.jdName}
			</div>
			</div>
		</div>
		<div class="control-group">
		<div class="lg-form">
			  <label class="control-label">考级证书等级：</label>
			<div class="controls">
				${zsdj.yyxykszsdj}
			</div>
			</div>
		<div class="lg-form">
			  <label class="control-label">考级证书成绩：</label>
			<div class="controls">
				<c:if test="${zsdj.yyxukszscj =='1'}">优秀</c:if>
				<c:if test="${zsdj.yyxukszscj =='2'}">良好</c:if>
				<c:if test="${zsdj.yyxukszscj =='3'}">合格</c:if>
			</div>
			</div>
		</div>	
		<div class="control-group">
		<div class="lg-form">
			 <label class="control-label">愿意兼报：</label>
			<div class="controls">
			<c:if test="${zsdj.isyyjb =='1'}">是</c:if>
			<c:if test="${zsdj.isyyjb =='0'}">否</c:if>
			</div>
			</div>
		<div class="lg-form">
			  <label class="control-label">兼报专业：</label>
			<div class="controls">
			 ${zsdj.jbzynm}
			</div>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">特殊政策考生：</label>
			<div class="controls">
			<c:if test="${zsdj.isdszcks =='0'}">否</c:if>
			<c:if test="${zsdj.isdszcks =='1'}">是</c:if>
			</div>
		</div>
		<div class="control-group">
		<div class="lg-form">
		 <label class="control-label" style="text-align: center;">学</label>
			<div class="controls">
			 <span  style="text-align: center;">何年何月至何年何月</span>
			</div>
			</div>
		<div class="lg-form">
			<div class="controls">
			  <span  style="text-align: center;">就读学校</span>
			</div>
			</div>
		</div>
		<div class="control-group">
			 <div class="lg-form">
			  <label class="control-label" style="text-align: center;">习</label>
				 <div class="controls" >
			      <c:if test="${zsdj.xxdate1 !='至'}">${zsdj.xxdate1}</c:if>
			   	 </div>
			 </div>
			 <div class="lg-form">
					<div class="controls" >
					  ${zsdj.jdxy1}
					</div>
			</div>
		</div>
			
		<div class="control-group">
			
			<div class="lg-form">
			 <label class="control-label" style="text-align: center;">经</label>
				<div class="controls" >
			        <c:if test="${zsdj.xxdate2 !='至'}">${zsdj.xxdate2}</c:if>
			   	</div>
			</div>
			<div class="lg-form">
				<div class="controls" >
				  ${zsdj.jdxy2}
				</div>
			</div>
		</div>
		
		<div class="control-group">
			
			<div class="lg-form">
			 <label class="control-label" style="text-align: center;">历</label>
				<div class="controls" >
			        <c:if test="${zsdj.xxdate3 !='至'}">${zsdj.xxdate3}</c:if>
			   	</div>
			</div>
			<div class="lg-form">
				<div class="controls" >
				  ${zsdj.jdxy3}
				</div>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">奖惩情况：</label>
			<div class="controls">
		        ${zsdj.jcqk}
		   	</div>
		</div>
			
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				${zsdj.remarks}
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="zsdj:zsdj:edit">
				<input id="btnCancel" class="btn" type="button" value="关闭" onclick="closeDialog();"/>
				
			</shiro:hasPermission>
		</div>
	</form:form>
</body>
</html>