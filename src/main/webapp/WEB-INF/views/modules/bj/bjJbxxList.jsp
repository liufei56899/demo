<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>班级管理</title>
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

		var zylxid = "${bjJbxx.zylxId.id}";
		var zyid = "${bjJbxx.zyId.id}";
		if (zylxid != null && zylxid != "") {
			$("#zyidli").empty();
			$.getJSON("${ctx}/zsjh/zsjh/findZyByLxIdAndZyId", {
				id : zylxid,
				zyId : zyid
			}, function(result) {
				$("#zyidli").html(result.html);
				$("#zyId").prev().remove();
				 $("#zyId").attr("onChange","tiaoJianCx();");
				$("#zyId").select2({
					formatResult : format,
					formatSelection : format,
					escapeMarkup : function(m) {
						return m;
					}
				});
			});
		}

	});
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").submit();
		return false;
	}

	function format(state) {
		return state.text;
	}
	//根据专业类别获取专业
	function zhuanYeOnClick(zylxVal) {
		$("#zyId").empty();
		$("#zyId").select2("destroy");
		$.getJSON("${ctx}/zsjh/zsjh/findZyByZylx", {
			id : zylxVal
		}, function(result) {
			 $("#zyId").attr("onChange","tiaoJianCx();");
			 console.log(result.html);
			$("#zyId").append(result.html);
		});
		$("#zyId").select2();
	}
	
	function add(){
		openDialog("${ctx}/bj/bjJbxx/form","添加班级",1280,480);
    }
    
    function editBj()
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
				   openDialog("${ctx}/bj/bjJbxx/form?id="+ids,"修改班级",1280,480);
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
    
    function deleteBj()
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
				confirmx('确认要删除班级信息吗？', "${ctx}/bj/bjJbxx/delete?ids="+ids);
			}
    }
	    
	    //重置
		function resetClick()
        {
        	$("#zylxId").select2("destroy");
        	$("#zylxId").find("option:selected").attr("selected",false);
        	$("#zylxId").select2();
        	
        	$("#zyId").select2("destroy");
        	$("#zyId").find("option:selected").attr("selected",false);
        	$("#zyId").select2();
        	
        	$("#bjmc").attr("value","");
        	$("#bh").attr("value","");
        }
</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="bjJbxx"
		action="${ctx}/bj/bjJbxx/" method="post"
		class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden"
			value="${page.pageSize}" />
			
			<div class="cxtj">查询条件</div>
			<table class="ul-form">
				<tr>
					<th style="width:200px;">专业类别</th>
					<td style="width:300px;">
						<form:select path="zylxId.id"
						id="zylxId" class="input-medium"
						onclick="zhuanYeOnClick(this.value);">
						<form:option value="" label="全部" />
						<form:options items="${fns:getZylxList()}" itemLabel="lxmc"
							itemValue="id" htmlEscape="false" />
					</form:select>
					</td>
					<th style="width:200px;">专业名称</th>
					<td style="width:300px;"  id="zyidli" >
						<select name="zyId.id"
							class="input-medium" id="zyId">
								<option value="" label="全部" />
						</select>
					</td>
				</tr>
				<tr>
					<th style="width:200px;">班级名称</th>
					<td style="width:300px;">
						<form:input path="bjmc" id="bjmc" htmlEscape="false" maxlength="34" 
							class="input-medium" style="width:170px;"/>
					</td>
					<th style="width:200px;">班号</th>
					<td style="width:300px;">
						<form:input path="bh" id="bh" htmlEscape="false" maxlength="34" 
							class="input-medium" style="width:170px;"/>
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
		<c:if test="${not empty xnList }">
			<input id="btnAdd" class="btn btn-primary" type="button" onclick="add()" value="增加"/>
		</c:if>
		<input id="btnEdit" class="btn btn-primary" type="button" onclick="editBj()" value="修改"/>
		<input id="btnDel" class="btn btn-primary" type="button" onclick="deleteBj()" value="删除"/>
	</div>
	
	<sys:message content="${message}" />
	<div class="cxjg">查询结果</div>
	<table id="contentTable"
		class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>
					<input type="checkbox" id="checkboxAll" name="choose" onclick="selAll(this)">
					<input type="hidden" name="ids" value="" />
				</th>
				<th>班级名称</th>
				<th>班号</th>
				<th>学年</th>
				<th>专业类别</th>
				<th>专业名称</th>
				<th>班主任</th>
				<th>教室编号</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="bjJbxx">
				<tr>
					<td>
				    	<input type="checkbox" id="checkbox" name="choose" value="${bjJbxx.id}" onclick="selFirst()">
				    	<input type="hidden" name="ids" value="${bjJbxx.id}" />
				    </td>
					<td>${bjJbxx.bjmc}</td>
					<td>${bjJbxx.bh}</td>
					<td>${bjJbxx.njid.nf}</td>			
					<td>${bjJbxx.zylxId.lxmc}</td>
					<td>${bjJbxx.zyId.zymc}</td>
					<td>${bjJbxx.jsId.name}</td>
					<td>${bjJbxx.jsbh}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<script type="text/javascript" src="${ctxStatic}/validMes/validMes.js"></script>
</body>
</html>