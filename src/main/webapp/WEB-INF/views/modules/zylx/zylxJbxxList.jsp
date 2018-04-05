<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>专业类别管理</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/base_index.jsp" %>
	<style type="text/css">
		body{
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
        
        
        //添加
        function addZy()

        {
        	openDialog("${ctx}/zylx/zylxJbxx/form","添加专业类",580,340);
        	//window.open("${ctx}/zylx/zylxJbxx/form", "添加专业类别", "top=400,left=530,menubar=no,location=yes,resizable=yes,scrollbars=yes,status=yes");
        }
        //修改
        function editZylx()
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
				   ids= id别s.substring(0,ids.length-1);
				   openDialog("${ctx}/zylx/zylxJbxx/form?id="+ids,"修改专业类别",580,340);
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
        
        function deleteZylx()
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
			}else{
				if(ids!=null && ids!="")
				{
				   ids = ids.substring(0,ids.length-1);			   
				 }
				confirmx('确认要删除该专业类别吗？', "${ctx}/zylx/zylxJbxx/delete?ids="+ids);
			}
			
			
        }
        
         //重置
		function resetClick()
        {
        	$("#lxmc").attr("value",'');
        }
	</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="zylxJbxx" action="${ctx}/zylx/zylxJbxx/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<div class="cxtj">查询条件</div>
		<table class="ul-form">
			<tr>
				<th style="width:400px;">类型名称</th>
				<td style="" colspan="3">
					<form:input path="lxmc" id="lxmc" htmlEscape="false" maxlength="64" class="input-medium"/>
				</td>
			</tr>
			<tr>
				<td colspan="4"  style="text-align: center;">
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" />
					<input id="btnReset" class="btn btn-primary" type="reset" onclick="resetClick();"  value="重置" />
				</td>
			</tr>
		</table>
	</form:form>
	
	<div  class="btn-div">
		<input id="btnAdd" class="btn btn-primary" type="button" onclick="addZy()" value="增加"/>
		<input id="btnEdit" class="btn btn-primary" type="button" onclick="editZylx()" value="修改"/>
		<input id="btnDel" class="btn btn-primary" type="button" onclick="deleteZylx()" value="删除"/>
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
				<th>类型名称</th>
				<th>类型描述</th>
				<!-- <th>创建者</th> -->
				<th>创建时间</th>
				<!-- <th>备注信息</th> -->
				<%-- <shiro:hasPermission name="zylx:zylxJbxx:edit"><th>操作</th>
				</shiro:hasPermission> --%>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="zylxJbxx">
			<tr>
				<td>
			    	<input type="checkbox" id="checkbox" name="choose" value="${zylxJbxx.id}" onclick="selFirst()">
			    	<input type="hidden" name="ids" value="${zylxJbxx.id}" />
			    </td>
				<td>
					${zylxJbxx.lxmc}
				</td>
				<td>
					${zylxJbxx.lxms}
				</td>
				<%-- <td>
					${zylxJbxx.createBy.id}
				</td> --%>
				<td>
					<fmt:formatDate value="${zylxJbxx.createDate}" pattern="yyyy-MM-dd"/>
				</td>
				<%-- <td>
					${zylxJbxx.remarks}
				</td> --%>
				<%-- <shir:has别Permission name="zylx:zylxJbxx:edit"><td>
    				<a href="${ctx}/zylx/zylxJbxx/form?id=${zylxJbxx.id}">修改</a>
					<a href="${ctx}/zylx/zylxJbxx/delete?id=${zylxJbxx.id}" onclick="return confirmx('确认要删除该专业类别吗？', this.href)">删除</a>
				</td></shiro:hasPermission> --%>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<script type="text/javascript" src="${ctxStatic}/validMes/validMes.js"></script>
</body>
</html>