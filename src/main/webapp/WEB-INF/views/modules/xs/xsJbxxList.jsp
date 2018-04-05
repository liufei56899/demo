<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学生信息管理</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/base_index.jsp" %>
	<style type="text/css">
	  .tabTreeselect 
	  {
	  	width:130px;
	  }
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
		getBanJi($("#njId").val());
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
        
        //初始化班级列表
        function loadBanJi(xsId,zyId)
        {
        	var strBj = ""; 
        	strBj += "<div class=\"modal fade\" style=\"width:680px;\" id=\"selectBanJi\">";
  			strBj += "<div class=\"modal-dialog\">";
    		strBj += "<div class=\"modal-content\">";
      		strBj += "<div class=\"modal-header\">";
       		strBj += "<button type=\"button\" class=\"close\" data-dismiss=\"modal\"><span>&times;</span></button>";
        	strBj += "<h4 class=\"modal-title\" id=\"myModalLabel\">选择班级</h4>";
      		strBj += "</div>";
      		strBj += "<div class=\"modal-body\">";
      		strBj += "<div id=\"banJiPanel\">";
			strBj += "</div>";
      		strBj += "</div>";
      		strBj += "<div class=\"modal-footer\">";
        	strBj += "<button type=\"button\" class=\"btn btn-default\" data-dismiss=\"modal\">关闭</button>";
        	strBj += "<button type=\"button\" onclick=\"SaveBanJi('"+xsId+"')\" class=\"btn btn-primary\" data-dismiss=\"modal\">确定</button>";
      		strBj += "</div>";
    		strBj += "</div>";
  			strBj += "</div>";
			strBj += "</div>";
			$("#banJiDiv").append(strBj);
			 $.getJSON("${ctx}/xs/xsJbxx/getBanJiList",{zyId:zyId},function(data)
			 {
			 	if(data.length >0)
				{
					var strSheng = "<table>";
					$.each(data,function(index,m){
						if(index==0){
							strSheng += "<tr>";
						}
						strSheng += "<td width=\"130\">";
						strSheng += "<input type=\"checkbox\" id="+m.id+"  rnrs="+m.rnrs+" name="+m.id+" value="+m.bjmc+" />";
						strSheng +=m.bjmc;
						strSheng += "</td>";
						if((index+1)%5==0 && index!=0){
							strSheng += "</tr><tr>";
						}
					});
					strSheng += "</tr>";
					strSheng += "</table>";
					
					$("#banJiPanel").html(strSheng);
				}
		  	 });
			$("#selectBanJi").modal("show");
        }
        
        //保存学生分班
        function SaveBanJi(xueShengId,zyId)
        {
            var num =0;//
            var bjId = "";//班级id
            var rnrs = parseInt(0);//容纳人数
            var zyid ="";//专业id
        	$("#banJiPanel").find("input[type='checkbox']").each(function()
        	{
        		if($(this).attr("checked"))
				{
					num ++;
					bjId = $(this).attr("id");
					rnrs = parseInt($(this).attr("rnrs"));
				}
        	});
        	if(num == 0)
        	{
        		alertx('请选择班级');
        	}
        	else if(num >1)
        	{
        		alertx('只能选择一个班级');
        	}
        	else 
        	{
        		//验证该班级人数已达容纳人数
        		 $.getJSON("${ctx}/xs/xsJbxx/getBanJiNum",{id:xueShengId,bjmc:bjId},function(data)
			 	{
			 		if(rnrs < parseInt(data.bjNum))
			 		{
			 			alertx('此班级人数已达数，请重新选择班级');
			 		}else
			 		{
			 			confirmx('确认分班？', "${ctx}/xs/xsJbxx/saveFenBan?id="+xueShengId+"&bjId="+bjId);
			 		}
			 		
			    });
        	}
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
		   
        //批量删除
		function deletes()
		{
			var isTrue = true;
			var ids ="";
			var status = "";
			var shzt ="";
			var count=0;
			$("#contentTable").find("input[type='checkbox']").each(function()
			{
				
				if($(this).attr("checked"))
				{
					if($(this).next().val()!=null && $(this).next().val()!="")
					{
						ids += $(this).next().val()+",";
						status += $(this).next().next().val()+",";
						shzt = $(this).next().next().val();
						isTrue = false;
						count++;
					}
				}
			});
			if(count==0){
			   alertx("请选择数据！");
			   return;
			}
			if(shzt==0){
			    alertx("审核中的信息不能删除！");
			    return;
			}
			var indexTG = status.indexOf("1");
			var indexBTG = status.indexOf("2");
			if(indexTG > -1 || indexBTG > -1){
				alertx('选中的记录包含已审核过的信息，请重新选择 ！');
				return;
			}
				if(ids!=null && ids!="")
				{
				   ids = ids.substring(0,ids.length-1);
				   confirmx("确认要删除选中的吗？", "${ctx}/xs/xsJbxx/deletes?ids="+ids);
				}
				
				if(isTrue)
				{
					alertx("请选择要删除的学生信息");
				}
		}
		
		//修改
		function udpateF()
		{
			var id ="";
			var shzt ="";
			var count =0;
			$("#contentTable").find("input[type='checkbox']").each(function()
			{
				if($(this).attr("checked"))
				{
					if($(this).next().val()!=null && $(this).next().val()!="")
					{
						id += $(this).next().val()+",";
						shzt = $(this).next().next().val();
						count++;
					}
				}
			});
			if(count ==0)
			{
				alertx("请选择数据修改");
			}
			else if(count >1)
			{
				alertx("只能选择一条数据修改");
			}else
			{
				if(shzt == "1")
				{
				  
					alertx("此学生信息已经审核通过，不能修改");
				}else if(shzt=="0"){
				  
				    alertx("此学生信息已经在审核中，不能修改");
				    
				}else
				{
					id = id.substring(0, id.length-1);
					openDialog("${ctx}/xs/xsJbxx/xsUpdateTab?id="+id, "学生信息修改", 1280, 640);
				}
			}
		}
		
		
		//修改
		function modify(id,shzt){
			if(shzt == "1"){
				alertx("此学生信息已经审核通过，不能修改");
				return;
			}
			else{
				//location.href = "${ctx}/xs/xsJbxx/form?id="+id;
				openDialog("${ctx}/xs/xsJbxx/xsUpdateTab?id="+id, "学生信息修改", 1280, 640);
			}
		}
		
		 //查询学生信息
        function getXueShengInfo(xsid)
        {
        	openDialog("${ctx}/xsfb/xsfb/getXueShengTab?id="+xsid, "学生信息查看", 870, 640);
          
        }
        
        //学生信息变更异动
        function stuInfoUpdateStatus(){
        	var id ="";
			var shzt ="";
			var count =0;
			$("#contentTable").find("input[type='checkbox']").each(function()
			{
				if($(this).attr("checked"))
				{
					if($(this).next().val()!=null && $(this).next().val()!="")
					{
						id += $(this).next().val()+",";
						shzt = $(this).next().next().val();
						count++;
					}
				}
			});
			if(count ==0)
			{
				alertx("请选择一条学生信息数据！");
			}
			else if(count >1)
			{
				alertx("只能选择一条数据进行操作！");
			}else
			{
				if(shzt == "0")
				{
					alertx("此学生信息已经在审核中，不能修改");
				}else{
					id = id.substring(0, id.length-1);
					/* openDialog("${ctx}/xs/xsJbxx/xsUpdateTab?id="+id, "学生信息修改", 1280, 640);  */
					 openDialog("${ctx}/xs/xsJbxx/stuInfoUpdateStatus?id="+id, "学生信息变更异动", 1280, 640);
				}
			}
        	
        }
        
        //批量提交
        function piLiangTiJiao()
        {
        	var id ="";
			var shzt ="";
			var count =0;
			var istrue = true;
			$("#contentTable").find("input[type='checkbox']").each(function()
			{
				if($(this).attr("checked"))
				{
					if($(this).next().val()!=null && $(this).next().val()!="")
					{
						id += $(this).next().val()+",";
						shzt = $(this).next().next().val();
						var ztVal =$(this).next().next().val();
						if(ztVal==3 || ztVal==0 || ztVal==1)
						{
							istrue=false;
						}
						count++;
					}
				}
			});
			
			if(count==0)
			{
				alertx("请选择数据提交！");
			}else
			{
				if(istrue)
				{
					if (id != null && id != "") 
					{
						id = id.substring(0, id.length - 1);
					} 
					confirmx('确认要提交学籍信息吗？', "${ctx}/xs/xsJbxx/piLiangTiJiao?ids=" + id);
				}
				else
				{
					alertx("只能提交学籍状态为未提交和审核不通过的数据！");
				}
			}
        }
		
		
		//重置
		function resetClick()
        {
        	$("#xmtxt").attr("value",'');
        	$("#bjmc").attr("value",''); 
        	$("#zymc1").attr("value",''); 
        	$("#sfzjh").attr("value",'');  
        	
        	$("#shzt1").select2("destroy");
        	$("#shzt1").find("option:selected").attr("selected",false);
        	$("#shzt1").attr("value",'');
        	$("#shzt1").select2();
        	
        	$("#njId").select2("destroy");
        	$("#njId").find("option:selected").attr("selected",false);
        	$("#njId").attr("value",'');
        	$("#njId").select2();
        }
        //当前年级下的班级
		function getBanJi(id){
		jQuery.ajax({
					type : 'post',
					url : "${ctx}/xsfb/xsfb/getBanJi",
					dataType : 'json',
					data : {
						njid : id
					},
					async : false,
					success : function(data) {
					$("#bjmc").select2("destroy");
					$("#bjmc").append('<option value="">请选择</option>');
						for(var i=0;i<data.length;i++){
						if($("#cc").val()==data[i].id){
						
						$("#bjmc").append(
						"<option value='"+data[i].id+"' selected='selected'>"+data[i].bjmc+"</option>"
						)
						}else{
						$("#bjmc").append(
						"<option value='"+data[i].id+"'>"+data[i].bjmc+"</option>"
						)
						}
						}
						$("#bjmc").select2();
					}
				});
		}
		
		
		
		
		
		/**
		` 根据条件导出
		*/
		function daoChuExcel()
		{
			 var bjId = $("#bjmc").find("option:selected").val();
			 var info ="是否导出全部的学生学籍信息？";
			 if(bjId!=null && bjId!="")
			 {
			 	var bjmc = $("#bjmc").find("option:selected").text();
				info = "是否导出{"+bjmc+"班级}的学生学籍信息？";
			 }
			//confirmx(info, "${ctx}/xs/xsJbxx/exportXjInfo"); 
			confirmx(info, exportXjAgax);
		}
		
		
		function exportXjAgax()
		{
		    $("#zymcInp").val($("#zymc1").val());
		    $("#njIdInp").val($("#njId").find("option:selected").val());
		    $("#bjInp").val($("#bjmc").find("option:selected").val());
		    $("#xmInp").val($("#xmtxt").val());
		    $("#sfzjhInp").val($("#sfzjh").val());
		    $("#shztInp").val($("#shzt1").find("option:selected").val());
		    $("#exprotForm").attr("action","${ctx}/xs/xsJbxx/exportXjInfo");
		    $("#exprotForm").submit();
		}
		
		
		/**
			导入
		*/
		function daoRuExcel()
		{
			openDialog("${ctx}/xs/xsJbxx/daoRuXjDialog", "导入学生学籍", 740, 330);
		}
		
		//拍照
		function getImage(id){
		openDialog("${ctx}/xs/xsJbxx/getImage?id="+id, "学籍照片拍照", 1200, 600);
		}
	</script>
</head>
<body>
	<%-- <ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/xs/xsJbxx/list/">学生信息列表</a></li>
	</ul> --%>
	<form action="" id="exprotForm" method="post">
		<input type="hidden" name="zyId.zymc" id="zymcInp" />
		<input type="hidden" name="nj.id" id="njIdInp" />
		<input type="hidden" name="bjmc.bjmc" id="bjInp" />
		<input type="hidden" name="xm" id="xmInp" />
		<input type="hidden" name="sfzjh" id="sfzjhInp" />
		<input type="hidden" name="shzt" id="shztInp" />
	
	</form>
	<form:form id="searchForm" modelAttribute="xsJbxx" action="${ctx}/xs/xsJbxx/list/" method="post" class="breadcrumb form-search">
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
						<form:select path="nj.id" id="njId"  class="input-xlarge" style="width:190px;" onchange="getBanJi(this.value);">
								<form:option value="" label=""/>
								<form:options items="${fns:getXnJbxxList()}" itemLabel="nf" itemValue="id" htmlEscape="false"/>
						</form:select>
					</td>
				</tr>
				<tr>
					<th style="width:200px;">班级</th>
					<td style="width:300px;">
						<%-- <form:input path="bjmc.bjmc" id="bjmc" htmlEscape="false" maxlength="32" class="input-medium" style="width:180px;"/> --%>
						<form:select path="bjmc.id" id="bjmc"  class="input-xlarge" style="width:190px;">
								<%-- <form:option value="" label=""/> --%>
							   <%-- <form:options items="${fns:getBjJbxxList()}" itemLabel="bjmc" itemValue="id" htmlEscape="false"/>  --%>
						</form:select>
						<input type="hidden" value="${bj.bjmc.id}" id="cc">
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
							<form:options items="${fns:getDictList('xj_shzt')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
		<input id="btnReview" class="btn btn-primary" type="button" value="学籍注册" onclick="udpateF();"/>
		<input id="btnReview" class="btn btn-primary" type="button" value="批量提交" onclick="piLiangTiJiao();"/>
		<input id="btnReview" class="btn btn-primary" type="button" value="学生信息变更异动" onclick="stuInfoUpdateStatus();"/>
		<input id="btnExportExcel" class="btn btn-primary" type="button" value="导出学生学籍"  onclick="daoChuExcel();"/>
		
		<input id="btnExcel" class="btn btn-primary" type="button" value="导入学生学籍" onclick="daoRuExcel();"/>
	</div>
	<sys:message content="${message}"/>
	<div class="cxjg">查询结果</div>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th><input type="checkbox" id="checkboxAll" name="choose" onclick="selAll(this)">
				    	<input type="hidden" name="ids" value="" />
				    	<input type="hidden" name="shzts" value="" />
				</th>
				<th>姓名</th>
				<th>性别</th>
				<!-- <th>出生日期</th> -->
				<!-- <th>身份证件类型</th> -->
				<th>身份证件号码</th>
				<th>专业名称</th>
				<th>年级</th>
				<th>学生来源</th>
				<th>学生类别</th>
				<th>入学方式</th>
				<th>修改时间</th>
				<th>学籍状态</th>
				<th>操作</th>
				
				<!-- <th>班级名称</th>
				<th>学号</th> -->
				<!-- <th>就读方式</th> -->
				<!-- <th>专业类别</th> -->
				<!-- <th>招生对象</th>
				<th>毕业学校</th> -->
				<!-- <th>更新时间</th> -->
				<%-- <shiro:hasPermission name="xs:xsJbxx:edit"><th>操作</th></shiro:hasPermission> --%>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="xsJbxx">
			<tr>
				<td>
						<input type="checkbox" id="checkbox" name="choose" value="${xsJbxx.id}" onclick="selFirst()">
						<input type="hidden" name="ids" value="${xsJbxx.id}" />
						<input type="hidden" name="shzts" value="${xsJbxx.shzt}" />
					</td>
					<!-- ${ctx}/xs/xsJbxx/form?id=${xsJbxx.id} -->
				<td><a href="javaScript:void(0);" onclick="getXueShengInfo('${xsJbxx.id}');">
					${xsJbxx.xm}
					</a>
				</td>
				<td>
					${fns:getDictLabel(xsJbxx.xbm, 'sex', '')}
				</td>
				<%-- <td>
					${fns:getDate(xsJbxx.csrq)}
				</td> --%>
				<%-- <td>
					${fns:getDictLabel(xsJbxx.sfzjlxm, 'sfzjlx', '')}
				</td> --%>
				<td>
					${xsJbxx.sfzjh}
				</td>
				<td>
					${xsJbxx.zyId.zymc}(${fns:getDictLabel(xsJbxx.zyId.xz, 'xzdm', '')})
				</td>
				<td>
					${xsJbxx.xsnj}
				</td>
				<td>
					${fns:getDictLabel(xsJbxx.xslym, 'xs_ly', '')}
				</td>
				<td>
					${fns:getDictLabel(xsJbxx.xslbm, 'xslb', '')}
				</td>
				<td>
					${fns:getDictLabel(xsJbxx.rxfsm, 'rxfs', '')}
				</td>
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
				
				
				<%-- <td>
					${fns:getDictLabel(xsJbxx.jdfsm, 'jdfs', '')}
				</td> --%>
				<%-- <td>
					${fns:getDictLabel(xsJbxx.zsdx, 'zsdx', '')}
				</td>
				<td>
					${xsJbxx.byxx}
				</td> --%>
				<%-- <shiro:hasPermission name="xs:xsJbxx:edit"><td>
    				<a href="javascript:modify('${xsJbxx.id}','${xsJbxx.shzt}');">修改</a>
				</td></shiro:hasPermission> --%>
			<td>
					<a href="javaScript:void(0);" onclick="getImage('${xsJbxx.id}');">拍照</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<!-- 把班级 -->
	<div id="banJiDiv">
		
	</div>
	<!-- -->
	<div class="pagination">${page}</div>
	<script type="text/javascript" src="${ctxStatic}/validMes/validMes.js"></script>
</body>
</html>