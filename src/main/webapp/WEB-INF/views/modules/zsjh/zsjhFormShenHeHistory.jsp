<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>计划招生管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/base_index.jsp" %>
    <script type="text/javascript"> 
    var rows = 0;
	$(document).ready(function() {
	   var jh_id = $("#cid").val();
	   if(jh_id !=null && jh_id !="" ){
		     var zt = "${zsjhRecord.zt}";
		    if(zt!=null && zt!=""){
				 startInit(jh_id,"${ctx}/zsjh/zsjh/findZyJhInitDisplay");
				 initCommit(rows);
			}else{
			     startInit(jh_id,"${ctx}/zsjh/zsjh/findZyJhInit");
			}
	   }
	   	
	   	//去掉删除操作 
			 $("#bmTableHistory").find("tr").each(function(i)
			{
				var tdNum = $(this).find("td").size();
				if(tdNum>3)
				{
					$(this).find("td :last").remove();
				}
			});
	   
	   });
	  function startInit(jh_id,url){
	  	jQuery.ajax({
			        type: "POST",
			        url: url,
			        data: {id:jh_id,rows:1,viewmodel:0},
			        dataType:'json',
			        async:false,
					success: function(result){
						 $("#bmTableHistory").append(result.html);
				   }
			    });
	    }
	 //首次提交初始化
	  function initCommit(rows){
		    /* $("#jhmc").attr("readonly",true);
			$("#nf").attr("readonly",true);
			$("#xqId").attr("disabled","disabled");
			$("#zsrs").attr("readonly",true);
			$("#remarks").attr("readonly",true);
			$("#jhsm").attr("readonly",true); */
	  }
    </script>
	<form:form id="inputForm22" modelAttribute="zsjhRecord" action="${ctx}/zsjh/zsjh/savesh" method="post" class="form-horizontal">
	    <form:hidden path="id" id="id"/>
		<form:hidden path="cid" id="cid"/>
		<form:hidden path="zt" id="zt"/> 
		<%-- <form:hidden path="act.taskId"/>
		<form:hidden path="act.taskName"/>
		<form:hidden path="act.taskDefKey"/>
		<form:hidden path="act.procInsId"/>
		<form:hidden path="act.procDefId"/>
		<form:hidden id="flag" path="act.flag" value="yes"/> --%>
		<sys:message content="${message}"/>		
		<div class="control-group" style="width:800px;">
		   <div class="lg-form">
			<label class="control-label">计划名称：</label>
			<div class="controls">${zsjhRecord.jhmc }
			</div>
			</div>
		</div>
		<div class="control-group">
		   <div class="lg-form">
			     <label class="control-label">招生人数：</label>
				<div class="controls">${zsjhRecord.zsrs }
				</div>
		   </div>
		   <div class="lg-form">
			<label class="control-label">学年：</label>
			<div class="controls">${zsjhRecord.nf.xnmc }(${zsjh1.nf.xq})
			</div>
			</div>
		</div>
		<div class="control-group">
		   <div class="lg-form">
		       <label class="control-label">招生开始时间：</label>
		       <div class="controls">
		       		<fmt:formatDate value="${zsjh1.startDate}" pattern="yyyy-MM-dd"/>
		       </div>
		   </div>
		   <div class="lg-form">
		       <label class="control-label">招生结束时间：</label>
		        <div class="controls">
		       		<fmt:formatDate value="${zsjh1.endDate}" pattern="yyyy-MM-dd"/>
		       </div>
		   </div>
		</div>
		<div style="text-align: center; width: 80%;margin-left: 90px; " contenteditable="false">
				<table id="bmTableHistory" class="table table-striped table-bordered table-condensed">
				   <tr>
				    <th >专业类别</th>
				     <th >专业名称</th>
				     <th >计划人数</th>
				    <!--  <th >班级数量</th> -->
				   </tr>
				</table>
		</div>
		<div class="control-group">
			    <label class="control-label">计划说明：</label>
				<div class="controls">
					${fns:abbr(zsjh1.jhsm,100)}
				</div>
		</div>
		<div class="control-group">
		        <label class="control-label">审核结果：</label>
				<div class="controls">
				      ${zsjhRecord.bcStatus}
		        </div>
		</div>
		<div class="control-group">
			<label class="control-label">审核意见：</label>
			<div class="controls">${fns:abbr(zsjh1.spnr,100)}
			</div>
		</div>
		<div class="control-group">
		  <div class="lg-form">
			<label class="control-label">审核人：</label>
			<div class="controls">${zsjhRecord.createBy.name}
			</div>
		  </div>
		   <div class="lg-form">
			     <label class="control-label">审核时间：</label>
			     <div class="controls"><fmt:formatDate value="${zsjhRecord.createDate}" pattern="yyyy-MM-dd"/>
			     </div>
		   </div>
		</div>
	</form:form>
</body>
</html>