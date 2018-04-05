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
	<script type="text/javascript">
		$(document).ready(function() {
		    var id = "${zsdj.zylx.id}";
		    var zyid =  "${zsdj.zy.id}";
		    var flag = "1";
		    if(id!= null && id!=""){
		    	$("#zyByLx").empty();
		       $.getJSON("${ctx}/zsdj/zsdj/findZyByLxIdAndZyId",
		             {id:"${zsdj.zylx.id}",zyId:"${zsdj.zy.id}",flag:flag},
		             function(result){
		                 if(result!=null&&result!=""){
		                   $("#zyByLx").html(result.html);
		                    $("#zyId").attr("style","width:195px;");
		                    $("#zyId").attr("onChange","tiaoJianCx();");
		                    $("#zyId").select2({
							 	formatResult: format,
							    formatSelection: format,
							    escapeMarkup: function(m) { return m; }
							 });
		                 }
		  	         }
		  	   );
		    }
		});
		
		function format(state) 
		{
			return state.text;
		}
		
		function openNewDialog(href, title, width, height) {
		
		$('#dialogdljgDiv').dialog({
			title : title,
			width : width,
			height : height,
			closed : false,
			cache : false,
			href : href,
			modal : true
		});
	
		$(".panel").css("top", "0px");
		$(".window-shadow").css("top", "0px");
	}
		
		function add()
        {
        	openNewDialog("${ctx}/zsdj/zsdj/listdl","代理机构登记",1100,480);
        }
		
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
         //选择专业
		function lxChange(info){
			$("#zyid1").empty();
			$("#zyid1").select2("destroy");
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
			if(zsdjzt==1){
					alertx('已报到的学生不能修改！');
					return;
			}
			if(count == 1)
			{
				if(ids!=null && ids!="")
				{
				   ids = ids.substring(0,ids.length-1);///zy/zyJbxx/form
				   openNewDialog("${ctx}/zsdj/zsdj/listdl?id="+ids,"修改招生登记信息",1100,480);
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
		
		//批量导入学生信息
		function piLiangDaoRu()
        {
        	openNewDialog("${ctx}/zsdj/zsdj/listmmDRTest/4","代理机构批量导入界面",1100,340);
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
			if(zsdjzt==1){
					alertx('已报到的学生不能删除！');
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
				confirmx('确认要删除招生登记信息吗？', "${ctx}/zsdj/zsdj/delete?ids="+ids+"&index="+4);
			}
		}
		
		
		//重置
		function resetClick()
        {
        	$("#xm").attr("value",'');
        	$("#jsid").attr("value",''); 
        	$("#office").attr("value",''); 
        	$("#officeId").attr("value",'');
        	$("#officeName").attr("value",'');
        	
        	$("#zsjhid").select2("destroy");
        	$("#zsjhid").find("option:selected").attr("selected",false);
        	$("#zsjhid").select2();
        	$("#xbm").select2("destroy");
        	$("#xbm").find("option:selected").attr("selected",false);
        	$("#xbm").select2();  
        	
        	$("#zylxId").select2("destroy");
        	$("#zylxId").find("option:selected").attr("selected",false);
        	$("#zylxId").select2();
        	
        	$("#zyid1").select2("destroy");
        	$("#zyid1").find("option:selected").attr("selected",false);
        	$("#zyid1").select2();
        	
        	$("#zyId").select2("destroy");
        	$("#zyId").find("option:selected").attr("selected",false);
        	$("#zyId").select2();
        }		
		//点击行显示详细信息
		function showZsdjInfoForm(zsdj_id){
			   openDialog("${ctx}/zsdj/zsdj/zsdjInfoForm?id="+zsdj_id,"查看招生登记信息",1100,480);
		}
	</script>
</head>
<body>
<div id='dialogdljgDiv' style='width:820px;'></div>
	<form:form id="searchForm" modelAttribute="zsdj" action="${ctx}/zsdj/zsdj/dljglist" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<div class="cxtj">查询条件</div>
			<table class="ul-form">
				<tr>
					<th style="width:200px;">计划名称</th>
					<td style="width:300px;">
						<form:select path="zsjh.id" id="zsjhid" maxlength="64" class="input-medium" style="width:175px;">
							<form:option value="" label="全部" />
							<form:options items="${fns:findZsjhListByUserId()}" itemLabel="jhmc"
								itemValue="id" htmlEscape="false" />
						</form:select>
					</td>
					<th style="width:200px;">学生姓名</th>
					<td style="width:300px;">
						<form:input path="xm" id="xm" htmlEscape="false" maxlength="64" class="input-medium"/>
					</td>
				</tr>
				<tr>
					<th >性别</th>
					<td >
					    <form:select path="xbm" id="xbm" class="input-medium" style="width:175px;">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
					<th>老师姓名</th>
					<td>
						<form:input path="js.id" id="jsid" htmlEscape="false" maxlength="64" class="input-medium"/>
					</td>
				</tr>
				
				
				<tr>
					<th >专业类别</th>
					<td >
					    <form:select path="zylx.id" id="zylxId" onchange="lxChange(this.value)" class="input-medium required" style="width:175px;">
							<form:option value="" label="全部"/>
							<form:options items="${fns:getZylxList()}" itemLabel="lxmc" itemValue="id" htmlEscape="false"/>
						</form:select>
					</td>
					<th>专业名称</th>
					<td  id="zyByLx">
						<select name="zy.id" class="input-medium"  id="zyid1" style="width:195px;">
					      <option value="" label="全部"/>
					    </select>
					</td>
				</tr>
				
				<tr>
					<th >部门名称</th>
					<td >
					    <sys:treeselect id="office" name="office.id" value="${requestScope.zsdj.office.id}" labelName="office.name" labelValue="${requestScope.zsdj.office.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
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
		<input id="btnAdd" class="btn btn-primary" type="button" onclick="piLiangDaoRu()" value="批量导入学生信息"/>
		<input id="btnAdd" class="btn btn-primary" type="button" onclick="add()" value="登记学生信息"/>
		<input id="btnEdit" class="btn btn-primary" type="button" onclick="editJh()" value="修改学生信息"/>
		<input id="btnDel" class="btn btn-primary" type="button" style="background-color: red;" onclick="deleteJh()" value="删除学生信息"/>
	</div>
	
	<sys:message content="${message}"/>
	<div class="cxjg">查询结果</div>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>
					<input type="checkbox" id="checkboxAll" name="choose" onclick="selAll(this)">
					<input type="hidden" name="ids" value="" />
					<input type="hidden" name="shzts" value="" />
				</th>
				<th>计划名称</th>
				<th>招生部门</th>
				<th>招生老师</th>
				<th>招生季节</th>
				<th>学生姓名</th>				
				<th>身份证件号码</th>
				<th>专业名称</th>
				<th>联系电话</th>
				<th>招生类型</th>
				<th>学生状态</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="zsdj">
			<tr >
				<td>
			    	<input type="checkbox" id="checkbox" name="choose" value="${zsdj.id}" onclick="selFirst()">
			    	<input type="hidden" name="ids" value="${zsdj.id}" />
			    	<input type="hidden" name="shzts" value="${zsdj.zsdjzt}" />
			    </td>
				<td>
					${zsdj.zsjh.jhmc}
				</td>
				<td>
					${zsdj.office.name}
				</td>
				<td>
					${zsdj.name}
				</td>
				<td>
					${zsdj.xnxq.xnmc}
				</td>
				<td>
					<a href="javascript:void(0);" onClick="showZsdjInfoForm('${zsdj.id}')">${zsdj.xm}</a>
				</td>
				<td>
					${zsdj.sfzjh}
				</td>
				<td>
					${zsdj.zy.zymc}(${zsdj.xz})
				</td>
				<td>
					${zsdj.lxdh}
				</td>
                <td>
					代理机构招生
				</td>
				<td>
					<c:if test="${zsdj.zsdjzt eq '0'}">
						<span style="color: red;">预报名</span>
					</c:if>
					<c:if test="${zsdj.zsdjzt eq '1'}">
						<span style="color: #0D73F3;">已报到</span>
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