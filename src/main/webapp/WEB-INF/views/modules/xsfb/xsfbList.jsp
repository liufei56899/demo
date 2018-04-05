<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>新生分班管理</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/base_index.jsp" %>
	<style type="text/css">
		body 
		{
			padding: 0px;
		}
		
		.banJiSpan
		{
			display: block;
			height: 23px;
			padding-top: 3px;
			font-family: Microsoft Yahei;
		}
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
        function divideClass(){
        	var ids ="";
        	var count =0;
			$("#contentTable").find("input[type='checkbox']").each(function(){
				if($(this).attr("checked"))
				{
					if($(this).next().val()!=null && $(this).next().val()!="")
					{
						ids += $(this).next().val()+",";
						count++;
					}
				}
			});
			if(count == 1){
				if(ids!=null && ids!=""){
				   var i = ids.indexOf(",");
				   var yyrs=ids.substring(i+1,ids.length-1); 				 									
				   ids = ids.substring(0,i);
				   window.location.href="${ctx}/xsfb/xsfb/form?id="+ids+"&yyrs="+yyrs;				   				  			   
				}
			}
			else if(count ==0){
				alertx('请选择需要分到的班级！');
			}else{
				alertx('只能选择一条班级信息！');
			}
        }
        //重置
		function resetClick(){
        	$("#bjmc").attr("value",'');
        	$("#zymc").attr("value",'');  	
        }     
	</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="fbxx" action="${ctx}/xsfb/xsfb/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>		
		<table class="ul-form">
			<tr>
				<th>班级名称：</th>
				<td>
					<form:input path="bjmc" id="bjmc" htmlEscape="false" maxlength="64" class="input-medium"/>
				</td>
				<th>班级专业：</th>
				<td>
					<form:input path="zymc" id="zymc" htmlEscape="false" maxlength="64" class="input-medium"/>
				</td>
			</tr>
			<tr>
				<td colspan="4" style="text-align: center;">
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" />
					<input id="btnReset" class="btn btn-primary" type="reset" onclick="resetClick();"  value="重置" />
				</td>
			</tr>
		</table>			
	</form:form>
	<div class="btn-div">
		<input id="btnAdd" class="btn btn-primary" type="button" onclick="divideClass()" value="分班"/>
		<!-- <input id="btnEdit" class="btn btn-primary" type="button" onclick="editDivideClass()" value="修改"/>	 -->	
	</div>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>
					<input type="checkbox" id="checkboxAll" name="choose" onclick="selAll(this)">
					<input type="hidden" name="ids" value="" />			
				</th>						
				<th>班级名称</th>
				<th>班级专业</th>
				<th>已有学生</th>				
				<th>男生数量</th>
				<th>女生数量</th>						
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="fbxx">
			<tr>
				<td>
			    	<input type="checkbox" id="checkbox" name="choose" value="${fbxx.id}" onclick="selFirst()">
			    	<input type="hidden" name="ids" value="${fbxx.id},${fbxx.yyxs}" />			    
			    </td>			    
				<td>
					${fbxx.bjmc}
				</td>
				<td>
					${fbxx.zymc}
				</td>
				<td>
					${fbxx.yyxs}
				</td>
				<td>
					${fbxx.man}
				</td>
				<td>
					${fbxx.woman}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<script type="text/javascript" src="${ctxStatic}/validMes/validMes.js"></script>
</body>
</html>