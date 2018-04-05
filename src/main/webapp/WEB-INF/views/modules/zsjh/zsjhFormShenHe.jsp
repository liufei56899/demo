<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>计划招生管理</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/base_index.jsp" %>
</head>
<body>
<script type="text/javascript">
	    var rows = 0;
	     function tiJiao()
	    {
			if ($("#shyj").next().attr("class") == "error") {
					$("#shyj").next().remove();
			}
			$("#shyj").next().remove();
	    	var val= $("input[name='bcStatus']:checked").val();
	    	$("#shyj").removeClass("required");
				$("#shyj").removeClass("error");
				if ($("#shyj").next().attr("class") == "error") {
					$("#shyj").next().remove();
				}
				$("#shyj").attr("class","input-xxlarge");
	    	if(val==2)
	    	{
	    		$("#shyj").parent().append("<span class='help-inline'><font color='red'>*</font> </span>");
	    		$("#shyj").addClass("required");
	    	}else
	    	{
				$("#shyj").removeClass("required");
				$("#shyj").removeClass("error");
				if ($("#shyj").next().attr("class") == "error") {
					$("#shyj").next().remove();
				}
				$("#shyj").attr("class","input-xxlarge");
				$("#shyj").next().remove();
		   }
	    }
		$(document).ready(function() {
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
			var jh_id = $("#id").val();
			if(jh_id !=null && jh_id !="" ){
			   var zt = "${zsjh.zt}";
			   if(zt!=null && zt!="" && zt>=2){
				 startInit(jh_id,"${ctx}/zsjh/zsjh/findZyJhInitDisplay");
				 initCommit(rows);
			   }else{
			     startInit(jh_id,"${ctx}/zsjh/zsjh/findZyJhInit");
			   }
			   
			} else{
			  rows=1;
			}
			
			//去掉删除操作 
			 $("#bmTable2").find("tr").each(function(i)
			{
				var tdNum = $(this).find("td").size();
				if(tdNum>3)
				{
					$(this).find("td :last").remove();
				}
			});
		});
		
	    function startInit(jh_id,url){
	     /*  $.getJSON(url,{id:jh_id,rows:1,viewmodel:0},function(result){
		     	  $("#bmTable2").append(result.html);
		     	  var r = document.getElementById("bmTable2") ;
		     	  rows = r.rows.length;
		     	  if(rows>1){
		     	    for(var i=1;i<rows;i++){
		     	       selectAddStyle("zylx"+i);
		       		   selectAddStyle("zy"+i);
		     	    }
		     	  }
		  	   }); */
		  	   jQuery.ajax({
			        type: "POST",
			        url: url,
			        data: {id:jh_id,rows:1,viewmodel:0},
			        dataType:'json',
			        async:false,
					success: function(result){
						 $("#bmTable2").append(result.html);
				     	 // var r = document.getElementById("bmTable1") ;
				     	 // rows = r.rows.length;
				   }
			    });  
	    }
	    //首次提交初始化
		function initCommit(rows){
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
		 var tab = document.getElementById("bmTable2") ;
		 //表格行数
		 $.getJSON("${ctx}/zsjh/zsjh/findPsTable",{rows:rows},function(result){
		       $("#bmTable2").append(result.html);
		       selectAddStyle("zylx"+(rows));
		       selectAddStyle("zy"+(rows));
		  });
		}
		
	   function zyLx(rows,info){
		   $.getJSON("${ctx}/zsjh/zsjh/findZyByLxId",{id:info.value,rows:rows},function(result){
		       $("#zyS"+rows).html(result.html);
		       selectAddStyle("zy"+(rows));
		  	});
		} 

      /* function del(o){
			var t=document.getElementById("bmTable");
			t.deleteRow(o.parentNode.parentNode.rowIndex)
		} */
		
		
	  function validateYear(obj,id,mes){
			   if(!/^\d{4}$/.test(obj.value)){
			   var myDate = new Date();
				 myDate.getYear(); //获取当前年份(2位)
				 obj.value=myDate.getFullYear();
				 validTxt(id,mes);
			   }
	  } 
	  /*
	   *验证专业不重复
	   */
	 function checkZy(info,id){
		   var infoV ="";
		   if(rows>1){
		     for(var i = 1;i<=rows;i++){
		        infoV= $("#zy"+i).val();
		        if(id!=("zy"+i)){
		          if(infoV==info.value){
		            validTxt(id,"专业名称不能重复!");
		            break;
		          }else{
		               if($("#"+id).next().attr("class") =="error")
						{
						   	$("#"+id).next().remove();
						}
		          }
		        }
		     }
		   }
		 } 
		 
		 /* 
		 *招生人数总和
		 */
		 function sumZsrs(th,value){
		    if(value==0){ 
		       alertx("计划人数大于 0");
		       th.value=1;
		       return;
		    }
		    var result = 0;
		    var h = 0;
		    var start = "";
		    if(rows>1){
		       for(var i = 0;i<rows;i++){
		        start =$("input[name='jhZyInfos["+i+"].zsrs']").val();
		        if(start!=null && start!=""){
		           h=parseInt(start);
		           result=result+h;
		        }
		       }
		       $("#zsrs").val(result);
		    }
		 }
	</script>
	<form:form id="inputForm" modelAttribute="zsjh" action="${ctx}/zsjh/zsjh/savesh" method="post" class="form-horizontal" style="width: 98%;">
		<%-- <form:hidden path="id" id="jh_id"/> --%>
		<form:hidden path="id" id="id"/>
		<form:hidden path="act.taskId"/>
		<form:hidden path="act.taskName"/>
		<form:hidden path="act.taskDefKey"/>
		<form:hidden path="act.procInsId"/>
		<form:hidden path="act.procDefId"/>
		<form:hidden id="flag" path="act.flag" value="yes"/>
		<form:hidden path="zt" id="zt"/>
		<sys:message content="${message}"/>
		<div class="control-group">
		   <div class="lg-form">
		       <label class="control-label">计划名称：</label>
		       <div class="controls">
		       		${zsjh.jhmc }
		       </div>
		   </div>
		   <div class="lg-form">
		       <label class="control-label">学年：</label>
		       <div class="controls">
		       		${zsjh.zsnd}
		       </div>
		   </div>
		</div>
		<div class="control-group">
		   <div class="lg-form">
		       <label class="control-label">招生人数：</label>
		        <div class="controls">
		       		${zsjh.zsrs }
		       </div>
		   </div>
		   <div class="lg-form">
		       <label class="control-label">学年：</label>
		       <div class="controls">
		       		${zsjh.nf.xnmc }(${zsjh.nf.xq})
		       </div>
		   </div>
		</div>
		<div class="control-group">
		   <div class="lg-form">
		       <label class="control-label">招生开始时间：</label>
		       <div class="controls">
		       		<fmt:formatDate value="${zsjh.startDate}" pattern="yyyy-MM-dd"/>
		       </div>
		   </div>
		   <div class="lg-form">
		       <label class="control-label">招生结束时间：</label>
		        <div class="controls">
		       		<fmt:formatDate value="${zsjh.endDate}" pattern="yyyy-MM-dd"/>
		       </div>
		   </div>
		</div>
		<div class="control-group">
		  <div style="text-align: center; width: 85%;margin-left: 55px;" contenteditable="false">
				 <table id="bmTable2" class="table table-striped table-bordered table-condensed">
					<tr>
								<!-- <th>专业类别</th>
								<th>专业</th>
								<th>计划人数</th> -->
								<!-- <th>操作</th> -->
								<th style="font-size:14px;">专业类别</th>
								<th style="font-size:14px;">专业名称</th>
								<th style="font-size:14px;">招生人数</th>
								<!-- <th style="font-size:14px;">班级数量</th> -->
					</tr>
				 </table>
			</div>
		</div>
		<div class="control-group">
		      <label class="control-label">计划说明：</label>
		      <div class="controls">
  		       		${zsjh.jhsm }
  		       </div>
		</div>
		<div class="control-group">
                <label class="control-label">审核结果：</label>
                <div class="controls">
                  <c:if test="${zsjh.zt eq '1'}">
                      <form:radiobutton path="bcStatus"  value="1" checked ="checked"  />通过
				      <form:radiobutton path="bcStatus" value="2" />不通过
                  </c:if>
                  <c:if test="${zsjh.zt ne '1'}">
                     <c:if test="${zsjh.bcStatus eq 1}">通过</c:if>
                     <c:if test="${zsjh.bcStatus eq 2}">不通过</c:if>
                  </c:if>
				</div>
		</div>
		<div class="control-group">
                <label class="control-label">审核意见：</label>
                <div class="controls">
                 <c:if test="${zsjh.zt ne '1'}">
                   ${zsjh.spnr}
                 </c:if>
                 <c:if test="${zsjh.zt eq '1'}">
                    <form:textarea path="spnr"  id="shyj" htmlEscape="false" rows="4"
							maxlength="255" style="width:700px;resize: none;"
							class="input-xxlarge " />
                 </c:if>
			    </div>
		</div>
		<div class="control-group">
		   <div class="lg-form">
		      <label class="control-label">审核人：</label>
		      <div class="controls">
		         <c:if test="${zsjh.zt eq '1'}">
		            <form:input path="approveBy.name" id="approveBy.name" htmlEscape="false"
							maxlength="11" readonly="true" class="input-xlarge required" />
		         </c:if>
		         <c:if test="${zsjh.zt ne '1'}">
		            ${zsjh.approveBy.name}
		         </c:if>
		      </div>
		   </div>
		   <div class="lg-form">
               <label class="control-label">审核时间：</label>
               <div class="controls">
                  <c:if test="${zsjh.zt eq '1'}">
                     <input name="approveDate" type="text" disabled="disabled"
							maxlength="64" class="input-xlarge Wdate required"
							value="<fmt:formatDate value="${zsjh.approveDate}" pattern="yyyy-MM-dd"/>"
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" />
                  </c:if>
                  <c:if test="${zsjh.zt ne '1'}">
                    <fmt:formatDate value="${zsjh.approveDate}" pattern="yyyy-MM-dd"/>
                  </c:if>
			   </div>
		   </div>
		</div>
		<div class="form-actions">
		     <c:if test="${zsjh.zt eq '1'}">
			     <input id="btnSubmitOk" class="btn btn-primary"  onclick="tiJiao();" type="submit"  value="确定" />&nbsp; 
		     </c:if>
			    <input id="btnCancel" class="btn " type="button" value="关闭" onclick="closeDialog();" />
		</div>
	</form:form>
</body>
</html>