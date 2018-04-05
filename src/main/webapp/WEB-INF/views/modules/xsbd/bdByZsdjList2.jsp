<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>招生登记管理</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/base_index.jsp" %>
	<style type="text/css">
		.form-horizontal .control-label 
		{
			width:130px;
		}
		.form-horizontal .controls
		{
			margin-left: 150px;
		}
		.tabTreeselect{
			width:125px;
		}
		body{
			padding: 0px;
		}
	</style>
	<script language="javascript" src="${ctxStatic}/Lodop6.218_CLodop2.130/LodopFuncs.js"></script>
	<script type="text/javascript">
		var LODOP;
		$(document).ready(function() {
		   
		});
		
		function format(state) 
		{
			return state.text;
		}
		
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		
		//重置
		function resetClick()
        {
        	$("#xm").attr("value",'');
        	$("#lxdh").attr("value",'');
            $("#xbm").select2("destroy");
        	$("#xbm").find("option:selected").attr("selected",false);
        	$("#xbm").select2();
        	$("#zsdjzt").select2("destroy");
        	$("#zsdjzt").find("option:selected").attr("selected",false);
        	$("#zsdjzt").select2();
        	$("#ly").select2("destroy");
        	$("#ly").find("option:selected").attr("selected",false);
        	$("#ly").select2();
        	$("#zsjhid").select2("destroy");
        	$("#zsjhid").find("option:selected").attr("selected",false);
        	$("#zsjhid").select2();
        	
        }	
        
        function editJh()
		{	
		    var zsdjzt="";
			var ids ="";
        	var count =0;
			$("#contentTable").find("input[type='checkbox']").each(function()
			{
				if($(this).attr("checked"))
				{
					if($(this).next().val()!=null && $(this).next().val()!="")
					{
						ids += $(this).next().val()+",";
						zsdjzt=$(this).next().next().val();
						count++;
					}
				}
			});
			if(zsdjzt==2){
					alertx('已报到的学生不能修改！');
					return;
			}
			if(count == 1)
			{	
				if(ids!=null && ids!="")
				{
				   ids = ids.substring(0,ids.length-1);///zy/zyJbxx/form
				   openDialog("${ctx}/zsdj/zsdj/form?id="+ids,"修改招生登记信息",1100,480);
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
		
		function deleteJh()
		{
			 var zsdjzt="";
			var ids ="";
        	var count =0;
			$("#contentTable").find("input[type='checkbox']").each(function()
			{
				if($(this).attr("checked"))
				{
					if($(this).next().val()!=null && $(this).next().val()!="")
					{
						ids += $(this).next().val()+",";
						zsdjzt=$(this).next().next().val();
						count++;
					}
				}
			});
			if(zsdjzt==1||zsdjzt==2){
					alertx('预报到和已报到的学生不能删除！');
					return;
			}
			if(count ==0)
			{
				alertx('请选择需要删除的数据！');
			}else
			{
				if(ids!=null && ids!="")
				{
				   ids = ids.substring(0,ids.length-1);
				 }
				confirmx('确认要删除招生登记信息吗？', "${ctx}/zsdj/zsdj/delete?ids="+ids+"&index="+5);
			}
		}
			
		//点击行显示详细信息
		function showZsdjInfoForm(zsdj_id){
			openDialog("${ctx}/zsdj/zsdj/zsdjInfoForm?id="+zsdj_id,"查看报到注册信息",1100,480);
		}
		//修改招生登记状态
		function changzsdjzt(zsdj_id){
		confirmx('确认要修改报道状态吗？', "${ctx}/zsdj/zsdj/savezsdezt?id="+zsdj_id);
		}
		
		//导出
		function daoChuClick()
		{
			openDialog("${ctx}/zsdj/zsdj/bdzcExport","导出报到注册信息",700,340);
		}
		
		function printZsdj()
		{
			var zsdjztFlag=false;
			var ids ="";
        	var count =0;
			$("#contentTable").find("input[type='checkbox']").each(function()
			{
				if($(this).attr("checked"))
				{
					if($(this).next().val()!=null && $(this).next().val()!="")
					{
						ids += $(this).next().val()+",";
						var zsdjzt=$(this).next().next().val();
						if(zsdjzt==0){
							zsdjztFlag=true;
						}
						count++;
					}
				}
			});
			if(zsdjztFlag){
				alertx('未报到的学生不能打印登记表！');
				return;
			}
			if(count ==0)
			{
				alertx('请选择需要打印的数据！');
			}else
			{
				if(ids!=null && ids!="")
				{
				   ids = ids.substring(0,ids.length-1);
				 }
				LODOP=getLodop();
				LODOP.PRINT_INIT("打印学生登记卡");
				createPrintPage(ids);
				LODOP.PREVIEW();
			}
		}
		function createPrintPage(ids){
			jQuery.ajax({
		        type: "POST",
		        url: "${ctx}/zsdj/zsdj/createPrintCode?ids="+ids,
		        data: {},
		        dataType:'json',
		        async:false,
				success: function(result){
					if(result!=null&&result.length>0){
						for(var i=0;i<result.length;i++){
							LODOP.NewPage();
							var r=result[i];
							var printCode=r.split(";");
							for(var j=0;j<printCode.length;j++){
								if(''!=printCode[j]){
									eval(printCode[j]);
								}
							}
						}
					}else{
						alertx("未获取到打印代码，请检查！");
					}
			   }
		    });
		}
				//拍照
		function getImage(id){
		openDialog("${ctx}/zsdj/zsdj/getImage?id="+id, "学籍照片拍照", 1200, 600);
		}
		//查看招生计划
	function editWindows2(value,value1){
		openDialog("${ctx}/zsjh/zsjh/viewform?id=" + value1+"&viewModel=view", "查看招生计划", 1100,620);
	}
	</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="zsdj" action="${ctx}/zsdj/zsdj/listByXsbd2" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		 <div class="cxjg">查询条件</div>
			<input type="hidden" name="checkType" id="checkType"/>
			<table class="ul-form">
			<tr><th >计划名称</th>
					<td >
						<form:select path="zsjh.id" id="zsjhid" maxlength="64" class="input-medium" style="width:175px;">
							<form:option value="" label="全部" />
							<form:options items="${fns:findListZsjh()}" itemLabel="jhmc"
								itemValue="id" htmlEscape="false" />
						</form:select>
					</td>
					<th >学生姓名</th>
					<td >
						<form:input path="xm" id="xm" htmlEscape="false" maxlength="64" class="input-medium"/>
					</td>
					<th >性别</th>
					<td >
					    <form:select path="xbm" id="xbm" class="input-medium" style="width:175px;">
							<form:option value="" label="全部"/>
							<form:options items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
					</tr>
				<tr>
					<th >联系电话</th>
					<td >
						<form:input path="lxdh" id="lxdh" htmlEscape="false" maxlength="64" class="input-medium"/>
					</td>
					<th>招生方式</th>
					<td> 
					<form:select path="ly" id="ly" class="input-medium" style="width:195px;">
							<form:option value="" label="全部"/>
							<form:options items="${fns:getDictList('zsly')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
				    </td>
				<th>报到状态</th>
					<td>
						<form:select path="zsdjzt" id="zsdjzt" class="input-medium" style="width:195px;">
							<form:option value="" label="全部"/>
							<form:options items="${fns:getDictList('zsdjzt')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
				</tr>
				<tr>
					<td colspan="6"  style="text-align: center;">
						<input id="btnSubmit" class="btn btn-primary"  type="submit" value="查询" />
						<input id="btnReset" class="btn btn-primary" type="reset" onclick="resetClick();"  value="重置" />
						<!-- <input id="daoChuBut" class="btn btn-primary"  type="button" onclick="daoChuClick();" value="导出" /> -->
					</td>
				</tr>
			</table>
		
	</form:form>
	 <div class="btn-div">	
	     <input id="btnEdit" class="btn btn-primary" type="button" onclick="editJh()" value="修改学生信息"/>
		<input id="btnDel" class="btn btn-primary" type="button" style="background-color: red;" onclick="deleteJh()" value="删除学生信息"/>
		<!-- <input id="btnAdd" class="btn btn-primary" type="button" onclick="printZsdj()" value="打印登记表"/> -->
	</div> 
	<sys:message content="${message}"/>
	<!-- <div class="cxjg">查询结果</div> -->
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>
					<input type="checkbox" id="checkboxAll" name="choose" onclick="selAll(this)">
					<input type="hidden" name="ids" value="" />
					<input type="hidden" name="shzts" value="" />
				</th>
				<th>计划名称</th>	
				<th>学生姓名</th>			
				<th>性别</th>
				<th>专业类别</th>
				<th>专业名称</th>
				<th>家庭住址</th>
				<th>联系电话</th>
				<th>学生来源</th>
				<th>报到状态</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="zsdj">
			<tr>
				<td >
			    	<input type="checkbox" id="checkbox" name="choose" value="${zsdj.id}" onclick="selFirst()">
			    	<input type="hidden" name="ids" value="${zsdj.id}" />
			    	<input type="hidden" name="shzts" value="${zsdj.zsdjzt}" />
			    </td>
			    <td><a href="javascript:editWindows2('${zsdj.zsjh.zt}','${zsdj.zsjh.id}&act.taskId=${zsdj.zsjh.act.task.id}&act.taskName=${fns:urlEncode(zsdj.zsjh.act.task.name)}&act.taskDefKey=${zsdj.zsjh.act.task.taskDefinitionKey}&act.procInsId=${zsdj.zsjh.act.task.processInstanceId}&act.procDefId=${zsdj.zsjh.act.task.processDefinitionId}&act.status=${zsdj.zsjh.act.status}')"> ${zsdj.zsjh.jhmc}</a>
					</td>
	            <td>
					<a href="javascript:void(0);"  onClick="showZsdjInfoForm('${zsdj.id}')">${zsdj.xm}</a>
				</td>
                <td>
					${fns:getDictLabel(zsdj.xbm, 'sex', '')}
				</td>
                <td>
					${zsdj.zylx.lxmc}
				</td>
				<td>
					${zsdj.zy.zymc}(${zsdj.xz})
				</td>
                <td title="${zsdj.jtzz }">
					${fns:abbr(zsdj.jtzz,15)}
				</td>
				<td>
					${zsdj.lxdh}
				</td>
				<td>
					<c:if test="${zsdj.ly eq '1'}">
						老师招生
					</c:if>
					<c:if test="${zsdj.ly eq '2'}">
						网上报名
					</c:if>
					<c:if test="${zsdj.ly eq '3'}">
						慕名报名
					</c:if>
					<c:if test="${zsdj.ly eq '4'}">
						招生代理
					</c:if>
				</td>
                 <td>
					<c:if test="${zsdj.zsdjzt eq '0' }">
						<%-- ${fns:getDictLabel(bdJbxx.jfzt, 'pay_cost', '')} --%>
						<a href="javascript:void(0);"  onClick="changzsdjzt('${zsdj.id}')"><span style="color: red;">已登记</span></a>
					</c:if>
					<c:if test="${zsdj.zsdjzt eq '1' }">
						<span style="color: #FF69B4;">预报道</span>
					</c:if>
					<c:if test="${zsdj.zsdjzt eq '2' }">
						<span style="color:#0D73F3;">已报到</span>
					</c:if>
				</td>
				<td>
				<a href="javaScript:void(0);" onclick="getImage('${zsdj.id}');">拍照</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<script type="text/javascript" src="${ctxStatic}/validMes/validMes.js"></script>
</body>
</html>