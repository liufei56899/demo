<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
<head>
	<title>专业管理</title>
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
        function addZy()
        {
        	openDialog("${ctx}/zy/zyJbxx/form","添加专业",1100,560);
        }
        
        function editZy()
        {
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
				if(ids!=null && ids!="")
				{
				   ids = ids.substring(0,ids.length-1);///zy/zyJbxx/form
				   var istrue =getXsJbxx("${ctx}",null,null,ids);
				   if(istrue)
				   {
				   		openDialog("${ctx}/zy/zyJbxx/zyJbxxUpdateForm?id="+ids,"修改专业",1080,480);
				   }else
				   {
				   		alertx('该专业下已存在学生不能修改！');
				   }
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
        
        function deleteZy()
        {
        	var ids ="";
        	var count =0;
        	var index =0;
			$("#contentTable").find("input[type='checkbox']").each(function()
			{
				if($(this).attr("checked"))
				{
					if($(this).next().val()!=null && $(this).next().val()!="")
					{
						ids += $(this).next().val()+",";
						count++;
						var istrue =getXsJbxx("${ctx}",null,null,$(this).next().val());
						if(!istrue)
						{
							index++;
						}
					}
				}
			});
			
			if(count ==0)
			{
				alertx('请选择需要删除的数据！');
			}else
			{
				if(index<=0)
				{
					if(ids!=null && ids!="")
					{
					   ids = ids.substring(0,ids.length-1);
					   
					 }
					confirmx('确认要删除该专业名称吗？', "${ctx}/zy/zyJbxx/delete?ids="+ids);
				}
				else
				{
					alertx('不能删除专业下已存在的学生数据 ！');
				}
			}
        }
        
        //重置
		function resetClick()
        {
        	$("#zymc").attr("value",'');
        	$("#zylx").select2("destroy");
        	$("#zylx").find("option:selected").attr("selected",false);
        	$("#zylx").select2();
        }
        		
		//点击行显示详细信息
		function showZyInfoForm(zsdj_id){
			openDialog("${ctx}/zy/zyJbxx/zyInfoForm?id="+zsdj_id,"查看专业详细信息",1100,480);
		}
	</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="zyJbxx" action="${ctx}/zy/zyJbxx/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<div class="cxtj">查询条件</div>
			<table class="ul-form">
				<tr>
					<th style="width:200px;">专业类别</th>
					<td style="width:300px;">
						<form:select path="zylx.id" id="zylx" class="input-medium">
							<form:option value="" label=""/>
							<form:options items="${fns:getZylxList()}" itemLabel="lxmc" itemValue="id" htmlEscape="false"/>
						</form:select>
					</td>
					
					<th style="width:200px;">专业名称</th>
					<td style="width:300px;">
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
	<div  class="btn-div">
		<input id="btnAdd" class="btn btn-primary" type="button" onclick="addZy()" value="增加"/>
		<input id="btnEdit" class="btn btn-primary" type="button" onclick="editZy()" value="修改"/>
		<input id="btnDel" class="btn btn-primary" type="button" onclick="deleteZy()" value="删除"/>
	</div>
	<sys:message content="${message}"/>
	<div class="cxjg">查询结果</div>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>
					<input type="checkbox" id="checkboxAll" name="choose" onclick="selAll(this)">
					<input type="hidden" name="ids" value="" />
				</th>
				<th>专业名称</th>
	
				<th>专业简称</th>
				<th>专业类别</th>
				<th>专业方向</th>
				<th>专业代码</th>
				
				<!-- <th>专业目录版本</th> -->
				
				<!-- <th>学制</th> -->
				<th>本校专业编号</th>
				<th>是否目录外专业</th>
				<th>办学状态</th>
				
				<!-- <th>专业描述</th>
				<th>创建者</th>
				<th>创建时间</th> -->
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="zyJbxx">
			<tr >
				<td >
			    	<input type="checkbox" id="checkbox" name="choose" value="${zyJbxx.id}" onclick="selFirst()">
			    	<input type="hidden" name="ids" value="${zyJbxx.id}" />
			    </td>
				<td>
					<a href="javascript:void(0);" onClick="showZyInfoForm('${zyJbxx.id}')">
					<c:if test="${zyJbxx.zymlbb eq '0'}">
					${zyJbxx.zymc}(目录外)
					</c:if>
					<c:if test="${zyJbxx.zymlbb ne '0'}">
					  ${zyJbxx.zymc}
					</c:if>
					</a>
				</td>
				<td>
					${zyJbxx.zyjc}
				</td>
				<td>
					${fns:getZylxLabel(zyJbxx.zylx.id)}
				</td>
				<td>
					${zyJbxx.zyfxmc}
				</td>
				<td>
					${zyJbxx.zydm}
				</td>
				
				<%-- <td>
					${zyJbxx.zymlbb}
				</td> --%>
				<%-- <td>
					${zyJbxx.xzmc}
				</td> --%>
				<td>
					${zyJbxx.bxzybh}
				</td>
				<td>
					<c:if test="${zyJbxx.zymlbb eq '0'}">
					是
					</c:if>
					<c:if test="${zyJbxx.zymlbb ne '0'}">
					  否
					</c:if>
				</td>
				<td>
					${fns:getDictLabel(zyJbxx.bxzt,"bxzt","")}
				</td>
				
				<%-- <td>
					${zyJbxx.zyms}
				</td>
				<td>
					${zyJbxx.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${zyJbxx.createDate}" pattern="yyyy-MM-dd"/>
				</td> --%>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<script type="text/javascript" src="${ctxStatic}/validMes/validMes.js"></script>
</body>
</html>