<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>计划招生管理</title>
<meta name="decorator" content="default" />
<%@ include file="/WEB-INF/views/include/base_index.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {
			$("#messageBox").removeClass("hide");
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
	//增加数据
	function newWindows() {
		openDialog("${ctx}/zsjh/zsjh/form", "添加招生计划", 1100, 510);
	}
	//修改数据
	function editWindows() {
		var ids = "";
		var count = 0;
		var urltest = "";
		var statu = "";
		$("#contentTable").find("input[type='checkbox']").each(
				function() {
					if ($(this).attr("checked")) {
						if ($(this).next().val() != null
								&& $(this).next().val() != "") {
							urltest = $(this).next().next().val();
							statu = $(this).next().next().next().val();
							ids += $(this).next().val() + ",";
							count++;
						}
					}
				});
		if (count == 1) {
			if(statu =="3" || statu =="1")
			{
				alertx('状态为审核中、审核通过的计划则不能修改！');
			}
			else
			{
				if (ids != null && ids != "") {
					ids = ids.substring(0, ids.length - 1);
					openDialog("${ctx}/zsjh/zsjh/form?id=" + ids + urltest+"&viewModel=2",
							"修改招生计划", 1100, 620);
				}
			}
		} else if (count == 0) {
			alertx('请选择需要修改的数据！');
		} else {
			alertx('只能选择一条信息进行修改！');
		}
	}
	
	//追加计划
	function addZsjh() {
		var ids = "";
		var count = 0;
		var ststus = "";
		$("#contentTable").find("input[type='checkbox']").each(
				function() {
					if ($(this).attr("checked")) {
						if ($(this).next().val() != null
								&& $(this).next().val() != "") {
							ids += $(this).next().val() + ",";
							ststus = $(this).next().next().next().val();
							count++;
						}
					}
				});
		if (count == 1) {
			if (ids != null && ids != "") {
			    if(ststus=="3"){
			       ids = ids.substring(0, ids.length - 1);
				   openDialog("${ctx}/zsjh/zsjh/zjform?id=" + ids + "&viewModel=2","追加招生计划", 1100, 620);
			    }else{
			       alertx("招生计划未审核通过.");
			    }
			}
		} else if (count == 0) {
			alertx('请选择要做追加计划的数据！');
		} else {
			alertx('只能选择一条信息进行追加计划！');
		}
	}
	
	//批量删除招生计划
	function deleteZsjh() {
		var ids = "";
		var count = 0;
		var statu = "";
		var urltest = "";
		$("#contentTable").find("input[type='checkbox']").each(
				function() {
					if ($(this).attr("checked")) {
						if ($(this).next().val() != null
								&& $(this).next().val() != "") {
							urltest = $(this).next().next().val();
							ids += $(this).next().val() + ",";
							statu += $(this).next().next().next().val() + ",";
							count++;
						}
					}
				});
		if (count == 0) {
			alertx('请选择需要删除的数据！');
		}else {
			if (ids != null && ids != "") {
				ids = ids.substring(0, ids.length - 1);
			}
			if (statu.match("1") != null||statu.match("3") != null||statu.match("2") != null) {
				alertx("该计划已经提交/审核,无法删除!");
				return;
			}
			confirmx('确认要删除招生计划吗？', "${ctx}/zsjh/zsjh/delete?ids=" + ids + urltest);
		}
	}
	//批量提交数据
	function piliangSubmit() {
	    var ids = "";
		var count = 0;
		var urltest = "";
		var statu = "";
		$("#contentTable").find("input[type='checkbox']").each(
				function() {
					if ($(this).attr("checked")) {
						if ($(this).next().val() != null
								&& $(this).next().val() != "") {
							urltest = $(this).next().next().val();
							statu += $(this).next().next().next().val();
							ids += $(this).next().val() + ",";
							count++;
						}
					}
				});
		if (count == 0) {
			alertx('请选择需要提交的数据！');
		}else if (count == 1) {
		    if (ids != null && ids != "") {
				ids = ids.substring(0, ids.length - 1);
			    openDialog("${ctx}/zsjh/zsjh/form?id=" + ids + urltest+"&viewModel=3", "提交招生计划", 1100,620);
			}
		} else {
			if (ids != null && ids != "") {
				ids = ids.substring(0, ids.length - 1);
			}
			if (statu.match("3") != null) {
				alertx("该计划已经提交/审核,无法修改!。");
				return;
			} 
			confirmx('确认要提交招生计划吗？', "${ctx}/zsjh/zsjh/moresubmit?ids=" + ids);
		}
	}
	//查看招生计划
	function editWindows2(value,value1){
		openDialog("${ctx}/zsjh/zsjh/viewform?id=" + value1+"&viewModel=view", "查看招生计划", 1100,620);
	}
	
	function resetClick()
	{
		$("#jhmc2").attr("value",'');
		$("#startDate1").attr("value",'');
		$("#endDate1").attr("value",'');
		$("#createDate1").attr("value",'');
       	$("#nf5").select2("destroy");
       	$("#nf5").find("option:selected").attr("selected",false);
       	$("#nf5").select2();
       	$("#zt1").select2("destroy");
	   	$("#zt1").find("option:selected").attr("selected",false);
	    $("#zt1").select2();
	}
	
</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="zsjh" action="${ctx}/zsjh/zsjh/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		  <div class="cxtj">查询条件</div> 
			<table class="ul-form" style=" width: 100%;">
			    <tr>
					<th style="text-align: right;">计划名称</th>
					<td style="text-align: center;"><form:input path="jhmc" id="jhmc2" class="input-medium" htmlEscape="false" maxlength="60" /></td>
					<th style="text-align: right;">学年学期</th>
					<td style="text-align: center;">
						<form:select path="nf.id" id="nf5"  class="input-xlarge required" style="width:180px;" >
							<form:option value="" label="全部" />
							<form:options items="${fns:getXnxqJbxxList()}" 
							              itemLabel="xnmc" itemValue="id" htmlEscape="false" />
					   </form:select>
					   <%-- <form:input path="nf" id="nf" class="input-medium" htmlEscape="false" maxlength="64" /> --%>
					</td>
						<th style="text-align: right;">招生时间</th>
					<td style="text-align: center;">
					    <input name="startDate" id="startDate1" type="text" readonly="readonly" maxlength="18" class="input-medium Wdate"
						       value="<fmt:formatDate value="${zsjh.startDate}" pattern="yyyy-MM-dd"/>" 
						       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" /> 至
						       <input name="endDate" id="endDate1" type="text" readonly="readonly" maxlength="18" class="input-medium Wdate"
						       value="<fmt:formatDate value="${zsjh.endDate}" pattern="yyyy-MM-dd"/>" 
						       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" />
					</td>
						<th style="text-align: right;">计划状态</th>
					<td style="text-align: center;">
						  <form:select path="zt" id="zt1" style="width:150px;">
		                    <form:option value="" label="全部" />
							<form:options items="${fns:getDictList('jhzt')}" itemLabel="label" itemValue="value" 
								htmlEscape="false"/>
				          </form:select>
					</td>
				</tr>
				<%-- <tr>
					<th style="text-align: right;"><label>学期</label></th>
					<td colspan="3"><form:select path="xqId" id="xqId" style="width:190px;">
							<form:option value="" label="全部" />
							<form:options items="${fns:getDictList('term_type')}"
								          itemLabel="label" itemValue="value" htmlEscape="false" />
						</form:select>
					</td>
				</tr> --%>
				<tr>
				   <td colspan="8" style="text-align: center;">
						<input id="btnSubmit1" class="btn btn-primary" type="submit"value="查询" /> 
						<input id="btnReset" class="btn btn-primary" type="reset" onclick="resetClick();"  value="重置" />
					</td>
				</tr>
			</table>
	</form:form>
	<div class="btn-div">
		<input id="btnSubmit2" onclick="newWindows()"class="btn btn-primary" type="button" value="增加" /> 
		<input id="btnSubmit3" onclick="editWindows()" class="btn btn-primary" type="button" value="修改" /> 
		<input id="btnSubmit4" onclick="piliangSubmit()" class="btn btn-primary" type="button" value="提交" /> 
		<input id="btnSubmit5" onclick="deleteZsjh()" class="btn btn-primary" type="button" value="删除" />
		<input id="btnSubmit6" onclick="addZsjh()" class="btn btn-primary" style="background-color: red;" type="button" value="追加计划" />
	</div>
	<sys:message content="${message}" />
<!-- 	<div class="cxjg">查询结果</div> -->
	<table id="contentTable"
		class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<TH>
				  <input type="checkbox" id="checkboxAll" name="choose" onclick="selAll1(this)">
				  <input type="hidden" name="ids" /> 
				  <input type="hidden" name="url" /> 
				  <input type="hidden" name="statu" />
				</TH>
				<th>招生年度</th>
				<th>学年</th>
				<th>计划名称</th>
				<!--  <th>学期</th> -->
				<th>招生人数</th>
				<th>开始时间</th>
				<th>结束时间</th>
				<th>创建者</th> 
				<th>创建时间</th>
				<!-- <th>备注信息</th> -->
				<th>计划状态</th>
				<%-- <shiro:hasPermission name="zsjh:zsjh:edit"><th>操作</th></shiro:hasPermission> --%>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="zsjh">
				<tr>
					<td>
					 <input type="checkbox" id="checkbox" name="choose" path="id" onclick="selFirst1()"> 
					 <input type="hidden" name="ids" value="${zsjh.id}" /> 
					 <input type="hidden" name="url"
						    value="&act.taskId=${zsjh.act.task.id}&act.taskName=${fns:urlEncode(zsjh.act.task.name)}&act.taskDefKey=${zsjh.act.task.taskDefinitionKey}&act.procInsId=${zsjh.act.task.processInstanceId}&act.procDefId=${zsjh.act.task.processDefinitionId}&act.status=${zsjh.act.status}" />
					 <input type="hidden" name="statu" value="${zsjh.zt}" />
					</td>
					<td>${zsjh.zsnd}</td>
					<td>${zsjh.nf.xnmc}(${zsjh.nf.xq})</td>
					<td><a href="javascript:editWindows2('${zsjh.zt}','${zsjh.id}&act.taskId=${zsjh.act.task.id}&act.taskName=${fns:urlEncode(zsjh.act.task.name)}&act.taskDefKey=${zsjh.act.task.taskDefinitionKey}&act.procInsId=${zsjh.act.task.processInstanceId}&act.procDefId=${zsjh.act.task.processDefinitionId}&act.status=${zsjh.act.status}')"> ${zsjh.jhmc}</a>
					</td>
				<%--  <td>${fns:getDictLabel(zsjh.xqId, 'term_type', '')}</td>  --%>
					
					<td>${zsjh.zsrs}</td>
					 <td><fmt:formatDate value="${zsjh.startDate}"
							pattern="yyyy-MM-dd" /></td>
					<td><fmt:formatDate value="${zsjh.endDate}"
							pattern="yyyy-MM-dd" /></td> 
							 <td>${zsjh.createBy.name}</td> 
					<td><fmt:formatDate value="${zsjh.createDate}"
							pattern="yyyy-MM-dd" /></td>
					<td>
					 <c:if test="${zsjh.zt eq '0'}">
                        <span style="color: red;">未提交</span>
					 </c:if> 
					 <c:if test="${zsjh.zt eq '1'}">
				        <span style="color: #0099CC;">审核中</span>
				     </c:if> 
				     <c:if test="${zsjh.zt eq '2'}">
						<span style="color: #ff0033;">审核不通过</span>
				     </c:if> 
				     <c:if test="${zsjh.zt eq '3'}">
					 	<span style="color: #0D73F3;">审核通过</span>
				     </c:if>
				   </td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<script type="text/javascript" src="${ctxStatic}/validMes/validMes.js"></script>
</body>
</html>