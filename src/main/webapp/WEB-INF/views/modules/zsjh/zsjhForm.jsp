<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>招生计划编辑/查看</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/base_index.jsp" %>
</head>
<link rel="Stylesheet" href="${ctxStatic}/jerichotab/css/jquery.jerichotab.css" />
	<style  type="text/css">
		label.error
		{
			background-position: 0px 3px;
		}
		.form-horizontal .control-label 
		{
			width:130px;	
		}
		.form-horizontal .controls 
		{
			margin-left:145px;
		}
		
	</style>
<body>
<script type="text/javascript" src="${ctxStatic}/jerichotab/js/jquery.jerichotab.js"></script>
<script type="text/javascript" src="${ctxStatic}/common/jeesite.js"></script>
<script type="text/javascript">
        function validateDate(value,tag){
            $.ajax({
			        type: "POST",
			        url: "${ctx}/zsjh/zsjh/validateDate",
			        data: {validateDate:value},
			        dataType:"json",
			        async:false,
					success: function(result){
					    if(result!=null&&result!=undefined&&result=="1"){
					        if(tag==0){
					               alert("招生开始时间无效");
					               $("#startDate2").val("");
					        }
					        if(tag==1){
					               alert("招生结束时间无效");
					               $("#endDate2").val("");
					        }
					    }
				    }
			    });
        }
		function validateJhmc()
		{
			var ret = true;
			var jhmc = $("#jhmc1").val();
			var id = "${zsjh.id}";
			if(jhmc!=null && jhmc!="")
			{
				jQuery.ajax({
			        type: "POST",
			        url: "${ctx}/zsjh/zsjh/validateJhmc",
			        data: {jhmc:jhmc,id:id},
			        dataType:'json',
			        async:false,
					success: function(result){
						ret = result.isTrue;
						if(!ret)
						{
							validTxt("jhmc1","计划名称不能重复");
							return false;
						}
				   }
			    });
			}
			return ret;
		}
		
		
		//验证时间
		function validDate()
		{
			var ret = true;
			var startDate2 = $("#startDate2").val();
			var endDate2= $("#endDate2").val();
			var d1 = new Date(startDate2.replace(/\-/g, "\/"));  
 			var d2 = new Date(endDate2.replace(/\-/g, "\/"));  
			if(d1 >d2)
			{
				validTxt("endDate2","结束时间不能小于开始时间");
				return false;
			}
			return ret;
		}
		
		function btnSub()
		{
			var ret = validateJhmc();
			if(ret)
			{
				ret = validDate();
			}
			
			return ret;
		}

	    var rows = 0;
		$(document).ready(function() {
			$("#inputForm").validate({
				submitHandler: function(form){
					var ret = btnSub();
					if(ret)
					{
						loading('正在提交，请稍等...');
						form.submit();
					}
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
			
			
			
			var jh_id = $("#id").val();
			if(jh_id !=null && jh_id !="" ){
			   var zt = "${zsjh.zt}";
			   if(zt!=null && zt!="" && zt>2){
				 startInit(jh_id,"${ctx}/zsjh/zsjh/findZyJhInitDisplay");
				 initCommit();
			   }else{
			     startInit(jh_id,"${ctx}/zsjh/zsjh/findZyJhInit");
			   }
			} else{
			  rows=1;
			}
		});
		
	    function startInit(jh_id,url){
	      $.getJSON(url,{id:jh_id,rows:1,viewmodel:0},function(result){
		     	  $("#bmTable").append(result.html);
		     	  var r = document.getElementById("bmTable") ;
		     	  rows = r.rows.length;
		     	  if(rows>1){
		     	    for(var i=1;i<rows;i++){
		     	       selectAddStyle("zylx"+i);
		       		   selectAddStyle("zy"+i);
		     	    }
		     	  }
		  	   });
	    }
	    //首次提交初始化
		function initCommit(){
		    $("#jhmc").attr("readonly",true);
			$("#nf").attr("readonly",true);
			$("#xqId").attr("disabled","disabled");
			$("#zsrs").attr("readonly",true);
			$("#remarks").attr("readonly",true);
			$("#jhsm").attr("readonly",true);
		}
	
		function addRow(){
		 rows=rows+1;
		 //表格行数
		 $.getJSON("${ctx}/zsjh/zsjh/findPsTable",{rows:rows},function(result){
		       $("#bmTable").append(result.html);
		       selectAddStyle("zylx"+(rows));
		       selectAddStyle("zy"+(rows));
		  });
		}
		
		function zyLx(rows,info){
		   $.getJSON("${ctx}/zsjh/zsjh/findZyByLxId",{id:info.value,rows:rows},function(result){
		   		//$("#zy"+rows).addCss("required");
		       $("#zyS"+rows).html(result.html);
		       $("#zy"+rows).addClass("required");
		       $("#zy"+rows).attr("style","width:150px;");
		       $("#zy"+rows).select2();
		       $("p#zy"+rows).text("");
		       /* selectAddStyle("zy"+(rows)); */
		  	});
		}
		
		function bc(){
		 	 $("#bcStatus").val("1");
		 	 
		}
		
		function tj(){
		 	$("#bcStatus").val("2");
		 	var zt ="${zsjh.zt}";
		 	if(zt==2)
		 	{
		 		tiJiaoShuJu();
		 	}else
		 	{
		 		$("#inputForm").submit();
		 	}
		 	
		}
		
		function tiJiaoShuJu()
		{
			jQuery.ajax({
		        url:'${ctx}/zsjh/zsjh/saveJh',
		        type:"POST",
		        data:$('#tijForm').serialize(),
		        dataType:'json',
			    async:false,
		        success: function(result) {
		          $("#result1").val(result.isTrue);
		          $("#jhForm12").submit();
		           closeDialog();
		        }
		    });
		}
		
		
		function del(o){
			var t=document.getElementById("bmTable");
			var row=o.parentNode.parentNode;
			var rowid=row.rowIndex;
			 //row.getElementById("bmTable");
			 var rowNum=row.getElementsByTagName("td")[2].firstChild.value;
			 var sum=$("#zsrs").val();
			 sum=sum-rowNum;
			 if(sum==0){
			 	$("#zsrs").val("");
			 }else{
			 	$("#zsrs").val(sum);
			 }
			t.deleteRow(rowid);
		}
		
		
		 function validateYear(obj,id,mes){
			   if(!/^\d{4}$/.test(obj.value)){
			   var myDate = new Date();
				 myDate.getYear(); //获取当前年份(2位)
				 obj.value=myDate.getFullYear();
				 validTxt(id,mes);
			   }
		 }
		 /***
		 *验证专业不重复
		 */
		 function checkZy(info,id2){
		 	$("p#"+id2).text("");
		   $.getJSON("${ctx}/zsjh/zsjh/getZhuanYeById", {
							id : info.value 
						}, function(result) {
							$("p#"+id2).text(result);
						});
		   }
		   var infoV ="";
		   if(rows>1){
		     for(var i = 1;i<=rows;i++){
		        infoV= $("#zy"+i).val();
		        if(id2!=("zy"+i)){
		          if(infoV==info.value){
		            validTxt(id2,"专业名称不能重复!");
		            break;
		          }else{
		               if($("#"+id2).next().attr("class") =="error")
						{
						   	$("#"+id2).next().remove();
						}
				}
			}
		}
	}

	/*
	 *招生人数总和
	 */
	function sumZsrs(th, value) {
		if (value == 0) {
			alertx("计划人数应大于 0");
			th.value = "";
			return;
		}
		var result = 0;
		var h = 0;
		var start = "";
		if (rows > 1) {
			for ( var i = 0; i < rows; i++) {
				start = $("input[name='jhZyInfos[" + i + "].zsrs']").val();
				if (start != null && start != "") {
					h = parseInt(start);
					result = result + h;
				}
			}
			$("#zsrs").val(result);
		}
	}

     //修改页面信息状态
	var viewmodel = $("#viewModel").val();
	if (viewmodel == "0") {
		$("#zybiaoti").css("display", "none");
		$("#option").css("display", "none");
		$("#btnSubmitBc").css("display", "none");
		$("#btnSubmitTj").css("display", "none");
	}else if (viewmodel == "1") {
		$("#zybiaoti").css("display", "none");
		$("#option").css("display", "none");
		$("#btnSubmitBc").css("display", "none");
	} else if (viewmodel == "3") {
		$("#zybiaoti").css("display", "none");
		$("#option").css("display", "none");
		$("#btnSubmitBc").css("display", "none");
	} else if (viewmodel == "view") {
		$("#zybiaoti").css("display", "none");
		$("#option").css("display", "none");
		$("#btnSubmitBc").css("display", "none");
	}

	
</script>
	<div style="margin-left: 50px;height: 29px;">
	<c:if test="${zsjh.zt eq '2'}">
	    <script type="text/javascript">
	    	var jericho = {
					buildTabpanel : function() {
						$.fn.initJerichoTab({
							renderTo : "#divRight2",
							uniqueId : "myJerichoTab",
							contentCss : {"height" : $("#divRight2").height()},
							tabs : []
						});
					}
			};
	        $(document).ready(function() {
				            $('#divRight2').css({width : 1060, height : 500});
							jericho.buildTabpanel();
							$.fn.jerichoTab.addTab({
							    title : "计划名称",
								closeable : false,
								data : {
									dataType : "formtag",
									dataLink : "#tbNews"
								}
							}).loadData(true);
							$("#divRight2").find("form").attr("id","tijForm");
							//$("#btnSubmitTj").attr("type","button");
							//$("#divRight2").next().remove();
							//$("#divRight2").next().find("form").attr("id","inform1");
							var jh_id = $("#id").val();
							//显示历史记录信息
							$.getJSON("${ctx}/zsjh/zsjhrecord/zsjhrecordlist",{rid : jh_id},function(result) {
							            var div = $("#selection_title2");
										var option = "<select id='selectZsjh' onchange=\"addtab1(this.value)\" style='width:200px;'><option value=''></option>";
										for ( var i = 0; i < result.length; i++) {
												option += "<option value=\""+result[i].id+"-"+result[i].cid+"\">"
																	+ result[i].cid
																	+ "</option>";
										}
										option = option + "</select>";
										div.append(option);
										$("#selectZsjh").select2();
							});
				});
	         function addtab1(value) {
	                if(value==""||value==null){
	                  return;
	                }
					var value1 = value.substr(0, value.indexOf("-"));
					var name = value.substr(value.indexOf("-") + 1,value.length);
					$.fn.jerichoTab.addTab({
								title : name,
								closeable : true,
								data : {
											dataType : "iframe",
											dataLink : "${ctx}/zsjh/zsjhrecord/formshhistory?id="+ value1
									   }
								}).loadData(true);
				}
	    </script>
	    <label class="control-label">招生计划历史记录:</label> 
				<label class="control-label" style="margin-left: 20px;">
					<div id="selection_title2" ></div> 
				</label>
	 <form id="jhForm12" action="${ctx}/zsjh/zsjh/jhForm" method="post" >
		<input type="hidden" name="result" id="result1" />
	</form> 
	 </c:if>
	 </div>
	<div id="divRight2" ></div>
	<c:if test="${zsjh.zt eq '2'}">
		<div id="tbNews" style="overflow-y: scroll;height: 500px;"></div>
	</c:if>
	<c:if test="${zsjh.zt eq '0' or zsjh.zt eq '1' or zsjh.zt eq '3'}">
		<div id="tbNews"></div>
	</c:if>
	
	<form:form id="inputForm" modelAttribute="zsjh" action="${ctx}/zsjh/zsjh/save" method="post" class="form-horizontal" style="width: 98%;" >
		<form:hidden path="viewModel" id="viewModel"/>
		<form:hidden path="id" id="id"/>
		<form:hidden path="act.taskId"/>
		<form:hidden path="act.taskName"/>
		<form:hidden path="act.taskDefKey"/>
		<form:hidden path="act.procInsId"/>
		<form:hidden path="act.procDefId"/>
		<form:hidden id="flag" path="act.flag" value="yes"/>
		<form:hidden path="zt" id="zt"/>
		<form:hidden path="bcStatus" id="bcStatus"/>
		<sys:message content="${message}"/>
		<div class="control-group">
		   <div class="lg-form">
		       <label class="control-label">计划名称：</label>
		       <div class="controls">
			       <form:input path="jhmc" id="jhmc1" htmlEscape="false" 
								maxlength="64" class="input-xlarge required"/>
				   <span class="help-inline"><font color="red">*</font></span>
			   </div>
		   </div>
		   <div class="lg-form">
		       <label class="control-label">招生年度：</label>
		       <div class="controls">
		       <fmt:parseDate value="${zsjh.zsnd}" pattern="yyyy" var="zsndDate"/>
			   <input name="zsnd"  id="zsnd"  type="text"  readonly="readonly" maxlength="20" class="input-xlarge Wdate required"
						       value="<fmt:formatDate value="${zsndDate}" pattern="yyyy"/>" 
						       onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});"/>
			   <span class="help-inline"><font color="red">*</font></span>
			   </div>
		   </div>
		</div>
		<div class="control-group">
		   <div class="lg-form">
		       <label class="control-label">招生人数：</label>
		       <div class="controls">
		       <form:input path="zsrs" id="zsrs" htmlEscape="false"
						   maxlength="11" readonly="true"
						   class="input-xlarge required digits" />
				</div>
		   </div>
		   <div class="lg-form">
		       <label class="control-label">学年：</label>
		       <div class="controls">
				<form:select path="nf.id" id="nf1"  class="input-xlarge required" style="width:215px;" >
					<form:option value="" label="请选择" />
					<form:options items="${fns:getXnxqJbxxList()}" 
					              itemLabel="xnmc" itemValue="id" htmlEscape="false" />
			   </form:select>
			   <span class="help-inline"><font color="red">*</font></span>
			   </div>
		   </div>
		</div>
		<div class="control-group">
		   <div class="lg-form">
		       <label class="control-label">招生开始时间：</label>
		       <div class="controls">
		       <input name="startDate"  id="startDate2"  type="text"  readonly="readonly" maxlength="20" class="input-xlarge Wdate required"
						       value="<fmt:formatDate value="${zsjh.startDate}" pattern="yyyy-MM-dd"/>" 
						       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'${nowDate}',isShowClear:false});"  onchange="validateDate(this.value,0)" />
			   <span class="help-inline"><font color="red">*</font></span></div>
		   </div>
		   <div class="lg-form">
		       <label class="control-label">招生结束时间：</label>
		       <div class="controls">
		       <input name="endDate" id="endDate2" type="text" readonly="readonly"maxlength="20" class="input-xlarge Wdate required"
						       value="<fmt:formatDate value="${zsjh.endDate}" pattern="yyyy-MM-dd"/>" 
						       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'${nowDate}',isShowClear:false});" onchange="validateDate(this.value,1)"  />
			   <span class="help-inline"><font color="red">*</font></span>
			   </div>
		   </div>
		</div>
		<div style="width: 80%;  margin-bottom: 5px;" id="zybiaoti">
		   <input style="margin-left: 90px;"type="button" onclick="addRow()" value="招生专业 +" />
		</div>
		<div class="control-group">
		 <div style="text-align: center; width: 90%;margin-left: 90px; margin-bottom:10px; height:200px; overflow: auto;">
			 <table id="bmTable" class="table table-striped table-bordered table-condensed" style="height: 100px;">
				<tr>
								<th style="font-size:14px;">专业类别</th>
								<th style="font-size:14px;">专业名称</th>
								<th style="font-size:14px;">招生人数</th>
								<!-- <th style="font-size:14px;">班级数量</th> -->
								<th style="font-size:14px;" id="option">操作</th>
				</tr>
			</table>
		  </div>
		</div>
		<div class="control-group">
		   <label class="control-label">招生说明：</label>
		   <div class="controls">
		   <form:textarea path="jhsm" id="jhsm" htmlEscape="false" rows="4"
						  maxlength="255" style="width:750px;resize: none;"
						  class="input-xxlarge" /> 
			</div>
		</div>
		<div class="form-actions">
		     <c:if test="${zsjh.zt eq '0' or zsjh.zt eq '' or zsjh.zt eq null}">
				   <input id="btnSubmitBc" class="btn btn-primary" onclick="bc()" type="submit" value="保 存" />&nbsp;
			 </c:if>
			 
			 <c:if test="${zsjh.zt ne '1' and zsjh.zt ne '3'}">
				   <input id="btnSubmitTj" class="btn btn-primary" onclick="tj()" type="button" value="提交" />&nbsp;
			 </c:if>
				   <input id="btnCancel" class="btn " type="button" value="关 闭" onclick="closeDialog();"/>
		</div>
	</form:form>
	
</body>

</html>
