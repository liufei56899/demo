<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>新生报到管理</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/base_index.jsp" %>
	<style type="text/css">
		.lg-lable 
		{
			width:130px;
		}
		
		.lg-controls {
			padding-left: 150px;
		}
		
		.form-horizontal .control-label 
		{
			width:130px;
		}
		.form-horizontal .controls
		{
			margin-left: 150px;
		}
		body
		{
		 	padding: 0px;
		}
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			//专业id 和专业类别id
			var zyid = "${bdJbxx.zyId.id}";
			var zylxid ="${bdJbxx.zylxId.id}";
			 if(zylxid!=null && zylxid!="")
			{
				 $("#zyidli").empty();
				  $.getJSON("${ctx}/zsjh/zsjh/findZyByLxIdAndZyId",{id:zylxid,zyId:zyid},function(result)
				 {
			       	 $("#zyidli").html(result.html);
			       	 $("#zyId").attr("onChange","tiaoJianCx();");
				     $("#zyId").select2({
					 	formatResult: format,
					    formatSelection: format,
					    escapeMarkup: function(m) { return m; }
					 });
			  	 });
			} 
		});
		
		function format(state) 
		{
			return state.text;
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
		
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
        
        //根据专业类别获取专业
		function zhuanYeOnClick(zylxVal)
		{
			   $("#zyId").empty();
			   $("#zyId").select2("destroy");
			   $.getJSON("${ctx}/zsjh/zsjh/findZyByZylx",{id:zylxVal,rows:0},function(result)
			   {
			      $("#zyId").append(result.html);
			       $("#zyId").attr("onChange","tiaoJianCx();");
			    });
			    $("#zyId").select2();
		}
		
		//单个删除学生
		function deleteXueSheng(id,jiaoFeiZt)
		{
			if(jiaoFeiZt == "1")
			{
				alertx('已缴费的学生不能删除');
			}
			else
			{
				confirmx('确认要删除该新生报到吗？', "${ctx}/xsbd/bdJbxx/delete?id="+id);
			}
		}
		
		//批量删除
		function piLiangDelOnClick()
		{
			var isTrue = true;
			var ids ="";
			var jiaoFeiZt = "";//缴费状态
			var jfztTrue = true;
			$("#contentTable").find("input[type='checkbox']").each(function()
			{
				
				if($(this).attr("checked"))
				{
					if($(this).next().val()!=null && $(this).next().val()!="")
					{
						ids += $(this).next().val()+",";
						if($(this).parent().find("input[name='jfzt']").val() == "1")
						{
							jfztTrue = false;
						}
						isTrue = false;
					}
				}
			});
			
			if(jfztTrue)
			{
				if(ids!=null && ids!="")
				{
				   ids = ids.substring(0,ids.length-1);
				   confirmx('确认要删除新生吗？', "${ctx}/xsbd/bdJbxx/piLiangDelete?ids="+ids);
				}
				
				if(isTrue)
				{
					alertx('请选择要删除的新生信息');
				}
			}else
			{
				alertx('已缴费的学生不能删除');
			}
		}
		
		function addXs()
		{
			openDialog("${ctx}/xsbd/bdJbxx/form","添加新生",1200,680);
		}
		
		function editXs()
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
				   openDialog("${ctx}/xsbd/bdJbxx/form?id="+ids,"修改新生",1200,680);
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
		
		function deleteXs()
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
				confirmx('确认要删除该专业类别吗？', "${ctx}/zy/zyJbxx/delete?ids="+ids);
			}
		}
		
		
		//重置
		function resetClick()
        {
        	$("#xmtxt").attr("value",'');
        	$("#sfzjh").attr("value",'');
        	$("#zymc").attr("value","");
        	
        	$("#jfzt").select2("destroy");
        	$("#jfzt").find("option:selected").attr("selected",false);
        	$("#jfzt").select2();
        }
		
	</script>
</head>
<body style="padding: 0px;">
		<form:form id="searchForm" modelAttribute="bdJbxx" action="${ctx}/xsbd/bdJbxx/bdlist" method="post" 
			class="breadcrumb form-search">
			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			<div class="cxtj">查询条件</div>
			<table class="ul-form">
				<tr>
					<th style="width:200px;">学生姓名</th>
					<td style="width:300px;">
						<form:input path="xm" id="xmtxt" htmlEscape="false" maxlength="64" class="input-medium" style="width:180px;"/>
					</td>
					
					<th style="width:200px;">身份证件号码</th>
					<td style="width:300px;">
						<form:input path="sfzjh" id="sfzjh" htmlEscape="false" 
							maxlength="64" class="input-medium" style="width:180px;"/>
					</td>
				</tr>
				<tr>
					<th >专业名称</th>
					<td >
					    <form:input path="zyname" id="zymc" htmlEscape="false" maxlength="64" class="input-medium" style="width:180px;"/>
					</td>
					<th>缴费状态</th>
					<td>
						<form:select path="jfzt" id="jfzt" class="input-medium" style="width:195px;">
							<form:option value="" label="全部"/>
							<form:options items="${fns:getDictList('pay_cost')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
				</tr>
				<tr>
					<td colspan="4"  style="text-align: center;">
						<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" />
						<input id="btnReset" class="btn btn-primary" type="reset" onclick="resetClick();" value="重置" />
					</td>
				</tr>
				
			</table>
		</form:form>
		
<!-- 		<div class="btn-div">
			 <input id="btnAdd" class="btn btn-primary" type="button" onclick="addXs()" value="增加"/>
			<input id="btnEdit" class="btn btn-primary" type="button" onclick="editXs()" value="修改"/>
			<input id="btnDel" class="btn btn-primary" type="button" onclick="piLiangDelOnClick()" value="删除"/> 
		</div> -->
		
		<sys:message content="${message}"/>
		<div class="cxjg">查询结果</div>
		<table id="contentTable" class="table table-striped table-bordered table-condensed">
			<thead>
				<tr>
				  <!--   <th><input type="checkbox" id="checkboxAll" name="choose" onclick="selAll(this)">
				    	<input type="hidden" name="ids" value="" />
				    	<input type="hidden" name="jfzt" value=""/>
				    </th> -->
					<th>学生姓名</th>
					<th>性别</th>
					<th>身份证件号码</th>
					<th>专业类别</th>
					<th>专业名称</th>
					<th>出生日期</th>
					<th>家庭住址</th>
					<th>缴费状态</th>
					<!-- <th>联系电话</th> -->
					<th>注册来源</th>
					<th>创建时间</th>
					<%-- <shiro:hasPermission name="xsbd:bdJbxx:edit">
					<th>操作</th></shiro:hasPermission>  --%>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${page.list}" var="bdJbxx">
				<tr>
				   <%--  <td>
						<input type="checkbox" id="checkbox" name="choose" value="${bdJbxx.id}" onclick="selFirst()">
						<input type="hidden" name="ids" value="${bdJbxx.id}" />
						<input type="hidden" name="jfzt" value="${bdJbxx.jfzt}"/>
					</td> --%>
					<td>
						${bdJbxx.xm}
					</td>
					<td>
						${fns:getDictLabel(bdJbxx.xbm, 'sex', '')}
					</td>
					<td>${bdJbxx.sfzjh}</td>
					<td>${bdJbxx.zyId.lxmc}</td>
					<td>${bdJbxx.zyname}</td>
					<td>
						<fmt:formatDate value="${bdJbxx.csrq}" pattern="yyyy-MM-dd"/>
					</td>
					<td>
						${fns:abbr(bdJbxx.jtzz,15)}
					</td>
					<td>
						<c:if test="${bdJbxx.jfzt eq '0' }">
							<%-- ${fns:getDictLabel(bdJbxx.jfzt, 'pay_cost', '')} --%>
							<span style="color: red;">${fns:getDictLabel(bdJbxx.jfzt, 'pay_cost', '')}</span>
						</c:if>
						<c:if test="${bdJbxx.jfzt eq '1' }">
							<span style="color: #0D73F3;">${fns:getDictLabel(bdJbxx.jfzt, 'pay_cost', '')}</span>
						</c:if>
					</td>
					<%-- <td>
						${bdJbxx.lxdh}
					</td> --%>
					<td>
						${fns:getDictLabel(bdJbxx.datafrom, 'bddjly', '')}
					</td>
					<td>
						<fmt:formatDate value="${bdJbxx.createDate}" pattern="yyyy-MM-dd"/>
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<div class="pagination">${page}</div>
		<script type="text/javascript" src="${ctxStatic}/validMes/validMes.js"></script>
</body>
</html>