<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>新生缴费</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/base_index.jsp" %>
	<style type="text/css">
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			//专业id 和专业类别id
			/* var zyid = "${bdJbxx.zyId.id}";
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
			}  */
			
		});
		
		function format(state) 
		{
			return state.text;
		}
		
		function page(n,s)
		{
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
			   $.getJSON("${ctx}/zsjh/zsjh/findZyByZylx",{id:zylxVal},function(result)
			   {
			      $("#zyId").append(result.html);
			      $("#zyId").attr("onChange","tiaoJianCx();");
			    });
			    $("#zyId").select2();
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
				   confirmx('确认要删除该新生报到吗？', "${ctx}/xsbd/bdJbxx/piLiangDelete?ids="+ids);
				}
				
				if(isTrue)
				{
					alertx('请选择要删除的新生报到信息');
				}
			}else
			{
				alertx('已缴费的学生不能删除');
			}
		}
		
		//批量缴费
		function piLiangJfOnClick()
		{
			var ids ="";
			var jiaoFeiZt = "";//缴费状态
			var yiJiaoFeiNum =0;//已缴费个数  
			var weiJiaoFeiNum =0;//未交费个数
			$("#contentTable").find("input[type='checkbox']").each(function()
			{
				if($(this).attr("checked"))
				{
					if($(this).next().val()!=null && $(this).next().val()!="")
					{
						ids += $(this).next().val()+",";
						if($(this).parent().find("input[name='jfzt']").val() == "0")
						{
							weiJiaoFeiNum++;
						}else
						{
						   
							yiJiaoFeiNum++;
						}
					}
				}
			});
			
			if(ids!=null && ids!="")
			{            //新加的已缴费的学生不能再次缴费
						   if(yiJiaoFeiNum>0){
						   alertx("已缴费的学生不能再次缴费！");
						   return;
						   }
			 
			   ids = ids.substring(0,ids.length-1);//xsbd/bdJbxx/xinShengJiaoFei
			   confirmx('确认要缴费吗？', "${ctx}/xsbd/bdJbxx/piLiangJiaoFei?ids="+ids+"&yiJiaoFeiNum="+yiJiaoFeiNum+"&weiJiaoFeiNum="+weiJiaoFeiNum);
			}else
			{
				alertx('请选择需要缴费的学生！');
			}
		}
		
		//重置
		function resetClick()
        {
        	$("#xmtxt").attr("value",'');
        	$("#sfzjh1").attr("value",'');
        	/*$("#xbm").select2("destroy");
        	 $("#xbm").find("option:selected").attr("selected",false);
        	$("#xbm").attr("value",'');
        	$("#xbm").select2(); */
        	
        	$("#zymc").attr("value","");
        	$("#jfzt").select2("destroy");
        	$("#jfzt").find("option:selected").attr("selected",false);
        	$("#jfzt").select2();
        }
		
		
		function getXueShengInfo(id)
		{
			openDialog("${ctx}/xsjf/xsjfjbxx/getXueShengInfo?id="+id, "学生信息查看", 980, 300); 
		}
		
	</script>
</head>
<body>
		<form:form id="searchForm" modelAttribute="bdJbxx" action="${ctx}/xsjf/xsjfjbxx/" method="post" 
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
						<form:input path="sfzjh" id="sfzjh1" htmlEscape="false" maxlength="64" class="input-medium" style="width:180px;"/>
					</td>
				</tr>
				<tr>
					<%-- <th>专业类别</th>
					<td>
						<form:select path="zylxId.id" class="input-medium" onclick="zhuanYeOnClick(this.value);" style="width:195px;">
							<form:option value="" label="全部"/>
							<form:options items="${fns:getZylxList()}" itemLabel="lxmc" itemValue="id" htmlEscape="false"/>
						</form:select>
					</td> --%>
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
						<input id="btnReset" class="btn btn-primary" type="reset" onclick="resetClick();"  value="重置" />
					</td>
				</tr>
			</table>
		</form:form>
		
		<div class="btn-div">
			<input id="btn" class="btn btn-primary" 
						type="button" value="缴费" onclick="piLiangJfOnClick();"/>
		</div>
		
		<sys:message content="${message}"/>
		<div class="cxjg">查询结果</div>
		<table id="contentTable" class="table table-striped table-bordered table-condensed">
			<thead>
				<tr><th><input type="checkbox" id="checkboxAll" name="choose" onclick="selAll(this)">
						<input type="hidden" name="ids" value="" />
				    	<input type="hidden" name="jfzt" value=""/>
				</th>
					<th width="100">学生姓名</th>
					<th>性别</th>
					<th>身份证件号码</th>
					<!-- <th>专业类别</th> -->
					<th>专业名称</th>
					<!-- <th>出生日期</th> -->
					<th>家庭住址</th>
					<th>联系电话</th>
					<!-- <th>创建时间</th> -->
					<th>缴费状态</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${page.list}" var="bdJbxx">
				<tr>
				    <td>
				    	<input type="checkbox" id="checkbox" name="choose" value="${bdJbxx.id}" onclick="selFirst()">
				    	<input type="hidden" name="ids" value="${bdJbxx.id}" />
						<input type="hidden" name="jfzt" value="${bdJbxx.jfzt}"/>
				    </td>
					<td width="100"><!-- ${ctx}/xsbd/bdJbxx/form?id=${bdJbxx.id} -->
						<a href="javaScript:void(0);" onclick="getXueShengInfo('${bdJbxx.id}');">
							${bdJbxx.xm}
						</a>
					</td>
					<td>
						${fns:getDictLabel(bdJbxx.xbm, 'sex', '')}
					</td>
					<td>${bdJbxx.sfzjh}</td>
					<%-- <td>${bdJbxx.zylxId.lxmc}</td> --%>
					<td>${bdJbxx.zyname}</td>
					<%-- <td>
						<fmt:formatDate value="${bdJbxx.csrq}" pattern="yyyy-MM-dd"/>
					</td> --%>
					<td>
						${bdJbxx.jtzz}
					</td>
					
					<td>
						${bdJbxx.lxdh}
					</td>
					<%-- <td>
						<fmt:formatDate value="${bdJbxx.createDate}" pattern="yyyy-MM-dd"/>
					</td> --%>
					<td>
						<c:if test="${bdJbxx.jfzt eq '0' }">
							<%-- ${fns:getDictLabel(bdJbxx.jfzt, 'pay_cost', '')} --%>
							<span style="color: red;">未缴费</span>
						</c:if>
						<c:if test="${bdJbxx.jfzt eq '1' }">
							<span style="color: #0D73F3;">已缴费</span>
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