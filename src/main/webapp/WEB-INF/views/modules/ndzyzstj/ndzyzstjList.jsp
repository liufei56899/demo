<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>统计</title>
<meta name="decorator" content="default" />
<%@ include file="/WEB-INF/views/include/base_index.jsp" %>
<style type="text/css">
	  .tabTreeselect 
	  {
	  	width:130px;
	  }
	  body 
	  {
	  	padding: 0px;
	  }
	</style>
<script type="text/javascript">
	$(document).ready(function() {
		/* var nowDate = "${nowDate}";
		$("#newYearId").select2("destroy");
		$("#newYearId").val(nowDate);
		$("#newYearId").find("option[value='"+nowDate+"']").attr("selected",true);
		$("#newYearId").select2(); */
		//
	    $('#tt').tabs(
	    	{
	    		onSelect :function(title,index)
	    		{
	    			if(index ===1)
	    			{
	    				var newYear = $("#newYearId").find("option:selected").val();
						var zszyId = $("#zszyId").find("option:selected").val();
						var tab = $('#tt').tabs('getSelected');
						var url='${ctx}/tj/ndzyzstj/ndzylblist?newYear='+newYear+'&id='+zszyId;
						$(this).tabs("update",{
							tab: tab,
							options: {
								title: title,
								href: url  // the new content URL
							}
						});
	    			}
	    		}
	    	}
	    );
		
 	});
	function page(n, s) {
		return false;
	}

	function format(state) {
		return state.text;
	}
	
	//导出
	function exportClick()
	{
		var newYear = $("#newYearId").find("option:selected").val();
		var zszyId = $("#zszyId").find("option:selected").val();
		 jQuery.ajax({
		        type: "POST",
		        url: "${ctx}/tj/ndzyzstj/expotZytjList",
		        data: {newYear:newYear,id:zszyId},
		        dataType:'json',
		        async:false,
				success: function(data){
					updateFile(data);
			   }
		    });
	}
	
	//下载
	function updateFile(filePath)
	{
		 window.location.href='${ctx}/tj/ndzyzstj/updateFile?filePath=1';
	}
	
	
	function tijiaoOnclick()
	{
		var newYear = $("#newYearId").find("option:selected").val();
		var zszyId = $("#zszyId").find("option:selected").val();
		 var tab = $('#tt').tabs('getSelected');
		var index = $('#tt').tabs('getTabIndex',tab);
		var url=""; 
		if(index==0)
		{
			url='${ctx}/tj/ndzyzstj/ndzytx?newYear='+newYear+'&id='+zszyId;
		}else
		{
			url='${ctx}/tj/ndzyzstj/ndzylblist?newYear='+newYear+'&id='+zszyId;
		}
 		$('#tt').tabs('getSelected').panel('refresh',url);
	}
	
	function ndzylbTab()
	{
		alert("11");
	}
    
   
</script>
</head>
<body>
	<div id="dialogDiv"></div>
	<form action="" id="exportForm" method="post"></form>
	<form:form id="searchForm1" modelAttribute="zyJbxx"
		action="" method="post"
		class="breadcrumb form-search">
		
			
			<div class="cxtj">查询条件</div>
			<table class="ul-form">
				<tr>
					<th style="width:200px;">招生年度</th>
					<td style="width:300px;">
						<select name="newYear" id="newYearId" class=" show-tick form-control"  
							style="width:185px;">
							<c:forEach items="${zsndList }" var="zsnd">
								<option value="${zsnd.zsnd }">${zsnd.zsnd }</option>
							</c:forEach>
						</select>
					</td>
					<th style="width:200px;">招生专业</th>
					<td style="width:300px;" >
						<form:select path="id" id="zszyId"
						 class="input-medium">
						<form:option value="" label="全部" />
						<form:options items="${fns:getZyList()}" itemLabel="zyxzmc"
							itemValue="id" htmlEscape="false" />
						</form:select>
					</td>
				</tr>
				<tr>
				<td colspan="4"  style="text-align: center;">
					<input id="btnSubmit" class="btn btn-primary" type="button" onclick="tijiaoOnclick();" value="查询" />
					
					<input id="btnExport" class="btn btn-primary" type="button" onclick="exportClick();"  value="导出" />
					<!-- <input id="btnReset" class="btn btn-primary" type="reset" onclick="resetClick();"  value="重置" /> -->
				</td>
				</tr>
			</table>
	</form:form>
	<div class="btn-div">
		
	</div>
	<sys:message content="" />
	<div class="cxjg">查询结果
	</div>
	<div id="tt" class="easyui-tabs" style="">
		    <div title="图形" style="padding:20px;min-width:100px;" data-options="href:'${ctx}/tj/ndzyzstj/ndzytx'" >
		        
		    </div><%-- href:'${ctx}/tj/ndzyzstj/ndzylblist' --%>
		    <div title="列表" data-options="" style="overflow:auto;padding:20px;width:100px;">
		        
		    </div>
	</div>
	<script type="text/javascript" src="${ctxStatic}/validMes/validMes.js"></script>
</body>
</html>