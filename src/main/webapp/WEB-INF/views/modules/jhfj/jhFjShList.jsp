<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>计划分解管理</title>
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
        
        function selAll(obj)
		{
		    var o=document.getElementsByName("choose");
		    for(var i=0;i<o.length;i++)
		    {
		        if(obj.checked==true)
		            o[i].checked=true;
		        else
		            o[i].checked=false;
		    }
		}
		//判断是否全部被选中，如果选中全选复选框被选中，反之未被选中
		function selFirst(){
		      var o=document.getElementsByName("choose");
		      var count=0;
		      var num=0;
		      for(var i=0;i<o.length-1;i++)
		      {
		        if(o[i+1].checked==true)
		        {
		          count++;
		        }
		        if(o[i+1].checked==false)
		        {
		          num++;
		        }
		      }
		      if(count==o.length-1)
		      {
		        o[0].checked=true;
		      }
		      if(num>0)
		      {
		        if(o[0].checked==true)
		        {
		          o[0].checked=false;
		        }
		      }
		   }
		   
		   //批量审核数据
	function piliangSubmit() {
	    var ids = "";//ID信息
		var count = 0;
		var status = "";//状态
		var officenames = "";//部门名称
		
		$("#contentTable").find("input[type='checkbox']").each(
				function() {
					if ($(this).attr("checked")) {
						if ($(this).next().val() != null
								&& $(this).next().val() != "") {
							status += $(this).next().next().next().val()+",";
							ids += $(this).next().val() + ",";
							officenames += $(this).next().next().val() + "<br>";
							count++;
						}
					}
		});
		var indexTG = status.indexOf("1");
		var indexBTG = status.indexOf("2");
		
		//判断信息
		if (count == 0) {
			alertx('请选择需要审核的数据！');
		}else if(count == 1){
		    if (ids != null && ids != "") {
				ids = ids.substring(0, ids.length - 1);
			}
			/* if(statu == "1"){
				alertx('此记录已审核通过，不能重复审核！');
				return;
			} */
		    openDialog("${ctx}/jhfj/jhFj/formsh?id=" + ids,"审核部门任务分解", 850, 550);
		}
		else {
		 if (ids != null && ids != "") {
				ids = ids.substring(0, ids.length - 1);
		 }
		 if(indexTG != -1 || indexBTG != -1){
			alertx('选中的记录包含已审核过的信息，请重新选择 ！');
			return;
		}
		$("#dialogDiv2").dialog({
					collapsible : false,
					minimizable : false,
					maximizable : false,
					title : "审核意见",
				    width : "400",
		            height : "300",
				    content :"<div style=\"text-align: left;margin-top: 10px;\"><p>对以下部门任务分解进行审核:"+
				             "<span style=\"color:red;\">(注意:审核通过的任务不允许修改!)</span></p>"+
				               officenames+"</div>",
					buttons : [ {
						text : "审核通过",
						handler : function() {
						    $.getJSON("${ctx}/jhfj/jhFj/moreShenHe",{ids:ids,shStatu:"1"},function(result){
						         if(result == "1"){
						         	alertx("分解任务审核'通过'成功!");
			  					      //刷新列表
			                         $("#searchForm").attr("action","${ctx}/jhfj/jhFj/shList");
						             $("#searchForm").submit();
						             closeDialog();
			  					 }else if(result == "0"){
			  					     alertx("分解任务审核'通过'失败!");
			  					     closeDialog();
			  					 }
		                    });
						}
					}, {
						text : "审核不通过",
						handler : function() {
							$.getJSON("${ctx}/jhfj/jhFj/moreShenHe",{ids:ids,shStatu:"2"},function(result){
			  					 if(result == "2"){
			  					 	alertx("分解任务审核'不通过'成功!");
			  					      //刷新列表
			                         $("#searchForm").attr("action","${ctx}/jhfj/jhFj/shList");
						             $("#searchForm").submit();
						             closeDialog();
			  					 }else if(result == "0"){
			  					     alertx("分解任务审核'不通过'失败!");
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
		
		function resetClick()
		{
			$("#zsjh").select2("destroy");
        	$("#zsjh").find("option:selected").attr("selected",false);
        	$("#zsjh").select2();
        	
        	$("#office").attr("value","");
        	$("#officeId").attr("value","");
        	$("#officeName").attr("value","");
        	$("#zsrs").attr("value","");
        	$("#bcStatus").select2("destroy");
        	$("#bcStatus").find("option:selected").attr("selected",false);
        	$("#bcStatus").select2();
		}
		
		
	</script>
</head>
<body>
	<div id="dialogDiv2"></div>
	<form:form id="searchForm" modelAttribute="jhFj" action="${ctx}/jhfj/jhFj/shList" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<div class="cxtj">查询条件</div>
		<table class="ul-form">
		<tr>
			<th style="text-align: right;">招生计划</th>
			<td><form:select id="zsjh" path="zsjh.id" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getZsjhList()}" itemLabel="jhmc" itemValue="id" htmlEscape="false"/>
				</form:select></td>
			<th style="text-align: right;">部门名称</th>
			<td><sys:treeselect id="office" name="office.id" value="${jhFj.office.id}" labelName="office.name" labelValue="${jhFj.office.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/></td>
		</tr>
			<tr>
				<th style="text-align: right;">招生人数</th>
				<td ><form:input path="zsrs" id="zsrs" htmlEscape="false" maxlength="11" class="input-medium" style="width:165px;"/></td>
				<th style="text-align: right;">审核状态</th>
				<td>
					<form:select path="bcStatus" id="bcStatus" class="input-medium" style="width:181px;">
						<form:option value="" label="全部"/>
						<form:options items="${fns:getDictList('jhfjzt')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</td>
			</tr>
			<tr>
				 <td colspan="4" style="text-align: center;">
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
	<div class="cxjg">查询结果</div>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th><input type="checkbox" id="checkboxAll" name="choose" onclick="selAll(this)">
				    	<input type="hidden" name="ids" value="" />
				  		<input type="hidden" name="name" value="" />
				  		<input type="hidden" name="status" value="" />
				</th>
				<th>招生计划</th>
				<th>部门名称</th>
				<th>招生人数</th>
				<th>审核状态</th>
				<th>更新时间</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="jhFj">
			<tr>
				<td>
						<input type="checkbox" id="checkbox" name="choose" value="${jhFj.id}" onclick="selFirst()">
						<input type="hidden" name="ids" value="${jhFj.id}" />
						<input type="hidden" name="name" value="${jhFj.office.name}" />
						<input type="hidden" name="status" value="${jhFj.bcStatus}" />  						
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
	<div class="pagination">${page}</div>
</body>
</html>