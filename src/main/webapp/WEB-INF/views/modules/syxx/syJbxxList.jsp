<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>生源信息管理</title>
<meta name="decorator" content="default" />
<%@ include file="/WEB-INF/views/include/base_index.jsp" %>
<style type="text/css">
	.form-horizontal .control-label 
		{
			width:130px;
		}
		.form-horizontal .controls
		{
			margin-left: 140px;
		}
		.tabTreeselect{
			width:155px;
		}
		body{
			padding: 0px;
		}
	
</style>

<script type="text/javascript">
$(document).ready(function() {
	$("#btnExport").click(function() {
		top.$.jBox.confirm("确认要导出用户数据吗？", "系统提示", function(v, h, f) {
			if (v == "ok") {
				$("#searchForm").attr("action","${ctx}/syxx/syJbxx/exportFile");
				$("#searchForm").submit();
			}$("#searchForm").attr("action","${ctx}/syxx/syJbxx/list");
	}, {buttonsFocus : 1});
	top.$('.jbox-body .jbox-icon').css('top', '55px');});
	//导入数据
	$("#btnImport").click(function() {
         $.jBox($("#importBox").html(), {
                       title:"生源信息导入", 
                       width:"500px",
                       hight:"300px",
                       showClose : true,
                       buttons:{"确定":"ok","取消":true},
                       bottomText : "", 
                       submit: function(v,h,f){
                          if(v =="ok"){
                            $("#uploadForm").attr("action","${ctx}/syxx/syJbxx/importfile");
						    $("#uploadForm").submit();
                          }
                       }});
                       $("#xq_id").select2();
				});
			});
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").submit();
		return false;
	}
	/**
	* 验证文件
	*/
	function doUpload() {
      var formData = new FormData($( "#uploadForm" )[0]);
       $.ajax({
          url: "${ctx}/syxx/syJbxx/veriftfile" ,
          type: "POST",
          data: formData,
          async: false,
          cache: false,
          contentType: false,
          processData: false,
          success: function (returndata) {
              $("#view_tip_infor").html(returndata);
          },
          error: function (returndata) {
              $("#view_tip_infor").html(returndata);
          }
     });
    }
    // 修改城市信息 
	function setByChr(value) { 
	    if(value!=null&&value!=""){
	       var result0 = "";
	       result0 += "<select select id='csId' name='csId.id' class='input-medium' style=\"width:175px;\" onchange='setByArea(this.value)'><option value=''>全部</option>";
		   $.getJSON("${ctx}/sys/area/findallbychr", {parentId: value}, function(result) {
			 if(result!=null&&result!=""){
			   $.each(result, function(i, field) {
				result0+="<option value="+field.id+" >"+field.name+"</option>";
			   });
			   result0+="</select>";
			   $("#city").html(result0);
			   $("#csId").select2();
			 }
		  });
		  
	    }
	}
	//修改区县信息
   function setByArea(value) {
        if(value!=null&&value!=""){
          var result0 = "&<select select id='qxId' path='qxId.id'  name='qxId.id' class='input-medium' style=\"width:175px;\" onchange=''><option value=''>全部</option>";
		  $.getJSON("${ctx}/sys/area/findallbychr", {parentId: value}, function(result) {
			if(result!=null&&result!=""){
			  $.each(result, function(i, field) {
				//修改地区信息
				result0+="<option value="+field.id+">"+field.name+"</option>";
			  });
			  result0+="</select>";
			  $("#area").html(result0);
			  $("#qxId").select2();
			}
		  });
        }
	}
	
	
	function addSy()
	{
		openDialog("${ctx}/syxx/syJbxx/form","添加生源信息",1080,540);
	}
	
	
	function editSy()
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
				   openDialog("${ctx}/syxx/syJbxx/form?id="+ids,"修改生源信息",1080,540);
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
	
	function deleteSy()
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
				confirmx('确认要删除生源信息吗？', "${ctx}/syxx/syJbxx/delete?ids="+ids);
			}
	}
	
		//重置
		function resetClick()
        {
        	$("#xxdz1").attr("value",'');
        	$("#sfzjh1").attr("value",''); 
        	$("#nf1").attr("value",''); 
        	$("#xxmc1").attr("value",'');
        	$("#xm1").attr("value","");
        	$("#byxx1").attr("value","");
        	
        	$("#sfid1").select2("destroy");
        	$("#sfid1").find("option:selected").attr("selected",false);
        	$("#sfid1").select2();
        	$("#cityselect1").select2("destroy");
        	$("#cityselect1").find("option:selected").attr("selected",false);
        	$("#cityselect1").select2();  
        	
        	$("#qxid1").select2("destroy");
        	$("#qxid1").find("option:selected").attr("selected",false);
        	$("#qxid1").select2();
        	
        	$("#xbm1").select2("destroy");
        	$("#xbm1").find("option:selected").attr("selected",false);
        	$("#xbm1").select2();
        	
        	$("#xsly1").select2("destroy");
        	$("#xsly1").find("option:selected").attr("selected",false);
        	$("#xsly1").select2();
        	
        	$("#xlm1").select2("destroy");
        	$("#xlm1").find("option:selected").attr("selected",false);
        	$("#xlm1").select2();
        	
        	$("#xqId1").select2("destroy");
        	$("#xqId1").find("option:selected").attr("selected",false);
        	$("#xqId1").select2();
        	
        }
	
</script>

<script type="text/template" id="importBox">
<form id="uploadForm" method="post" style="width:100%;hight:100%;padding:2px;" >
  <table border="1" >
        <tr>
           <td><p style="font-size:16px;text-align:right;padding-top:5px;">年份:</p></td>
           <td style="padding-top:10px;">
              <input name="nf" type="text" readonly="readonly" style="width:150px;"
                     maxlength="20" class="input-medium Wdate"
					 value="${fns:getDate(syJbxx.nf)}" pattern="yyyy"
					 onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});"/>
           </td>
           <td><p style="font-size:16px;padding-top:5px;">学期:</p></td>
           <td>
               <select name="xqId" id="xq_id" style="width:185px;">
                  <option value=""></option>
				  <c:forEach items="${fns:getDictList('term_type')}" var="dict">
					  <option value="${dict.value}">${dict.label}</option>
				  </c:forEach>
			   </select>
           </td>
        </tr>
        <tr>
           <td><p style="font-size:16px;padding-top:5px;">导入文件:</p></td>
           <td colspan="3">
               <input id="uploadFile" name="file" type="file" style="width:330px" />
               <input id="btnImportSubmit" class="btn btn-primary" type="button" value="上传" onclick="doUpload()" />
           </td>
        </tr>
        <tr>
           <td><p style="font-size:16px;">导入说明:</p></td>
           <td colspan="3">
               <p style="font-size:16px;">1.导入前需要下载导入的模板:<a href="${ctx}/syxx/syJbxx/template">导入模板下载</a></p>
               <p style="font-size:16px;">2.导入的文件格式为XLS;</p>
               <p style="font-size:16px;">3.导入的数据应该按照模板提供的数据格式进行录入.</p>
           </td>
        </tr>
        <tr>
           <td colspan="4"><div style="height : 100px; weight:500px; overflow: scroll"><p id="view_tip_infor" style="font-size:16px;color:red;text-align: center;height : 100%; weight:100%;"></p></td>
        </tr>
    </table>
  </form>
</script>

</head>
<body>
	<form:form id="searchForm" modelAttribute="syJbxx" action="${ctx}/syxx/syJbxx/list" 
	           method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<div class="cxtj">查询条件</div>
        <table class="ul-form">
           <tr>
              <th>姓名</th>
              <td><form:input path="xm" id="xm1" htmlEscape="false"
						style="width:165px;" maxlength="64" class="input-medium" /></td>
			  <th>性别</th>
			  <td><form:select path="xbm" id="xbm1" class="input-medium" style="width:178px;">
						<form:option value="" label="全部" />
						<form:options items="${fns:getDictList('sex')}" itemLabel="label"
							          itemValue="value" htmlEscape="false" />
				  </form:select>
			  </td>
           </tr>
           <tr>
				<th>身份证件号码</th>
				<td><form:input path="sfzjh" id="sfzjh1" htmlEscape="false"
						maxlength="64" class="input-medium" style="width:165px;" /></td>
				<th>毕业学校</th>
				<td><form:input path="byxx" id="byxx1" htmlEscape="false"
						style="width:165px;" maxlength="64" class="input-medium" /></td>
			</tr>
			<tr>
				<th>应届/往届</th>
				<td><form:select path="xsly" id="xsly1" class="input-medium"
						style="width:178px;">
						<form:option value="" label="全部" />
						<form:options items="${fns:getDictList('xs_ly')}"
							itemLabel="label" itemValue="value" htmlEscape="false" />
					</form:select></td>
				<th>毕业年份</th>
				<td><input name="nf" id="nf1" type="text" readonly="readonly"
					maxlength="20" class="input-medium Wdate"
					value="${fns:getDate(syJbxx.nf)}" pattern="yyyy"
					style="width:170px;"
					onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});" /></td>
			</tr>
			<tr>
			    <th>学历层次</th>
				<td><form:select path="xlm" id="xlm1" class="input-medium"
						style="width:178px;">
						<form:option value="" label="全部" />
						<form:options items="${fns:getDictList('education_type')}"
							itemLabel="label" itemValue="value" htmlEscape="false" />
					</form:select></td>
				<th>详细地址</th>
				<td><form:input path="xxdz" id="xxdz1" htmlEscape="false"
						maxlength="255" class="input-medium" style="width:165px;" /></td>
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
		<input id="btnAdd" class="btn btn-primary" type="button" onclick="addSy()" value="增加"/>
		<input id="btnEdit" class="btn btn-primary" type="button" onclick="editSy()" value="修改"/>
		<input id="btnDel" class="btn btn-primary" type="button" onclick="deleteSy()" value="删除"/>
		<input id="btnImport" class="btn btn-primary" 
		       type="button" value="导入" /> 
		<input id="btnExport" class="btn btn-primary" 
		       type="button" value="导出" />
		
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
				<th>姓名</th>
				<th>性别</th>
				<th>身份证件号码</th>
				
				<th>毕业学校</th>
				<th>应届/往届</th>
				<th>毕业年份</th>
				
				<th>学历层次</th>
				<th>详细地址</th>
				<%-- <shiro:hasPermission name="syxx:syJbxx:edit">
					<th>操作</th>
				</shiro:hasPermission> --%>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="syJbxx">
				<tr>
					<td>
				    	<input type="checkbox" id="checkbox" name="choose" value="${syJbxx.id}" onclick="selFirst()">
				    	<input type="hidden" name="ids" value="${syJbxx.id}" />
				    </td>
					<td>${syJbxx.xm}</td>
					<td>${fns:getDictLabel(syJbxx.xbm, 'sex', '')}</td>
					<td>${syJbxx.sfzjh}</td>
					
					<th>${syJbxx.byxx}</th>
				    <td>${fns:getDictLabel(syJbxx.xsly, 'xs_ly', '')}</td>
				    <td>${syJbxx.nf}</td>
				    
					<td>${fns:getDictLabel(syJbxx.xlm, 'education_type', '')}</td>
					<td>${syJbxx.xxdz}</td>
					<%-- <shiro:hasPermission name="syxx:syJbxx:edit">
					  <td>
						<a href="${ctx}/syxx/syJbxx/form?id=${syJbxx.id}">修改</a>
						<a href="${ctx}/syxx/syJbxx/delete?id=${syJbxx.id}"
						   onclick="return confirmx('确认要删除该生源信息吗？', this.href)">删除</a>
					  </td>
					</shiro:hasPermission> --%>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<script type="text/javascript" src="${ctxStatic}/validMes/validMes.js"></script>
</body>
</html>