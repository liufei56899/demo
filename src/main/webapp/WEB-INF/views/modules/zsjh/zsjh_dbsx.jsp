<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>计划招生管理</title>
<meta name="decorator" content="default" />
<style type="text/css">
   .btn-div{
    margin-right: 30px;
    height: 40px; 
    line-height: 40px;
   }
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/base_index.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {

	});
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").submit();
		return false;
	}
	function selAll1(obj) {
		var o = document.getElementsByName("choose");
		for ( var i = 0; i < o.length; i++) {
			if (obj.checked == true)
				o[i].checked = true;
			else
				o[i].checked = false;
		}
	}
	function selFirst1() {
		var o = document.getElementsByName("choose");
		var count = 0;
		var num = 0;
		for ( var i = 0; i < o.length - 1; i++) {
			if (o[i + 1].checked == true) {
				count++;
			}
			if (o[i + 1].checked == false) {
				num++;
			}
		}
		if (count == o.length - 1) {
			o[0].checked = true;
		}
		if (num > 0) {
			if (o[0].checked == true) {
				o[0].checked = false;
			}
		}
	}
	
	//计划审核
	function plshZsjh()
	{
		//alert("批量审核11");
		var ids = "";//ID信息
		//var zsjhnames = "";//zsjh名称
		var count = 0;
		$("#contentTable1").find("input[type='checkbox']").each(
				function() {
					if ($(this).attr("checked")) {
						if ($(this).next().val() != null
								&& $(this).next().val() != "") {
							ids += $(this).next().val() + ",";
							//zsjhnames += $(this).next().next().val() + "<br>";
							count++;
						}
					}
		});
		if (count == 0)
		{
			alertx('请选择需要审核的数据！');
		}
		else
		{
			if (ids != null && ids != "") 
			{
				ids = ids.substring(0, ids.length - 1);
		 	}
		 	top.$.jBox.confirm("是否审核通过这些数据？",'系统提示',function(v,h,f){
				if(v=='ok'){
					updateJiHua(ids);
				}
			},{buttonsFocus:1, closed:function(){
				if (typeof closed == 'function') {
					closed();
				}
			}});
			top.$('.jbox-body .jbox-icon').css('top','55px');
		 	
		}
	}
	
	function updateJiHua(ids)
	{
		jQuery.ajax({
		        type: "POST",
		        url: "${ctx}/zsjh/zsjh/moreShenHe",
		        data: {ids:ids,shStatu:"2"},
		        dataType:'json',
		        async:false,
				success: function(result){
					console.log(result);
					if(result=="2")
					{
						alertx('审核成功！');
						closeDialog();
		                openDialog("${ctx}/zsjh/zsjh/zsjh_dbsh","待办事项",1080,540);
					}
			   }
		    });
	}
	
	
	//分解到部门
	function plshJhbmrw()
	{
		var ids = "";//ID信息
		//var zsjhnames = "";//zsjh名称
		var count = 0;
		$("#contentTable2").find("input[type='checkbox']").each(
				function() {
					if ($(this).attr("checked")) {
						if ($(this).next().val() != null
								&& $(this).next().val() != "") {
							ids += $(this).next().val() + ",";
							//zsjhnames += $(this).next().next().val() + "<br>";
							count++;
						}
					}
		});
		if (count == 0)
		{
			alertx('请选择需要审核的数据！');
		}
		else
		{
			if (ids != null && ids != "") 
			{
				ids = ids.substring(0, ids.length - 1);
		 	}
		 	top.$.jBox.confirm("是否审核通过这些数据？",'系统提示',function(v,h,f){
				if(v=='ok'){
					updatefjbm(ids);
				}
			},{buttonsFocus:1, closed:function(){
				if (typeof closed == 'function') {
					closed();
				}
			}});
			top.$('.jbox-body .jbox-icon').css('top','55px');
		 	
		}
	}
	
	function updatefjbm(ids)
	{
		jQuery.ajax({
		        type: "POST",
		        url: "${ctx}/jhfj/jhFj/moreShenHe",
		        data: {ids:ids,shStatu:"1"},
		        dataType:'json',
		        async:false,
				success: function(result){
					console.log(result);
					if(result=="1")
					{
						alertx('审核成功！');
						closeDialog();
		                openDialog("${ctx}/zsjh/zsjh/zsjh_dbsh","待办事项",1080,540);
					}
			   }
		    });
	}
	
	
	//个人任务
	function plshgrrw()
	{
		var ids = "";//ID信息
		//var zsjhnames = "";//zsjh名称
		var count = 0;
		$("#contentTable3").find("input[type='checkbox']").each(
				function() {
					if ($(this).attr("checked")) {
						if ($(this).next().val() != null
								&& $(this).next().val() != "") {
							ids += $(this).next().val() + ",";
							//zsjhnames += $(this).next().next().val() + "<br>";
							count++;
						}
					}
		});
		if (count == 0)
		{
			alertx('请选择需要审核的数据！');
		}
		else
		{
			if (ids != null && ids != "") 
			{
				ids = ids.substring(0, ids.length - 1);
		 	}
		 	top.$.jBox.confirm("是否审核通过这些数据？",'系统提示',function(v,h,f){
				if(v=='ok'){
					updategrfj(ids);
				}
			},{buttonsFocus:1, closed:function(){
				if (typeof closed == 'function') {
					closed();
				}
			}});
			top.$('.jbox-body .jbox-icon').css('top','55px');
		 	
		}
	}
	
	function updategrfj(ids)
	{
		jQuery.ajax({
		        type: "POST",
		        url: "${ctx}/jhfjgr/jhFjGr/moreShenHe",
		        data: {ids:ids,shStatu:"1"},
		        dataType:'json',
		        async:false,
				success: function(result){
					console.log(result);
					if(result=="1")
					{
						alertx('审核成功！');
						closeDialog();
		                openDialog("${ctx}/zsjh/zsjh/zsjh_dbsh","待办事项",1080,540);
					}
			   }
		    });
	}
	
	
</script>
	<div id="dialogDiv2"></div>
	<form:form id="searchForm"  action="" method="post" class="breadcrumb form-search">
	</form:form>
	<div class="easyui-tabs" fit="true" style="width: 98%;height: 98%">
		<div title="招生计划审核"  style="height: 100%;" >
			<div class="btn-div" style="margin-right: 30px; height: 40px; line-height: 40px;">
				<input id="btnSubmit" onclick="plshZsjh()"
					class="btn btn-primary" type="button" value="批量审核通过" />
			</div>
			<sys:message content="${message}" />
			<table id="contentTable1"  style=""
				class="table table-striped table-bordered table-condensed">
				<thead>
					<tr>
						<TH><input type="checkbox" id="checkboxAll" name="choose"
							onclick="selAll1(this)"> 
							<input type="hidden" name="ids" />
							<input type="hidden" name="url" /> <input type="hidden"
							name="statu" /></TH>
						<th>计划名称</th>
						<th>年份</th>
						<!-- <th>学期</th> -->
						<th>招生人数</th>
						<th>创建者</th>
						<th>创建时间</th>
						<th>状态</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${page1.list}" var="zsjh">
						<tr>
							<td><input type="checkbox" id="checkbox" name="choose"
								path="id" onclick="selFirst1()"> <input type="hidden"
								name="ids" value="${zsjh.id}" /> 
								<input type="hidden" name="name" value="${zsjh.jhmc}" />
								<input type="hidden"
								name="url"
								value="&act.taskId=${zsjh.act.task.id}&act.taskName=${fns:urlEncode(zsjh.act.task.name)}&act.taskDefKey=${zsjh.act.task.taskDefinitionKey}&act.procInsId=${zsjh.act.task.processInstanceId}&act.procDefId=${zsjh.act.task.processDefinitionId}&act.status=${zsjh.act.status}" />
								<input type="hidden" name="statu" value="${zsjh.zt}" /></td>
							<td>
									${zsjh.jhmc}
							</td>
							<td>${zsjh.nf.xnmc}</td>
							<%-- <td>${fns:getDictLabel(zsjh.xqId, 'term_type', '')}</td> --%>
							<td>${zsjh.zsrs}</td>
							<td>${zsjh.createBy.name}</td>
							<td><fmt:formatDate value="${zsjh.createDate}"
									pattern="yyyy-MM-dd" />
							</td>
							<%-- <td>${zsjh.remarks}</td> --%>
							<td><c:if test="${zsjh.zt eq '0'}">
                                                    未提交
					 </c:if> <c:if test="${zsjh.zt eq '1'}">
				            审核中   
				     </c:if> <c:if test="${zsjh.zt eq '2'}">
					  审核不通过
				     </c:if> <c:if test="${zsjh.zt eq '3'}">
					  审核通过
				     </c:if>
				     </td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div title="招生计划分解到部门审核"  style="height: 100%">
		<div class="btn-div" style="margin-right: 30px; height: 40px; line-height: 40px;">
				<input id="btnSubmit" onclick="plshJhbmrw()"
					class="btn btn-primary" type="button" value="批量审核通过" />
			</div>
			<table id="contentTable2" class="table table-striped table-bordered table-condensed"
			        style="">
		<thead>
			<tr>
				<th>
					<input type="checkbox" id="checkboxAll" name="choose" onclick="selAll(this)">
					<input type="hidden" name="ids" value="" />
					<input type="hidden" name="bcStatus" value="" />
				</th>
				<th>招生计划</th>
				<th>部门名称</th>
				<th>招生人数</th>
				<th>分解状态</th>
				<th>审核状态</th>
				<th>更新时间</th>
				<%-- <shiro:hasPermission name="jhfj:jhFj:edit"><th>操作</th></shiro:hasPermission> --%>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page2.list}" var="jhFj">
			<tr style="height:51px;">
				<td>
			    	<input type="checkbox" id="checkbox" name="choose" value="${jhFj.id}" onclick="selFirst()">
			    	<input type="hidden" name="ids" value="${jhFj.id}" />
			    	<input type="hidden" name="bcStatus" value="${jhFj.bcStatus}" />
			    </td>
				<td>
					${jhFj.zsjh.jhmc}
				</td>
				<td>
					${jhFj.office.name}
				</td>
				<td>
					${jhFj.zsrs}
				</td>
				<td>
					${fns:getDictLabel(jhFj.fjFlag, 'fjFlag', '')}
				</td>
				<td>
					<c:if test="${jhFj.bcStatus eq '0'}">
					   <span style="color: #0099CC;">审核中</span>
					</c:if>
					<c:if test="${jhFj.bcStatus eq '1'}">
					   <span style="color: #0D73F3;">审核通过</span>
					</c:if>
					<c:if test="${jhFj.bcStatus eq '2'}">
					 	<span style="color: #ff0033;">审核不通过</span>
					</c:if>
				</td>
				<td>
					<fmt:formatDate value="${jhFj.updateDate}" pattern="yyyy-MM-dd"/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
		</div>
		<div title="招生计划分解到个人审核"  style="height: 100%;">
		<div class="btn-div" style="margin-right: 30px; height: 40px; line-height: 40px;">
				<input id="btnSubmit" onclick="plshgrrw()"
					class="btn btn-primary" type="button" value="批量审核通过" />
		</div>
		<table id="contentTable3" class="table table-striped table-bordered table-condensed"
		        style="height:100px;">
		<thead>
			<tr>
				<th>
					<input type="checkbox" id="checkboxAll" name="choose" onclick="selAll(this)">
					<input type="hidden" name="ids" value="" />
					<input type="hidden" name="bcStatus" value="" />
				</th>
				<th>招生计划</th>
				<th>招生部门</th>
				<th>教师名称</th>
				<th>招生人数</th>
				<th>审核状态</th>
				<th>更新时间</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page3.list}" var="jhFjGr">
			<tr>
				<td>
			    	<input type="checkbox" id="checkbox" name="choose" value="${jhFjGr.id}" onclick="selFirst()">
			    	<input type="hidden" name="ids" value="${jhFjGr.id}" />
			    	<input type="hidden" name="bcStatus" value="${jhFjGr.bcStatus}" />
			    </td>
				<td>
					${jhFjGr.zsjh.jhmc}
				</td>
				<td>
					${jhFjGr.officeId}
				</td>
				<td>
					${jhFjGr.jsmc}
				</td>
				<td>
					${jhFjGr.zsrs}
				</td>
				<td>
					<c:if test="${jhFjGr.bcStatus eq '0'}">
					 	<span style="color: #0099CC;">审核中</span>
					</c:if>
					<c:if test="${jhFjGr.bcStatus eq '1'}">
					 	<span style="color: #0D73F3;">审核通过</span>
					</c:if>
					<c:if test="${jhFjGr.bcStatus eq '2'}">
						<span style="color: #ff0033;">审核不通过</span>
					</c:if>
				</td>
				<td>
					<fmt:formatDate value="${jhFjGr.updateDate}" pattern="yyyy-MM-dd"/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
		</div>
	</div>
</body>
</html>