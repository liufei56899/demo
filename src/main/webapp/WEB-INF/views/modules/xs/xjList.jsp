<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学生信息管理</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/base_index.jsp"%>
	<style type="text/css">
	  .tabTreeselect 
	  {
	  	width:120px;
	  }
	  .btnxz
	  {
	  	   background-color:#438AB7;
	  }
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnZsxxDemo").click(function() {
				top.$.jBox.confirm("确认要导出招生信息采集表吗？", "系统提示", function(v, h, f) {
					if (v == "ok") {
						$("#searchForm").attr("action","${ctx}/xs/xsJbxx/exportZsxxDemo");
						$("#searchForm").submit();
					}
			}, {buttonsFocus : 1});
			top.$('.jbox-body .jbox-icon').css('top', '55px');});
			
			$("#btnXsxxDemo").click(function() {
				top.$.jBox.confirm("确认要导出新生信息采集表吗？", "系统提示", function(v, h, f) {
					if (v == "ok") {
						$("#searchForm").attr("action","${ctx}/xs/xsJbxx/exportXsxxDemo");
						$("#searchForm").submit();
					}
			}, {buttonsFocus : 1});
			top.$('.jbox-body .jbox-icon').css('top', '55px');});
			
			$("#btnExport3").click(function() {
				top.$.jBox.confirm("确认要导出新生头像采集信息吗？", "系统提示", function(v, h, f) {
					if (v == "ok") {
						$("#searchForm").attr("action","${ctx}/xs/xsJbxx/exportTxxx");
						$("#searchForm").submit();
					}
			}, {buttonsFocus : 1});
			top.$('.jbox-body .jbox-icon').css('top', '55px');});
			//导入招生信息
			$("#btnImportZsxx").click(function(){
				$.jBox($("#importZsxxBox").html(), {title:"导入招生信息", buttons:{"关闭":true}, 
					bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
			});
			//导入新生信息
			$("#btnImportXsxx").click(function(){
				$.jBox($("#importXsxxBox").html(), {title:"导入新生信息", buttons:{"关闭":true}, 
					bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
			});
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
		   
		//批量审核
		function Reviews()
		{
			var isTrue = true;
			var ids ="";
			$("#contentTable").find("input[type='checkbox']").each(function()
			{
				
				if($(this).attr("checked"))
				{
					if($(this).next().val()!=null && $(this).next().val()!="")
					{
						ids += $(this).next().val()+",";
						isTrue = false;
					}
				}
			});
			
				if(ids!=null && ids!="")
				{
				   ids = ids.substring(0,ids.length-1);
				   confirmx("确认要审核选中的吗？", "${ctx}/xs/xsJbxx/updateShzt?ids="+ids);
				}
				
				if(isTrue)
				{
					alertx("请选择要审核的学籍信息");
				}
		}
		
		 //查询学生信息
        function getXueShengInfo(xsid)
        {
        	openDialog("${ctx}/xsfb/xsfb/getXueShengTab?id="+xsid, "学生信息查看",870, 640);
        	/* openDialog("${ctx}/xsfb/xsfb/getXueShengInfo?id="+xsid, "学生信息查看", 780, 580); */
        }
		
		//批量审核数据
	function piliangSubmit() {
	    var ids = "";//ID信息
		var count = 0;
		var status = "";//状态
		var studentnames = "";//部门名称
		
		$("#contentTable").find("input[type='checkbox']").each(
				function() {
					if ($(this).attr("checked")) {
						if ($(this).next().val() != null
								&& $(this).next().val() != "") {
							status += $(this).next().next().next().val()+",";
							ids += $(this).next().val() + ",";
							studentnames += $(this).next().next().val() + "<br>";
							count++;
						}
					}
		});
		var indexTG = status.indexOf("1");
		var indexBTG = status.indexOf("2");
		
		
		//判断信息
		
		 //alert(indexTG+"     "+indexBTG)
		 if(indexBTG=="0"){
		     alertx('已否决！');
		     return;
		 }
		if (count == 0) {
			alertx('请选择需要提交的数据！');
		}else if(count == 1){
		    if (ids != null && ids != "") {
				ids = ids.substring(0, ids.length - 1);
			}
		    openDialog("${ctx}/xs/xsJbxx/shForm?id=" + ids,"审核学生信息", 1200, 650);
		}
		else {
		 if (ids != null && ids != "") {
				ids = ids.substring(0, ids.length - 1);
		 }
		if(indexTG != -1 || indexBTG != -1){
			alertx('选中的记录包含已审核过的信息，请重新选择 ！');
			return;
		}
		
		$("#dialogDiv2").dialog({
					collapsible : false,
					minimizable : false,
					maximizable : false,
					title : "审核意见",
				    width : "400",
		            height : "300",
				    content :"<div style=\"text-align: left;margin-top: 10px;\"><p>对以下学生信息进行审核:"+
				             "<span style=\"color:red;\">(注意:审核通过的学生信息不允许修改!)</span></p>"+
				               studentnames+"</div>",
					buttons : [ {
						text : "审核通过",
						handler : function() {
						    $.getJSON("${ctx}/xs/xsJbxx/moreShenHe",{ids:ids,shStatu:"1"},function(result){
			  					if(result == "1"){
			  						alertx("批量审核学生'通过'成功!");
			  					      //刷新列表
			                         $("#searchForm").attr("action","${ctx}/xs/xsJbxx/xjList");
						             $("#searchForm").submit();
						             closeDialog();
			  					 }else if(result == "0"){
			  					     alertx("批量审核学生'通过'失败!");
			  					     closeDialog();
			  					 }
		                    });
						}
					}, {
						text : "审核不通过",
						handler : function() {
							$.getJSON("${ctx}/xs/xsJbxx/moreShenHe",{ids:ids,shStatu:"2"},function(result){
			  					if(result == "2"){
			  						alertx("批量审核学生'不通过'成功!");
			  					      //刷新列表
			                         $("#searchForm").attr("action","${ctx}/xs/xsJbxx/xjList");
						             $("#searchForm").submit();
						             closeDialog();
			  					 }else if(result == "0"){
			  					     alertx("批量审核学生'不通过'失败!");
			  					     closeDialog();
			  					 }
		                    });
						}
					} ]
				});
				$(".panel").css("top", "0px");
				$(".window-shadow").css("top", "0px");
			}
		}
		function loadBj(njId){
			if(njId!=null&&njId!=""){
		    	 $.ajax({
				        type: "POST",
				        url: "${ctx}/bj/bjJbxx/getBjList",
				        data: {njid:njId},
				        dataType:'json',
				        async:false,
						success: function(result){
							if(result!=null&&result!=""){
								  $("#bjmc").empty();
								  $("#bjmc").append("<option value=''></option>");
								  for(var i in result){
									  var r=result[i];
									  $("#bjmc").append("<option value='"+r.id+"'>"+r.bjmc+"</option>");
								  }
							      
							  }else{
								  $("#bjmc").empty();
							  }
					   }
				    });
		        
		     }
		}
	</script>
</head>
<body>
	<div id="importZsxxBox" class="hide">
		<form id="importForm" action="${ctx}/xs/xsJbxx/importZsxx" method="post" enctype="multipart/form-data"
			class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
			<input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　　
			<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
		</form>
	</div>
	<div id="importXsxxBox" class="hide">
		<form id="importForm" action="${ctx}/xs/xsJbxx/importXsxx" method="post" enctype="multipart/form-data"
			class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
			<input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　　
			<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
		</form>
	</div>
	<%-- <ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/xs/xsJbxx/xjList/">学籍信息</a></li>
		<shiro:hasPermission name="xs:xsJbxx:edit"><li>
		<a href="${ctx}/xs/xsJbxx/form">学生信息添加</a></li></shiro:hasPermission>
	</ul> --%>
	<div id="dialogDiv2"></div>
	<form:form id="searchForm" modelAttribute="xsJbxx" action="${ctx}/xs/xsJbxx/xjList/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<div class="cxtj">查询条件</div>
		<table class="ul-form">
			<tr>
					<th>专业名称</th>
					<td>
						<form:input path="zyId.zymc" id="zymc1" 
							htmlEscape="false" maxlength="18" class="input-medium" style="width:180px;"/>
					</td>
					<th style="width:200px;">年级</th>
					<td style="width:300px;">
						<form:select path="nj.id" id="njId"  class="input-xlarge" style="width:190px;">
								<form:option value="" label=""/>
								<form:options items="${fns:getXnJbxxList()}" itemLabel="nf" itemValue="id" htmlEscape="false"/>
						</form:select>
					</td>
				</tr>
				<tr>
					<th style="width:200px;">班级</th>
					<td style="width:300px;">
						<%--<form:input path="bjmc.bjmc" id="bjmc" htmlEscape="false" maxlength="32" class="input-medium" style="width:180px;"/>
					--%>
						<form:select path="bjmc.id" id="bjmc"  class="input-xlarge" style="width:190px;">
								<form:option value="" label=""/>
								<c:forEach items="${bjList}" var="bj">
									<form:option value="${bj.id}" label="${bj.bjmc}"/>
								</c:forEach>
						</form:select>
					</td>
					<th style="width:200px;">姓名</th>
					<td style="width:300px;">
						<form:input path="xm" id="xmtxt" htmlEscape="false" maxlength="64" class="input-medium" style="width:180px;" />
					</td>
				</tr>
				<tr>
					<th>身份证件号码</th>
					<td>
						<form:input path="sfzjh" id="sfzjh" htmlEscape="false" maxlength="18" class="input-medium" style="width:180px;"/>
					</td>
					<th>学籍状态</th>
					<td>
						<form:select path="shzt" id="shzt1" class="input-medium" style="width:195px;">
							<form:option value="" label="全部"/>
							<form:option value="0" label="审核中"/>
							<form:option value="1" label="审核通过"/>
							<form:option value="2" label="审核不通过"/>
							<%-- <form:options items="${fns:getDictList('xj_shzt')}" itemLabel="label" itemValue="value" htmlEscape="false"/> --%>
						</form:select>
					</td>  
				</tr>
			<td colspan="4"  style="text-align: center;">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
				<!-- <input id="btnReview" class="btn btn-primary" 
							type="button" value="审核" onclick="Reviews();"/> -->
				<input id="btnZsxxDemo" class="btn btn-primary btnxz" 
					       type="button" value="招生信息V1.1下载" />
				<input id="btnXsxxDemo" class="btn btn-primary btnxz" 
					       type="button" value="学生学籍信息V1.2下载" />
			    <input id="btnExport3" class="btn btn-primary btnxz" 
					       type="button" value="新生头像采集信息下载" />
				<input id="btnImportZsxx" class="btn btn-primary" 
					       type="button" value="招生信息V1.1导入" /> 
				<input id="btnImportXsxx" class="btn btn-primary" 
				       type="button" value="学生学籍信息V1.2导入" /> 
			</td>
			</tr>
		</table>
	</form:form>
		<div class="btn-div">
			<input id="btnSubmit" type="button" class="btn btn-primary" onclick="piliangSubmit()" value="审核"/>
		</div>
	<sys:message content="${message}"/>
	<div class="cxjg">查询结果</div>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th><input type="checkbox" id="checkboxAll" name="choose" onclick="selAll(this)">
				    	<input type="hidden" name="ids" value="" />
				    	<input type="hidden" name="name" value="" />
				    	<input type="hidden" name="status" value="" /> 
				</th>
				<th>姓名</th>
				<th>性别</th>
				<!-- <th>出生日期</th> -->
				<!-- <th>身份证件类型</th> -->
				<th>身份证件号码</th>
				<th>专业名称</th>
				<th>年级</th>
				<!-- <th>学生来源</th>
				<th>学生类别</th>
				<th>入学方式</th> -->
				<th>修改时间</th>
				<th id="xjzt">学籍状态</th>
				<%-- <shiro:hasPermission name="xs:xsJbxx:edit"><th>操作</th></shiro:hasPermission> --%>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="xsJbxx">
			<tr>
				<td>
						<input type="checkbox" id="checkbox" name="choose" value="${xsJbxx.id}" onclick="selFirst()">
						<input type="hidden" name="ids" value="${xsJbxx.id}" />
						<input type="hidden" name="name" value="${xsJbxx.xm}" />
						<input type="hidden" name="status" value="${xsJbxx.shzt}" />
					</td><!-- ${ctx}/xs/xsJbxx/form?id=${xsJbxx.id} -->
				<td><a href="javaScript:void(0);" onclick="getXueShengInfo('${xsJbxx.id}');">
					${xsJbxx.xm}
					</a>
				</td>
				<td>
					${fns:getDictLabel(xsJbxx.xbm, 'sex', '')}
				</td>
				<td>
					${xsJbxx.sfzjh}
				</td>
				<td>
					${xsJbxx.zyId.zymc}(${fns:getDictLabel(xsJbxx.zyId.xz, 'xzdm', '')})
				</td>
				<td>
					${xsJbxx.nj.nf}
				</td>
				<%-- <td>
					${fns:getDictLabel(xsJbxx.xslym, 'xs_ly', '')}
				</td>
				<td>
					${fns:getDictLabel(xsJbxx.xslbm, 'xslb', '')}
				</td>
				<td>
					${fns:getDictLabel(xsJbxx.rxfsm, 'rxfs', '')}
				</td> --%>
				<td>
					<fmt:formatDate value="${xsJbxx.updateDate}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					<%-- ${fns:getDictLabel(xsJbxx.shzt, 'xj_shzt', '')} --%>
					<c:if test="${xsJbxx.shzt eq '0'}">
					审核中
					</c:if>
					<c:if test="${xsJbxx.shzt eq '1'}">
					   审核通过
					</c:if>
					<c:if test="${xsJbxx.shzt eq '2'}">
					 审核不通过
					</c:if>
					<c:if test="${xsJbxx.shzt eq '3'}">
					 学籍未注册
					</c:if>
					<c:if test="${xsJbxx.shzt eq '4'}">
					 学籍未提交
					</c:if>
				</td>
				<%-- <shiro:hasPermission name="xs:xsJbxx:edit"><td>
    				<a href="${ctx}/xs/xsJbxx/shForm?id=${xsJbxx.id}">审核</a>
				</td></shiro:hasPermission> --%>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<!-- 把班级 -->
	<div id="banJiDiv">
		
	</div>
	<!-- -->
	<div class="pagination">${page}</div>
</body>
</html>