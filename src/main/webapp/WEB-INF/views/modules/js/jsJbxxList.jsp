<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>教师信息管理</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/base_index.jsp" %>
	<style type="text/css">
	  .tabInput 
	  {
	  	width:270px;
	  }
	  .tabTreeselect 
	  {
	  	width:155px;
	  }
	  .form-horizontal .control-label 
		{
			width:130px;
		}
		.form-horizontal .controls
		{
			margin-left: 150px;
		}
		.tabInput
		{
			width:200px;
		}
		body 
		{
			padding: 0px;
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
        
        function addJs()
        {
        	openDialog("${ctx}/js/jsJbxx/form","添加教师信息",1200,480);
        }
        
        function editJs()
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
				   openDialog("${ctx}/js/jsJbxx/form?id="+ids,"修改教师信息",1200,480);
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
        
        function deleteJs()
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
			
			if(count ==0)
			{
				alertx('请选择需要删除的数据！');
			}else
			{
				if(ids!=null && ids!="")
				{
				   ids = ids.substring(0,ids.length-1);
				   
				 }
				confirmx('确认要删除教师信息吗？', "${ctx}/js/jsJbxx/delete?ids="+ids);
			}
        }
        
         //重置
		function resetClick()
        {
        	$("#xm").attr("value",'');
        }
        
	</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="jsJbxx" action="${ctx}/js/jsJbxx/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<div class="cxtj">查询条件</div>
			<table class="ul-form">
				<tr>
					<th style="width:50%;">姓名</th>
					<td style="" colspan="3">
						<form:input path="xm" id="xm" htmlEscape="false" maxlength="64" class="input-medium"/>
					</td>
				</tr>
				<tr>
					<td colspan="4"  style="text-align: center;">
						<input id="btnSubmit" class="btn btn-primary"  type="submit" value="查询" />
						<input id="btnReset" class="btn btn-primary" type="reset" onclick="resetClick();"  value="重置" />
					</td>
				</tr>
			</table>
		<%-- <ul class="ul-form">
			<li style="width:310px;"><label>姓名：</label>
				<form:input path="xm" id="xm" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul> --%>
	</form:form>
	
	<div class="btn-div">
		<input id="btnAdd" class="btn btn-primary" type="button" onclick="addJs()" value="增加"/>
		<input id="btnEdit" class="btn btn-primary" type="button" onclick="editJs()" value="修改"/>
		<input id="btnDel" class="btn btn-primary" type="button" onclick="deleteJs()" value="删除"/>
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
				<!-- <th>学校代码</th> -->
				<th>姓名</th>
				<th>工号</th>
				<th>性别</th>
				<th>出生日期</th>
				<th>联系电话</th>
				<th>身份证件号码</th>
				<th>民族</th>
				<th>学历</th>
				<th>政治面貌</th>
				<th>参加工作年月</th>
				<!-- <th>身份证件类型码</th> -->
				<!-- <th>来校年月</th> -->
				<th>更新时间</th>
				<!-- <th>备注信息</th> -->
				<%-- <shiro:hasPermission name="js:jsJbxx:edit"><th>操作</th></shiro:hasPermission> --%>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="jsJbxx">
			<tr>
				<td>
			    	<input type="checkbox" id="checkbox" name="choose" value="${jsJbxx.id}" onclick="selFirst()">
			    	<input type="hidden" name="ids" value="${jsJbxx.id}" />
			    </td>
				<%-- <td>
					${jsJbxx.xxdm}
				</td> --%>
				<td>
					${jsJbxx.xm}
				</td>
				<td>
					${jsJbxx.gh}
				</td>
				<td>
					${fns:getDictLabel(jsJbxx.xbm, 'sex', '')}
				</td>
				<td>
					${jsJbxx.csrq}
				</td>
				<td>
					${jsJbxx.lxdh}
				</td>
				<td>
					${jsJbxx.sfzjh}
				</td>
				<td>
					${fns:getDictLabel(jsJbxx.mzm, 'nation', '')}
				</td>
				<td>
					${fns:getDictLabel(jsJbxx.xlm, 'education_type', '')}
				</td>
				<td>
					${fns:getDictLabel(jsJbxx.zzmmm, 'zzmm', '')}
				</td>
				<td>
					${jsJbxx.gzny}
				</td>
				<td>
					<fmt:formatDate value="${jsJbxx.updateDate}" pattern="yyyy-MM-dd"/>
				</td>
				<%-- <shiro:hasPermission name="js:jsJbxx:edit"><td>
    				<a href="${ctx}/js/jsJbxx/form?id=${jsJbxx.id}">修改</a>
					<a href="${ctx}/js/jsJbxx/delete?id=${jsJbxx.id}" onclick="return confirmx('确认要删除该教师信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission> --%>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<script type="text/javascript" src="${ctxStatic}/validMes/validMes.js"></script>
</body>
</html>