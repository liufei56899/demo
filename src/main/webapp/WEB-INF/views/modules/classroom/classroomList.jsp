<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>教室信息管理管理</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/base_index.jsp" %>	
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
        function addclassroom(){
        	openDialog("${ctx}/classroom/classroom/form","添加课程信息",900,300);
        }
        function editclassroom(){
        	var ids ="";
        	var count =0;
			$("#contentTable").find("input[type='checkbox']").each(function()
			{
				if($(this).attr("checked"))
				{
					if($(this).next().val()!=null && $(this).next().val()!="")
					{
						ids += $(this).next().val()+",";
						count++;
					}
				}
			});
			if(count == 1)
			{
				if(ids!=null && ids!=""){
					var i = ids.indexOf(",");
					var status=ids.substring(i+1,ids.length); 				 									
				   	ids = ids.substring(0,i);								   
				   openDialog("${ctx}/classroom/classroom/form?id="+ids,"修改教室信息",900,300);
				}
			}
			else if(count ==0)
			{
				alertx('请选择需要修改的数据！');
			}else
			{
				alertx('只能选择一条信息进行修改！');
			}
    	
        }
        function deleteclassroom(){
        	var ids ="";
        	var count =0;
			$("#contentTable").find("input[type='checkbox']").each(function()
			{
				if($(this).attr("checked"))
				{
					if($(this).next().val()!=null && $(this).next().val()!="")
					{
						ids += $(this).next().val()+",";
						count++;
					}
				}
			});
			if(count == 1)
			{
				if(ids!=null && ids!=""){
				   var i = ids.indexOf(",");				   				 									
				   ids = ids.substring(0,i);			   
				   confirmx('确认要删除该教室信息吗？', "${ctx}/classroom/classroom/delete?id="+ids);
			   
				}
			}
			else if(count ==0)
			{
				alertx('请选择需要删除的数据！');
			}else
			{
				alertx('只能选择一条信息进行删除！');
			}
    	
        }
        function qClassroom(){
        	var ids ="";       	
        	var count =0;
			$("#contentTable").find("input[type='checkbox']").each(function(){
				if($(this).attr("checked")){
					if($(this).next().val()!=null && $(this).next().val()!="")
					{
						ids += $(this).next().val();
						count++;
					}
				}
			});
			if(count == 1){
				if(ids!=null && ids!=""){			
					var i = ids.indexOf(",");
					var status=ids.substring(i+1,ids.length); 				 									
				   	ids = ids.substring(0,i);
				   	if(status==0){				    	
				   		confirmx('确认要启用该教室信息吗？', "${ctx}/classroom/classroom/save?id="+ids+"&status=1"); 
				   	}else{
				   		alertx('该教室信息已经启用！');
				   	}  
				}
			}
			else if(count ==0)
			{
				alertx('请选择需要启用的教室信息数据！');
			}else
			{
				alertx('只能选择一条教室信息进行启用！');
			}
    	
        }
        function tClassroom(){
        	var ids ="";
        	var count =0;
			$("#contentTable").find("input[type='checkbox']").each(function()
			{
				if($(this).attr("checked"))
				{
					if($(this).next().val()!=null && $(this).next().val()!="")
					{
						ids += $(this).next().val();
						count++;
					}
				}
			});
			if(count == 1)
			{
				if(ids!=null && ids!=""){
					var i = ids.indexOf(",");
					var status=ids.substring(i+1,ids.length); 				 									
				   	ids = ids.substring(0,i);
				   	if(status==1){
				   		confirmx('确认要停用该教室信息吗？', "${ctx}/classroom/classroom/save?id="+ids+"&status=0");
				   	}else{
				   		alertx('该教室信息已经停用！');
				   	}				  						   
				}
			}
			else if(count ==0)
			{
				alertx('请选择需要停用的教室信息数据！');
			}else
			{
				alertx('只能选择一条教室信息进行停用！');
			}
    	
        }
        function setClassroom(){
        	var ids ="";
        	var count =0;
			$("#contentTable").find("input[type='checkbox']").each(function()
			{
				if($(this).attr("checked"))
				{
					if($(this).next().val()!=null && $(this).next().val()!="")
					{
						ids += $(this).next().val();
						count++;
					}
				}
			});
			 if(count == 1){
				if(ids!=null && ids!=""){
					var i = ids.indexOf(",");							 									
				   	ids = ids.substring(0,i);
				   jQuery.ajax({ 
  						url:"${ctx}/classroom/classroom/count?flag=set",
  						data:{id:ids}, 
  						type:"post",  						
  						dataType:'json', 
  						success:function(data) { 
    						if(data.msg =="true" ){     
      							openDialog("${ctx}/classroom/classroom/setroom?id="+ids,"设置固定教室",900,320); 
    						}else{      							
      							alertx(data.msg); 
    						} 
   						}, 
   						error : function() {   
     						alertx('系统出现异常，请联系管理员！'); 
   						} 
					});   

				}
			}
			else if(count ==0)
			{
				alertx('请选择需要设置的教室信息数据！');
			}
			 else
			{
				alertx('只能选择一条教室信息进行设置！');
			}
        }
        //更改固定教室
        function updateSetClassroom(){
        	var ids ="";
        	var count =0;
			$("#contentTable").find("input[type='checkbox']").each(function(){
				if($(this).attr("checked")){
					if($(this).next().val()!=null && $(this).next().val()!=""){
						ids += $(this).next().val();
						count++;
					}
				}
			});
			if(count == 1){
				if(ids!=null && ids!=""){
					var i = ids.indexOf(",");							 									
				   	ids = ids.substring(0,i);
				   jQuery.ajax({ 
  						url:"${ctx}/classroom/classroom/count?flag=update",
  						data:{id:ids}, 
  						type:"post",  						
  						dataType:'json', 
  						success:function(data) { 
    						if(data.msg =="true" ){     
      							openDialog("${ctx}/classroom/classroom/setroom?id="+ids,"更改固定教室",900,320); 
    						}else{      							
      							alertx(data.msg); 
    						} 
   						}, 
   						error : function() {   
     						alertx('系统出现异常，请联系管理员！'); 
   						} 
					});   

				}
			}
			else if(count ==0)
			{
				alertx('请选择需要更改的固定教室信息！');
			}
			 else
			{
				alertx('只能选择一条固定教室信息进行更改！');
			}
        }
         //点击行显示详细信息
        function showClassroomForm(classroom_id){
        	openDialog("${ctx}/classroom/classroom/setroom?id="+classroom_id+"&flag=view","查看课程详细信息",900,310);
        }                   		
        //重置
		function resetClick(){
        	$("#jslh").attr("value",'');
        	$("#jsmph").attr("value",'');
        	$("#jslx").attr("value",'');
        	$("#status").attr("value",'');    	
        }
        
       
	</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="classroom" action="${ctx}/classroom/classroom/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table class="ul-form">
			<tr>
				<th>教室楼号：</th>
				<td>
					<form:input path="jslh" id="jslh" htmlEscape="false" maxlength="64" class="input-medium"/>
				</td>
				<th>教室门牌号：</th>
				<td>
					<form:input path="jsmph" id="jsmph" htmlEscape="false" maxlength="64" class="input-medium"/>
				</td>
				<th>教室类型：</th>
				<td style="width:300px;">
					<form:select path="jslx" id="jslx" class="input-medium">
						<form:option value="" label="--请选择--"/>					
						<form:option value="1" label="普通教室"/>	
						<form:option value="2" label="非普通教室"/>				
					</form:select>
				</td>					
				<th>状态：</th>
				<td style="width:300px;">
					<form:select path="status" id="status" class="input-medium">
					<form:option value="" label="--请选择--"/>					
						<form:option value="0" label="停用"/>	
						<form:option value="1" label="启用"/>						
					</form:select>
				</td>			
			</tr>
			<tr>
				<td colspan="8" style="text-align: center;">
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" />
					<input id="btnReset" class="btn btn-primary" type="reset" onclick="resetClick();"  value="重置" />
				</td>
			</tr>
		</table>
	</form:form>
	<div  class="btn-div">
		<input id="btnAdd" class="btn btn-primary" type="button" onclick="addclassroom()" value="增加"/>
		<input id="btnEdit" class="btn btn-primary" type="button" onclick="editclassroom()" value="修改"/>
		<input id="btnDel" class="btn btn-primary" type="button" onclick="deleteclassroom()" value="删除"/>
		<input class="btn btn-primary" type="button" onclick="qClassroom()" value="启用"/>
		<input class="btn btn-primary" type="button" onclick="tClassroom()" value="停用"/>
		<input class="btn btn-primary" type="button" onclick="setClassroom()" value="设置固定教室"/>
		<input class="btn btn-primary" type="button" onclick="updateSetClassroom()" value="更改固定教室"/>
	</div>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>
					<input type="checkbox" id="checkboxAll" name="choose" onclick="selAll(this)">
					<input type="hidden" name="ids" value="" />
				</th>
				<th>序号</th>
				<th>教室楼号</th>
				<th>教室门牌号</th>
				<th>教室类型</th>
				<th>可容纳人数</th>
				<th>状态</th>	
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="classroom">
			<tr>
				<td>
			    	<input type="checkbox" id="checkbox" name="choose" value="${classroom.id}" onclick="selFirst()">
			    	<input type="hidden" name="ids" value="${classroom.id},${classroom.status}"/>			    
			    </td>
				<td>
					<a href="javascript:void(0);" onClick="showClassroomForm('${classroom.id}')">
					${classroom.xh}
					</a>
				</td>
				<td>
					${classroom.jslh}
				</td>
				<td>
					${classroom.jsmph}
				</td>
				<td>
					<c:if test="${classroom.jslx eq '1'}">
						普通教室
					</c:if>
					<c:if test="${classroom.jslx ne '1'}">
					 	 非普通教室
					</c:if>						
				</td>
				<td>
					${classroom.rnrs}
				</td>
				<td>
					<c:if test="${classroom.status eq '0'}">
					停用
					</c:if>
					<c:if test="${classroom.status ne '0'}">
					  启用
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