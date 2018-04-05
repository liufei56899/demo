<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>教学大纲管理</title>
	<meta name="decorator" content="default"/>	
	<script type="text/javascript">
	  var rows=parseInt('${xh}');
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
		function findZyLxByJhId(id){
		jQuery.ajax({
			type : "POST",
			url : "${ctx}/zsdj/zsdj/getZsdjBySfzh",
			data : {
				sfzjh : personID
			},
			dataType : 'json',
			async : false,
			success : function(data) {
				if(data.zsdj!=''&&data.zsdj!=null){
				alertx("该生已报名，请进行其他操作！");
				flagA=1;
			}else{
				flagA=0;
			}
			}
		});
		}
		function zcount(){
		var jk=0;
		var sj=0;
		var kwsj=0;
		var zxs=0;
		var a=$("#jkCount").val();
		var b=$("#sjCount").val();
		var c=$("#kwsjCount").val();
		if(a!=""&& !isNaN(a)){
		  jk=a;
		}
		if(b!="" && !isNaN(b)){
		  sj=b;
		}
		if(c!="" && !isNaN(c)){
		  kwsj=c;
		}
		zxs=parseInt(jk)+parseInt(sj)+parseInt(kwsj);
		$("#zxsCount").val(zxs);
		};

		function addxsfp(){	
		   			
				   if(rows<10){
				   var row=rows;
				   rows=rows+1;
				   var  htmlss="<tr class='text-center'>";
				   htmlss+="<td> <input name='jxdgXsfp["+(row-1)+"].xuhao1' style='width:50px;border:none;outline:medium;' readonly='readonly'  value="+row+"></td>";
				   htmlss+= "<td> <input type='text' name='jxdgXsfp["+(row-1)+"].jxnr' maxlength='64'  style='width:130px;' ></td>";
				   htmlss+= "<td> <input type='text' id='jkCount"+rows+"'  name='jxdgXsfp["+(row-1)+"].jkCount1'  style='width:50px;' maxlength='2' onkeyup=\""+"this.value=this.value.replace(/\\D/g,'')"+"\"  onafterpaste=\""+"this.value=this.value.replace(/\\D/g,'')"+"\" oninput='xiaoji(this);'></td>"; 
				   htmlss+= "<td> <input type='text' id='sjCount"+rows+"' name='jxdgXsfp["+(row-1)+"].sjCount1'  style='width:50px;' maxlength='2' onkeyup=\""+"this.value=this.value.replace(/\\D/g,'')"+"\"  onafterpaste=\""+"this.value=this.value.replace(/\\D/g,'')"+"\" oninput='xiaoji(this);'></td>"; 
				   htmlss+= "<td> <input type='text' id='kwCount"+rows+"' name='jxdgXsfp["+(row-1)+"].kwCount1'  style='width:50px;' maxlength='2' onkeyup=\""+"this.value=this.value.replace(/\\D/g,'')"+"\"  onafterpaste=\""+"this.value=this.value.replace(/\\D/g,'')"+"\" oninput='xiaoji(this);'></td>"; 
				   htmlss+= "<td> <input type='text' id='xjCount"+rows+"' name='jxdgXsfp["+(row-1)+"].xjCount'  style='width:50px;' readonly='readonly' ></td>";                                    
		           htmlss+="<td><input type='button' onclick=del(this) value='删除'  style='width:50px;'/></td>";  
		           htmlss+="</tr>";
		           $("#table2").append(htmlss);                                  
				   }else{
				    $("#addxxjl").html("添加学时分配已达上限");
				   }
		         }
		        
	function xiaoji(o){
	    var row=o.parentNode.parentNode;
		var rowid=row.rowIndex;
		alert(rowid);
		var jk=0;
		var sj=0;
		var kwsj=0;
		var zxs=0;
	
		var a=$("#jkCount"+rowid).val();
		var b=$("#sjCount"+rowid).val();
		var c=$("#kwCount"+rowid).val();
		
		 if(a!=""&& !isNaN(a)){
		  jk=a;
		}
		if(b!="" && !isNaN(b)){
		  sj=b;
		}
		if(c!="" && !isNaN(c)){
		  kwsj=c;
		}
		zxs=parseInt(jk)+parseInt(sj)+parseInt(kwsj);
		
		$("#xjCount"+rowid).val(zxs);
		 var count=0;
		for(i=0;i<rows-1;i++){
		  count+=parseInt($("input[name='jxdgXsfp["+i+"].xjCount']").val());
			 } 
        var countz=0;
		var co= $("#zxsCount").val();
		if(co!="" && !isNaN(co)){
		var countz=co;
		}	
		  if(count>countz){
		  alertx("课时数大于总课时数！！");
		  } 
		
		};
           
   function del(o){
			var t=document.getElementById("table2");
			var row=o.parentNode.parentNode;
			var rowid=row.rowIndex;
			if (rowid==rows) {
			t.deleteRow(rowid);
			rows=rows-1;
			}else{
		
			alertx("请先删除最后一行");
			}
			
			if(rows<10){
			 $("#addxxjl").html("");
			}
		    }
      function  findjxdgByCourseXnxq(){
         
      }
	  function  OnSubmit(){
	  var xnxq=$("#xnxq").val();
	     var kcId=$("#kcId").val();
		 var count=0;
		for(i=0;i<rows-1;i++){
		  count+=parseInt($("input[name='jxdgXsfp["+i+"].xjCount']").val());
			 } 
	    var countz=0;
		var co= $("#zxsCount").val();
		if(co!="" && !isNaN(co)){
		var countz=co;
		}
		  if(count>countz){
		  alertx("课时数大于总课时数！！");
		   return false;
		  } 
		  else{
	         $("#inputForm").submit();
		  } 
		}
		
		function courseChange(){
		var a=$("#kcId").val();
		if(a==''){
		  $("#skjs").text("");
         $("#zyId").text(""); 
		}else{
		$.getJSON("${ctx}/jxdg/jxDg/getCourse",{id:a},function(result) {
         $("#skjs").text(result.teachername);
         $("#zyId").text(result.zymc); 
		});
		}
		}
	</script>
	<style>
	.comments {  
    width:85%;/*自动适应父布局宽度*/  
    overflow:auto;  
    word-break:break-all;  
    }
    #table1 td{
    text-align:left;
    padding-left: 4%;
    }
    #table3 td{
    text-align:left;
    padding-left: 4%;
    }
	</style>
</head>
<body>

	<ul class="nav nav-tabs">
		<li><a href="${ctx}/jxdg/jxDg/">教学大纲列表</a></li>
		<li class="active"><a href="${ctx}/jxdg/jxDg/form?id=${jxDg.id}">教学大纲<shiro:hasPermission name="jxdg:jxDg:edit">${not empty jxDg.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="jxdg:jxDg:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	  
	     <div class="text-center"><span>教学大纲</span></div>
	    <div style="height: 10px;"></div>
	    
	<form:form id="inputForm" modelAttribute="jxDg" action="${ctx}/jxdg/jxDg/save" method="post" >
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		 <table id="table1" class="table table-bordered" style="width:60%;height:100%; margin-left: 20%;">	
		    <tr >
			     <td >学年学期：</td>
			     <td ><input name="xnxq" id="xnxq"  class="input-xlarge required"  readonly="readonly" value="${jxDg.xnxq}">
					<%-- <form:select path="xnxq" id="xnxq"  class="input-xlarge required"  readonly="readonly">
						<form:option value="" label="请选择" />
						<form:options items="${fns:getXnxqJbxxList()}" 
						              itemLabel="xnmc" itemValue="xnmc" htmlEscape="false" />
				   </form:select>
				   <span class="help-inline"><font color="red">*</font></span> --%>
				  
			     </td>
				  <td>开学学期:</td>
			      <td>
			      <input name="kkxq" id="kkxq"  class="input-xlarge required"  readonly="readonly" value="${jxDg.kkxq}">
			    <%--   <form:select path="kkxq" id="kkxq"  class="input-xlarge required" readonly="readonly">
						<form:option value="" label="请选择" />
						<form:option value="第一学期" label="第一学期" />
						<form:option value="第二学期" label="第二学期" />
				   </form:select>
			      <span class="help-inline"><font color="red">*</font></span> --%>
			      </td>
			  </tr>
			  <tr>
			     <td>课程名称:</td>
			     <td>
			   <form:select path="kcId" id="kcId"  class="input-xlarge required" onchange="courseChange();" readonly="readonly">
						<form:option value="" label="请选择" />
						<form:options items="${fns:getCourseList()}" 
						              itemLabel="coursename" itemValue="id" htmlEscape="false" />
				   </form:select>
				   <span class="help-inline"><font color="red">*</font></span>
			     </td>
		  
			   <td>课程性质:</td>
			   <td>
			   <form:select path="kcxzid" id="kcxzid"  class="input-xlarge required" >
						  <form:option value="" label="全部" />
							<form:options items="${fns:getDictList('kcxzid')}" itemLabel="label" itemValue="label" 
								htmlEscape="false"/>
				   </form:select>
				   <span class="help-inline"><font color="red">*</font></span>
			   </td>
			  </tr>
			  <tr>
			   <td>总学时数:</td>
			   <td>
			   <input type="text" name="zxsCount"  id="zxsCount" class="input-xlarge required" readonly="readonly" value="${jxDg.zxsCount}" />
			   </td>
		       <td>讲课时数:</td>
			   <td>
			   <input type="text" name="jkCount"  id="jkCount" class="input-xlarge required" maxlength="3" value="${jxDg.jkCount}" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" oninput="zcount();"/>
			   <span class="help-inline"><font color="red">*</font></span>
			   </td>
			</tr>
		    <tr>
			   <td>实践时数:</td>
			   <td>
			   <input type="text" name="sjCount"  id="sjCount" class="input-xlarge" maxlength="3" value="${jxDg.sjCount}" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" oninput="zcount();"/>
			   </td>
		       <td>课外实践:</td>
			   <td>
			   <input type="text" name="kwsjCount"  id="kwsjCount" class="input-xlarge" maxlength="3" value="${jxDg.kwsjCount}" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" oninput="zcount();"/>
			   </td>
			</tr>
		    <tr>
			   <td>适合层次:</td>
			   <td colspan="3" >
			      <form:select path="shccId" id="shccId"  class="input-xlarge required" >
						  <form:option value="" label="全部" />
							<form:options items="${fns:getDictList('shccId')}" itemLabel="label" itemValue="label" 
								htmlEscape="false"/>
				   </form:select>
				   <span class="help-inline"><font color="red">*</font></span>
			   </td>
		  </tr>
		  <tr>
			  <td>代课老师:</td>
			  <td colspan="3">
			  <textarea  id="skjs" name="skjs" class="comments" readonly="readonly" style="vertical-align: middle;" >${jxDg.skjs}</textarea>
			  </td>
		  </tr>
		  <tr>
		     <td >适合专业:</td>
		     <td colspan="3">
		     <textarea  id="zyId" name="zyId" class="comments" maxlength="200" readonly="readonly" style="vertical-align: middle;">${jxDg.zyId}</textarea>
		     </td>
		  </tr>	
		   <tr>
		     <td>课程的目的与任务:</td>
		     <td   colspan="3">
		     <textarea  id=kcmdrw name="kcmdrw" maxlength="200" class="comments required"  style="vertical-align: middle;">${jxDg.kcmdrw}</textarea>
		      <span class="help-inline"><font color="red">*</font></span>
		     </td>
		  </tr>	
		 <tr>
		     <td>理论教学要求:</td>
		     <td   colspan="3">
		     <textarea  id="lljyyq" name="lljyyq" class="comments required"  maxlength="200" style="vertical-align: middle;">${jxDg.lljyyq}</textarea>
		      <span class="help-inline"><font color="red">*</font></span>
		     </td>
		  </tr>
		  </table> 
		  <div style="height: 10px;"></div>
		  <input style="margin-left: 20%;" type="button" onclick="addxsfp();" value="学时分配+" /><span id="addxxjl" style="color:red;"></span>
		  
		   <table id="table2" class="table table-bordered" style="width:60%;margin-left: 20%;">	
		   <tr>
		  <th colspan="7" style="text-align: center;">学时分配</th>
		  </tr> 
		  <tr>
		  <td>序号</td>
		  <td>教学内容</td>
		  <td>讲课</td>
		  <td>实践</td>
		  <td>课外</td>
		  <td>小计</td>
		  <td>操作</td>
		  </tr>
		  <c:forEach items="${jxDg.jxdgXsfp}" var="jxdgxsfp">
		 <tr class="text-center">
		  <td><input name="jxdgXsfp[${jxdgxsfp.xuhao1-1}].xuhao1" style="width:50px;border:none;outline:medium;" readonly="readonly"  value="${jxdgxsfp.xuhao1}">
		  </td>
		    <td> <input type="text" name="jxdgXsfp[${jxdgxsfp.xuhao1-1}].jxnr" maxlength="64"  style="width:130px;" value="${jxdgxsfp.jxnr}"></td>
		    <td> <input type="text" id="jkCount${jxdgxsfp.xuhao1+1}"  name="jxdgXsfp[${jxdgxsfp.xuhao1-1}].jkCount1"  style="width:50px;" maxlength="2" onkeyup="this.value=this.value.replace(/\\D/g,'')"  onafterpaste="this.value=this.value.replace(/\\D/g,'')" oninput="xiaoji(this);"  value="${jxdgxsfp.jkCount1}"></td> 
		    <td> <input type="text" id="sjCount${jxdgxsfp.xuhao1+1}" name="jxdgXsfp[${jxdgxsfp.xuhao1-1}].sjCount1"  style="width:50px;" maxlength="2" onkeyup="this.value=this.value.replace(/\\D/g,'')"  onafterpaste="this.value=this.value.replace(/\\D/g,'')" oninput="xiaoji(this);" value="${jxdgxsfp.sjCount1}"></td> 
			<td> <input type="text" id="kwCount${jxdgxsfp.xuhao1+1}" name="jxdgXsfp[${jxdgxsfp.xuhao1-1}].kwCount1"  style="width:50px;" maxlength="2" onkeyup="this.value=this.value.replace(/\\D/g,'')"  onafterpaste="this.value=this.value.replace(/\\D/g,'')" oninput="xiaoji(this);" value="${jxdgxsfp.kwCount1}"></td> 
		    <td> <input type="text" id="xjCount${jxdgxsfp.xuhao1+1}" name="jxdgXsfp[${jxdgxsfp.xuhao1-1}].xjCount"  style="width:50px;" readonly="readonly" value="${jxdgxsfp.xjCount}"></td>                                   
		    <td><input type="button" onclick=del(this) value="删除"  style="width:50px;"/></td> 
		  </tr>
		  </c:forEach>
		</table> 
		 <table id="table3" class="table table-bordered" style="width:60%;margin-left: 20%;">
		 <tr>
		 <td width="20%">课程相关说明:</td>
		 <td>
		 <textarea id="kcxgsm"  name="kcxgsm" class="comments"  maxlength="200" style="vertical-align: middle;">${jxDg.kcxgsm}</textarea>
		 </td>
		 </tr>
		  <tr>
		 <td width="20%">教学建议:</td>
		 <td>
		  <textarea id="jxjy" name="jxjy" class="comments"  maxlength="200" style="vertical-align: middle;">${jxDg.jxjy}</textarea>
		 </td>
		 </tr>	
		 </table>  
		<div style="text-align: center;"><shiro:hasPermission name="jxdg:jxDg:edit"><input id="btnSubmit" class="btn btn-primary" type="button" value="保 存"  onclick="OnSubmit();"/>&nbsp;</shiro:hasPermission>
		  <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	<div style="height: 60px;">
	</div>
</body>
</html>