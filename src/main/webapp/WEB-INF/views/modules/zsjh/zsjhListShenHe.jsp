<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>计划招生管理</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/base_index.jsp"%>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
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
	//批量审核数据
	function piliangSubmit() {
	    var ids = "";//ID信息
		var count = 0;
		var statu = "";//状态
		var urltest = "";
		var zsjhnames = "";//zsjh名称
		
		$("#contentTable").find("input[type='checkbox']").each(
				function() {
					if ($(this).attr("checked")) {
						if ($(this).next().val() != null
								&& $(this).next().val() != "") {
							statu += $(this).next().next().next().val()+",";
							ids += $(this).next().val() + ",";
							urltest = $(this).next().next().val();
							zsjhnames += $(this).next().next().next().next().val() + "<br>";
							count++;
						}
					}
		});
		//判断信息
		if (count == 0) {
			alertx('请选择需要审核的数据！');
		}else if(count == 1){
		    if (ids != null && ids != "") {
				ids = ids.substring(0, ids.length - 1)	;
			}
			if(statu.match("3")){
			   statu = "1";
			}
			if(statu.match("2")){
			   statu = "2";
			}
		    openDialog("${ctx}/zsjh/zsjh/formsh?id=" + ids + urltest,"审核招生计划", 1000, 450);
		}else {
		 if (ids != null && ids != "") {
				ids = ids.substring(0, ids.length - 1);
		 }
		 if (statu.match("2") != null||statu.match("3") != null) {
				alertx("招生计划已处理,不允许重复处理.");
				return;
		 }
		 $("#dialogDiv2").dialog({
					collapsible : false,
					minimizable : false,
					maximizable : false,
					title : "审核意见",
				    width : "400",
		            height : "300",
				    content :"<div style=\"text-align: left;margin-top: 10px;\"><p>对以下招生计划进行审核:"+
				             "<span style=\"color:red;\">(注意:审核通过的招生计划不允许修改!)</span></p>"+
				               zsjhnames+"</div>",
					buttons : [ {
						text : "审核通过",
						handler : function() {
						    $.getJSON("${ctx}/zsjh/zsjh/moreShenHe",{ids:ids,shStatu:"2"},function(result){
			                      if(result=="2"){
			                      	 alertx("审核通过成功!");
			                         //刷新列表
			                         $("#searchForm").attr("action","${ctx}/zsjh/zsjh/zsjhShenHe");
						             $("#searchForm").submit();
			                         closeDialog();
			                       }else if(result=="0"){
			                          alertx("审核通过失败!");
			                          closeDialog();
			                       }
		                    });
						}
					}, {
						text : "审核不通过",
						handler : function() {
							$.getJSON("${ctx}/zsjh/zsjh/moreShenHe",{ids:ids,shStatu:"1"},function(result){
			                       if(result=="1"){
			                         alertx("审核不通过成功!");
			                         //刷新列表
			                         $("#searchForm").attr("action","${ctx}/zsjh/zsjh/zsjhShenHe");
						             $("#searchForm").submit();
			                         closeDialog();
			                       }else if(result=="0"){
			                          alertx("审核不通过失败!");
			                          closeDialog();
			                       }
		                    });
						}
					} ]
				});
				$(".panel").css("top", "0px");
				$(".window-shadow").css("top", "0px");
			}
		}
		//修改信息
		/* function editWindows2(value){
			openDialog("${ctx}/zsjh/zsjh/viewform?id=" + value1+"&viewModel=view", "查看招生计划", 1100,62
		   //openDialog("${ctx}/zsjh/zsjh/formsh?id=" + value,"审核招生计划", 1000, 450);
		} */
		
		//查看招生计划
		function editWindows2(value,value1){
			openDialog("${ctx}/zsjh/zsjh/viewform?id=" + value1+"&viewModel=view", "查看招生计划", 1100,620);
		}
		
		function resetClick()
		{
			$("#jhmc3").attr("value",'');
	       	$("#nf3").select2("destroy");
	       	$("#nf3").find("option:selected").attr("selected",false);
	       	$("#nf3").select2();
	       	$("#zt1").select2("destroy");
	       	$("#zt1").find("option:selected").attr("selected",false);
	       	$("#zt1").select2();
	       	$("#startDate1").attr("value",'');
			$("#endDate1").attr("value",'');
			$("#createDate").attr("value",'');
		}
	</script>
</head>
<body>
    <div id="dialogDiv2"></div>
	<form:form id="searchForm" modelAttribute="zsjh" action="${ctx}/zsjh/zsjh/zsjhShenHe" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<div class="cxtj">查询条件</div> 
		<table class="ul-form">
			<tr>
					<th style="text-align: right;">计划名称</th>
					<td style="text-align: center;"><form:input path="jhmc" id="jhmc3" class="input-medium" htmlEscape="false" maxlength="64" /></td>
					<th style="text-align: right;">学年</th>
					<td style="text-align: center;">
						<form:select path="nf.id" id="nf3"  class="input-xlarge required" style="width:190px;" >
							<form:option value="" label="全部" />
							<form:options items="${fns:getXnxqJbxxList()}" 
							              itemLabel="xnmc" itemValue="id" htmlEscape="false" />
					   </form:select>
					   <%-- <form:input path="nf" id="nf" class="input-medium" htmlEscape="false" maxlength="64" /> --%>
					</td>
					<th style="text-align: right;">招生时间</th>
				<td style="text-align: center;">
				    <input name="startDate" id="startDate1" type="text" readonly="readonly"maxlength="20" class="input-medium Wdate"
					       value="<fmt:formatDate value="${zsjh.startDate}" pattern="yyyy-MM-dd"/>" 
					       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" /> 至
				<input name="endDate" id="endDate1" type="text" readonly="readonly"maxlength="20" class="input-medium Wdate"
					       value="<fmt:formatDate value="${zsjh.endDate}" pattern="yyyy-MM-dd"/>" 
					       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" />
				</td>
				 <th style="text-align: right;">状态</th>
		      <td style="text-align: center;">
		         <form:select path="zt" id="zt1" style="width:195px;">
		                    <form:option value="" label="全部" />
							<form:options items="${fns:getDictList('jhzt')}" itemLabel="label" itemValue="value" 
								htmlEscape="false"/>
				 </form:select>
		      </td>
			</tr>
		   <tr>
				 <td colspan="8" style="text-align: center;">
						<input id="btnSubmit1" class="btn btn-primary" type="submit"value="查询" /> 
						<input id="btnReset" class="btn btn-primary" type="reset" onclick="resetClick();"  value="重置" />
				 </td>
		   </tr>
		</table> 
	</form:form>
	<div class="btn-div">
		  <input id="btnSubmit" type="button" class="btn btn-primary" onclick="piliangSubmit()" value="审核"/>
		</div>
	<sys:message content="${message}"/>
	<!-- <div class="cxjg">查询结果</div> -->
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr><TH>
				  <input type="checkbox" id="checkboxAll" name="choose" onclick="selAll1(this)"> 
				  <input type="hidden" name="ids" value="" /> 
				  <input type="hidden" name="url" value="" /> 
				  <input type="hidden" name="statu" value="" />
				  <input type="hidden" name="name" value="" /> 
				</TH>
				<th>计划名称</th>
				<th>年份</th>
				<!-- <th>学期</th> -->
				<th>招生人数</th>
				<!-- <th>创建时间</th> -->
				<th>开始时间</th>
				<th>结束时间</th>
				<th>创建者</th>
				<th>更新时间</th>
				<!-- <th>备注信息</th> -->
				<th>状态</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="zsjh">
		    <c:if test="${zsjh.zt eq '1' or zsjh.zt eq '2' or zsjh.zt eq '3'}">
		       <tr>
		        <td>
					<input type="checkbox" id="checkbox" name="choose" path="id" onclick="selFirst1()"> 
					<input type="hidden" name="ids" value="${zsjh.id}" /> 
					<input type="hidden" name="url"
						   value="&act.taskId=${zsjh.act.task.id}&act.taskName=${fns:urlEncode(zsjh.act.task.name)}&act.taskDefKey=${zsjh.act.task.taskDefinitionKey}&act.procInsId=${zsjh.act.task.processInstanceId}&act.procDefId=${zsjh.act.task.processDefinitionId}&act.status=${zsjh.act.status}" />
					<input type="hidden" name="statu" value="${zsjh.zt}" />
					<input type="hidden" name="name" value="${zsjh.jhmc}" /> 
				</td>
				<%-- <td>
				   <a href="javascript:editWindows2('${zsjh.id}&act.taskId=${zsjh.act.task.id}&act.taskName=${fns:urlEncode(zsjh.act.task.name)}&act.taskDefKey=${zsjh.act.task.taskDefinitionKey}&act.procInsId=${zsjh.act.task.processInstanceId}&act.procDefId=${zsjh.act.task.processDefinitionId}&act.status=${zsjh.act.status}')">
					${zsjh.jhmc}
				   </a>
                </td> --%>
                <td>
                <a href="javascript:editWindows2('${zsjh.zt}','${zsjh.id}&act.taskId=${zsjh.act.task.id}&act.taskName=${fns:urlEncode(zsjh.act.task.name)}&act.taskDefKey=${zsjh.act.task.taskDefinitionKey}&act.procInsId=${zsjh.act.task.processInstanceId}&act.procDefId=${zsjh.act.task.processDefinitionId}&act.status=${zsjh.act.status}')"> 
                	${zsjh.jhmc}</a>
                </td>
                
				<td>
					${zsjh.nf.xnmc}(${zsjh.nf.xq})
				</td>
				<%-- <td>
					${fns:getDictLabel(zsjh.xqId, 'term_type', '')}
				</td> --%>
				<td>
					${zsjh.zsrs}
				</td>
				<%-- <td>
					<fmt:formatDate value="${zsjh.createDate}" pattern="yyyy-MM-dd"/>
				</td> --%>
				
				<td><fmt:formatDate value="${zsjh.startDate}"
							pattern="yyyy-MM-dd" /></td>
					<td><fmt:formatDate value="${zsjh.endDate}"
							pattern="yyyy-MM-dd" /></td>
					<td>
					${zsjh.createBy.name}
				</td>
				<td>
					<fmt:formatDate value="${zsjh.updateDate}" pattern="yyyy-MM-dd"/>
				</td>
				<%-- <td>
					${zsjh.remarks}
				</td> --%>
			<%-- 	<th>
				<c:if test="${zsjh.zt eq '1'}">
				   审核中
				</c:if>
				<c:if test="${zsjh.zt eq '2'}">
				 审核不通过
				</c:if>
				<c:if test="${zsjh.zt eq '3'}">
				 审核通过
				</c:if>
				${fns:getDictLabel(zsjh.zt, 'jhzt', '')}
				</th> --%>
				<td>
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
		    </c:if>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>