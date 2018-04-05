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
	  .select2-search-choice{
	  	border:none !important;
	  	background: none !important;
	  	padding: 0 !important;
	  	line-height: 26px !important;
	  	padding-left: 15px !important;
	  }

	  .form-search .ul-form li{
	  	height: 26px !important;
	  	line-height: 26px;
	  }
	  .select2-choices{
	  	border-radius:4px;
	  }
	  .panel-body{
	  	overflow:hidden;
	  }
	</style>
<script type="text/javascript">
	$(document).ready(function() {
		
		$("#newYearId").select2("data");
        $("#newYearId").select2({
         	allowClear: true,
	        newYearId: true,
	        maximumSelectionSize:3
	    });
	    
	    $('#tt').tabs(
	    	{
	    		onSelect :function(title,index)
	    		{
	    			if(index ===1)
	    			{
	    				var newYearId = $("#newYearId").val(); 
						var newYear = $("#newYeartxtId").val(newYearId);
						var zszyId = $("#zszyId").find("option:selected").val();
						var zsnd1 = $("#newYeartxtId").val();
						var tab = $('#tt').tabs('getSelected');
						var url='${ctx}/tj/ndzyzstj/ndjzylbtj?zsnd1='+zsnd1+'&id='+zszyId;
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
		var newYearId = $("#newYearId").val(); 
		var newYear = $("#newYeartxtId").val(newYearId);
		var zszyId = $("#zszyId").find("option:selected").val();
		var zsnd1= $("#newYeartxtId").val();
		 jQuery.ajax({
		        type: "POST",
		        url: "${ctx}/tj/ndzyzstj/expotNdjZytjList",
		        data: {zsnd1:zsnd1,id:zszyId},
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
		 window.location.href='${ctx}/tj/ndzyzstj/updateFile?filePath=2';
	}
	
	
	
	function tijiaoOnclick()
	{
		var newYearId = $("#newYearId").val(); 
		if(newYearId == null || newYearId.length <=1)
		{	
			alertx('请至少选择2个年度！');
			return;
		}
		var newYear = $("#newYeartxtId").val(newYearId);
		var zszyId = $("#zszyId").find("option:selected").val();
		 var tab = $('#tt').tabs('getSelected');
		var index = $('#tt').tabs('getTabIndex',tab);
		var url=""; 
		
		if(index==0)
		{
			url='${ctx}/tj/ndzyzstj/ndjzytxtj?zsnd1='+$("#newYeartxtId").val()+'&id='+zszyId;
		}else
		{
			url='${ctx}/tj/ndzyzstj/ndjzylbtj?zsnd1='+$("#newYeartxtId").val()+'&id='+zszyId;
		}
 		$('#tt').tabs('getSelected').panel('refresh',url);
	}
    
   
</script>
</head>
<body>
	<div id="dialogDiv"></div>
	<form:form id="searchForm1" modelAttribute="zyJbxx"
		action="" method="post"
		class="breadcrumb form-search">
		
			<input type="hidden" name="newYear" id="newYeartxtId" value="" />
			<div class="cxtj">查询条件</div>
			<table class="ul-form">
				<tr>
					<th style="width:200px;">招生年度</th>
					<td style="width:300px;">
<select name="zs" id="newYearId" class="selectpicker show-tick form-control"  style="width:185px;" multiple="multiple">
							<c:forEach items="${zsndList }" var="zsnd" varStatus="status">
								<option value="${zsnd.zsnd }"
									<c:if test="${status.index==0||status.index==1}">selected="selected"</c:if>
								>${zsnd.zsnd }</option>
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
		    <div title="图形" style="padding:20px;width:100px;overflow:hidden;" data-options="href:'${ctx}/tj/ndzyzstj/ndjzytxtj'" >
		        
		    </div><%-- href:'${ctx}/tj/ndzyzstj/ndjzylbtj --%>
		    <div title="列表" data-options="" style="overflow:auto;padding:20px;width:100px;">
		        
		    </div>
	</div>
	<script type="text/javascript" src="${ctxStatic}/validMes/validMes.js"></script>
</body>
</html>